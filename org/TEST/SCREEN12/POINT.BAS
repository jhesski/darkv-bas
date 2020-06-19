DECLARE SUB drawUi ()
DECLARE FUNCTION jInkey% ()
DECLARE SUB loadOldPic ()
DECLARE SUB selectColor (clr%)
DECLARE FUNCTION cRGB& (r AS LONG, g AS LONG, B AS LONG)
DECLARE SUB cursor (x%, y%, cUp%, cColor%)

DEFINT A-Z
SCREEN 12

CONST False = 0, True = -1

DIM KeyPress AS STRING
DIM SHARED sUnderCursor(7)
DIM SHARED showPreview: showPreview = True

DIM kbUp AS STRING: kbUp = CHR$(0) + CHR$(72)
DIM kbDn AS STRING: kbDn = CHR$(0) + CHR$(80)
DIM kbLt AS STRING: kbLt = CHR$(0) + CHR$(75)
DIM kbRt AS STRING: kbRt = CHR$(0) + CHR$(77)
DIM kbEsc AS STRING: kbEsc = CHR$(27)

h = 479
w = 639
hm = h / 2
wm = w / 2
cX = wm
cY = hm

cColor = 15
cUp = True

drawUi

cursor cX, cY, cUp, cColor

selectColor (cColor)

mainLoop:
DO
  KeyPress = INKEY$
  LOCATE 1, 1: PRINT KeyPress
  SELECT CASE UCASE$(KeyPress)
    CASE "W", kbUp
      IF cY - 2 >= 0 THEN cY = cY - 2
      CALL cursor(cX, cY, cUp, cColor)

    CASE "S", kbDn
      IF cY + 2 < h THEN cY = cY + 2
      CALL cursor(cX, cY, cUp, cColor)

    CASE "D", kbRt
      IF cX + 2 < w THEN cX = cX + 2
      CALL cursor(cX, cY, cUp, cColor)

    CASE "A", kbLt
      IF cX - 2 >= 0 THEN cX = cX - 2
      CALL cursor(cX, cY, cUp, cColor)

    CASE ","
      IF cColor > 0 THEN
        cColor = cColor - 1
        CALL cursor(cX, cY, cUp, cColor)
        selectColor (cColor)
      END IF

    CASE "."
      IF cColor < 15 THEN
        cColor = cColor + 1
        CALL cursor(cX, cY, cUp, cColor)
        selectColor (cColor)
      END IF

    CASE UCASE$("l")
      GOSUB repaintUI
  END SELECT
LOOP UNTIL KeyPress = kbEsc

LOCATE 28, 1
PRINT "Exit program?"
' GET (0, 240)-(639, 479), sHalf(0)


DO
  KeyPress$ = INKEY$
LOOP WHILE KeyPress$ = ""
             
IF UCASE$(KeyPress$) <> "Y" THEN
  'PUT (0, 240), BL(0)
  'PUT (320, 240), BR(0)
  drawUi
  GOTO mainLoop
END IF

END

repaintUI:
  loadOldPic
  cursor cX, cY, cUp, cColor
RETURN

REM $DYNAMIC
SUB cPxl2Hex (p1 AS INTEGER, p2 AS INTEGER, retunrP AS STRING)
  'returnP1 = HEX$(pi)
END SUB

DEFSNG R
FUNCTION cRGB& (r AS LONG, g AS LONG, B AS LONG)
  IF r <> 0 THEN r = (r / 255) * 63
  IF g <> 0 THEN g = (g / 255) * 63
  IF B <> 0 THEN B = (B / 255) * 63
  cRGB& = CLNG(r + (g * 256) + (B * (256 ^ 2)))
END FUNCTION

DEFINT R
STATIC SUB cursor (x, y, penUp, clr)

  '----check underCursor is valid ----
  IF init = False THEN
    GET (cX, cY)-(cX + 1, cY + 1), sUnderCursor(0)
    cX = x: cY = y
    init = True
  END IF

  ' put under graphic back
  PUT (cX, cY), sUnderCursor(0), PSET

  ' get new under cursor
  GET (x, y)-(x + 1, y + 1), sUnderCursor(0)

  ' draw new cursor
  LINE (x, y)-(x + 1, y + 1), clr, B
  
  cX = x: cY = y
END SUB

REM $STATIC
SUB drawUi ()
  PALETTE 0, cRGB(5, 5, 7)
2
  ' preview frame
  IF showPreview THEN LINE (639, 0)-(318, 201), 15, B

  colur = 0
  FOR i = 1 TO (16 * 8) STEP 8
    LINE (i, 1)-(i + 6, 7), colur, BF
    colur = colur + 1
  NEXT i

END SUB

REM $DYNAMIC
FUNCTION jInkey ()
  jInkey = INP(96)
END FUNCTION

SUB loadOldPic ()
  'Screen Text Segment = &HB800
  'Screen Video segment =&HA000
  '
  DIM p(8269)
  ' For screen 1 ;4 bits per pixel
  ' A Char is 8 bits 0 - 255
  DIM sp(319, 200)

  DIM filename AS STRING: filename = "..\org\burn.pic"
  DIM pal(3)

  '--carr.pic
  pal(1) = 2
  pal(2) = 11
  pal(3) = 6

  '--burn.pic
  pal(1) = 14
  pal(2) = 12
  pal(3) = 4


  'GET (0, 0)-(639, 339), sHalf(0)

  SCREEN 1
  DEF SEG = &HB800
  BLOAD filename, 0
  DEF SEG

  SLEEP

  'PSET (0, 0), 15
  'PSET (0, 199), 15
  'PSET (319, 0), 15
  'PSET (319, 199), 15

  FOR y = 0 TO 199
    FOR x = 0 TO 319
      sp(x, y) = pal(POINT(x, y))
      PSET (x, y), 15
    NEXT x
  NEXT y

  '+------------------------------+
  '|  screen 12  --draw data--    |
  '+------------------------------+

  SCREEN 12

  '+-----------------+
  '|   draw screen   |
  '+-----------------+

  '----2X
  doubleScale = False
  IF doubleScale THEN
    FOR y = 0 TO 199
      FOR x = 0 TO 319
        x2 = x * 2
        y2 = y * 2
        PSET (x2, y2), sp(x, y)
        PSET (x2 + 1, y2), sp(x, y)
        PSET (x2, y2 + 1), sp(x, y)
        PSET (x2 + 1, y2 + 1), sp(x, y)
      NEXT x
    NEXT y
    showPreview = False
  ELSE
    FOR y = 0 TO 199
      FOR x = 0 TO 319
        offsetX = x + 320
        offsetY = y + 1
        PSET (offsetX, offsetY), sp(x, y)
      NEXT x
    NEXT y
    showPreview = True
  END IF

  drawUi

END SUB

STATIC SUB selectColor (clr)
  LINE (x1, 0)-(x2, 8), 0, B
  x1 = clr * 8
  x2 = (clr * 8) + 8
  LINE (x1, 0)-(x2, 8), 15, B
END SUB

