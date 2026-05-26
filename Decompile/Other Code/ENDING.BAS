
SUB ending
SCREEN 13
DEFINT A-C
DIM b(10400)
GET (1, 140)-(100, 180), b
OPEN "256colo.pal" FOR INPUT AS #1
FOR I = 1 TO 255 STEP 1
INPUT #1, p
IF p = 0 AND I > 10 THEN I = 255
PALETTE I + 16, p
IF I > 20 AND I < 22 THEN LOCATE 1, 1: PRINT "Figuring Palette"
NEXT I
CLOSE
150 CLS
DEF SEG = VARSEG(b(1))
BLOAD "end1.pic", 0
PUT (61, 61), b
GET (61, 61)-(233, 163), b
FOR I = 60 TO 0 STEP -2
SOUND 32676, 1
PUT (I, I), b, PSET
NEXT I
FOR D = 600 TO 50 STEP -12
SOUND D, .1: SOUND 50 + RND * 200, .1
NEXT D
tim = TIMER: DO: LOOP UNTIL TIMER - tim > 2
GOSUB 295
DEF SEG = VARSEG(b(1))
BLOAD "end2.pic", 0
PUT (161, 61), b
GET (161, 61)-(320, 163), b
FOR I = 60 TO 0 STEP -2
SOUND 32676, 1
PUT (160, I), b, PSET
NEXT I
tim = TIMER: DO: LOOP UNTIL TIMER - tim > 3
ib = 160: GOSUB 295
DEF SEG = VARSEG(b(1))
BLOAD "end3.pic", 0
PUT (61, 101), b
GET (61, 101)-(233, 200), b
FOR I = 60 TO 0 STEP -2
SOUND 32676, 1
PUT (I, 100), b, PSET
NEXT I
RANDOMIZE 116: FOR I = 1 TO 9
SOUND 300 + INT(RND * 10) * 100, 3
SOUND 32676, 2
NEXT I
tim = TIMER: DO: LOOP UNTIL TIMER - tim > 2
ib = 0: ia = 100: GOSUB 295
DEF SEG = VARSEG(b(1))
BLOAD "end4.pic", 0
PUT (160, 100), b
g = .4
FOR I = 50 TO 200 STEP 1
IF I / 20 = I \ 20 THEN g = g - .01: f = f + .01
SOUND 32676, g
SOUND I, .05 + f: SOUND 32676, g: SOUND 80, .1 + f
NEXT I
tim = TIMER: DO: LOOP UNTIL TIMER - tim > 1
ib = 160: ia = 100: GOSUB 295
tim = TIMER
151 a$ = INKEY$: IF TIMER - tim > 6 THEN a$ = " "
IF a$ = "" THEN 151
CLS
COLOR 28
PRINT "Abrahms ran towards the brain his hands"
PRINT "waving as if he thought he could somehow"
PRINT "stop the destruction of his one great"
PRINT "invention by placing himself between"
PRINT "it and the blast. It would not have "
PRINT "worked even if he was in time. Abrahms"
PRINT "and his machine, the true Dream Giver,"
PRINT "were obliterated. The spread of the"
PRINT "plague was stopped, but its symptoms on"
PRINT "those already infected are not. You"
PRINT "inject yourself carefully in the arm"
PRINT "with the antidote. You've already saved"
PRINT "millions of lives, and are intent on"
PRINT "saving your own. Using the phone you"
PRINT "dial your eastern headquarters. It's"
PRINT "only a few hours before you hear the"
PRINT "whirring of a helicopter. It won't"
PRINT "be long now."
153 a$ = INKEY$: IF a$ = "" THEN 153
FOR I = 60 TO 1 STEP -1
PALETTE 28, I
SOUND 32676, 1
NEXT I
CLS
SCREEN 12: COLOR 8
LOCATE 3, 1: PRINT "C:\JON\EGADRAW>"
FOR I = 10 TO 50 STEP 1
PALETTE 8, I + I * 256 + I * 65536
SOUND 32676, 1.8
a$ = INKEY$: IF a$ <> "" THEN gf = gf + 1: LOCATE 3, gf + 15: PRINT a$
NEXT I
SYSTEM
295 FOR b = 2 TO 160 STEP 4
FOR a = 3 TO 100 STEP 4
CIRCLE (b + ib, a + ia), 2, POINT(b + ib, a + ia)
NEXT a
NEXT b
RETURN

END SUB

