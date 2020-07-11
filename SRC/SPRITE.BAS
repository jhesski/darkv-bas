DECLARE FUNCTION g.RGB& (r AS LONG, g AS LONG, b AS LONG)
DEFINT A-Z

DIM spJoe1(21, 32)
DIM spJoe2(21, 32)
DIM spJoe1M(21, 32)
DIM spJoe2M(21, 32)

DIM joe13_1(364)
DIM joe13_2(364)
DIM joe13_1M(365)
DIM joe13_2M(365)

DIM spriteFolder AS STRING
DIM artFolder AS STRING

DIM joe1(130)
DIM joe2(130)
DIM pal(255)
pal(1) = 8: pal(2) = 1: pal(3) = 6

spriteFolder = ".\res\sp\"
artFolder = ".\art\"
SCREEN 1
PALETTE 1, 8: PALETTE 2, 1: PALETTE 3, 6

OPEN spriteFolder + "joew2.pct" FOR INPUT AS #1

FOR i = 0 TO 125
  INPUT #1, joe1(i), joe2(i)
NEXT i
CLOSE

PUT (0, 0), joe1(0)
PUT (22, 0), joe2(0)


'----Create sprite
FOR y = 0 TO 30
  FOR x = 0 TO 21
    spJoe1(x, y) = pal(POINT(x, y))
    spJoe2(x, y) = pal(POINT(x + 22, y))
  NEXT x
NEXT y

'+==========================+
'|   Convert to screen 13   |
'+==========================+
SCREEN 13

CLS

PALETTE 255, g.RGB(255, 255, 255)

FOR y = 0 TO 30
  FOR x = 0 TO 21
    PSET (x, y), spJoe1(x, y)
    PSET (x + 22, y), spJoe2(x, y)
  NEXT x
NEXT y

DEF SEG = VARSEG(joe13_1M(0))
  BLOAD artFolder + "joe01m.pct", VARPTR(joe13_1M(0))

DEF SEG = VARSEG(joe13_2M(0))
  BLOAD artFolder + "joe02m.pct", VARPTR(joe13_2M(0))
DEF SEG = 0

CLOSE

pal(255) = 15

'---- Get sprints
GET (0, 0)-(21, 32), joe13_1(0)
GET (22, 0)-(43, 32), joe13_2(0)

CLS

'----Put the sprits
PUT (0, 0), joe13_1, PSET
PUT (23, 0), joe13_2, PSET
PUT (0, 31), joe13_1M(0), PSET
PUT (23, 31), joe13_2M(0), PSET


'----Parse sprite masks
FOR y = 0 TO 30
  FOR x = 0 TO 21
    spJoe1M(x, y) = pal(POINT(x, y + 31))
    spJoe2M(x, y) = pal(POINT(x + 23, y + 31))
  NEXT x
NEXT y


OPEN spriteFolder + "joew2.pga" FOR OUTPUT AS #1


'PRINT joe13_1M(30)
'PRINT joe13_1M(31)

WRITE #1, "joew1", "joew1 mask", "joew2", "joew2 mask"
FOR i = 0 TO 364
  WRITE #1, joe13_1(i), joe13_1M(i), joe13_2(i), joe13_2M(i)
NEXT i

CLOSE

SLEEP

'+==========================+
'|   Convert to screen 12   |
'+==========================+

SCREEN 12

FOR y = 0 TO 30
  FOR x = 0 TO 21
    x2 = x * 2
    y2 = y * 2
    PSET (x2, y2), spJoe1(x, y)
    PSET (x2 + 1, y2), spJoe1(x, y)
    PSET (x2, y2 + 1), spJoe1(x, y)
    PSET (x2 + 1, y2 + 1), spJoe1(x, y)

    PSET (x2 + 46, y2), spJoe2(x, y)
    PSET (x2 + 47, y2), spJoe2(x, y)
    PSET (x2 + 46, y2 + 1), spJoe2(x, y)
    PSET (x2 + 47, y2 + 1), spJoe2(x, y)

    PSET (x2, y2 + 62), spJoe1M(x, y)
    PSET (x2 + 1, y2 + 62), spJoe1M(x, y)
    PSET (x2, y2 + 63), spJoe1M(x, y)
    PSET (x2 + 1, y2 + 63), spJoe1M(x, y)

    PSET (x2 + 46, y2 + 62), spJoe2M(x, y)
    PSET (x2 + 47, y2 + 62), spJoe2M(x, y)
    PSET (x2 + 46, y2 + 63), spJoe2M(x, y)
    PSET (x2 + 47, y2 + 63), spJoe2M(x, y)
  NEXT x
NEXT y

DIM foo1(745)
DIM foo2(745)
DIM foo3(745)
DIM foo4(745)

GET (0, 0)-(43, 61), foo1(0)
GET (46, 0)-(89, 61), foo2(0)
GET (0, 62)-(43, 123), foo3(0)
GET (46, 62)-(89, 123), foo4(0)

OPEN spriteFolder + "joew2.psg" FOR OUTPUT AS #1
WRITE #1, "joew1", "joew1 mask", "joew2", "joew2 mask"
FOR i = 0 TO 745
  WRITE #1, foo1(i), foo2(i), foo3(i), foo4(i)
NEXT i

CLOSE

FUNCTION g.RGB& (r AS LONG, g AS LONG, b AS LONG)
  IF r <> 0 THEN r = (r / 255) * 63
  IF g <> 0 THEN g = (g / 255) * 63
  IF b <> 0 THEN b = (b / 255) * 63
  g.RGB& = CLNG(r + (g * 256) + (b * (256 ^ 2)))
END FUNCTION

