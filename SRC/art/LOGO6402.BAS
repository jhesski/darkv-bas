DECLARE FUNCTION rgb2color& (r AS LONG, g AS LONG, b AS LONG)
DEFINT A-Z
DIM sp.screen(32000)
CLS
filename$ = "tp640"

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

OPEN "imga.pxt" FOR INPUT AS #1
OPEN "imgb.pxt" FOR INPUT AS #2

FOR y = 0 TO 199
    INPUT #1, s1$
    INPUT #2, s2$
  FOR x = 0 TO 639
    px1$ = MID$(s1$, x + 1, 1)
    px2$ = MID$(s2$, x + 1, 1)
    PSET (x, y), VAL("&H" + px1$)
    PSET (x, y + 200), VAL("&H" + px2$)
  NEXT x
NEXT y
CLOSE

'----------save screen
  GET (0, 0)-(639, 159), sp.screen(0)

  DEF SEG = VARSEG(sp.screen(0))
    BSAVE filename$ + ".sga", 0, 64000
  DEF SEG

  GET (0, 160)-(639, 320), sp.screen(0)

  DEF SEG = VARSEG(sp.screen(0))
    BSAVE filename$ + ".sgb", 0, 64000
  DEF SEG

  PAINT (2, 2), 15

  GET (0, 321)-(639, 479), sp.screen(0)

  DEF SEG = VARSEG(sp.screen(0))
    BSAVE filename$ + ".sgc", 0, 50884
  DEF SEG


  CLS


  '------------load screen
  DEF SEG = VARSEG(sp.screen(0))
    BLOAD filename$ + ".sga", VARPTR(sp.screen(0))

  PUT (0, 0), sp.screen(0), PSET

  DEF SEG = VARSEG(sp.screen(0))
    BLOAD filename$ + ".sgb", VARPTR(sp.screen(0))

  PUT (0, 160), sp.screen(0), PSET

  DEF SEG = VARSEG(sp.screen(0))
    BLOAD filename$ + ".sgc", VARPTR(sp.screen(0))

  PUT (0, 321), sp.screen(0), PSET


SLEEP

FUNCTION rgb2color& (r AS LONG, g AS LONG, b AS LONG)
  IF r <> 0 THEN r = (r / 255) * 63
  IF g <> 0 THEN g = (g / 255) * 63
  IF b <> 0 THEN b = (b / 255) * 63
  rgb2color& = CLNG(r + (g * 256) + (b * (256 ^ 2)))
END FUNCTION

