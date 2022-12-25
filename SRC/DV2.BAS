DECLARE SUB intro.hall ()
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
DIM SHARED s.hall AS LONG
DIM SHARED s.hall2 AS LONG
DIM SHARED s.joe AS LONG


initUgl

intro.loadImages 0

intro.logo
intro.car
intro.hill
intro.hall


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
		'GOSUB intro.CarSound
		SWAP wrkPg, visPg
	NEXT i
	uglClear video, uglColor(UGL.8BIT, 0, 0, 0)
	intro.loadImages 1
	EXIT SUB
END SUB

SUB intro.hall ()
	DIM s.joeWalk AS LONG
	DIM s.joeWalk2 AS LONG
	DIM s.joeBlank AS LONG
	DIM s.joeFrame AS LONG
	DIM s.joeLocation AS LONG
	DIM t1 AS TMR

	delay = 0
	visPg = 0
	wrkPg = 1
	joeLocation = 300
	joeIndex = 0
	delHallImgs = 3

	s.joeWalk = uglNew(ems, cFMT, 32, 60)
	s.joeWalk2 = uglNew(ems, cFMT, 32, 60)
	s.joeBlank = uglNew(ems, cFMT, 52, 500)
	uglPut s.joeWalk, 0, 0, s.joe
	uglPut s.joeWalk2, 0, -61, s.joe

	'----- SETUP screen
	
	setWrkPage wrkPg

	uglClear video, uglColor(UGL.8BIT, 0, 0, 0)
	uglPut video, 108, 212, s.hall

	swapPgs wrkPg, visPg
	setWrkPage wrkPg

	uglClear video, uglColor(UGL.8BIT, 0, 0, 0)
	uglPut video, 108, 212, s.hall


	uglGet video, 287, 0, s.joeBlank
	uglPutMsk video, 296, joeLocation, s.joeWalk
	setVisPage wrkPg: swapPgs wrkPg, visPg
	setWrkPage wrkPg


	'----Joe walks in
	FOR i = 0 TO 55

		IF joeIndex < 4 THEN
			s.joeFrame = s.joeWalk
			joeLocation = joeLocation - .75
			joeIndex = joeIndex + 1
		ELSE
			s.joeFrame = s.joeWalk2
			IF joeIndex <= 8 THEN
				joeIndex = joeIndex + 1
				joeLocation = joeLocation - .75
			ELSE
				joeIndex = 0
			END IF
		END IF

		setWrkPage wrkPg

		IF i < 40 THEN
			uglPut video, 287, 0, s.joeBlank
			uglPutMsk video, 296, joeLocation, s.joeFrame
		END IF
		setVisPage wrkPg
		WAIT &H3DA, 8
		swapPgs wrkPg, visPg
	NEXT i
	
	uglGet video, 108, 212, s.hall 'gets hall with joe.

	'----Talking
	setWrkPage wrkPg

	uglClear video, uglColor(UGL.8BIT, 0, 0, 0)
	uglPut video, 63, 26, s.hall2

	setVisPage wrkPg
	swapPgs wrkPg, visPg
	tmrInit

	tmrNew t1, TMR.ONETIME, tmrMs2Freq(14500)
	DO
	LOOP WHILE (t1.state) AND (LEN(INKEY$) = 0)


	uglClear video, uglColor(UGL.8BIT, 0, 0, 0)
	uglPut video, 108, 212, s.hall

	setWrkPage wrkPg
	uglClear video, uglColor(UGL.8BIT, 0, 0, 0)
	uglPut video, 108, 212, s.hall
	setVisPage wrkPg
	swapPgs wrkPg, visPg


	FOR i = 0 TO 20
		IF joeIndex < 4 THEN
			s.joeFrame = s.joeWalk
			joeLocation = joeLocation - .75
			joeIndex = joeIndex + 1
		ELSE
			s.joeFrame = s.joeWalk2
			IF joeIndex <= 8 THEN
				joeIndex = joeIndex + 1
				joeLocation = joeLocation - .75
			ELSE
				joeIndex = 0
			END IF
		END IF

		setWrkPage wrkPg
		uglPut video, 287, 0, s.joeBlank
		uglPutMsk video, 296, joeLocation, s.joeFrame

		setVisPage wrkPg
		WAIT &H3DA, 8
		swapPgs wrkPg, visPg
		
	NEXT i

	uglClear video, uglColor(UGL.8BIT, 0, 0, 0)
	intro.loadImages delHallImgs
	tmrEnd
	EXIT SUB
END SUB

SUB intro.hill ()
	DIM s.house AS LONG
	DIM t1 AS TMR
	
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

	tmrInit

	tmrNew t1, TMR.ONETIME, tmrMs2Freq(2500)
	DO
		IF RND <= .02 THEN
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
	uglClear video, uglColor(UGL.8BIT, 0, 0, 0)
	tmrEnd
	intro.loadImages 2
	'EXIT SUB
	
END SUB

SUB intro.loadImages (task AS INTEGER)
	'DIM palLogo(256) AS tRGB
	loadImgs = 0: delCarImgs = 1: delHillImgs = 2
	delHallImgs = 3
	PRINT task
	SELECT CASE task
		CASE IS = loadImgs
			s.logo = uglNewBMPEx(ems, UGL.8BIT, "10PLGO2x.bmp", BMPOPT.NO332)
			'------Into Car
			s.carBg = uglNewBMP(ems, UGL.8BIT, "carr2x.bmp")
			s.car = uglNewBMPEx(ems, UGL.8BIT, "car.bmp", BMPOPT.MASK)
			s.car2 = uglNewBMPEx(ems, UGL.8BIT, "car2.bmp", BMPOPT.MASK)
			
			'------Into Hill
			s.hill = uglNewBMP(ems, UGL.8BIT, "hill22x.bmp")
			s.hill2 = uglNewBMP(ems, UGL.8BIT, "hill2f2x.bmp")
			
			'------Intro Hall
			s.hall = uglNewBMP(ems, UGL.8BIT, "INTROH~1.bmp")
			s.hall2 = uglNewBMP(ems, UGL.8BIT, "hall2.bmp")
			s.joe = uglNewBMP(ems, UGL.8BIT, "joe.bmp")
		CASE IS = delCarImgs
			uglDel s.carBg
			uglDel s.car
			uglDel s.car2
		CASE IS = delHillImgs
			uglDel s.hill
			uglDel s.hill2
		CASE IS = delHallImgs
			uglDel s.hall
			uglDel s.hall2
			uglDel s.joe
	END SELECT

END SUB

SUB intro.logo ()
	DIM pal(256) AS LONG
	visPg = 0
	wrkPg = 1
	setVisPage visPg
	setWrkPage wrkPg

	uglPut video, 0, 0, s.logo

	setVisPage wrkPg
	WAIT &H3DA, 8           f
	swapPgs wrkPg, visPg

	SLEEP 2
	uglClear video, uglColor(UGL.8BIT, 0, 0, 0)
	
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

