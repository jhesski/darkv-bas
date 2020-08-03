DEFINT A-Z
'$INCLUDE: 'ugl.bi'
'$INCLUDE: 'tmr.bi'

CONST xRes = 640
CONST yRes = 480
CONST cFMT = UGL.8BIT


DIM t1 AS TMR
DIM video AS LONG
DIM s.bg AS LONG
DIM s.car AS LONG
DIM s.road AS LONG

'' initialize
IF (NOT uglInit) THEN GOTO exitError
video = uglSetVideoDC(cFMT, xRes, yRes, 2)
IF (video = 0) THEN GOTO exitError

s.bg = uglNewBMP(UGL.EMS, cFMT, "carr2x.bmp")
's.car = uglNewBMPEx(UGL.EMS, cFMT, "car.bmp", BMPOPT.MASK)
s.road = uglNew(UGL.EMS, cFMT, 624, 155)

visPg = 0
wrkPg = 1


uglSetWrkPage wrkPg

uglPut video, 0, 0, s.bg
uglGet video, 16, 266, s.road
uglPut video, 16, 0, s.road

uglSetVisPage wrkPg
SWAP wrkPg, visPg
uglSetWrkPage wrkPg
uglPut video, 0, 0, s.bg

SLEEP

uglSetVisPage wrkPg
SWAP wrkPg, visPg

SLEEP

'FOR i = 16 TO 440 STEP 4
'  uglSetVisPage visPg
'  uglSetWrkPage wrkPg
'  uglPut video, 0, 266, s.road
'  uglPutMsk video, i, 266, s.car
'  visPg = wrkPg
'  wrkPg = (wrkPg + 1) MOD 2
'NEXT i

'uglPutScl video, 0, 0, 1.5, 1.5, bg2
'SLEEP


exitError:
	PRINT "exit"
	tmrEnd
	uglRestore
	uglEnd
END


