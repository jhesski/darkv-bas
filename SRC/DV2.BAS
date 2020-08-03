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
DIM s.road AS LONG

'' initialize
IF (NOT uglInit) THEN GOTO exitError
video = uglSetVideoDC(cFMT, xRes, yRes, 2)
IF (video = 0) THEN GOTO exitError

s.bg = uglNewBMP(ems, cFMT, "carr2x.bmp")
s.car = uglNewBMPEx(ems, cFMT, "car.bmp", BMPOPT.MASK)
s.road = uglNew(ems, cFMT, 624, 155)

visPg = 0
wrkPg = 1

uglSetWrkPage wrkPg

uglPut video, 0, 0, s.bg
uglGet video, 16, 212, s.road

uglSetVisPage wrkPg
SWAP wrkPg, visPg

uglSetWrkPage wrkPg
uglPut video, 0, 0, s.bg

uglSetVisPage wrkPg
SWAP wrkPg, visPg

SLEEP

carY = 212
stp = 0
FOR i = 16 TO 435 STEP 7
	stp = stp + 1
	carY = 266 - CINT(stp * ((435 - 16) / 7) / 60)
	uglSetVisPage visPg
	DO: LOOP UNTIL (INP(&H3DA) AND &H8)
	uglSetWrkPage wrkPg
	uglPut video, 16, 212, s.road
	uglPutMsk video, i, carY, s.car
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


