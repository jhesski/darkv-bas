DECLARE FUNCTION cRGB# (r AS LONG, g AS LONG, B AS LONG)
DEFINT A-Z
DIM imgDir AS STRING
DIM sp.screen(32000)

mode = 13
SCREEN mode

imgDir = ".\RES\BG\"
filename$ = "burn"

OPEN imgDir + "PXT  \" + filename$ + ".pxt" FOR INPUT AS #1

IF mode = 13 THEN
  y = 0
  DO
    INPUT #1, row$
    x = 0
    FOR i = 1 TO LEN(row$) STEP 2
      pixel$ = "&H" + MID$(row$, i, 2)
      PSET (x, y), VAL(pixel$)
      x = x + 1
    NEXT i
    y = y + 1
  LOOP UNTIL EOF(1)
  '-----------SAVE
  DEF SEG = &HA000
    BSAVE imgDir + "VGA\" + filename$ + ".vga", 0, 64000
  DEF SEG

  CLS

  '-----------LOAD
  DEF SEG = &HA000
    BLOAD imgDir + "VGA\" + filename$ + ".vga", 0
  DEF SEG


END IF
mode = 12
SCREEN 12
CLS
CLOSE
OPEN imgDir + "PXT  \" + filename$ + ".pxt" FOR INPUT AS #1
IF mode = 12 THEN
  y = 0
  DO
    INPUT #1, row$
    x = 0
    FOR i = 1 TO LEN(row$) STEP 2
      pixel$ = "&H" + MID$(row$, i, 2)
      PSET (x, y), VAL(pixel$)
      PSET (x + 1, y), VAL(pixel$)
      PSET (x, y + 1), VAL(pixel$)
      PSET (x + 1, y + 1), VAL(pixel$)
      x = x + 2
    NEXT i
    y = y + 2
  LOOP UNTIL EOF(1)

  '----------save screen
  GET (0, 0)-(639, 159), sp.screen(0)

  DEF SEG = VARSEG(sp.screen(0))
    BSAVE imgDir + "SGA\" + filename$ + ".sga", 0, 64000
  DEF SEG

  GET (0, 160)-(639, 320), sp.screen(0)

  DEF SEG = VARSEG(sp.screen(0))
    BSAVE imgDir + "SGA\" + filename$ + ".sgb", 0, 64000
  DEF SEG

  GET (0, 321)-(639, 479), sp.screen(0)

  DEF SEG = VARSEG(sp.screen(0))
    BSAVE imgDir + "SGA\" + filename$ + ".sgc", 0, 64000
  DEF SEG


  CLS

  '------------load screen
  DEF SEG = VARSEG(sp.screen(0))
    BLOAD imgDir + "SGA\" + filename$ + ".sga", VARPTR(sp.screen(0))

  PUT (0, 0), sp.screen(0), PSET

  DEF SEG = VARSEG(sp.screen(0))
    BLOAD imgDir + "SGA\" + filename$ + ".sgb", VARPTR(sp.screen(0))

  PUT (0, 160), sp.screen(0), PSET

  DEF SEG = VARSEG(sp.screen(0))
    BLOAD imgDir + "SGA\" + filename$ + ".sgc", VARPTR(sp.screen(0))

  PUT (0, 321), sp.screen(0), PSET

END IF

FUNCTION cRGB# (r AS LONG, g AS LONG, B AS LONG)
  IF r <> 0 THEN r = (r / 255) * 63
  IF g <> 0 THEN g = (g / 255) * 63
  IF B <> 0 THEN B = (B / 255) * 63
  cRGB# = CLNG(r + (g * 256) + (B * (256 ^ 2)))
END FUNCTION

