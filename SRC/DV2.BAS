DECLARE SUB intro.hill ()
DECLARE SUB intro.car ()
DECLARE SUB swapPgs (pg1 AS INTEGER, pg2 AS INTEGER)
DECLARE SUB setVisPage (page AS INTEGER)
DECLARE SUB setWrkPage (page AS INTEGER)
DEFINT A-Z
'$INCLUDE: 'ugl.bi'
'$INCLUDE: 'tmr.bi'

CONST xRes = 640
CONST yRes = 480
CONST cFMT = UGL.8BIT
CONST ems = UGL.EMS

DIM t1 AS TMR
DIM SHARED video AS LONG
DIM SHARED s.bg AS LONG

'' initialize
IF (NOT uglInit) THEN GOTO exitError
video = uglSetVideoDC(cFMT, xRes, yRes, 2)
IF (video = 0) THEN GOTO exitError

'intro.car
intro.hill

'uglPutScl video, 0, 0, 1.5, 1.5, bg2
'SLEEP


exitError:
	PRINT "exit"
	tmrEnd
	uglRestore
	uglEnd
END

SUB intro.car ()
	DIM s.car AS LONG
	DIM s.car2 AS LONG
	DIM s.road AS LONG

	visPg = 0
	wrkPg = 1

	s.bg = uglNewBMP(ems, cFMT, "carr2x.bmp")
	s.car = uglNewBMPEx(ems, cFMT, "car.bmp", BMPOPT.MASK)
	s.car2 = uglNewBMPEx(ems, cFMT, "car2.bmp", BMPOPT.MASK)
	s.road = uglNew(ems, cFMT, 624, 155)

	'----- SETUP screen
	setWrkPage wrkPg

	uglPut video, 2, 46, s.bg
	uglGet video, 16, 212, s.road

	setVisPage wrkPg: swapPgs wrkPg, visPg

	setWrkPage wrkPg
	uglPut video, 2, 46, s.bg

	setVisPage wrkPg: swapPgs wrkPg, visPg

	'----- Car animation
	carY = 212: stp = 0
	startPx = 16: endPx = 435: steps = 7

	FOR i = startPx TO endPx STEP steps
		stp = stp + 1

		carY = 266 - CINT(stp * ((endPx - startPx) / steps) / 60)

		setVisPage visPg

		DO: LOOP UNTIL (INP(&H3DA) AND &H8)
		motor = 37
		setWrkPage wrkPg
		uglPut video, 16, 212, s.road

		IF stp MOD 2 = 0 THEN
			uglPutMsk video, i, carY, s.car2
		ELSE
			uglPutMsk video, i, carY, s.car
		END IF
		GOSUB intro.CarSound
		SWAP wrkPg, visPg
	NEXT i

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

SUB intro.hill ()
	DIM s.hill AS LONG
	DIM s.hill2 AS LONG
	
	visPg = 0
	wrkPg = 1

	s.hill = uglNewBMP(ems, cFMT, "hill22x.bmp")
	
	'----- SETUP screen
	setWrkPage wrkPg

	uglPut video, 0, 0, s.hill

	setVisPage wrkPg: swapPgs wrkPg, visPg

	SLEEP

	EXIT SUB
	
END SUB

SUB setVisPage (page AS INTEGER)
	uglSetVisPage page
END SUB

SUB setWrkPage (page)
	uglSetWrkPage page
END SUB

SUB swapPgs (pg1 AS INTEGER, pg2 AS INTEGER)
	SWAP pg1, pg2
END SUB

