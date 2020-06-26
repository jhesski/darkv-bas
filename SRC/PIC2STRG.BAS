DECLARE SUB switchPal (BYVAL filename AS STRING, pal%())
DECLARE FUNCTION pad$ (strg AS STRING)
DECLARE FUNCTION pad4$ (strg AS STRING)
DEFINT A-Z
DIM imgDir AS STRING

SCREEN 1

vidSeg = &HA000
imgDir = "..\org\"
filename$ = "rack"

DIM pal(4)
pal(1) = 11: pal(2) = 13: pal(3) = 15
switchPal filename$, pal()

PALETTE 0, pal(0)
PALETTE 1, pal(1)
PALETTE 2, pal(2)
PALETTE 3, pal(3)

PRINT vidSeg

DEF SEG = vidSeg
  BLOAD imgDir + filename$ + ".pic"
DEF SEG

OPEN ".\RES\BG\" + filename$ + ".pxt" FOR OUTPUT AS #1
FOR y = 0 TO 199
  line$ = ""
  FOR x = 0 TO 319
    line$ = line$ + pad$(HEX$(pal(POINT(x, y))))
    PSET (x, y), 15
  NEXT x
  PRINT #1, line$
NEXT y
CLOSE

FUNCTION pad$ (strg AS STRING)
  pad$ = RIGHT$("0000" + strg, 2)
END FUNCTION

SUB switchPal (BYVAL filename AS STRING, pal())
  blue = 1: green = 2
  cyan = 3: red = 4
  magenta = 5: orange = 6
  lightGray = 7: gray = 8
  lightBlue = 9: lightGreen = 10
  lightCyan = 11: lightOrange = 12
  lightMagenta = 13: yellow = 14
  white = 15

  IF MID$(filename, 1, 4) = "room" THEN filename = "room"
  SELECT CASE filename
    CASE "book"
      pal(1) = lightGray: pal(2) = green: pal(3) = white
    CASE "burn"
      pal(1) = yellow: pal(2) = lightOrange: pal(3) = red
      'pal(1) = white: pal(2) = yellow: pal(3) = lightOrange
    CASE "carr"
      pal(1) = green: pal(2) = lightCyan: pal(3) = orange
    CASE "death"
      pal(1) = lightGray: pal(2) = red: pal(3) = lightOrange
    CASE "desk"
      pal(1) = lightGray: pal(2) = lightOrange: pal(3) = orange
    CASE "dindead"
      pal(1) = lightOrange: pal(2) = gray: pal(3) = orange
    CASE "end"
      pal(1) = gray: pal(2) = red: pal(3) = yellow
    CASE "end1"
      pal(1) = gray: pal(2) = cyan: pal(3) = yellow
    CASE "end2"
      pal(1) = gray: pal(2) = green: pal(3) = orange
    CASE "enter"
      pal(1) = gray: pal(2) = blue: pal(3) = orange
    CASE "hill"
      pal(1) = green: pal(2) = lightCyan: pal(3) = cyan
    CASE "lightn"
      pal(1) = blue: pal(2) = lightBlue: pal(3) = white
    CASE "map1"
      pal(1) = orange: pal(2) = red: pal(3) = gray
    CASE "openclos"
      pal(1) = green: pal(2) = cyan: pal(3) = gray
    CASE "rack"
      pal(1) = lightGray: pal(2) = magenta: pal(3) = orange
    CASE "room"
      pal(1) = gray: pal(2) = blue: pal(3) = orange
    CASE "safe"
      pal(1) = gray: pal(2) = lightGray: pal(3) = white
    CASE "table"
      pal(1) = green: pal(2) = red: pal(3) = gray
    CASE "talk"
      pal(1) = lightOrange: pal(2) = orange: pal(3) = gray
    CASE "title"
      pal(1) = lightCyan: pal(2) = lightBlue: pal(3) = blue
    CASE "window"
      pal(1) = blue: pal(2) = green: pal(3) = gray
  END SELECT
END SUB

