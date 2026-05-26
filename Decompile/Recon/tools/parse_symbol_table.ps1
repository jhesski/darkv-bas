# Parses the QB4.5 decompiler symbol table from the tail of GAME6.TXT.
# The table appears twice (by name and by address); we read the first pass.
# Format example: 'L0     0036 E   L10    10A3     I14    2958 IE  I15    0CE6 IA
# Each line holds 4 entries of (name, hex address, optional flags).
# Flag letters: I=Integer, E=Established/Initialized, A=Array, S=String.
param(
  [Parameter(Mandatory=$true)][string]$Path,
  [int]$StartLine = 1909,
  [int]$EndLine = 1962
)

$lines = Get-Content $Path
$results = New-Object System.Collections.Generic.List[PSCustomObject]

for ($n = $StartLine - 1; $n -lt [Math]::Min($EndLine, $lines.Count); $n++) {
  $line = $lines[$n]
  if ($line -notmatch "^'") { continue }
  $body = $line.Substring(1)
  # Split into 4 columns of width 17 each (approx). Tolerate variable widths.
  # Flag letters are limited to {I,E,A,S}. Constraining to [IESA] prevents
  # the regex from greedily consuming the leading L/I of the NEXT variable name.
  $matches = [regex]::Matches($body, '([IL][0-9]+\$?)\s+([0-9A-Fa-f]{4})\s*([IESA]{0,4})(?=\s|$)')
  foreach ($m in $matches) {
    $name = $m.Groups[1].Value
    $addr = [Convert]::ToInt32($m.Groups[2].Value, 16)
    $flags = $m.Groups[3].Value
    $type = if ($name.StartsWith('I')) { 'Integer' }
            elseif ($name.EndsWith('$')) { 'String' }
            else { 'Long' }
    if ($flags -match 'S') { $type = 'String' }
    $isArray = $flags -match 'A'
    $isInit = $flags -match 'E'
    $results.Add([PSCustomObject]@{
      Name = $name
      Address = $addr
      AddressHex = $m.Groups[2].Value
      Flags = $flags
      Type = $type
      IsArray = $isArray
      IsInitialized = $isInit
    }) | Out-Null
  }
}

$results
