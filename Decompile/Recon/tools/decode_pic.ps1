# Decodes a CGA SCREEN 1 BSAVE .pic file to an ASCII map.
# SCREEN 1: 320x200, 2 bits/pixel, 4 colors. Interleaved scanlines:
#   even rows at data offset 0, odd rows at offset 0x2000 (8192). 80 bytes/row.
# BSAVE header = 7 bytes (0xFD + seg(2) + off(2) + len(2)), pixel data follows.
param(
  [Parameter(Mandatory=$true)][string]$Path,
  [int]$X1 = 0, [int]$Y1 = 0, [int]$X2 = 319, [int]$Y2 = 199,
  [int]$StepX = 1, [int]$StepY = 1
)

$bytes = [System.IO.File]::ReadAllBytes($Path)
$base = 7  # skip BSAVE header
$chars = @(' ', '.', 'o', '#')  # color 0..3

function Get-Pixel {
  param([int]$x, [int]$y)
  if ($x -lt 0 -or $x -gt 319 -or $y -lt 0 -or $y -gt 199) { return 0 }
  $bank = $y -band 1
  $rowInBank = [int]([math]::Floor($y / 2))
  $byteOff = $base + $bank * 8192 + $rowInBank * 80 + [int]([math]::Floor($x / 4))
  if ($byteOff -ge $bytes.Length) { return 0 }
  $b = $bytes[$byteOff]
  $pairIndex = 3 - ($x -band 3)   # leftmost pixel = high bits
  return ($b -shr ($pairIndex * 2)) -band 3
}

# Column header (tens digit of X every 10 cols)
$header = "     "
for ($x = $X1; $x -le $X2; $x += $StepX) {
  if ($x % 10 -eq 0) { $header += ("{0,-10}" -f $x); $x += ($StepX * 0) }
}
Write-Output $header

for ($y = $Y1; $y -le $Y2; $y += $StepY) {
  $line = ("{0,4} " -f $y)
  for ($x = $X1; $x -le $X2; $x += $StepX) {
    $line += $chars[(Get-Pixel -x $x -y $y)]
  }
  Write-Output $line
}
