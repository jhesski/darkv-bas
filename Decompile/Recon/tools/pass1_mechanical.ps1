# Pass 1 mechanical conversion of Spring decompiler output to compilable QB4.5.
#
# Structure observed in GAME6.TXT:
#   - Lines 110..~15530: main program at module level (no SUB wrapper)
#   - Lines 15540..16740: real SUB S15540 ... End Sub
#   - Lines 16760..18670: real SUB S16760 ... End Sub
#
# Spring's emission rules:
#   - `<linenum> Subroutine S<target>` -- pseudo-annotation marking that
#     line <target> below is a jump target. NOT real BASIC. Delete.
#   - Variants observed: `Subroutune` (typo), `Subroutine 10840` (no S prefix),
#     `      Subroutine S10820` (indented, no leading QB line number).
#   - `Call S<num>` -- a real CALL to a SUB named S<num>. KEEP AS-IS.
#   - `GOSUB S<num>` / `GoSub S<num>` -- GOSUB to QB line number <num>, with
#     Spring's S prefix that isn't valid QB syntax. STRIP THE S.
#   - `GOTO S<num>` / `GoTo S<num>` -- same as GOSUB. STRIP THE S.
#   - `SUB S<num>` -- real subroutine declaration. KEEP.
#   - `End Sub` paired with a SUB -- KEEP.
#
# Idempotent: safe to re-run.
param(
  [string]$InPath = "C:\Code\darkv-bas\Decompile\GAME6.TXT",
  [string]$OutPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS"
)

$lines = Get-Content $InPath
$out = New-Object System.Collections.Generic.List[string]
$stats = @{
  SubroutineDeleted = 0
  SubroutineDeletedIndented = 0
  SPrefixStripped = 0
}

for ($i = 0; $i -lt $lines.Count; $i++) {
  $line = $lines[$i]

  # Rule 1: handle `Subroutine SNNNN` / `Subroutune SNNNN` (typo) /
  # `Subroutine NNNN` annotation lines. Two sub-cases:
  #
  #   1a) `<linenum> Subroutine S?<target>` -- has a leading QB line number.
  #       This line number may itself be a GOTO/GOSUB target elsewhere in
  #       the program (Spring's annotations don't always point to truly
  #       redundant labels). REPLACE with just the line number as a bare
  #       label, so the target is preserved.
  #
  #   1b) `      Subroutine S<target>` -- no leading QB line number,
  #       indented. Pure section-marker annotation, safe to fully delete.
  #
  # Must NOT match `SUB SNNNN` (real declaration - all caps SUB).
  if ($line -match '^\s*(\d+)\s+(Subroutine|Subroutune)\s+S?\d+\s*$' -or
      $line -match '^\s*(\d+)\s+(Subroutine|Subroutune)\s+S\?\?\?\?\s*$') {
    $stats.SubroutineDeleted++
    # Keep the line number as a bare label so GOTO/GOSUB targets stay valid.
    $out.Add($Matches[1])
    continue
  }
  if ($line -match '^\s+(Subroutine|Subroutune)\s+S?\d+\s*$' -or
      $line -match '^\s+(Subroutine|Subroutune)\s+S\?\?\?\?\s*$') {
    $stats.SubroutineDeletedIndented++
    continue
  }

  # Rule 2: strip `S` prefix from line-number targets after GOSUB/GOTO.
  # Spring emits `GOSUB S12280` where 12280 is a QB line number; real
  # syntax is `GOSUB 12280`.
  $converted = [regex]::Replace($line, '\b(GOSUB|GoSub|GOTO|GoTo)\s+S(\d+)\b', {
    param($m); $script:stats.SPrefixStripped++; "$($m.Groups[1].Value) $($m.Groups[2].Value)"
  })

  $out.Add($converted)
}

[System.IO.File]::WriteAllLines($OutPath, $out)

"Wrote $OutPath"
"  Source lines: $($lines.Count)"
"  Output lines: $($out.Count)"
"  Subroutine annotations -> bare line-number labels: $($stats.SubroutineDeleted)"
"  Indented Subroutine annotations fully deleted: $($stats.SubroutineDeletedIndented)"
"  GOSUB/GOTO S-prefix stripped: $($stats.SPrefixStripped)"
