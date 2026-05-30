DECLARE SUB unsetTimer ()
DECLARE FUNCTION setupTimer# (freq#)
DECLARE FUNCTION pxl2chr$ (p1%, p2%)
DECLARE SUB loadOldPic ()
DECLARE SUB selectColor (clr%)
DECLARE FUNCTION cRGB& (r AS LONG, g AS LONG, B AS LONG)
DECLARE SUB cursor (x%, y%, cUp%, cColor%)

DEFINT A-Z
SCREEN 12

DIM KeyPress AS STRING
DIM SHARED sUnderCursor(7)
DIM SHARED false: false = 0
DIM SHARED true: true = 1

h = 479
w = 639
hm = h / 2
wm = w / 2
cX = wm
cY = hm

PALETTE 0, cRGB(5, 5, 7)
cColor = 15
cUp = true

CALL cursor(cX, cY, cUp, cColor)

' preview frame
LINE (639, 0)-(318, 201), 15, B

c = 0
FOR i = 1 TO (16 * 8) STEP 8
  LINE (i, 1)-(i + 6, 7), c, BF
  c = c + 1
NEXT i

selectColor (cColor)

DO
  KeyPress = UCASE$(INKEY$)

  SELECT CASE KeyPress

    CASE UCASE$("w")
      IF cY - 2 >= 0 THEN cY = cY - 2
      CALL cursor(cX, cY, cUp, cColor)

    CASE UCASE$("s")
      IF cY + 2 < h THEN cY = cY + 2
      CALL cursor(cX, cY, cUp, cColor)

    CASE UCASE$("d")
      IF cX + 2 < w THEN cX = cX + 2
      CALL cursor(cX, cY, cUp, cColor)

    CASE UCASE$("a")
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
      loadOldPic
  END SELECT
LOOP UNTIL KeyPress = CHR$(27)

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
  IF init = false THEN
    GET (cX, cY)-(cX + 1, cY + 1), sUnderCursor
    cX = x: cY = y
    init = true
  END IF

  ' put under graphic back
  PUT (cX, cY), sUnderCursor, PSET

  ' get new under cursor
  GET (x, y)-(x + 1, y + 1), sUnderCursor

  ' draw new cursor
  LINE (x, y)-(x + 1, y + 1), clr, B
  
  cX = x: cY = y
END SUB

SUB loadOldPic ()
  'Screen Text Segment = &HB800
  'Screen Video segment =&HA000
  '
  DIM p(8269)
  ' For screen 1 ;4 bits per pixel
  ' A Char is 8 bits 0 - 255
  DIM s(16004)
  DIM sp(319, 200)

  DIM TL(27901)
  DIM TR(27901)
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


  GET (0, 0)-(319, 339), TL(0)
  GET (320, 0)-(639, 339), TR(0)

  SCREEN 1
  DEF SEG = &HB800
    BLOAD filename, 0
  DEF SEG

  GET (0, 0)-(319, 199), s

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
  PUT (0, 0), TL(0), PSET
  PUT (320, 0), TR(0), PSET

'+-----------------+
'|   draw screen   |
'+-----------------+
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


END SUB

STATIC SUB selectColor (clr)
  LINE (x1, 0)-(x2, 8), 0, B
  x1 = clr * 8
  x2 = (clr * 8) + 8
  LINE (x1, 0)-(x2, 8), 15, B
END SUB

FUNCTION setupTimer# (frequency#)

  IF (frequency# > 1193181) OR (frequency# < 10) THEN ERROR 5'Illegal function call

  ticksPerTimer& = 1193181# / frequency#

  OUT &H43, &H34                          'Specifies a bitmask setting the timer style and initializing the ports for receiving a clock rate
  OUT &H40, ticksPerTimer& AND 255        'Send low 8 bits first
  OUT &H40, ticksPerTimer& \ 256          'Then sent high 8 bits
  setupTimer# = 1193181 / ticksPerTimer&  'And finally, return the resulting clock rate
END FUNCTION

SUB unsetTimer ()
  OUT &H43, &H34
  OUT &H40, 0 ' SET low 8 bits of trigger to 0
  OUT &H40, 0 'Set high 8 bits of trigger to 0
END SUB

