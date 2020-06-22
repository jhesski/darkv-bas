DEFINT A-Z
'$dynamic
DIM g.screen.1(640 * 480 + 4)
DIM SHARED s.UnderCur(2 * 2 + 4)

'--- Screen object
CONST screen.width = 639
CONST screen.height = 479
CONST screen.midW = screen.width / 2
CONST screen.midH = screen.height / 2

CONST false = 0
CONST true = -1
CONST color.12.white = 15

'--- Cursor object
DIM SHARED cur.X: cur.X = screen.midW
DIM SHARED cur.Y: cur.Y = screen.midH
DIM SHARED cur.penUp: cur.penUp = true
DIM SHARED cur.color: cur.color = color.12.white

'--- keyboard char code.
DIM kbUp AS STRING: kbUp = CHR$(0) + CHR$(72)
DIM kbDn AS STRING: kbDn = CHR$(0) + CHR$(80)
DIM kbLt AS STRING: kbLt = CHR$(0) + CHR$(75)
DIM kbRt AS STRING: kbRt = CHR$(0) + CHR$(77)
DIM kbEsc AS STRING: kbEsc = CHR$(27)


SCREEN 12
CLS

LINE (0, 0)-(639, 479), 8, BF
PSET (0, 0), 15
PSET (0, 479), 15
PSET (639, 0), 15
PSET (639, 479), 15

GET (0, 0)-(639, 479), g.screen.1(0)

CLS

ui.drawUi
ui.drawCursor cur.X, cur.Y, cur.penUp, cur.color

DO
  keyPressed$ = INKEY$
  updateCursor = false
  SELECT CASE UCASE$(keyPressed$)
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
      END IF
    CASE "."
      IF cur.color < 15 THEN
        cur.color = cur.color + 1
        updateCursor = true
      END IF
  END SELECT
  IF updateCursor THEN ui.drawCursor cur.X, cur.Y, cur.penUp, cur.color
LOOP UNTIL keyPressed$ = CHR$(27)




SUB ui.drawUi
  '---- draw color palette
  FOR i = 0 TO 15
    offset = 5 * i
    LINE (offset + 2, 1)-(offset + 5, 5), i, BF
  NEXT i

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

