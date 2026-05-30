# Detects "split arrays": the Spring failure mode where an array accessed by a
# CONSTANT index was decompiled into standalone scalar variables that shadow the
# array's storage (e.g. I300() -> I189, I193, ... at consecutive addresses).
#
# Signature: an array symbol (flag 'A') whose base address is immediately
# followed by a run of >=3 same-type scalar symbols at the element stride.
# Integer elements (I-name) = 2 bytes; Long/Single/String descriptor = 4 bytes.
#
# Reports candidates for MANUAL review - a short run could be coincidental
# (separate vars the compiler happened to place contiguously). I300's run was 33.
param(
  [string]$BasPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS",
  [int]$StartLine = 1665,
  [int]$EndLine   = 1780,
  [int]$MinRun    = 3
)

$lines = Get-Content $BasPath
$syms = @{}   # name -> [pscustomobject]
for ($n = $StartLine - 1; $n -lt [Math]::Min($EndLine, $lines.Count); $n++) {
  $line = $lines[$n]
  if ($line -notmatch "^'") { continue }
  foreach ($m in [regex]::Matches($line, '([IL][0-9]+\$?)\s+([0-9A-Fa-f]{4})\s*([IESA]{0,4})(?=\s|$)')) {
    $name = $m.Groups[1].Value
    if ($syms.ContainsKey($name)) { continue }
    $addr = [Convert]::ToInt32($m.Groups[2].Value, 16)
    $flags = $m.Groups[3].Value
    $isArray = $flags -match 'A'
    $isStr = ($name.EndsWith('$')) -or ($flags -match 'S')
    $isInt = ($name.StartsWith('I')) -and (-not $isStr)
    $stride = if ($isInt) { 2 } else { 4 }
    $syms[$name] = [pscustomobject]@{ Name=$name; Addr=$addr; Flags=$flags; IsArray=$isArray; IsInt=$isInt; IsStr=$isStr; Stride=$stride }
  }
}

$all = $syms.Values | Sort-Object Addr
"Parsed $($all.Count) unique symbols (addr $('0x{0:X4}' -f ($all[0].Addr)) .. $('0x{0:X4}' -f ($all[-1].Addr)))."
""

# Index scalars by address for fast lookup
$scalarAt = @{}
foreach ($s in $all) { if (-not $s.IsArray) { $scalarAt[$s.Addr] = $s } }

$found = 0
foreach ($arr in ($all | Where-Object IsArray)) {
  $stride = $arr.Stride
  $run = New-Object System.Collections.Generic.List[object]
  $a = $arr.Addr + $stride
  while ($scalarAt.ContainsKey($a)) {
    $s = $scalarAt[$a]
    # element must match the array's storage type
    if ($s.IsInt -ne $arr.IsInt) { break }
    $run.Add($s) | Out-Null
    $a += $stride
  }
  if ($run.Count -ge $MinRun) {
    $found++
    $typeName = if ($arr.IsInt) { 'Integer(2B)' } elseif ($arr.IsStr) { 'String(4B)' } else { 'Long/Single(4B)' }
    "*** SPLIT ARRAY CANDIDATE: $($arr.Name) @ 0x$('{0:X4}' -f $arr.Addr) [$($arr.Flags)] $typeName -- $($run.Count) shadow scalar(s):"
    foreach ($s in $run) {
      $idx = ($s.Addr - $arr.Addr) / $stride
      "      $($s.Name) @ 0x$('{0:X4}' -f $s.Addr)  =>  $($arr.Name)($idx)"
    }
    ""
  }
}
if ($found -eq 0) { "No split-array candidates with run >= $MinRun. (I300 already fixed.)" }
else { "$found candidate array(s). Verify each against actual array usage before converting." }
