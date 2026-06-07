COMMON SHARED x

SUB logo
SCREEN 13
DIM a(1500)
DIM b(1500)
COLOR 188: LOCATE 1, 1: PRINT "Kreuzer"
GET (1, 0)-(56, 8), a
COLOR 189
LOCATE 1, 1: PRINT "Industries"
GET (1, 0)-(88, 8), b
CLS
LOCATE 1, 1: PRINT "Loading"
GOTO 3
3 FOR i = 1 TO 62
PALETTE i, i
NEXT i
FOR i = 1 TO 62
PALETTE i + 62, i * 65536
NEXT i
FOR i = 1 TO 62
PALETTE i + 124, i * 256
NEXT i
FOR i = 1 TO 62
PALETTE i + 190, i + i * 256 + i * 65536
NEXT i
CLS
FOR i = 1 TO 62: z = i * 2: x = i * 1.7
LINE (0 + z, 0 + x)-(320 - z, 200 - x), 190 + i, BF
NEXT i
FOR i = 1 TO 62
CIRCLE (157, 64), 63 - i, i + 62: PAINT (157, 64), i + 62, i + 62
NEXT i
FOR i = 1 TO 62
CIRCLE (74, 124), 63 - i, i: PAINT (74, 124), i, i
NEXT i
FOR i = 1 TO 62
CIRCLE (246, 124), 63 - i, i + 124: PAINT (246, 124), i + 124, i + 124
NEXT i
FOR i = 1 TO 128 STEP 1
a$ = INKEY$: IF a$ = "s" THEN x = 1: GOTO 101
PUT (i, 30), a, XOR: FOR d = 1 TO 1: SOUND 32676, .5: NEXT d
PUT (i, 30), a, XOR
NEXT i: PUT (i, 30), a, XOR
FOR i = 230 TO 119 STEP -1
PUT (i, 42), b, XOR: FOR d = 1 TO 1: SOUND 32676, .5: NEXT d
PUT (i, 42), b, XOR
NEXT i: PUT (i, 42), b, XOR
FOR i = 1 TO 62 STEP 1
COLOR i
LOCATE 11, 17: PRINT "Presents"
SOUND 32676, .25
NEXT i
PLAY "p9"
101
END SUB

