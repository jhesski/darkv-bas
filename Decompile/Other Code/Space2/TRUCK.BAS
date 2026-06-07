SCREEN 13
DEFINT C
x = 52: y = 150: p = 4: sip = 1
SHELL "midplay /q /r ufo.mid"
fg$ = "house2.pal"
DIM pl(256) AS LONG
OPEN fg$ FOR INPUT AS #1
FOR i = 1 TO 255 STEP 1
INPUT #1, pl(i)
NEXT i
PALETTE USING pl(0)
gef = 32300: q$ = "car"
DIM c(1 TO gef)
COLOR 74
CLS
LOCATE 1, 1: PRINT "You are driving to your cabin late in   the night. You feel yourself beginning  to drift off into sleep."
tim = TIMER
DO: LOOP UNTIL TIMER - tim > 5
CLS
GET (2, 10)-(310, 199), c
DEF SEG = VARSEG(c(1))
BLOAD q$ + ".pic", VARPTR(c(1))
PUT (1, 1), c, PSET'places picture in certain postion
sip = 1
l = x - 48 - p: IF l < 1 THEN l = 1
GET (l, y - 15 - p / 2)-(x + 100, y + 28), c
FOR x = 15 TO 644 STEP 6

1 FOR i = 1 TO 15
LINE (x, y + i)-(x + 100 - p * 3, y + i * .75 - p / 2), 71 - i
NEXT i
CIRCLE (x + 70 - p * 1.8, y + 10 - p / 1.5), 9, 171, , , p / 6 + .5
CIRCLE (x + 14 - p / 2, y + 13), 9, 171, , , p / 6 + .5
PAINT (x + 70 - p * 1.8, y + 10 - p / 1.5), 173, 171
PAINT (x + 14 - p / 2, y + 13), 172, 171
FOR i = 1 TO 15
LINE (x, y + i)-(x - 8 - p * 2, y + i * .75 - (20 - p) / 2), 71 - i
NEXT i
FOR i = 1 TO 10
LINE (x, y)-(x + 70 - p * 1.8, y - 10 - p / 1.5 + i), 30 + i * 2
LINE -(x + 100 - p * 3, y - p / 2), 30 + i * 2
NEXT i
i = 1
LINE (x, y)-(x + 70 - p * 1.8, y - 10 - p / 1.5 + i), 71 + i
LINE (x + 70 - p * 1.8, y - p / 1.5 + i)-(x + 70 - p * 1.8, y - 10 - p / 1.5 + i)
LINE -(x + 100 - p * 3, y - p / 2), 71 + i
FOR i = 1 TO 22
LINE (x - (i) * p / 10 - 4, y - i / 3 + p / 5)-(x + 70 - p * 1.8 - i, y - 10 - p / 1.5), 60 + i
NEXT i
FOR i = 1 TO 5000 * sip: NEXT i
PUT (l, y - 15 - p / 2), c, PSET
l = x - 30 - p: IF l < 1 THEN l = 1
y = y - .8 - p / 42: IF p < 22 THEN p = p + .3
WINDOW SCREEN (1 + (y - 149) * 4, 1 + (y - 149) * 4)-(320 - (y - 149) * 4, 200 - (y - 149) * 4)
GET (l, y - 15 - p / 2)-(x + 100, y + 28), c
NEXT x
WINDOW SCREEN (0, 0)-(320, 200)
FOR i = 1 TO 200
LINE (1, i)-(320, i), 20 + i / 6
FOR p = 1 TO 3000 * sip: NEXT p
NEXT i
q$ = "1truck"
IF MID$(q$, 1, 1) = "1" THEN fg$ = "house2.pal" ELSE fg$ = "ship2.pal"
q$ = MID$(q$, 2, 8)
CLS
5 GET (2, 10)-(310, 199), c
DEF SEG = VARSEG(c(1))
BLOAD q$ + ".pic", VARPTR(c(1))
CLS
PUT (1, 1), c, PSET
q$ = "ufo"
tim = TIMER
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
IF TIMER - tim < 8 THEN GOTO 26
11 CLS : COLOR 74: PALETTE 74, 1
GET (2, 10)-(310, 199), c
DEF SEG = VARSEG(c(1))
BLOAD "house.pic", VARPTR(c(1))
PUT (c(1), c(2)), c(3)
LOCATE 1, 1: PRINT "When you awake and shake away the       cobwebs you find that you"
             PRINT "have mysteriously appeared at your      summer cabin."
             PRINT "You wrestle with your brain to try to   remember the drive"
             PRINT "but you can recall nothing. Nothing     that is except for a"
             PRINT "bright light. How did you get here?     Who would put you here ..."
             PRINT "and why? (Hit a key)"
FOR l = 1 TO 60
PALETTE 74, l
FOR d = 1 TO 1000 * sip: NEXT d
NEXT l
tim = TIMER
10 DO: LOOP UNTIL TIMER - tim > 1
12 a$ = INKEY$: IF a$ = "" THEN 12

