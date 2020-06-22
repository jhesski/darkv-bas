DEFINT A-Z
'$dynamic
DIM g.screen.1(640 * 480 + 4)
DIM SHARED s.UnderCur(2 * 2 + 4)

DIM keyPressed AS STRING

'--- Screen object
CONST screen.width = 639
CONST screen.height = 479
CONST screen.midW = screen.width / 2
CONST screen.midH = screen.height / 2
CONST screen.topRight = "TR"

CONST false = 0
CONST true = -1
CONST color.12.white = 15

'--- Cursor object
DIM SHARED cur.X: cur.X = screen.midW
DIM SHARED cur.Y: cur.Y = screen.midH
DIM SHARED cur.penUp: cur.penUp = true
DIM SHARED cur.color: cur.color = color.12.white
DIM SHARED DirList$(100)


DIM SHARED ui.previewWindow: ui.previewWindow = true
DIM SHARED ui.previewLocation AS STRING: ui.previewLocation = screen.topRight

'--- keyboard char code.
DIM kbUp AS STRING: kbUp = CHR$(0) + CHR$(72)
DIM kbDn AS STRING: kbDn = CHR$(0) + CHR$(80)
DIM kbLt AS STRING: kbLt = CHR$(0) + CHR$(75)
DIM kbRt AS STRING: kbRt = CHR$(0) + CHR$(77)
DIM kbEsc AS STRING: kbEsc = CHR$(27)

SCREEN 12

GET (0, 0)-(639, 479), g.screen.1(0)

CLS

ui.drawUi
ui.selectColor (cur.color)
ui.drawCursor cur.X, cur.Y, cur.penUp, cur.color

foo$ = DIR$("..\org\*.pic")
PRINT UBOUND(DirList$)
SLEEP
FOR i = 0 TO UBOUND(DirList$)
  IF DirList$(i) <> "" THEN PRINT DirList$(i)
NEXT i

DO
  keyPressed$ = INKEY$
  updateCursor = false
  SELECT CASE UCASE$(keyPressed)
    CASE "W", kbUp
      cur.Y = cur.Y - 2: updateCursor = true
    CASE "S", kbDn
      cur.Y = cur.Y + 2: updateCursor = true
    CASE "D", kbRt
      cur.X = cur.X + 2: updateCursor = true
    CASE "A", kbLt
      cur.X = cur.X - 2: updateCursor = true
    CASE ","
      IF cur.color > 0 THEN
        cur.color = cur.color - 1
        updateCursor = true
        ui.selectColor cur.color
      END IF
    CASE "."
      IF cur.color < 15 THEN
        cur.color = cur.color + 1
        updateCursor = true
        ui.selectColor cur.color
      END IF
  END SELECT
  IF updateCursor THEN ui.drawCursor cur.X, cur.Y, cur.penUp, cur.color
LOOP UNTIL keyPressed = kbEsc


'+------------------+
'|       SUBS       |
'+------------------+
SUB ui.drawUi
  PALETTE 0, g.RGB(5, 5, 7)
  '---- draw color palette
  FOR i = 0 TO 15
    offset = 6 * i
    LINE (offset + 1, 1)-(offset + 5, 5), i, BF
  NEXT i

  '---- draw preview window
  IF ui.previewWindow THEN LINE (318, 0)-(639, 201), 15, B
END SUB

SUB ui.selectColor (colur) STATIC
  LINE (x1, 0)-(x2, 6), 0, B
  x1 = colur * 6
  x2 = (colur * 6) + 6
  PSET (x1, 5), 15
  DRAW "D1 R1 B R4 R1 U1"
END SUB


SUB ui.drawCursor (x, y, penUp, colur) STATIC
  IF init = false THEN
    GET (CX, CY)-(CX + 1, CY + 1), s.UnderCur(0)
    CX = x: CY = y
    init = true
  END IF

  IF x <= 0 THEN x = 0
  IF y <= 0 THEN y = 0

  IF x >= screen.width - 1 THEN x = screen.width - 1
  IF y >= screen.height - 1 THEN y = screen.height - 1

  IF CX <= 0 THEN CX = 0
  IF CY <= 0 THEN CY = 0

  ' put under graphic back
  PUT (CX, CY), s.UnderCur(0), _CLIP PSET

  ' get new under cursor
  GET (x, y)-(x + 1, y + 1), s.UnderCur(0), offscreenColor

  ' draw new cursor
  LINE (x, y)-(x + 1, y + 1), colur, B

  CX = x: CY = y
END SUB

FUNCTION g.RGB& (r AS LONG, g AS LONG, B AS LONG)
  IF r <> 0 THEN r = (r / 255) * 63
  IF g <> 0 THEN g = (g / 255) * 63
  IF B <> 0 THEN B = (B / 255) * 63
  g.RGB& = CLNG(r + (g * 256) + (B * (256 ^ 2)))
END FUNCTION


FUNCTION DIR$ (spec$)
  CONST TmpFile$ = "DIR$INF0.INF", ListMAX% = 500 'change maximum to suit your needs
  SHARED DIRCount% 'returns file count if desired
  STATIC Index%, tempFilename$
  IF spec$ > "" THEN 'get file names when a spec is given
    SHELL _HIDE "DIR " + spec$ + " /b > " + TmpFile$
    Index% = 0: DirList$(Index%) = "": ff% = FREEFILE
    OPEN TmpFile$ FOR APPEND AS #ff%
    size& = LOF(ff%)
    CLOSE #ff%
    IF size& = 0 THEN KILL TmpFile$: EXIT FUNCTION
    OPEN TmpFile$ FOR INPUT AS #ff%
    DO WHILE NOT EOF(ff%) AND Index% < ListMAX%
      Index% = Index% + 1
      LINE INPUT #ff%, tempFilename$
      IF tempFilename$ <> "" THEN DirList$(Index%) = tempFilename$
    LOOP
    DIRCount% = Index% 'SHARED variable can return the file count
    CLOSE #ff%
    KILL TmpFile$
  ELSE IF Index% > 0 THEN Index% = Index% - 1 'no spec sends next file name
  END IF
  REDIM _PRESERVE DirList$(0 TO DIRCount%)
  DIR$ = DirList$(Index%)
END FUNCTION


