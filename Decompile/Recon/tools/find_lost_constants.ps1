# Finds lost constants: symbols the EXE symbol-table gives a compile-time VALUE for
# (no type flag), that our reconstructed code USES but never ASSIGNS - so they
# silently default to 0 (the Spring "lost DATA/READ init" failure mode).
#
# Symbol-table column is a VALUE for constants (no flag) and an ADDRESS for runtime
# vars (flagged E/I/S/A). Proven: L145=003B=59, L191=0047=71, L466=0041=65 all match
# values derived independently; and L467=004A / L632=004B are 1 byte apart, impossible
# as addresses. So: no-flag entry == constant whose value is the hex shown.
param([string]$BasPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS")

$lines = Get-Content $BasPath

# --- 1. constants from the symbol table (comment lines, no-flag entries) ---
$consts = [ordered]@{}
foreach ($line in $lines) {
  if ($line -notmatch "^'") { continue }                       # symbol table lives in comments
  foreach ($m in [regex]::Matches($line, '([IL][0-9]+\$?)\s+([0-9A-Fa-f]{4})(\s+[IESA]{1,4}(?![0-9]))?')) {
    if ($m.Groups[3].Success) { continue }                     # has a flag -> runtime var (address), skip
    $name = $m.Groups[1].Value
    if ($name.EndsWith('$')) { continue }                      # strings aren't numeric consts
    if (-not $consts.Contains($name)) { $consts[$name] = [Convert]::ToInt32($m.Groups[2].Value, 16) }
  }
}

# --- 2. code = every non-comment line (incl. the un-numbered init block at top) ---
$code = $lines | Where-Object { $_ -notmatch "^\s*'" }
$codeText = ($code -join "`n")
# "used" must mean a real reference, NOT a COMMON SHARED / DIM declaration
$useText  = (($code | Where-Object { $_ -notmatch '\b(COMMON|DIM)\b' }) -join "`n")

function Used($n)     { [regex]::IsMatch($useText, "(?<![A-Za-z0-9_])$n(?![A-Za-z0-9_\$])") }
function Assigned($n) {
  foreach ($cl in $code) {
    if ($cl -match "(?:^\s*\d*\s*|:\s*|\bTHEN\s+)$n\s*=")                     { return $true } # LET-style assign
    if ($cl -match "\bFOR\s+$n\s*=")                                          { return $true } # FOR counter
    if ($cl -match "\b(INPUT|READ)\b.*(?<![A-Za-z0-9_])$n(?![A-Za-z0-9_\$])") { return $true } # value-read only; DIM/SHARED are declarations, not assignments
    if ($cl -match "\bGET\b.*,\s*$n(?![A-Za-z0-9_\$])")                       { return $true } # graphics GET buffer
  }
  return $false
}

$lost = @(); $ok = @()
foreach ($name in $consts.Keys) {
  $val = $consts[$name]
  if ($val -eq 0) { continue }                                 # symbol value 0 -> nothing to recover
  if (-not (Used $name)) { continue }                          # not referenced -> irrelevant
  $row = [pscustomobject]@{ Name=$name; Value=$val; Hex=('0x{0:X4}' -f $val) }
  if (Assigned $name) { $ok += $row } else { $lost += $row }
}

"Constants in symbol table (no-flag, non-zero, used in code): $($lost.Count + $ok.Count)"
""
"==================  LOST: used but NEVER assigned -> defaulting to 0  =================="
if ($lost.Count) { $lost | Sort-Object Value | Format-Table Name, Value, Hex -AutoSize | Out-String | Write-Output }
else { "  (none - all used constants are initialized)" }
""
"==================  OK: already assigned somewhere  =================="
$ok | Sort-Object Name | Format-Table Name, Value -AutoSize | Out-String | Write-Output
