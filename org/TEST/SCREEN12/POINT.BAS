DECLARE SUB setMouse (mx%, my%, b1%, b2%)
DECLARE SUB drawUI ()
DECLARE FUNCTION jInkey% ()
DECLARE SUB loadOldPic ()
DECLARE SUB selectColor (clr%)
DECLARE FUNCTION cRGB& (r AS LONG, g AS LONG, B AS LONG)
DECLARE SUB cursor (x%, y%, cUp%, cColor%)
DECLARE SUB getMouse (mx%, my%, b1%, b2%)

DEFINT A-Z
SCREEN 12

CONST false = 0, true = -1
CONST mouse = 51' The mouse driver uses interupt 51
DIM KeyPress AS STRING
DIM SHARED sUnderCursor(7)
DIM SHARED showPreview: showPreview = true
DIM SHARED mx
DIM SHARED my
DIM SHARED b1
DIM SHARED b2

DIM kbUp AS STRING: kbUp = CHR$(0) + CHR$(72)
DIM kbDn AS STRING: kbDn = CHR$(0) + CHR$(80)
DIM kbLt AS STRING: kbLt = CHR$(0) + CHR$(75)
DIM kbRt AS STRING: kbRt = CHR$(0) + CHR$(77)
DIM kbEsc AS STRING: kbEsc = CHR$(27)

h = 479
w = 639
hm = h / 2
wm = w / 2
CX = wm
cY = hm

cColor = 15
cUp = true

drawUI

cursor CX, cY, cUp, cColor

selectColor (cColor)

mainLoop:
DO
	lx = mx: ly = my

	CALL getMouse(mx, my, b1, b2)
	CX = mx: cY = my
	LOCATE 1, 1

	KeyPress = INKEY$
	SELECT CASE UCASE$(KeyPress)
		CASE "W", kbUp
			IF cY - 2 >= 0 THEN cY = cY - 2
			CALL cursor(CX, cY, cUp, cColor)
			CALL setMouse(CX, cY, b1, b2)
			ly = cY
		CASE "S", kbDn
			IF cY + 2 < h THEN cY = cY + 2
			CALL cursor(CX, cY, cUp, cColor)
			CALL setMouse(CX, cY, b1, b2)
			ly = cY
		CASE "D", kbRt
			IF CX + 2 < w THEN CX = CX + 2
			CALL cursor(CX, cY, cUp, cColor)
			CALL setMouse(CX, cY, b1, b2)
			lx = CX
		CASE "A", kbLt
			IF CX - 2 >= 0 THEN CX = CX - 2
			CALL cursor(CX, cY, cUp, cColor)
			CALL setMouse(CX, cY, b1, b2)
			lx = CX
		CASE ","
			IF cColor > 0 THEN
				cColor = cColor - 1
				CALL cursor(CX, cY, cUp, cColor)
				selectColor (cColor)
			END IF

		CASE "."
			IF cColor < 15 THEN
				cColor = cColor + 1
				CALL cursor(CX, cY, cUp, cColor)
				selectColor (cColor)
			END IF

		CASE UCASE$("l")
			GOSUB repaintUI
	END SELECT
	IF lx <> mx THEN
		CALL cursor(mx, my, cUp, cColor): drawUI
	END IF
	IF ly <> my THEN
		CALL cursor(mx, my, cUp, cColor): drawUI
	END IF
	
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
	drawUI
	GOTO mainLoop
END IF

END

repaintUI:
	loadOldPic
	cursor CX, cY, cUp, cColor
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
	IF init = false THEN
		GET (CX, cY)-(CX + 1, cY + 1), sUnderCursor(0)
		CX = x: cY = y
		init = true
	END IF

	IF CX >= 638 THEN CX = 638
	IF cY >= 478 THEN cY = 478

	' put under graphic back
	PUT (CX, cY), sUnderCursor(0), PSET

	' get new under cursor
	GET (x, y)-(x + 1, y + 1), sUnderCursor(0)

	' draw new cursor
	LINE (x, y)-(x + 1, y + 1), clr, B
	
	CX = x: cY = y
END SUB

REM $STATIC
SUB drawUI ()
	PALETTE 0, cRGB(7, 5, 5)
	' preview frame
	IF showPreview THEN LINE (639, 0)-(318, 201), 15, B

	colur = 0
	FOR i = 1 TO (16 * 8) STEP 8
		LINE (i, 1)-(i + 6, 7), colur, BF
		colur = colur + 1
	NEXT i

END SUB

SUB getMouse (mx, my, b1, b2)
	DIM inary(7) AS INTEGER, outary(7) AS INTEGER
	inary(0) = 3

	CALL INT86OLD(mouse, inary(), outary())

	mx = outary(2) '==For screen mode 12 we don't need this / 2
	my = outary(3)
	bbb = outary(1)

	SELECT CASE bbb
		CASE 0
			b1 = false
			b2 = false
		CASE 1
			b1 = true
			b2 = false
		CASE 2
			b1 = false
			b2 = true
		CASE 3
			b1 = true
			b2 = true
	END SELECT

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
	doubleScale = false
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
		showPreview = false
	ELSE
		FOR y = 0 TO 199
			FOR x = 0 TO 319
				offsetX = x + 320
				offsetY = y + 1
				PSET (offsetX, offsetY), sp(x, y)
			NEXT x
		NEXT y
		showPreview = true
	END IF

	drawUI

END SUB

STATIC SUB selectColor (clr)
	LINE (x1, 0)-(x2, 8), 0, B
	x1 = clr * 8
	x2 = (clr * 8) + 8
	LINE (x1, 0)-(x2, 8), 15, B
END SUB

REM $STATIC
SUB setMouse (mx, my, b1, b2)
	DIM inary(7) AS INTEGER, outary(7) AS INTEGER
	inary(0) = 3

	inary(2) = mx
	inary(3) = my
	
	IF b1 AND b2 THEN bbb = 3
	IF b1 AND NOT b2 THEN bbb = 1
	IF NOT b1 AND b2 THEN bbb = 2
	IF NOT b1 AND NOT b2 THEN bbb = 0

	CALL INT86OLD(mouse, inary(), outary())

	mx = outary(2) '==For screen mode 12 we don't need this / 2
	my = outary(3)
	bbb = outary(1)

	SELECT CASE bbb
		CASE 0
			b1 = false
			b2 = false
		CASE 1
			b1 = true
			b2 = false
		CASE 2
			b1 = false
			b2 = true
		CASE 3
			b1 = true
			b2 = true
	END SELECT

END SUB

