' +====================+
' |   Loading images   |
' +====================+
DEFINT A-Z
'$INCLUDE: '.\lib\ugl.bi'
'$INCLUDE: '.\lib\tmr.bi'

CONST xRes = 640
CONST yRes = 480
CONST cFMT = UGL.8BIT
CONST ems = UGL.EMS
DIM video AS LONG
DIM s.hill AS LONG

'' initialize
IF (NOT uglInit) THEN GOTO exitError
video = uglSetVideoDC(cFMT, xRes, yRes, 2)
IF (video = False) THEN GOTO exitError

s.hill = uglNewBMP(ems, cFMT, "./img/hill22x.bmp")

uglPut video, 0, 0, s.hill

SLEEP


exitError:
	PRINT "exit"
	tmrEnd
	uglRestore
	uglEnd
END

