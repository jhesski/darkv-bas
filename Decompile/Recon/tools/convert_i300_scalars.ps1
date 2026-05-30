# Converts ALL remaining I300 split-scalars to I300(index).
#
# The inventory pass (fix_inventory_array.ps1) handled the slots that appear in
# the inventory display. But I300 is the whole 65-element game-state vector
# (save/restore persists I300(1..65)), and Spring split MANY non-inventory state
# flags into scalars too - including I358 (the win flag), I140 (formula combine),
# I449, etc. These are read by game logic but set via I300(idx) by .PAC actions,
# so as standalone scalars they're permanently 0 -> puzzles and the win condition
# never fire.
#
# Map is derived from the symbol table by ADDRESS (deterministic): every even-
# address integer scalar between I300's base (0x295A) and the next array bounds
# an I300 element at index (addr-0x295A)/2. Already-converted inventory scalars
# simply won't be found in the code (0 occurrences) - harmless.
param(
  [string]$BasPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS",
  [int]$SymStart = 1665,
  [int]$SymEnd   = 1780,
  [switch]$Apply
)

$lines = Get-Content $BasPath

# --- parse symbol table (dedupe by name) ---
$syms = @{}
for ($n = $SymStart - 1; $n -lt [Math]::Min($SymEnd, $lines.Count); $n++) {
  $line = $lines[$n]
  if ($line -notmatch "^'") { continue }
  foreach ($m in [regex]::Matches($line, '([IL][0-9]+\$?)\s+([0-9A-Fa-f]{4})\s*([IESA]{0,4})(?=\s|$)')) {
    $name = $m.Groups[1].Value
    if (-not $syms.ContainsKey($name)) {
      $syms[$name] = [pscustomobject]@{
        Name=$name; Addr=[Convert]::ToInt32($m.Groups[2].Value,16); Flags=$m.Groups[3].Value
        IsArray=($m.Groups[3].Value -match 'A'); IsInt=($name.StartsWith('I') -and -not $name.EndsWith('$'))
      }
    }
  }
}
$all = $syms.Values | Sort-Object Addr
$I300 = $syms['I300']
if (-not $I300) { throw "I300 not found in symbol table range." }

# upper bound = address of the next ARRAY after I300
$nextArr = ($all | Where-Object { $_.IsArray -and $_.Addr -gt $I300.Addr } | Sort-Object Addr | Select-Object -First 1)
$hi = if ($nextArr) { $nextArr.Addr } else { $I300.Addr + 2*100 }
"I300 base = 0x$('{0:X4}' -f $I300.Addr); range upper bound (next array $($nextArr.Name)) = 0x$('{0:X4}' -f $hi)"
""

# every even-address integer scalar strictly inside the range is an I300 element
$map = [ordered]@{}
foreach ($s in $all) {
  if ($s.IsArray -or -not $s.IsInt) { continue }
  if ($s.Addr -le $I300.Addr -or $s.Addr -ge $hi) { continue }
  if ((($s.Addr - $I300.Addr) % 2) -ne 0) { continue }   # odd address = not an integer element
  $map[$s.Name] = ($s.Addr - $I300.Addr) / 2
}
"Derived I300 element scalars ($($map.Count)):"
foreach ($k in $map.Keys) { "  {0,-6} = I300({1})" -f $k, $map[$k] }
""

# --- convert code lines only ---
$out = New-Object System.Collections.Generic.List[string]
$changes = New-Object System.Collections.Generic.List[string]
$hits = @{}
foreach ($line in $lines) {
  if ($line -notmatch '^\s*\d+\b') { $out.Add($line); continue }
  $orig = $line
  foreach ($scalar in $map.Keys) {
    $pat = "\b$scalar\b"
    if ([regex]::IsMatch($line, $pat)) {
      if (-not $hits.ContainsKey($scalar)) { $hits[$scalar] = 0 }
      $hits[$scalar] += [regex]::Matches($line, $pat).Count
      $line = [regex]::Replace($line, $pat, "I300($($map[$scalar]))")
    }
  }
  if ($line -ne $orig) { $changes.Add("  - $orig"); $changes.Add("  + $line") }
  $out.Add($line)
}

"Occurrences found in code (already-converted inventory scalars show 0):"
foreach ($k in $map.Keys) { $c = if ($hits.ContainsKey($k)) { $hits[$k] } else { 0 }; "  {0,-6} -> I300({1,-2}) : {2}" -f $k, $map[$k], $c }
""
"Changed lines ($($changes.Count/2)):"
$changes | ForEach-Object { $_ }

if ($Apply) { [System.IO.File]::WriteAllLines($BasPath, $out); ""; "APPLIED to $BasPath" }
else { ""; "DRY RUN - re-run with -Apply to write." }
