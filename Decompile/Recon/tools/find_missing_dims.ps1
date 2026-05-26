# Identifies array variables present in GAME6.TXT's symbol table but missing
# from the COMMON SHARED block at the top of GAME.BAS. Spring captured the
# COMMON SHARED declarations but dropped the local DIM statements.
#
# Estimates array sizes from address spacing in the symbol table when possible.
param(
  [string]$DecompPath = "C:\Code\darkv-bas\Decompile\GAME6.TXT",
  [string]$BasPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS"
)

$here = Split-Path -Parent $MyInvocation.MyCommand.Path

# Parse symbol table - all entries flagged as Array
$syms = & "$here\parse_symbol_table.ps1" -Path $DecompPath
$arraySyms = $syms | Where-Object { $_.IsArray } | Sort-Object Address

# Estimate sizes by looking at gap to next variable's address
for ($i = 0; $i -lt $arraySyms.Count; $i++) {
  $next = if ($i -lt $arraySyms.Count - 1) { $arraySyms[$i + 1].Address } else { $arraySyms[$i].Address + 100 }
  $bytesSpan = $next - $arraySyms[$i].Address
  $arraySyms[$i] | Add-Member -NotePropertyName ByteSpan -NotePropertyValue $bytesSpan -Force
}

# Parse COMMON SHARED block from GAME.BAS - everything declared with `name(`
$basText = Get-Content $BasPath -Raw
$commonBlock = ''
foreach ($line in (Get-Content $BasPath)) {
  if ($line -match '^COMMON SHARED') { $commonBlock += $line + "`n" }
  elseif ($commonBlock -ne '') { break }
}
$commonArrays = New-Object System.Collections.Generic.HashSet[string]
foreach ($m in [regex]::Matches($commonBlock, '([IL][0-9]+\$?)\(\)')) {
  [void]$commonArrays.Add($m.Groups[1].Value)
}

# Diff: arrays in symbol table but NOT in COMMON SHARED
$missing = $arraySyms | Where-Object { -not $commonArrays.Contains($_.Name) }

"Total arrays in symbol table: $($arraySyms.Count)"
"Arrays declared in COMMON SHARED: $($commonArrays.Count)"
"Arrays missing from COMMON SHARED (need local DIM): $($missing.Count)"
""
"| Name | Address | ByteSpan | Suggested DIM |"
"|------|---------|----------|---------------|"
foreach ($a in $missing) {
  # Suggested DIM size: assume INTEGER (2 bytes/element). Round up.
  $intElems = [Math]::Ceiling($a.ByteSpan / 2)
  # But that's likely too tight if the next var is offset by a small gap.
  # Use generous fallback: max(intElems, 100).
  $dimSize = [Math]::Max($intElems, 100)
  "| $($a.Name) | 0x$($a.AddressHex) | $($a.ByteSpan) | DIM $($a.Name)($dimSize) |"
}
