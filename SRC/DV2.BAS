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
DIM video AS LONG
DIM s.bg AS LONG
DIM s.car AS LONG
DIM s.car2 AS LONG
DIM s.road AS LONG

'' initialize
IF (NOT uglInit) THEN GOTO exitError
video = uglSetVideoDC(cFMT, xRes, yRes, 2)
IF (video = 0) THEN GOTO exitError

visPg = 0
wrkPg = 1

s.bg = uglNewBMP(ems, cFMT, "carr2x.bmp")
s.car = uglNewBMPEx(ems, cFMT, "car.bmp", BMPOPT.MASK)
s.car2 = uglNewBMPEx(ems, cFMT, "car2.bmp", BMPOPT.MASK)
s.road = uglNew(ems, cFMT, 624, 155)


setWrkPage wrkPg

uglPut video, 2, 46, s.bg
uglGet video, 16, 212, s.road

setVisPage wrkPg: swapPgs wrkPg, visPg

setWrkPage wrkPg
uglPut video, 2, 46, s.bg

setVisPage wrkPg: swapPgs wrkPg, visPg


carY = 212: stp = 0
startPx = 16: endPx = 435: steps = 7

FOR i = startPx TO endPx STEP steps
	stp = stp + 1

	carY = 266 - CINT(stp * ((endPx - startPx) / steps) / 60)

	setVisPage visPg

	DO: LOOP UNTIL (INP(&H3DA) AND &H8)

	setWrkPage wrkPg
	uglPut video, 16, 212, s.road

	IF stp MOD 2 = 0 THEN
		uglPutMsk video, i, carY, s.car2
	ELSE
		uglPutMsk video, i, carY, s.car
	END IF
	SWAP wrkPg, visPg
NEXT i

'uglPutScl video, 0, 0, 1.5, 1.5, bg2
'SLEEP


exitError:
	PRINT "exit"
	tmrEnd
	uglRestore
	uglEnd
END

SUB setVisPage (page AS INTEGER)
	uglSetVisPage page
END SUB

SUB setWrkPage (page)
	uglSetWrkPage page
END SUB

SUB swapPgs (pg1 AS INTEGER, pg2 AS INTEGER)
	SWAP pg1, pg2
END SUB

