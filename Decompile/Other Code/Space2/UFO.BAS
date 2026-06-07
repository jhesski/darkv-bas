DEFINT A-E
gef = 32300
DIM SHARED c(1 TO gef)
DIM SHARED pl(260)  AS LONG
q$ = "1truck"
IF MID$(q$, 1, 1) = "1" THEN fg$ = "house2.pal" ELSE fg$ = "ship2.pal"
q$ = MID$(q$, 2, 8)
SCREEN 13
GOSUB 3
5 GET (2, 10)-(310, 199), c
DEF SEG = VARSEG(c(1))
BLOAD q$ + ".pic", VARPTR(c(1))
CLS
PUT (1, 1), c, PSET
q$ = "ufo"
SHELL "midplay /q /r " + q$ + ".mid"
26 FOR p = 0 TO 5 STEP 1
FOR d = 1 TO 6 STEP 1
y = d * 10 + p * 10
IF y > 60 THEN y = y - 60
PALETTE 25 - d, y
FOR l = 1 TO 1000: NEXT l
NEXT d
gbg = gbg + 1: IF gbg > 60 THEN gbg = 60
PALETTE 18, gbg
NEXT p
GOTO 26
3 OPEN fg$ FOR INPUT AS #1
FOR i = 1 TO 255 STEP 1
INPUT #1, pl(i)
NEXT i
PALETTE USING pl(0)
CLOSE
RETURN

