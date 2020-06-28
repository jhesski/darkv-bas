DECLARE SUB intro.hill ()
DECLARE SUB intro.car ()
DECLARE SUB loadBG (imageName AS STRING)
DECLARE FUNCTION setupTimer# (freq#)
DECLARE SUB delay (ms%)
DEFINT A-Z

SCREEN 13
DIM SHARED imageFolder AS STRING
DIM SHARED dataFolder AS STRING
imageFolder = ".\res\bg\vga\"
'dataFolder = ".\res\data\"

intro:
'intro.car
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
	moter = 37

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

		carY = carY - .5
		
		PUT (carX, carY), carMask(0), AND: PUT (carX, carY), car(0), XOR

		FOR moter = 50 TO 200 STEP 18
			SOUND 69, .06: SOUND moter, .06
		NEXT moter
	
		PUT (carX, carY), car(0), XOR
		PUT (8, 123), ground(0), PSET
	NEXT carX


	FOR i = 1 TO 4
	NEXT i

	'---clean up arrays
	ERASE ground
	ERASE car
	ERASE carMask
END SUB

SUB intro.hill ()
	DIM bg1(32000)
	DIM bg2(32000)

	bgCaptured = 0

	loadBG "hill"
	GET (0, 0)-(319, 199), bg1(0)

	SLEEP
	white# = 63 + (63 * 256) + (63 * (256 ^ 2))
	FOR i = 1 TO 300

	NEXT i
	FOR i = 1 TO 35
		FOR moter = 50 TO 200 STEP 18
		 SOUND 69, .06: SOUND moter, .06
		NEXT moter
		IF RND > .8 THEN
			PALETTE 0, 0
			'PAINT (0, 0), 15, 2


			FOR j = 0 TO 2
			 SOUND 32676, .04
			NEXT j

		ELSE
			PALETTE 0, white#
			IF NOT bgCaptured THEN
				PALETTE 0, white#
				GET (0, 0)-(319, 199), bg2(0)
			ELSE
				PUT (0, 0), bg2(0)
			END IF

		END IF
	NEXT i

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

