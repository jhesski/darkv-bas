DECLARE SUB intro.hill ()
DECLARE SUB intro.car ()
DECLARE SUB loadBG (imageName AS STRING)
DECLARE FUNCTION setupTimer# (freq#)
DECLARE SUB delay (ms%)
DEFINT A-Z

SCREEN 13
DIM SHARED imageFolder AS STRING
DIM SHARED dataFolder AS STRING
imageFolder = ".\"
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
	DIM carM(2108)

	carY# = 133

	loadBG "carr"

	DEF SEG = VARSEG(carM(0))
		BLOAD imageFolder + "carmask.pct", VARPTR(carM(0))
	DEF SEG

'---pull out the car
	GET (8, 133)-(105, 175), car(0)
	PUT (8, 133), car(0), XOR

'---paint road back in.
	LINE (8, 155)-(105, 145), 6
	LINE (69, 176)-(120, 170), 6

	moter = 37
	FOR carX = 8 TO 220 STEP 4
		carY# = carY# - .5
		'PUT (carX, carY#), carM(0), AND

		PUT (carX, carY#), car(0), XOR

		FOR moter = 50 TO 200 STEP 18
			SOUND 100, .06
			SOUND moter, .06
		NEXT moter
	
		PUT (carX, carY#), car(0), XOR
	NEXT carX


	FOR i = 1 TO 2
		SOUND 32676, 1
	NEXT i

END SUB

SUB intro.hill ()
	loadBG "hill"
END SUB

SUB loadBG (imageName AS STRING)
	CONST videoSeg = &HB800
	DEF SEG = videoSeg
		BLOAD imageFolder + imageName + ".vga"
	DEF SEG
END SUB

FUNCTION setupTimer# (freq#)

IF (freq# > 1193181) OR (freq# < 18.3) THEN ERROR 5'Illegal function call

ticksPerTimer& = 1193181# / freq#

OUT &H43, &H34                          'Specifies a bitmask setting the timer style and initializing the ports for receiving a clock rate
OUT &H40, ticksPerTimer& AND 255        'Send low 8 bits first
OUT &H40, ticksPerTimer& \ 256          'Then sent high 8 bits
setupTimer# = 1193181 / ticksPerTimer&  'And finally, return the resulting clock rate
END FUNCTION

