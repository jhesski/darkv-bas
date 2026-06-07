SUB logo
SCREEN 13: mn = .5
DIM x(3): DIM y(3)
RANDOMIZE TIMER
SHELL "midplay /q /r logo.mid"
SHELL "midplay /q /r logo.mid"
v1 = RND * 2 + 1: v2 = RND * 2 + 1: v3 = RND * 2 + 1
i = 10
PALETTE 0, (i \ v1) + (i \ v2) * 65536 + (i \ v3) * 256
FOR i = 60 TO 10 STEP -1
PALETTE 61 - i, (i \ v1) + (i \ v2) * 65536 + (i \ v3) * 256
NEXT i
x(1) = 135: y(1) = 90: x(2) = 175: y(2) = 110
1 LINE (x(1), y(1))-(x(2), y(2)), 50, BF
FOR i = 100 TO 1 STEP -1
LINE (x(1) - i, y(1) - i)-(x(2) + i, y(2) + i), 51 - (i / 2), B
NEXT i
IF a$ = "8" THEN 5 ELSE 6
5 x(1) = x(1) - 1.7:  x(2) = x(2) + 1.7: y(1) = y(1) - 1.3: y(2) = y(2) + 1.3: GOTO 7
6 x(1) = x(1) + 1.7:  x(2) = x(2) - 1.7: y(1) = y(1) + 1.3: y(2) = y(2) - 1.3
7 IF x(2) < -100 THEN 3
GOTO 1
3 FOR i = 1 TO 27 STEP .8
mn = mn + .8
DRAW "s=" + VARPTR$(mn)
DRAW "bm160,100": f = mn * 13.3
DRAW "ta=" + VARPTR$(f)
DRAW "bl25bd4c2u8d4c7ne4f4br3c10u8r4d4c14l4f4br4u8c17nr4d4nr3c20d4r4br4c24nu8r4nu8c27br8l4u2e4c30u2nl4br4nr4c33d4nr3d4c37r4br4u8c40r4d4l4f4"
tim = TIMER
2 FOR d = 1 TO 1000: NEXT d
IF i < 26.5 THEN CLS
NEXT i
COLOR 35: LOCATE 20, 15: PRINT "Industries"
FOR i = 400 TO 50 STEP -9
jg = jg + .1
i = i + jg
NEXT i
FOR i = 1 TO 60
PALETTE 0, i
FOR d = 1 TO 150: NEXT d
NEXT i
FOR i = 60 TO 1 STEP -1
PALETTE 0, i
FOR d = 1 TO 150: NEXT d
NEXT i
CLS
END SUB

