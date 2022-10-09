DECLARE SUB intro.logo ()
DECLARE SUB initUgl ()
DECLARE SUB intro.loadImages (task AS INTEGER)
DECLARE SUB intro.hill ()
DECLARE SUB intro.hill ()
DECLARE SUB intro.car ()
DECLARE SUB swapPgs (pg1 AS INTEGER, pg2 AS INTEGER)
DECLARE SUB setVisPage (page AS INTEGER)
DECLARE SUB setWrkPage (page AS INTEGER)
DEFINT A-Z
'$INCLUDE: 'ugl.bi'
'$INCLUDE: 'tmr.bi'

CONST ems = UGL.EMS

DIM SHARED video AS LONG
DIM SHARED s.logo AS LONG
DIM SHARED s.carBg AS LONG
DIM SHARED s.car AS LONG
DIM SHARED s.car2 AS LONG
DIM SHARED s.hill AS LONG
DIM SHARED s.hill2 AS LONG


initUgl

intro.loadImages 0
'intro.logo
intro.car
intro.hill


tmrEnd
uglRestore
uglEnd

END

SUB initUgl ()
	'' initialize
	IF (NOT uglInit) THEN GOTO exitError
	video = uglSetVideoDC(UGL.8BIT, 640, 480, 2)
	IF (video = 0) THEN GOTO exitError

	EXIT SUB

exitError:
	SCREEN 1
	CLS
	PRINT "exit"
	tmrEnd
	uglRestore
	uglEnd
	END
END SUB

SUB intro.car ()
	DIM s.road AS LONG
	visPg = 0
	wrkPg = 1

	s.road = uglNew(ems, cFMT, 624, 155)

	'----- SETUP screen
	setWrkPage wrkPg

	uglPut video, 2, 46, s.carBg
	uglGet video, 16, 212, s.road

	setVisPage wrkPg: swapPgs wrkPg, visPg

	setWrkPage wrkPg

	uglPut video, 2, 46, s.carBg
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
	intro.loadImages 1
	EXIT SUB
	
	'+------------------+
	'|    Sound loop    |
	'+------------------+
intro.CarSound:
		GOTO intro.carCheckSound

intro.CarIncSound:
		'SOUND motor, .06
		'SOUND 80, .06
		motor = motor + 18

intro.carCheckSound:
		IF motor <= 200 THEN GOTO intro.CarIncSound
	RETURN

END SUB

SUB intro.hill ()
	DIM s.house AS LONG
	DIM t1 AS TMR
	tmrInit
	
	visPg = 0
	wrkPg = 1

	s.house = uglNew(ems, cFMT, 640, 246)
	
	'----- SETUP screen
	setWrkPage wrkPg

	uglPut video, 0, 0, s.hill
	uglGet video, 0, 0, s.house

	setVisPage wrkPg: swapPgs wrkPg, visPg
	
	setWrkPage wrkPg
	uglPut video, 0, 0, s.hill

	tmrNew t1, TMR.ONESHOT, tmrMs2Freq(2000)
	DO
		IF RND <= .1 THEN
			uglPut video, 0, 0, s.hill2
		ELSE
			uglPut video, 0, 0, s.house
		END IF

		swapPgs wrkPg, visPg

		setVisPage visPg
		setWrkPage wrkPg

		DO: LOOP UNTIL (INP(&H3DA) AND &H8)
		'SOUND 32676, .05
	LOOP WHILE (t1.state) AND (LEN(INKEY$) = 0)
	
	'SLEEP

	tmrEnd
	intro.loadImages 2
	EXIT SUB
	
END SUB

SUB intro.loadImages (task AS INTEGER)
	DIM palLogo(256) AS tRGB
	loadImgs = 0: delCarImgs = 1: delHillImgs = 2
	SELECT CASE task
		CASE IS = loadImgs
			s.logo = uglNewBMPEx(ems, UGL.8BIT, "10PLGO2x.bmp", BMPOPT.NO332)
			s.carBg = uglNewBMP(ems, UGL.8BIT, "carr2x.bmp")
			'uglPalGetBuff 0, 256, pala(0)
			s.car = uglNewBMPEx(ems, UGL.8BIT, "car.bmp", BMPOPT.MASK)
			s.car2 = uglNewBMPEx(ems, UGL.8BIT, "car2.bmp", BMPOPT.MASK)
			s.hill = uglNewBMP(ems, UGL.8BIT, "hill22x.bmp")
			s.hill2 = uglNewBMP(ems, UGL.8BIT, "hill2f2x.bmp")
		CASE IS = delCarImgs
			uglDel s.carBg
			uglDel s.car
			uglDel s.car2
		CASE IS = delHillImgs
			uglDel s.hill
			uglDel s.hill2
	END SELECT

END SUB

SUB intro.logo ()
	s.logo = uglPutBMPEx(video, 2, 46, "10pl01", BMPOPT.NO332)
	SLEEP
	uglClear video, 0
END SUB

SUB setVisPage (page AS INTEGER)
	uglSetVisPage page
END SUB

SUB setWrkPage (page AS INTEGER)
	uglSetWrkPage page
END SUB

SUB swapPgs (pg1 AS INTEGER, pg2 AS INTEGER)
	SWAP pg1, pg2
END SUB

