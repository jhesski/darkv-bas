DEFINT A-Z
'$INCLUDE: 'tmr.bi'

DIM t1 AS TMR

tmrInit

tmrNew t1, TMR.ONETIME, tmrMs2Freq(2000)

CLS

DO
  PRINT t1.cnt; t1.state
LOOP WHILE (t1.state) AND (LEN(INKEY$) = 0)
tmrEnd

