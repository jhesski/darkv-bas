# Extracts printable ASCII strings from a binary file with their byte offsets.
# Usage: powershell -File extract_strings.ps1 <input.exe> [minLength]
param(
  [Parameter(Mandatory=$true)][string]$Path,
  [int]$MinLength = 4
)

$bytes = [System.IO.File]::ReadAllBytes($Path)
$results = New-Object System.Collections.Generic.List[PSCustomObject]
$start = -1
for ($i = 0; $i -lt $bytes.Length; $i++) {
  $b = $bytes[$i]
  $printable = ($b -ge 0x20 -and $b -le 0x7E)
  if ($printable) {
    if ($start -lt 0) { $start = $i }
  } else {
    if ($start -ge 0) {
      $len = $i - $start
      if ($len -ge $MinLength) {
        $text = [System.Text.Encoding]::ASCII.GetString($bytes, $start, $len)
        $results.Add([PSCustomObject]@{
          Offset = $start
          Length = $len
          Text = $text
        }) | Out-Null
      }
      $start = -1
    }
  }
}
if ($start -ge 0) {
  $len = $bytes.Length - $start
  if ($len -ge $MinLength) {
    $text = [System.Text.Encoding]::ASCII.GetString($bytes, $start, $len)
    $results.Add([PSCustomObject]@{ Offset = $start; Length = $len; Text = $text }) | Out-Null
  }
}

$results
