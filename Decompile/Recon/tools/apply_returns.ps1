# Applies suggested RETURN insertions from find_missing_returns.ps1.
#
# For each GOSUB target T that lacks a RETURN, finds the last line before
# the next GOSUB target (or before a System/End/End Sub) and inserts a
# RETURN right after the existing code there.
#
# Strategy: for each routine that needs a RETURN, look at the LAST non-empty
# line of the routine. If that line is a GoTo XXXX (transfers control elsewhere),
# the routine never falls through, so RETURN there would be unreachable - skip.
# Otherwise, the routine falls through; add RETURN at the end.
param(
  [string]$BasPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS"
)

$lines = Get-Content $BasPath

# 1) Find all GOSUB targets and call sites
$gosubTargets = New-Object System.Collections.Generic.HashSet[int]
for ($i = 0; $i -lt $lines.Count; $i++) {
  if ($lines[$i] -match "^'") { continue }
  foreach ($m in [regex]::Matches($lines[$i], '\b(?:GoSub|GOSUB)\s+(\d+)\b')) {
    [void]$gosubTargets.Add([int]$m.Groups[1].Value)
  }
}

# 2) QB line -> file line index map
$qbToFile = @{}
for ($i = 0; $i -lt $lines.Count; $i++) {
  if ($lines[$i] -match '^(\d+)\b') {
    $qbToFile[[int]$Matches[1]] = $i
  }
}

$sortedTargets = $gosubTargets | Sort-Object

# 3) For each target, determine the LAST file-line of its routine
# = file line right before the next GOSUB target (in QB line number order)
$insertions = New-Object System.Collections.Generic.List[PSCustomObject]
for ($t = 0; $t -lt $sortedTargets.Count; $t++) {
  $target = $sortedTargets[$t]
  if (-not $qbToFile.ContainsKey($target)) { continue }
  $startIdx = $qbToFile[$target]
  $endIdx = if ($t -lt $sortedTargets.Count - 1) { $qbToFile[$sortedTargets[$t + 1]] - 1 } else { $lines.Count - 1 }

  # Check if routine already has RETURN (anywhere in its range)
  $hasReturn = $false
  for ($i = $startIdx; $i -le $endIdx; $i++) {
    if ($lines[$i] -match '\b(?:RETURN|Return)\b' -and $lines[$i] -notmatch "^'") { $hasReturn = $true; break }
  }
  if ($hasReturn) { continue }

  # Walk backwards from endIdx to find the last non-empty, non-comment, non-bare-label line
  $lastCodeIdx = -1
  for ($i = $endIdx; $i -ge $startIdx; $i--) {
    $l = $lines[$i]
    if ($l -match "^'") { continue }
    if ($l -match '^\s*$') { continue }
    if ($l -match '^\s*\d+\s*$') { continue }    # bare label
    if ($l -match '^Rem\b') { continue }
    $lastCodeIdx = $i
    break
  }
  if ($lastCodeIdx -lt 0) { continue }

  $lastLine = $lines[$lastCodeIdx]

  # If the last code line is an unconditional GoTo, the routine transfers control;
  # adding RETURN after would be unreachable. Skip.
  if ($lastLine -match '^\s*\d+\s+(?:GoTo|GOTO)\s+\d+\s*$') { continue }
  if ($lastLine -match '^\s*\d+\s+System\b') { continue }
  if ($lastLine -match '^\s*\d+\s+End\s*$') { continue }

  # Find a free line number to use. Use 1 more than the last line of the routine.
  $lastQBLine = -1
  if ($lastLine -match '^\s*(\d+)\b') { $lastQBLine = [int]$Matches[1] }
  $newQBLine = $lastQBLine + 1
  # Avoid colliding with next routine's start
  if ($t -lt $sortedTargets.Count - 1 -and $newQBLine -ge $sortedTargets[$t + 1]) {
    # Use a fractional/just-below approach - prepend a label-only RETURN line
    # Actually QB lines are integers. Use $lastQBLine + 1 if available
    if ($newQBLine -ge $sortedTargets[$t + 1]) { continue }
  }

  $insertions.Add([PSCustomObject]@{
    Target = $target
    InsertAfterFileLine = $lastCodeIdx
    NewQBLine = $newQBLine
    LastLine = $lastLine.Trim()
  }) | Out-Null
}

"Will insert $($insertions.Count) RETURN statements"

# 4) Apply insertions (in reverse order so indices stay valid)
$reversed = $insertions | Sort-Object InsertAfterFileLine -Descending
$out = New-Object System.Collections.Generic.List[string]
$out.AddRange([string[]]$lines)
foreach ($ins in $reversed) {
  $returnLine = "$($ins.NewQBLine) RETURN 'PASS2-RECON-AUTO: routine entry at QB line $($ins.Target); inserted by apply_returns.ps1"
  $out.Insert($ins.InsertAfterFileLine + 1, $returnLine)
}

[System.IO.File]::WriteAllLines($BasPath, $out)
"Done. New file size: $($out.Count) lines"
