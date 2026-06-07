
SUB intro
DEFINT A-I: DIM b(1 TO 10800)
DIM a(500): DIM c(2000): DIM d(250)
DIM e(250): DIM f(250): DIM g(250)
DIM h(1500): DIM i(250)
me$ = "The year is 2667. The earth has been torn apart by events of cataclysmic proportion. The country side is left in oblivion. Civilization is at a standstill."
SCREEN 12: SCREEN 13
LOCATE 25, 26: PRINT "Loading ...."
CLOSE : OPEN "256colo.pal" FOR INPUT AS #1
FOR i = 1 TO 255 STEP 1
INPUT #1, p
IF p = 0 AND i > 10 THEN i = 255
PALETTE i + 16, p
NEXT i
CLOSE
OPEN "introd.dat" FOR INPUT AS #1
CLS
GOSUB 6
PLAY "mb<<<<aa>c<aa>p3"
GET (2, 2)-(180, 100), b
DEF SEG = VARSEG(b(1))
781 BLOAD "introcty.pic", VARPTR(b(1))
DEF SEG = 0
GET (252, 50)-(280, 170), c
882 PUT (73, 56), b, PSET
GOSUB 4: GOTO 5
4 GET (253, 57)-(271, 73), i
GET (253, 76)-(271, 93), d: GET (253, 96)-(271, 113), e
GET (253, 116)-(271, 133), f: GET (253, 136)-(271, 153), g
PUT (252, 50), c, PSET
GET (73, 56)-(251, 153), b
GOSUB 91
RETURN
5 GOSUB 7
GOSUB 9
GET (2, 2)-(180, 100), b
DEF SEG = VARSEG(b(1))
    BLOAD "intromrg.pic", VARPTR(b(1))
PLAY "mbaa>c<aap3"
GET (252, 50)-(280, 170), c
    PUT (73, 56), b, PSET
GOSUB 4
me$ = "A deadly plague is sweeping across the surviving portions of the world. This disease is characterized by instant unexplainable death during the hours of the night.": ex = 7
GOSUB 7
GOSUB 9
DEF SEG = VARSEG(b(1))
    BLOAD "introusa.pic", VARPTR(b(1))
PLAY "mb>aa>c<aap3"
GET (252, 50)-(280, 170), c
    PUT (73, 56), b, PSET
GOSUB 4
me$ = "A series of earthquakes has altered the geography of the US. The Mississippi and the Great Lakes have formed a fifth ocean. Both sides are ruled by separate governments. Both deny involvement.": ex = 35
GOSUB 7
GOSUB 9
DEF SEG = VARSEG(b(1))
    BLOAD "introsub.pic", VARPTR(b(1))
PLAY "mb>aa>c<aa>ed6c5<b4a3"
    GET (252, 50)-(280, 170), c
    PUT (73, 56), b, PSET
GOSUB 4
me$ = " You have been hired by the crumbling eastern empire to find a cure before it is too late. You enter the underground subways and travel to the coastal city of Topeka, the center-point of the plague.": ex = 40
GOSUB 7
GOSUB 9
LOCATE 2, 1: PRINT "                                       "
GOSUB 80
PLAY ">e3p3c9e9c9<b9>c4>ce5e5e5<a2"
PUT (252, 50), c, PSET
t = TIMER
11 IF TIMER - t < 2 THEN 11
DEF SEG = VARSEG(b(1))
    BLOAD "title3.pic", VARPTR(b(1))
GET (252, 50)-(280, 170), c
    PUT (73, 56), b, PSET
GOSUB 4
t = TIMER
12 qf = TIMER - tim: qf = INT(qf * 10) / 10
IF qf <> pf THEN GOSUB 72
IF TIMER - t < 2.3 THEN 12
DEF SEG = VARSEG(b(1))
    BLOAD "title2.pic", VARPTR(b(1))
GET (252, 50)-(280, 170), c
    PUT (73, 56), b, PSET
GOSUB 4
t = TIMER
13 qf = TIMER - tim: qf = INT(qf * 10) / 10
IF qf <> pf THEN GOSUB 72
IF TIMER - t < 1.8 THEN 13
DEF SEG = VARSEG(b(1))
    BLOAD "title3.pic", VARPTR(b(1))
