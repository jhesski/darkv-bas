DECLARE FUNCTION setupTimer# (freq#)
DECLARE SUB delay (ms%)
DEFINT A-Z

SCREEN 13
DIM pCur(4)
DIM pCurUnder(4)
DIM strt AS SINGLE
sW = 319        ' Screen Width
sH = 199        ' Screen Height
sMidW = 319 / 2 ' Screen Mid Width
sMidH = 199 / 2 ' Screen Med Height
sCurX = sMidW
sCurY = sMidH


PRINT "lets create"

LINE (sMidW - 10, sMidH - 10)-(sMidW + 10, sMidH + 10), 2, BF

' GET (sMidW, sMidH)-(sMidW, sMidH), pCurUnder

' Draw cursor
PSET (sMidW, sMidH), 2

' Get cursor
GET (sMidW, sMidH)-(sMidW, sMidH), pCur


' SLEEP 1
' PUT (sMidW, sMidH), pCurUnder, PSET
SLEEP 1
PUT (sMidW, sMidH), pCur, XOR

s# = TIMER

FOR i = 0 TO 199
	s# = TIMER
	PUT (sCurX, sCurY), pCur, XOR
	sCurY = i
	PUT (sCurX, sCurY), pCur, XOR
	FOR j = 0 TO 200
	NEXT j
NEXT i

PRINT INT((TIMER - s#) * 1000)

SUB delay (ms)
	start# = TIMER
	DO
	LOOP WHILE INT((TIMER - start#) * 1000) <= ms
END SUB

FUNCTION setupTimer# (freq#)

IF (freq# > 1193181) OR (freq# < 18.3) THEN ERROR 5'Illegal function call

ticksPerTimer& = 1193181# / freq#

OUT &H43, &H34                          'Specifies a bitmask setting the timer style and initializing the ports for receiving a clock rate
OUT &H40, ticksPerTimer& AND 255        'Send low 8 bits first
OUT &H40, ticksPerTimer& \ 256          'Then sent high 8 bits
setupTimer# = 1193181 / ticksPerTimer&  'And finally, return the resulting clock rate
END FUNCTION

