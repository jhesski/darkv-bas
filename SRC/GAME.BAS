DECLARE SUB intro.tenthPlay ()
DECLARE FUNCTION rgb2Color& (r AS LONG, g AS LONG, b AS LONG)
DECLARE FUNCTION Exist% (filename AS STRING)
DECLARE SUB intro.enter ()
DECLARE SUB intro.hill ()
DECLARE SUB intro.car ()
DECLARE SUB loadBG (imageName AS STRING)
DECLARE SUB delay (ms%)
DEFINT A-Z

SCREEN 13, 0

DIM SHARED imageFolder AS STRING
DIM SHARED dataFolder AS STRING
DIM SHARED spriteFolder AS STRING
imageFolder = ".\res\bg\vga\"
spriteFolder = ".\res\sp\"
'dataFolder = ".\res\data\"

intro:
intro.tenthPlay
intro.car
intro.hill
intro.enter
SLEEP

SUB delay (ms)
	start# = TIMER
	DO
	LOOP WHILE INT((TIMER - start#) * 1000) <= ms
END SUB

FUNCTION Exist% (filename AS STRING)
	f% = FREEFILE
	OPEN filename FOR APPEND AS #f%
	IF LOF(f%) THEN Exist% = -1 ELSE exitst% = 0: CLOSE #f%: KILL filename ' delete empty files
	CLOSE #f%
END FUNCTION

SUB intro.car ()
	'$DYNAMIC
	DIM car(2108)
	'$DYNAMIC
	DIM carMask(2108)
	'$DYNAMIC
	DIM ground(5455)
	DIM carY AS DOUBLE
	carY = 133

	loadBG "carr"
	'+--------------------+
	'|   BLOAD car mask   |
	'+--------------------+
	DEF SEG = VARSEG(carMask(0))
		BLOAD imageFolder + "carmask.pct", VARPTR(carMask(0))
	DEF SEG

	'+----------------------+
	'|   pull out the car   |
	'+----------------------+
	GET (8, 133)-(105, 175), car(0)
	PUT (8, 133), car(0), XOR


	'+-------------------------+
	'|   paint road back in.   |
	'+-------------------------+
	LINE (8, 155)-(105, 145), 6
	LINE (69, 176)-(120, 170), 6

	'+----------------------------+
	'|   Get ground for repaint   |
	'+----------------------------+
	GET (8, 123)-(310, 158), ground(0)

											 
	FOR carX = 8 TO 220 STEP 4
		motor = 37
		carY = carY - .5
		PUT (carX, carY), carMask(0), AND
		PUT (carX, carY), car(0), XOR

	
		GOSUB intro.CarSound

		PUT (carX, carY), car(0), XOR
		PUT (8, 123), ground(0), PSET
	NEXT carX


	FOR i = 1 TO 4
	NEXT i
	
	'---clean up arrays
	ERASE ground
	ERASE car

	ERASE carMask
	EXIT SUB

'+------------------+
'|    Sound loop    |
'+------------------+
intro.CarSound:
	GOTO intro.carCheckSound

intro.CarIncSound:
	SOUND motor, .06
	SOUND 80, .06
	motor = motor + 18

intro.carCheckSound:
	IF motor <= 200 THEN GOTO intro.CarIncSound

RETURN
END SUB

REM $STATIC
SUB intro.enter ()
	'$DYNAMIC
	DIM joe1(364)
	'$DYNAMIC
	DIM joe1M(364)
	'$DYNAMIC
	DIM joe2(364)
	'$DYNAMIC
	DIM joe2M(364)

	DIM BG(937)

	joeStartY = 6

	loadBG "enter"


	CLOSE
	OPEN spriteFolder + "joew2.pga" FOR INPUT AS #1

	INPUT #1, foo$, foo2$, foo3$, foo4$

	FOR i = 0 TO 364
		IF i <> 0 THEN
			INPUT #1, joe1(i - 1), joe1M(i - 1), joe2(i - 1), joe2M(i - 1)
		END IF
	NEXT i

	GET (143, 114)-(168, 185), BG(0)

	
	FOR i = 155 TO 138 STEP -1
		stp = 0
		PUT (143, 114), BG(0), PSET
		IF i MOD 2 = 0 THEN
			PUT (143, i), joe2M(0), AND
			PUT (143, i), joe2(0), XOR
		ELSE
			PUT (143, i), joe1M(0), AND
			PUT (143, i), joe1(0), XOR
		END IF

		FOR j = 100 TO 250 STEP 10
			SOUND 100, .05
			SOUND stp, .05

			SOUND j, .05
		NEXT j
	NEXT i


	
	joeStartY = 126

END SUB

REM $STATIC
SUB intro.hill ()
	r76 = 0#

	loadBG "hill"
	'---Lenghtning

	OUT &H3C8, 15: OUT &H3C9, 45
	OUT &H3C9, 45: OUT &H3C9, 48

	FOR i = 1 TO 35
		motor = 50
		GOSUB intro.hillSound

		IF RND > .8 THEN
			loadBG "hill2"
			
			GOSUB intro.hillLSound
		ELSE
			loadBG "hill"
		END IF

	NEXT i

	loadBG "hill"

	GOSUB intro.hillWalk

	delay 400
EXIT SUB

'+------------------+
'|    Sound loop    |
'+------------------+
intro.hillSound:
	GOTO intro.hillCheckSound

intro.hillIncSound:
	SOUND motor, .06
	SOUND 69, .06
	motor = motor + 18

intro.hillCheckSound:
	IF motor <= 200 THEN GOTO intro.hillIncSound
RETURN

'+------------------+
'|    Sound loop    |
'+------------------+
EXIT SUB

intro.hillLSound:
	SOUND 76, .04
	r76 = r76 + 1
	IF r76 <= 2 THEN GOTO intro.hillLSound
RETURN

intro.hillWalk:
	GOTO intro.hillwalkCheck
intro.hillWalkSound:
	SOUND motor, .1
	SOUND 75, .1
	SOUND 32676, 1
	motor = motor - 10
intro.hillwalkCheck:
	IF motor >= 50 THEN GOTO intro.hillWalkSound
RETURN

END SUB

SUB intro.tenthPlay ()
	loadBG "TPLOGO"
	SLEEP 3
	CLS
	SCREEN 0: SCREEN 13
END SUB

SUB loadBG (imageName AS STRING)
	DIM palFile AS STRING: palFile = imageFolder + imageName + ".pal"

	IF Exist(palFile) THEN
		DIM pal(255) AS LONG
		file = FREEFILE
		OPEN palFile FOR INPUT AS #file
		FOR i = 0 TO 255
			INPUT #file, r&, g&, b&
			pal(i) = rgb2Color(r&, g&, b&)
		NEXT i
		PALETTE USING pal
		CLOSE
	END IF

	CONST videoSeg = &HB800
	DEF SEG = videoSeg
		BLOAD imageFolder + imageName + ".vga"
	DEF SEG
END SUB

FUNCTION rgb2Color& (r AS LONG, g AS LONG, b AS LONG)
	IF r <> 0 THEN r = (r / 255) * 63
	IF g <> 0 THEN g = (g / 255) * 63
	IF b <> 0 THEN b = (b / 255) * 63
	rgb2Color& = CLNG(r + (g * 256) + (b * (256 ^ 2)))
END FUNCTION

