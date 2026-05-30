# Reconnects the in-room Joe-walk animation (routine 8240) to its real sprite data.
#
# The walk loads joewN.pct into I404 (col0 = frame A) / L405 (col1 = frame B) but
# the animation PUTs L278/L403 - which the original got from a bogus
# GET (1,8)-(9,18) (a decompiler artifact; the .pct already carries its own
# 62,31 GET-array header, exactly like the intro walk at 18310 that we fixed).
#
# Mirror the working intro: PUT the loaded frames directly. Replace L278->I404 and
# L403->L405, but ONLY within the walk animation (QB lines 8570-9210), leaving the
# death cutscenes (9910/10140) and inventory (5200) PUTs untouched for now.
param(
  [string]$BasPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS",
  [int]$Lo = 8570, [int]$Hi = 9210,
  [switch]$Apply
)
$lines = Get-Content $BasPath
$out = New-Object System.Collections.Generic.List[string]
$changes = New-Object System.Collections.Generic.List[string]
foreach ($line in $lines) {
  if ($line -match '^\s*(\d+)\b') {
    $n = [int]$Matches[1]
    if ($n -ge $Lo -and $n -le $Hi -and ($line -match '\bL278\b' -or $line -match '\bL403\b')) {
      $new = [regex]::Replace($line, '\bL278\b', 'I404')
      $new = [regex]::Replace($new, '\bL403\b', 'L405')
      $changes.Add("  - $line"); $changes.Add("  + $new")
      $out.Add($new); continue
    }
  }
  $out.Add($line)
}
"Replacements ($($changes.Count/2)):"
$changes | ForEach-Object { $_ }
if ($Apply) { [System.IO.File]::WriteAllLines($BasPath, $out); ""; "APPLIED" } else { ""; "DRY RUN" }
