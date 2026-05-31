# Reconnects the facing routine 9230 to the REAL joed.pct sprites.
# 9230 draws L415-L429 (bogus, GET from a blank corner). joed.pct loads the 8 real
# facing poses into I431/L432-L438. Per the user's frame->direction map and 9230's
# direction->L4xx map, the correct array for each PUT is:
#   L415 (dir "4" left)       -> L434 (joed col3 = left)
#   L417 (dir "2" down)       -> I431 (joed col0 = down)
#   L419 (dir "6" right)      -> L433 (joed col2 = right)
#   L421 (dir "8" up)         -> L432 (joed col1 = up)
#   L423 (dir "1" down-left)  -> L435 (joed col4 = down-left)
#   L425 (dir "7" up-left)    -> L437 (joed col6 = up-left)
#   L427 (dir "9" up-right)   -> L438 (joed col7 = up-right)
#   L429 (dir "3" down-right) -> L436 (joed col5 = down-right)
# Scoped to the 9230 PUTs (lines 9240-9540) so the GETs (9570+) are untouched (removed separately).
param([string]$BasPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS", [int]$Lo = 9240, [int]$Hi = 9540, [switch]$Apply)
$map = [ordered]@{ 'L415'='L434'; 'L417'='I431'; 'L419'='L433'; 'L421'='L432'; 'L423'='L435'; 'L425'='L437'; 'L427'='L438'; 'L429'='L436' }
$lines = Get-Content $BasPath
$out = New-Object System.Collections.Generic.List[string]
$changes = New-Object System.Collections.Generic.List[string]
foreach ($line in $lines) {
  $new = $line
  if ($line -match '^\s*(\d+)\b') {
    $n = [int]$Matches[1]
    if ($n -ge $Lo -and $n -le $Hi) {
      foreach ($k in $map.Keys) { $new = [regex]::Replace($new, "\b$k\b", $map[$k]) }
    }
  }
  if ($new -ne $line) { $changes.Add("  - $line"); $changes.Add("  + $new") }
  $out.Add($new)
}
"Replacements ($($changes.Count/2)):"
$changes | ForEach-Object { $_ }
if ($Apply) { [System.IO.File]::WriteAllLines($BasPath, $out); ""; "APPLIED" } else { ""; "DRY RUN" }
