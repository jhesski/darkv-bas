# Restores lost RETURN statements in GAME.BAS.
#
# Insight: Spring replaced each original RETURN line with a "Subroutine SNNNN"
# annotation (marking the next routine's start). Pass 1 converted those
# annotations to BARE line numbers. So every bare line that is NOT the target
# of any GOTO/GOSUB is a lost RETURN sitting at a routine boundary.
#
# Routines that exit via GOTO (e.g. 7860 -> 8130 GOTO 8240) have NO bare line,
# so they are automatically left untouched - which avoids the false positives
# that broke the earlier blunt auto-insert.
#
# Bare lines that ARE jump targets are real labels (or early-exit RETURNs) and
# are reported for manual review rather than auto-converted.
param(
  [string]$BasPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS",
  [int]$MaxQBLine = 15540,   # only convert game-logic bare lines; leave the intro SUBs (>=15540) which already work
  [switch]$Apply
)

$lines = Get-Content $BasPath

# 1. Collect targets. We need TWO sets:
#    $targets    = ALL jump targets (GOTO/GOSUB/THEN/RESUME) - to test if a bare line is jumped to.
#    $gosubTgts  = GOSUB targets ONLY - real subroutine starts. A bare line is a routine-end
#                  RETURN only if the NEXT line is a GOSUB target (not merely a GOTO label).
#                  This avoids false positives like 6850->6860 (GOTO label) and 7040->7050 (main loop).
$targets   = New-Object System.Collections.Generic.HashSet[int]
$gosubTgts = New-Object System.Collections.Generic.HashSet[int]
foreach ($line in $lines) {
  if ($line -match '^\s*\d+\s*$') { continue }
  foreach ($m in [regex]::Matches($line, '\b(?:GOTO|GOSUB|THEN|RESUME)\s+(\d+)')) {
    [void]$targets.Add([int]$m.Groups[1].Value)
  }
  foreach ($m in [regex]::Matches($line, '\bGOSUB\s+(\d+)')) {
    [void]$gosubTgts.Add([int]$m.Groups[1].Value)
  }
  if ($line -match '\bON\b.*\bGOSUB\s+([\d,\s]+)') {
    foreach ($num in ($Matches[1] -split '[,\s]+')) {
      if ($num -match '^\d+$') { [void]$targets.Add([int]$num); [void]$gosubTgts.Add([int]$num) }
    }
  }
}

# 2. Walk lines; classify bare lines.
$toReturn = New-Object System.Collections.Generic.List[object]   # non-target bare -> RETURN
$review   = New-Object System.Collections.Generic.List[object]   # target bare -> manual
$out = New-Object System.Collections.Generic.List[string]

for ($i = 0; $i -lt $lines.Count; $i++) {
  $line = $lines[$i]
  if ($line -match '^\s*(\d+)\s*$') {
    $num = [int]$Matches[1]
    $prev = if ($i -gt 0) { $lines[$i-1].Trim() } else { '' }
    $next = if ($i -lt $lines.Count-1) { $lines[$i+1].Trim() } else { '' }
    # next line's QB number (the annotated routine start)
    $nextNum = -1
    if ($next -match '^(\d+)\b') { $nextNum = [int]$Matches[1] }

    if ($num -ge $MaxQBLine) {
      $out.Add($line)   # leave intro SUBs untouched
    } elseif ($targets.Contains($num)) {
      $review.Add([PSCustomObject]@{ Line=$num; Prev=$prev; Next=$next; Reason='is a jump target' }) | Out-Null
      $out.Add($line)
    } elseif (-not $gosubTgts.Contains($nextNum)) {
      # bare line NOT a target, but next line is NOT a GOSUB target -> mid-flow fall-through, NOT a RETURN
      $review.Add([PSCustomObject]@{ Line=$num; Prev=$prev; Next=$next; Reason="next ($nextNum) not GOSUB'd - likely fall-through" }) | Out-Null
      $out.Add($line)
    } else {
      $toReturn.Add([PSCustomObject]@{ Line=$num; Prev=$prev; Next=$next }) | Out-Null
      $out.Add("$num RETURN 'PASS2-RECON-AUTO: lost RETURN. Nothing jumps to $num and next line $nextNum is a GOSUB'd subroutine, so $num is a routine-end RETURN.")
    }
  } else {
    $out.Add($line)
  }
}

"Jump targets found: $($targets.Count)"
"Bare lines -> RETURN (non-targets, auto-convert): $($toReturn.Count)"
"Bare lines that ARE jump targets (manual review): $($review.Count)"
""
if ($review.Count -gt 0) {
  "=== Jump-target bare lines (NOT auto-converted) ==="
  foreach ($r in $review) { "  line $($r.Line): prev=[$($r.Prev)] next=[$($r.Next)]" }
  ""
}
"=== Sample of auto-convert RETURNs (first 12) ==="
foreach ($t in ($toReturn | Select-Object -First 12)) { "  $($t.Line) RETURN   (after: $($t.Prev))" }

if ($Apply) {
  [System.IO.File]::WriteAllLines($BasPath, $out)
  ""
  "APPLIED: wrote $($toReturn.Count) RETURNs to $BasPath"
} else {
  ""
  "DRY RUN - re-run with -Apply to write changes."
}