GET (252, 50)-(280, 170), c
    PUT (73, 56), b, PSET
GOSUB 4
t = TIMER
14 qf = TIMER - tim: qf = INT(qf * 10) / 10
IF qf <> pf THEN GOSUB 72
IF TIMER - t < 3 THEN 14
GOTO 177
9 FOR i = 1 TO 50 STEP 1
LINE (73, 55 + i)-(251, i + 55), i / 4 + 18
LINE (73, 155 - i)-(251, 155 - i), i / 4 + 18
FOR d = 1 TO 2: SOUND 32676, .2: SOUND RND * 100 + 14050 + i * 10, .2: NEXT d
NEXT i
RETURN
6 FOR i = 0 TO 13
LINE (320 - i * 5.3, 200 - i * 3.65)-(1 + i * 5.3, 10 + i * 3.65), i + 17, BF
NEXT i
RETURN
7 fl = 0: FOR i = 1 TO 121 + ex
COLOR 46 - INT(RND * 1)
LOCATE 2, 2
PRINT MID$(me$, i, 38);
IF i = 1 THEN a$ = INKEY$: IF a$ = "f" THEN i = 121 + ex ELSE FOR g = 1 TO 35: GOSUB 45: qf = TIMER - tim: qf = INT(qf * 10) / 10:  GOSUB 72: NEXT g
a$ = INKEY$: l$ = INKEY$: IF a$ = " " OR l$ = " " THEN h$ = " "
IF a$ <> " " AND l$ <> " " AND h$ <> "d" THEN GOSUB 45 ELSE IF h$ = " " THEN h$ = "d" ELSE IF h$ = "d" THEN h$ = ""
qf = TIMER - tim: qf = INT(qf * 10) / 10
IF qf <> pf THEN GOSUB 72
IF a$ = "s" THEN GOTO 177
IF a$ = "f" THEN i = 121 + ex
IF MID$(me$, i + 38, 1) = " " AND fl = 1 THEN i = i - 1: nm = nm + 1: IF nm = 8 THEN nm = 0: i = i + 1
fl = 1
NEXT i
FOR g = 1 TO 12: GOSUB 45: NEXT g
RETURN
45 t = TIMER
DO: LOOP UNTIL TIMER - t > .02
RETURN
80 q$ = "try"
 f = 4
81 i = f: IF f < 0 THEN RETURN
 FOR d = i TO -1 * i STEP -1
 GET (2, 2)-(180 + d, 100 + d), b
 DEF SEG = VARSEG(b(1))
 t = TIMER
  BLOAD q$ + ".pic", VARPTR(b(1)) + 1
 PUT (73, 56), b, PSET
18 IF TIMER - t < .1 THEN 18
 NEXT d
 FOR d = -1 * i + 1 TO i STEP 1
GET (2, 2)-(180 + d, 100 + d), b
 DEF SEG = VARSEG(b(1))
 t = TIMER
 BLOAD q$ + ".pic", VARPTR(b(1)) + 1
 PUT (73, 56), b, PSET
19 IF TIMER - t < .1 THEN 19
NEXT d
 f = f - 1
  GOTO 81
70 tim = TIMER
qf = (TIMER - tim) * 1
PUT (73, 56), b, PSET
72 'animation
IF qf > rt THEN 70
IF qf = qa(1) OR qf = qa(1) THEN PUT (fx(1) + 71, fy(1) + 55), i, PSET
IF qf = qa(2) OR qf = qb(2) THEN PUT (fx(2) + 71, fy(2) + 55), d, PSET
IF qf = qa(3) OR qf = qb(3) THEN PUT (fx(3) + 71, fy(3) + 55), e, PSET
IF qf = qa(4) OR qf = qb(4) THEN PUT (fx(4) + 71, fy(4) + 55), f, PSET
IF qf = qa(5) OR qf = qb(5) THEN PUT (fx(5) + 71, fy(5) + 55), g, PSET
pf = qf
RETURN
 OPEN "introd.dat" FOR INPUT AS #1
91 INPUT #1, rt
FOR i = 1 TO 5
INPUT #1, qa(i), qb(i), fx(i), fy(i)
NEXT i
RETURN
177 END SUB

