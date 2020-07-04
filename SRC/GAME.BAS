DECLARE SUB intro.hill ()
DECLARE SUB intro.car ()
DECLARE SUB loadBG (imageName AS STRING)
DECLARE SUB delay (ms%)
DEFINT A-Z

SCREEN 13
DIM SHARED imageFolder AS STRING
DIM SHARED dataFolder AS STRING
imageFolder = ".\res\bg\vga\"
'dataFolder = ".\res\data\"

intro:
intro.car
intro.hill

SLEEP

SUB delay (ms)
	start# = TIMER
	DO
	LOOP WHILE INT((TIMER - start#) * 1000) <= ms
END SUB

SUB intro.car ()
	DIM car(2108)
	DIM carMask(2108)
	DIM ground(5455)
	DIM carY AS DOUBLE
	carY = 133
	motor = 37

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
	'GET (8, 123)-(310, 158), ground(0)


	
	FOR carX = 8 TO 220 STEP 4
		motor = 37
		carY = carY - .5
		'PUT (carX, carY), carMask(0), AND
		PUT (carX, carY), car(0), XOR

	
		GOSUB into.CarSound

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
into.CarSound:
	GOTO intro.carCheckSound

into.CarIncSound:
	SOUND motor, .06
	SOUND 69, .06
	motor = motor + 18

intro.carCheckSound:
	IF motor <= 200 THEN GOTO into.CarIncSound

RETURN
END SUB

SUB intro.hill ()
	r76 = 0#

	loadBG "hill"
	'---Lenghtning
	'OUT &H3C8, 0: OUT &H3C9, 33
	'OUT &H3C9, 33: OUT &H3C9, 33

	FOR i = 1 TO 35
		motor = 50
		GOSUB into.hillSound

		IF RND <= .8 THEN
			loadBG "hill2"
			
			GOSUB into.hillLSound
			
			loadBG "hill"
		ELSE
			loadBG "hill"
		END IF
	NEXT i

	GOSUB into.hillWalk

EXIT SUB

'+------------------+
'|    Sound loop    |
'+------------------+
into.hillSound:
	GOTO intro.hillCheckSound

into.hillIncSound:
	SOUND motor, .06
	SOUND 69, .06
	motor = motor + 18

intro.hillCheckSound:
	IF motor <= 200 THEN GOTO into.hillIncSound
RETURN

'+------------------+
'|    Sound loop    |
'+------------------+
EXIT SUB

into.hillLSound:
	SOUND 76, .04
	r76 = r76 + 1
	IF r76 <= 2 THEN GOTO into.hillLSound
RETURN

into.hillWalk:
	GOTO into.hillwalkCheck
into.hillWalkSound:
	SOUND motor, .1
	SOUND 75, .1
	SOUND 32676, 1
	motor = motor - 10
into.hillwalkCheck:
	IF motor >= 50 THEN GOTO into.hillWalkSound
RETURN

END SUB

SUB loadBG (imageName AS STRING)
	CONST videoSeg = &HB800
	DEF SEG = videoSeg
		BLOAD imageFolder + imageName + ".vga"
	DEF SEG
END SUB

