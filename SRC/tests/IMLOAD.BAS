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
DIM s.hillMask AS LONG
DIM s.hill2 AS LONG

'' initialize
IF (NOT uglInit) THEN GOTO exitError
video = uglSetVideoDC(cFMT, xRes, yRes, 2)
IF (video = False) THEN GOTO exitError

s.hill = uglNewBMP(ems, cFMT, "./img/hill22x.bmp")
s.hillMask = uglNew(ems, cFMT, 640, 246)
s.hill2 = uglNewBMP(ems, cFMT, "./img/hill2f2x.bmp")

uglPut video, 0, 0, s.hill
uglGet video, 0, 0, s.hillMask

FOR i = 0 TO 22
  IF i MOD 12 = 0 THEN uglPut video, 0, 0, s.hill2
  IF i MOD 2 <> 0 THEN uglPut video, 0, 0, s.hillMask
NEXT i


exitError:
	PRINT "exit"
	tmrEnd
	uglRestore
	uglEnd
END

