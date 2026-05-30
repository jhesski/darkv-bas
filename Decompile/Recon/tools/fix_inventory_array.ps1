# Reconnects the inventory possession flags to the I300 array.
#
# Spring split the I300 integer array (base 0x295A) into standalone scalar
# variables wherever the original source used a CONSTANT index (e.g. I300(12)
# became the scalar "I213" at address 0x2972). The variable-index accesses
# (the pickup at 6340: I300(CINT(L319))) stayed as the array. Our reconstruction
# DIMs I300 separately, so the scalars no longer overlap the array - the pickup
# writes I300(n) but the inventory/puzzle code reads the disconnected scalar,
# so nothing is ever "in" your inventory.
#
# Fix: replace each scalar with I300(index). index = (addr - 0x295A)/2, which is
# exactly the inventory item number written to I192 in the display - both the
# symbol-table addresses AND the I192 item numbers agree, so the map is verified.
#
# Only CODE lines (start with a QB line number) are touched; COMMON SHARED
# declarations and the symbol-table comments are left intact (the scalars stay
# declared but unused - harmless).
param(
  [string]$BasPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS",
  [switch]$Apply
)

# scalar -> I300 index (verified: symbol-table address AND inventory I192 number)
$map = [ordered]@{
  'I189'=1;  'I193'=2;  'I195'=3;  'I197'=4;  'I199'=5;  'I201'=6;  'I203'=7
  'I205'=8;  'I207'=9;  'I209'=10; 'I211'=11; 'I213'=12; 'I215'=13; 'I217'=14
  'I219'=15; 'I221'=16; 'I223'=17; 'I225'=18; 'I228'=19; 'I230'=20; 'I232'=21
  'I234'=22; 'I236'=23; 'I238'=24; 'I239'=25; 'I241'=26; 'I243'=27; 'I245'=28
  'I247'=29; 'I255'=34; 'I252'=35; 'I139'=36; 'I250'=49
}

$lines = Get-Content $BasPath
$out = New-Object System.Collections.Generic.List[string]
$changes = New-Object System.Collections.Generic.List[string]
$perScalar = @{}

for ($i = 0; $i -lt $lines.Count; $i++) {
  $line = $lines[$i]
  # Only transform executable code lines (begin with a QB line number).
  if ($line -notmatch '^\s*\d+\b') { $out.Add($line); continue }
  $orig = $line
  foreach ($scalar in $map.Keys) {
    $idx = $map[$scalar]
    $pattern = "\b$scalar\b"
    if ([regex]::IsMatch($line, $pattern)) {
      $n = [regex]::Matches($line, $pattern).Count
      $line = [regex]::Replace($line, $pattern, "I300($idx)")
      if (-not $perScalar.ContainsKey($scalar)) { $perScalar[$scalar] = 0 }
      $perScalar[$scalar] += $n
    }
  }
  if ($line -ne $orig) {
    $changes.Add("  - $orig") | Out-Null
    $changes.Add("  + $line") | Out-Null
  }
  $out.Add($line)
}

"Per-scalar replacement counts:"
foreach ($k in $map.Keys) {
  $c = if ($perScalar.ContainsKey($k)) { $perScalar[$k] } else { 0 }
  "  {0,-6} -> I300({1,-2})  : {2} occurrence(s)" -f $k, $map[$k], $c
}
""
"Changed lines ($($changes.Count / 2)):"
$changes | ForEach-Object { $_ }

if ($Apply) {
  [System.IO.File]::WriteAllLines($BasPath, $out)
  ""
  "APPLIED to $BasPath"
} else {
  ""
  "DRY RUN - re-run with -Apply to write."
}
