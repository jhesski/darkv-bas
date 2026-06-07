COMMON SHARED gu AS INTEGER, sip
COMMON SHARED f1 AS INTEGER, e1 AS INTEGER, lle1 AS INTEGER, lf1 AS INTEGER, lj1 AS INTEGER, llh1 AS INTEGER, le1 AS INTEGER, lh1 AS INTEGER, s4 AS INTEGER, s3 AS INTEGER, m4 AS INTEGER, m3 AS INTEGER

SUB logo ()
DIM x(2): DIM y(2)
mn = .5
v1 = RND * 2 + 1: v2 = RND * 2 + 1: v3 = RND * 2 + 1
i = 10
PALETTE 0, (i \ v1) + (i \ v2) * 65536 + (i \ v3) * 256
FOR i = 60 TO 10 STEP -1
PALETTE 61 - i, (i \ v1) + (i \ v2) * 65536 + (i \ v3) * 256
NEXT i
884 x(1) = 135: y(1) = 90: x(2) = 175: y(2) = 110
881 LINE (x(1), y(1))-(x(2), y(2)), 50, BF
FOR i = 100 TO 1 STEP -2
LINE (x(1) - i, y(1) - i)-(x(2) + i, y(2) + i), 51 - (i / 2), B
NEXT i
SOUND 100 + y(1) * 4, .1
886 x(1) = x(1) + 1.3:  x(2) = x(2) - 1.3: y(1) = y(1) + 1: y(2) = y(2) - 1
887 IF x(2) < -100 THEN 883 ELSE 881
883 FOR i = 1 TO 27 STEP .5
mn = mn + .5
DRAW "s=" + VARPTR$(mn)
DRAW "bm160,100": f = mn * 13.3
DRAW "ta=" + VARPTR$(f)
DRAW "bl25bd4c2u8d4c7ne4f4br3c10u8r4d4c14l4f4br4u8c17nr4d4nr3c20d4r4br4c24nu8r4nu8c27br8l4u2e4c30u2nl4br4nr4c33d4nr3d4c37r4br4u8c40r4d4l4f4"
SOUND 1000 - mn * 5, .1: SOUND RND * 16000 + 50, .1
FOR d = 1 TO 100 * sip: NEXT d
IF i < 26.5 THEN CLS
NEXT i
COLOR 35: LOCATE 20, 15: PRINT "Industries"
FOR i = 400 TO 50 STEP -9
jg = jg + .1
i = i + jg
SOUND i, .15: SOUND RND * 500 + i, .1
NEXT i
COLOR 30
LOCATE 25, 1: PRINT "tap a key to proceed";
850 a$ = INKEY$: IF a$ = "" THEN 850
FOR i = 1 TO 60
PALETTE 0, i
FOR d = 1 TO 150 * sip: NEXT d
NEXT i
FOR i = 60 TO 1 STEP -1
PALETTE 0, i
FOR d = 1 TO 150 * sip: NEXT d
NEXT i
CLS

END SUB

