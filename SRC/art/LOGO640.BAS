DECLARE FUNCTION rgb2color& (r AS LONG, g AS LONG, b AS LONG)
DEFINT A-Z
'$DYNAMIC
DIM sc(319, 199)
'$DYNAMIC
DIM sc2(319, 199)

DIM pal(255)
SCREEN 13
pal(255) = 15
pal(254) = 14
pal(253) = 13
pal(252) = 12
pal(251) = 11
pal(250) = 10
pal(249) = 9
pal(248) = 8
pal(247) = 7
pal(246) = 6
pal(245) = 5
pal(244) = 4
pal(243) = 3
pal(242) = 2
pal(241) = 1
pal(240) = 0

DEF SEG = &HA000
BLOAD "TP640C.pct"
FOR y = 0 TO 199
  FOR x = 0 TO 319
    sc(x, y) = pal(POINT(x, y))
    PSET (x, y), 15
  NEXT x
NEXT y
BLOAD "TP640D.pct"
FOR y = 0 TO 199
  FOR x = 0 TO 319
    sc2(x, y) = pal(POINT(x, y))
    PSET (x, y), 15
  NEXT x
NEXT y



CLS

SCREEN 12
PALETTE 0, rgb2color(0, 0, 0)
PALETTE 1, rgb2color(227, 227, 227)
PALETTE 2, rgb2color(140, 139, 139)
PALETTE 3, rgb2color(95, 94, 94)
PALETTE 4, rgb2color(19, 17, 16)
PALETTE 5, rgb2color(33, 30, 28)
PALETTE 6, rgb2color(48, 44, 41)
PALETTE 7, rgb2color(11, 6, 2)
PALETTE 8, rgb2color(26, 12, 1)
PALETTE 9, rgb2color(65, 32, 4)
PALETTE 10, rgb2color(44, 21, 2)
PALETTE 11, rgb2color(79, 78, 77)
PALETTE 12, rgb2color(63, 60, 57)
PALETTE 13, rgb2color(2, 1, 0)
PALETTE 14, rgb2color(186, 186, 185)
PALETTE 15, rgb2color(1, 1, 0)

FOR y = 0 TO 199
  FOR x = 0 TO 319
    PSET (x, y), sc(x, y)
    PSET (x + 320, y), sc2(x, y)
  NEXT x
NEXT y

OPEN "imgb.pxt" FOR OUTPUT AS #1

FOR y = 0 TO 199
  s$ = ""
  FOR x = 0 TO 639
    s$ = s$ + HEX$(POINT(x, y))
    PSET (x, y), 1
  NEXT x
  PRINT #1, s$
NEXT y
CLOSE

ERASE sc
ERASE sc2
SLEEP

REM $STATIC
FUNCTION rgb2color& (r AS LONG, g AS LONG, b AS LONG)
  IF r <> 0 THEN r = (r / 255) * 63
  IF g <> 0 THEN g = (g / 255) * 63
  IF b <> 0 THEN b = (b / 255) * 63
  rgb2color& = CLNG(r + (g * 256) + (b * (256 ^ 2)))
END FUNCTION

