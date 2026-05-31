# ASCII-renders a column (frame) of a .PCT GET-array dump, to verify the decode
# and confirm the sprite data is present. Mirrors pct_viewer.html.
param([Parameter(Mandatory=$true)][string]$Path, [int]$Col = 0, [int]$WFix = 0, [switch]$Linear)

$lines = Get-Content $Path | Where-Object { $_.Trim() }
if ($Linear) {
  # row-major: concatenate every value in file order = one sprite (e.g. JOES.PCT)
  $ints = New-Object System.Collections.Generic.List[int]
  foreach ($line in $lines) {
    foreach ($p in ($line.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ })) {
      $v = 0; if ([int]::TryParse($p, [ref]$v)) { $ints.Add($v) }
    }
  }
} else {
  # column-per-frame: column j = frame j's GET array (e.g. JOEW1-4 = 2 walk frames)
  $cols = @{}
  foreach ($line in $lines) {
    $parts = $line.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ }
    for ($j = 0; $j -lt $parts.Count; $j++) {
      if (-not $cols.ContainsKey($j)) { $cols[$j] = New-Object System.Collections.Generic.List[int] }
      $v = 0; if ([int]::TryParse($parts[$j], [ref]$v)) { $cols[$j].Add($v) }
    }
  }
  $ints = $cols[$Col]
}
$w2 = $ints[0]; $h = $ints[1]
$width = [int][math]::Round($w2 / 2) + $WFix; $height = $h
"File: $(Split-Path $Path -Leaf)  col $Col  header=($w2,$h)  -> ${width}x${height}  ($($ints.Count) ints, $($cols.Count) cols)"
""
$bytes = New-Object System.Collections.Generic.List[int]
for ($i = 2; $i -lt $ints.Count; $i++) {
  $u = ((($ints[$i] % 65536) + 65536) % 65536)
  $bytes.Add($u -band 0xFF); $bytes.Add(($u -shr 8) -band 0xFF)
}
$bpr = [int][math]::Ceiling($width * 2 / 8)
$chars = ' ', '.', 'o', '#'
for ($y = 0; $y -lt $height; $y++) {
  $row = ""
  for ($x = 0; $x -lt $width; $x++) {
    $bi = $y * $bpr + [math]::Floor($x / 4)
    $b = if ($bi -lt $bytes.Count) { $bytes[$bi] } else { 0 }
    $shift = (3 - ($x % 4)) * 2
    $row += $chars[(($b -shr $shift) -band 3)]
  }
  $row
}
