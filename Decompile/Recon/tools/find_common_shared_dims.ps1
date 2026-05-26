# Identifies COMMON SHARED arrays that need explicit DIM statements.
# Outputs sized DIMs based on symbol-table address gaps.
param(
  [string]$DecompPath = "C:\Code\darkv-bas\Decompile\GAME6.TXT",
  [string]$BasPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS"
)

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$syms = & "$here\parse_symbol_table.ps1" -Path $DecompPath

# Read COMMON SHARED block from GAME.BAS - find arrays (with parens)
$commonArrays = New-Object System.Collections.Generic.HashSet[string]
foreach ($line in (Get-Content $BasPath)) {
  if ($line -match '^COMMON SHARED') {
    foreach ($m in [regex]::Matches($line, '([IL][0-9]+\$?)\(\)')) {
      [void]$commonArrays.Add($m.Groups[1].Value)
    }
  } elseif ($commonArrays.Count -gt 0 -and -not ($line -match '^COMMON SHARED')) {
    break
  }
}

# Match COMMON SHARED arrays against symbol table for sizing
$allSyms = $syms | Sort-Object Address
$results = New-Object System.Collections.Generic.List[PSCustomObject]
for ($i = 0; $i -lt $allSyms.Count; $i++) {
  $s = $allSyms[$i]
  if (-not $commonArrays.Contains($s.Name)) { continue }

  # Find next symbol at higher address for size estimation
  $nextAddr = if ($i -lt $allSyms.Count - 1) { $allSyms[$i + 1].Address } else { $s.Address + 200 }
  $byteSpan = $nextAddr - $s.Address

  # Bytes per element by type: integers/string descriptors=2-4
  $bytesPerElem = if ($s.Name.StartsWith('I') -or $s.Name.EndsWith('$')) { 2 } else { 4 }
  $elemCount = [Math]::Max([Math]::Ceiling($byteSpan / $bytesPerElem), 50)

  $results.Add([PSCustomObject]@{
    Name = $s.Name
    Address = $s.AddressHex
    ByteSpan = $byteSpan
    Suggested = "DIM $($s.Name)($elemCount)"
  }) | Out-Null
}

"COMMON SHARED arrays found in symbol table: $($results.Count)"
$results | Format-Table -AutoSize
"---"
"DIM block to insert:"
foreach ($r in $results) { $r.Suggested }
