fg$ = "house2.pal"
SCREEN 13, 0
0 ' Must include this to load
g = 32000
DEFINT B-C
DIM c(1 TO g)
DIM pl(256) AS LONG
SCREEN 13
' End of including
fe$ = "n"
 CLS
1 DIM B(1 TO g)
DIM h(500): DIM i(500): DIM g(500)
  DIM su(100): DIM sm(100)
  DIM si(100): DIM col(300)
  DIM cl(5): DIM a(15)
  DIM word$(50): DIM low(50)
490 DIM CS(31): DIM bs(31): DIM mess$(31)
495 DIM ky$(31): DIM df$(31)
498 DIM st(31): DIM vh$(50)
FOR i = 1 TO 50
vh$(i) = "                                                                               "
NEXT i
RANDOMIZE TIMER: DEF SEG = 0: POKE 1047, 32
3 DRAW "bm1,1c50r1": GET (1, 1)-(1, 1), a
4 REM k(400)
5 CLS : a = 100: B = 160
gk = 1: fca$ = "z"
q$ = "Type in name"
7 f = 0
8 e$ = "n"
9 s = 1: c = 0
COLOR 42
GOSUB 120
'PALETTE 15, 50 + 50 * 65536 + 50 * 256
10 a$ = INKEY$
PEN ON
g = PEN(3)
IF g = 0 THEN 16
xb = B: ya = a
B = PEN(4)
a = PEN(5)
IF f <> 0 THEN LINE (xb, ya)-(B, a), f
16 IF a$ = "-" THEN d = d - 1: IF f <> 0 THEN f = f - 1: DRAW "c=" + VARPTR$(d)
IF a$ = "=" THEN d = d + 1: IF f <> 0 THEN f = f + 1: DRAW "c=" + VARPTR$(d)
IF fd <> d THEN LINE (206, 1)-(209, 3), d, BF: fd = d: LINE (B, a)-(B, a), POINT(B, a)
12 IF a$ = "." THEN IF SIZ = 0 THEN GOTO 300 ELSE SIZ = 0: f = d: DRAW "c=" + VARPTR$(f): a$ = "5": GOTO 61
15 IF a$ = "6" THEN IF f <> 0 OR e$ = "y" THEN DRAW "r=" + VARPTR$(s): B = B + s ELSE B = B + s
IF a$ = "i" THEN d = POINT(B, a)
20 IF a$ = "8" THEN IF f <> 0 OR e$ = "y" THEN DRAW "u=" + VARPTR$(s): a = a - s ELSE a = a - s
25 IF a$ = "2" THEN IF f <> 0 OR e$ = "y" THEN DRAW "d=" + VARPTR$(s): a = a + s ELSE a = a + s
30 IF a$ = "4" THEN IF f <> 0 OR e$ = "y" THEN DRAW "l=" + VARPTR$(s): B = B - s ELSE B = B - s
32 IF a$ = "c" THEN IF c = 0 THEN c = 1: GET (2, 10)-(310, 199), c: LINE (2, 10)-(310, 199), 0, BF ELSE c = 0: PUT (2, 10), c, PSET
IF a$ = "C" THEN GOTO click
35 IF a$ = "1" THEN IF f <> 0 OR e$ = "y" THEN DRAW "g=" + VARPTR$(s): a = a + s: B = B - s ELSE a = a + s: B = B - s
IF a$ = "v" THEN GOSUB 2
IF a$ = "j" THEN GOSUB 14
37 IF a$ = "n" THEN LOCATE 25, 1: PRINT "New?"; : zx$ = INKEY$: IF zx$ = "" THEN 37 ELSE IF zx$ = "y" THEN 5 ELSE LOCATE 25, 1: PRINT "    ";
39 IF a$ = "\" THEN GET (2, 2)-(200, 100), c: GOSUB 350
40 IF a$ = "9" THEN IF f <> 0 OR e$ = "y" THEN DRAW "e=" + VARPTR$(s): a = a - s: B = B + s ELSE a = a - s: B = B + s
42 IF a$ = "`" THEN GOSUB 220
IF a$ = "f" THEN IF fe$ = "y" THEN fe$ = "n" ELSE fe$ = "y"
IF a$ = "?" THEN GOSUB 184
45 IF a$ = "7" THEN IF f <> 0 OR e$ = "y" THEN DRAW "h=" + VARPTR$(s): a = a - s: B = B - s ELSE a = a - s: B = B - s
50 IF a$ = "3" THEN IF f <> 0 OR e$ = "y" THEN DRAW "f=" + VARPTR$(s): a = a + s: B = B + s ELSE a = a + s: B = B + s
IF fr$ = "y" THEN PUT (B, a), B, PSET
IF a$ = "t" THEN ft = POINT(B, a)
IF a$ = "y" THEN fy = POINT(B, a)
IF a$ = "]" THEN IF fr$ = "" THEN fr$ = "y" ELSE fr$ = ""
IF fe$ = "n" THEN 57
FOR gf = 0 TO 4
FOR g = 0 TO 4
IF POINT(B + gf, a + g) = ft THEN PSET (B + gf, a + g), fy
NEXT g
NEXT gf
57 IF a$ = "<" THEN LOCATE 25, 1: PRINT "Restore image?"; : c$ = INKEY$: IF c$ = "" THEN 57 ELSE IF c$ = "y" THEN PUT (1, 10), c, PSET:  ELSE LOCATE 25, 1: PRINT "                    ";
55 IF a$ = "g" THEN GOSUB 320
56 IF a$ = "d" THEN GOSUB 325
IF a$ = "e" THEN GOSUB 182
IF a$ = "%" THEN LOCATE 15, 1: INPUT gk: LOCATE 15, 1: PRINT "             "
58 IF a$ = "s" OR a$ = "S" THEN GOSUB 150
59 IF a$ = "b" THEN LOCATE 15, 1: INPUT c: COLOR c
60 IF SIZ = 1 THEN 70
61 IF a$ = "5" AND f <> 0 THEN DRAW "c0": IF SIZ = 0 THEN d = f: f = 0: a$ = "" ELSE f = 0: a$ = ""
65 IF a$ = "5" AND f = 0 THEN DRAW "c=" + VARPTR$(d): f = d: GOTO 100
70 ON ERROR GOTO 200
IF f = 0 AND e$ = "n" THEN PUT (B, a), a, XOR
72 IF f = 0 AND e$ = "y" AND SIZ = 0 THEN DRAW "c43u2r2d2l2c0u2r2d2l1u1bg1"
75 IF a$ = "0" THEN s = s + 2: IF s = 5 OR s = 8 THEN s = 1
IF a$ = "$" THEN GOSUB 49
76 IF a$ = "z" THEN mz = B: mx = a
IF a$ = "{" THEN GOSUB 183
77 IF a$ = "x" THEN nz = B: nx = a
78 IF a$ = "l" THEN IF f <> 0 THEN LINE (mz, mx)-(nz, nx), f ELSE LINE (mz, mx)-(nz, nx), d
80 IF a$ = "u" THEN DRAW "c1": f = 1
83 IF a$ = "o" THEN GOSUB 101
IF a$ = "a" THEN GOSUB 185: GET (B, a)-(B + 18, a + 18), B
85 IF a$ = CHR$(13) THEN 115
88 IF a$ = "r" OR a$ = "R" THEN GOSUB 260
IF a$ = "(" THEN GOSUB 232
IF a$ = ")" THEN GOSUB 242
91 IF a$ = "k" THEN GOSUB 800
93 IF a$ = "+" THEN IF s <> 6 THEN s = 6 ELSE s = 1
95 IF a$ = "*" THEN GET (1, 10)-(319, 199), c: LINE (0, 10)-(321, 10), d: GOTO 140
96 IF a$ = "q" THEN LOCATE 25, 1: PRINT "Really quit?"; : ad$ = INKEY$: IF ad$ = "" THEN 96 ELSE IF ad$ = "y" THEN SYSTEM ELSE LOCATE 25, 1: PRINT "                 ";
97 IF f = 0 AND e$ = "n" AND SIZ = 0 THEN PUT (B, a), a, XOR
99 IF a$ = "/" AND SIZ = 0 THEN IF e$ = "y" THEN e$ = "n" ELSE e$ = "y"
100 GOTO 10
49 FOR i = 1 TO 256: col(i) = 0
NEXT i
FOR i = 1 TO 301
FOR d = 11 TO 199
col(POINT(i, d)) = 1
NEXT d
NEXT i
tc = 0
FOR i = 0 TO 256
IF col(i) = 1 THEN tc = tc + 1
NEXT i: LOCATE 17, 1: PRINT tc
RETURN
101 RETURN: LOCATE 1, 1: PRINT "What color   "
INPUT cl
204 DRAW "c=" + VARPTR$(cl): f = cl
LOCATE 15, 1: PRINT "             ": LOCATE 16, 1: PRINT "      "
RETURN
102 LOCATE 15, 1: INPUT f
105 IF f > 250 THEN 102
108 DRAW "c=" + VARPTR$(f)
110 GOTO 10
115 LOCATE 15, 1: INPUT q
125 CIRCLE (B, a), q, f
130 GOTO 100
140 LINE (B, a)-(B, a), 0
141 PAINT (B, a), f, f
145 GOTO 100
150 LOCATE 1, 1: PRINT q$; : INPUT f$
IF f$ = "a" OR f$ = "A" THEN RETURN
IF f$ <> "" THEN q$ = f$
IF a$ = "s" GOTO 778 ELSE GOTO 777
    ON ERROR GOTO 700
    OPEN q$ + ".pac" FOR INPUT AS #1
    INPUT #1, xzc, zxn
153 LOCATE 15, 1: PRINT "Save over previous picture?": a$ = INKEY$: IF a$ = "" THEN 153
    IF a$ = "y" THEN 151 ELSE ON ERROR GOTO 200: GOTO 10
151 CLOSE : LOCATE 15, 1
152 PRINT "                                "
155 DEF SEG = &HB800
160 BSAVE q$ + ".pic", 0, &H4000
165 OPEN q$ + ".pac" FOR OUTPUT AS #1
175 CLOSE
180 END
182 LOCATE 10, 30: INPUT mel
LINE (1, 110)-(320, 200), 0, BF
FOR axc = mx TO nx STEP 1
FOR ixc = mz TO nz STEP 1
IF gk = 2 THEN LINE (180 - (axc - mx) * mel, 181 - (ixc - mz) * mel)-(180 - (axc - mx) * mel - (mel - .9), 181 - (ixc - mz) * mel - (mel - .9)), POINT(ixc, axc), BF
IF gk = 3 THEN LINE (1 + (ixc - mz) * mel, 180 - (axc - mx) * mel)-(1 + (ixc - mz) * mel - (mel - .9), 180 - (axc - mx) * mel - (mel - .9)), POINT(ixc, axc), BF
IF gk = 1 THEN LINE (1 + (ixc - mz) * mel, 120 + (axc - mx) * mel)-(1 + (ixc - mz) * mel - (mel - .9), 120 + (axc - mx) * mel - (mel - .9)), POINT(ixc, axc), BF
IF gk = 4 THEN LINE (181 - (ixc - mz) * mel, 120 + (axc - mx) * mel)-(181 - (ixc - mz) * mel - (mel - .9), 120 + (axc - mx) * mel - (mel - .9)), POINT(ixc, axc), BF
IF 120 + (axc - mx) * mel > 200 THEN RETURN
NEXT ixc: NEXT axc
RETURN
183 mel = 1.8: mx = 100: nx = 1: mz = 1: nz = 320
FOR axc = 100 TO 1 STEP -1
FOR ixc = 1 TO 320 STEP 1
LINE (1 + (ixc - mz) * mel, 200 + (axc - mx) * mel)-(1 + (ixc - mz) * mel - (mel - .9), 200 + (axc - mx) * mel - (mel - .9)), POINT(ixc, axc), BF
NEXT ixc: NEXT axc
RETURN
232 FOR i = mx TO nx STEP 1
FOR d = mz TO nz STEP 1
IF POINT(d, i) <> 0 THEN PSET (d, i), POINT(d, i) + 1
NEXT d
NEXT i
RETURN
242 FOR i = mx TO nx STEP 1
FOR d = mz TO nz STEP 1
IF POINT(d, i) <> 0 THEN PSET (d, i), POINT(d, i) - 1
NEXT d
NEXT i
RETURN
243 FOR i = mx TO nx STEP 1
FOR d = mz TO nz STEP 1
IF POINT(d, i) <> 0 THEN PSET (d, i), 15
NEXT d
NEXT i: RETURN
184 FOR mel = .1 TO 4 STEP .15
FOR axc = mx TO nx STEP 1
FOR ixc = mz TO nz STEP 1
LINE (1 + (ixc - mz) * mel, 120 + (axc - mx) * mel)-(1 + (ixc - mz) * mel - (mel - .9), 120 + (axc - mx) * mel - (mel - .9)), POINT(ixc, axc), BF
NEXT ixc: NEXT axc
NEXT mel
LINE (1, 110)-(320, 200), 0, BF: RETURN
185 LOCATE 15, 1: PRINT "Which box?": INPUT i
x(i) = B: y(i) = a
RETURN
200 IF B > 319 THEN B = 319
201 IF B < 1 THEN B = 1
205 IF a < 1 THEN a = 1
210 IF a > 199 THEN a = 199
211 SOUND 400, 1: SOUND 200, .5
215 RESUME 10
220 pa = a \ 8: pb = B \ 8
221 LOCATE pa, pb: PRINT ".": a$ = INKEY$: IF a$ = "" THEN 221
222 LOCATE pa, pb: PRINT " "
223 IF a$ = CHR$(8) THEN a$ = "4"
225 IF a$ = "8" THEN pa = pa - 1: GOTO 221
230 IF a$ = "4" THEN pb = pb - 1: GOTO 221
235 IF a$ = "6" THEN pb = pb + 1: GOTO 221
240 IF a$ = "2" THEN pa = pa + 1: GOTO 221
245 IF a$ = "`" THEN RETURN
250 LOCATE pa, pb: PRINT a$
252 a$ = "6": GOTO 235
260 CLS
275 FILES "*.pic"
280 CLOSE : INPUT q$
    IF a$ = "r" THEN GOTO 780 ELSE GOTO 781
284 CLS
285 'DEF SEG = &HB800
290 'BLOAD q$ + ".pic", 0: GOTO 10
300  SIZ = 1: DRAW "c0": IF f <> 0 THEN d = f: f = 4: GOTO 10:  ELSE f = 4: a$ = "": GOTO 10
320 GET (mz, mx)-(nz, nx), B: RETURN
325 PUT (B, a), B, OR: RETURN
350 tile$ = ""
352 FOR i = ft TO fy
354 tile$ = tile$ + CHR$(i)
356 NEXT i
LINE (0, 10)-(321, 10), f, B
360 PAINT (B, a), tile$, f
370 tile$ = ""
375 RETURN
120 GOSUB 121
FOR i = 1 TO 120
LINE (i + 30, 1)-(i + 30, 2), i
NEXT i
FOR i = 121 TO 255
LINE (i - 95, 3)-(i - 95, 4), i
NEXT i
RETURN
400 '-------------Click starts----------------
click:
401 tr$ = "n"
    fca$ = "c"
440 SCREEN 13
    FILES "*.pic"
450 INPUT q$
  REM  GOSUB 709 'load specials
453 CLOSE
454 CLS : B = 50: dd = 50: GOTO 500
455 GOSUB 781
RETURN
462 LOCATE 1, 1: PRINT "                                       "
464 LOCATE 2, 1: PRINT "                                       "
465 LOCATE 3, 1: PRINT "                                       "
466 LOCATE 4, 1: PRINT "                                       "
470 RETURN
500 ON ERROR GOTO 820
CQ = CQ + 1
502 IF CQ > 30 THEN 525
503 INPUT "More"; a$
504 IF a$ = "n" OR a$ = "no" OR a$ = "N" OR a$ = "NO" THEN 525 ELSE GOSUB 455
LOCATE 1, 1: PRINT "Special #"; CQ
508 GOSUB 462: LOCATE 2, 1: PRINT "What number can`t be set?"
LOCATE 3, 1: INPUT CS(CQ)
512 GOSUB 462: LOCATE 2, 1: PRINT "What # must be set?"
514 INPUT bs(CQ)
516 GOSUB 462: LOCATE 2, 1: PRINT "What gets set?"
518 INPUT st(CQ)
GOSUB 462: LOCATE 2, 1: PRINT "What is displayed?"
522 INPUT mess$(CQ)
523 GOSUB 462: LOCATE 2, 1: PRINT "What key activates?": INPUT ky$(CQ)
524 GOSUB 462: LOCATE 2, 1: PRINT "Extra info?/Transfer": INPUT df$(CQ): GOTO 500
525 CLS
GOSUB 781
565 DRAW "c51bm1,1r3d3l3u2r1d1r1u1"
570 GET (1, 1)-(4, 4), a
571 DRAW "bm200,6c2r75"
572 PUT (B, dd), a, XOR
574 a$ = INKEY$: IF a$ = "" THEN 574
575 PUT (B, dd), a, XOR
ON ERROR GOTO 820
    IF tar$ = "y" AND a$ <> "t" THEN GOSUB 815
579 IF a$ = "2" THEN dd = dd + 4
585 IF a$ = "8" THEN dd = dd - 4
590 IF a$ = "4" THEN B = B - 4
    IF a$ = "7" THEN B = B - 4: dd = dd - 4
    IF a$ = "9" THEN B = B + 4: dd = dd - 4
    IF a$ = "1" THEN B = B - 4: dd = dd + 4
    IF a$ = "3" THEN B = B + 4: dd = dd + 4
    IF a$ = "f" THEN GOSUB 810
    IF a$ = "t" THEN IF tar$ = "n" THEN tar$ = "y": INPUT ap$ ELSE tar$ = "n"
592 IF a$ = "s" THEN GOSUB 890
    IF a$ = "d" THEN GOSUB 789: LOCATE 1, 1: ip = 1: INPUT gp$: FOR i = 1 TO 30: GOSUB 790: NEXT i
593 IF a$ = "e" THEN LOCATE 16, 1: PRINT "Exit click?": a$ = INKEY$: IF a$ = "" THEN a$ = "e": GOTO 593 ELSE IF a$ = "y" THEN RUN
595 IF a$ = "6" THEN B = B + 4
596 IF a$ = CHR$(13) THEN IF gs < 75 THEN GOSUB 610 ELSE BEEP
600 GOTO 572
610 LOCATE 1, 1
614 PRINT "What special?"
615 INPUT ap$
621 MID$(vh$(dd \ 4 + 1), B \ 4 + 1, 1) = ap$: GOTO 625
635 IF si(gs) <> 0 THEN GOTO 635
622 si(gs) = B: su(gs) = dd
624 sm(gs) = i: gs = gs + 1
625 LOCATE 1, 1: PRINT "       "
DRAW "bm275,6c0l=" + VARPTR$(gs)
630 RETURN
640 OPEN q$ + ".pac" FOR OUTPUT AS #1
    GOSUB 641
    GOTO 680
641 WRITE #1, c, ia, ib, ic
645 CLOSE : RETURN
680 PRINT "Edit another file?"
682 a$ = INKEY$: IF a$ = "" THEN 682
684 IF a$ = "y" THEN RUN
685 IF a$ = "n" THEN SYSTEM
687 PRINT "Type y or n": GOTO 682
709 ' Loads screen's push/open/use/look
CLOSE
OPEN q$ + ".dat" FOR INPUT AS #1
INPUT #1, fit
FOR i = 1 TO 5
INPUT #1, qa(i), qb(i), x(i), y(i)
NEXT i
INPUT #1, gen$, da$(1), da$(2), da$(3), da$(4), da$(5), da$(6)
FOR i = 1 TO 50
INPUT #1, vh$(i)
NEXT i
FOR i = 1 TO 30
 INPUT #1, mess$(i), ky$(i), bs(i), CS(i), st(i), df$(i)
 NEXT i
RETURN
789 LOCATE 1, 1: PRINT "                                                                "
LOCATE 2, 1: PRINT "                                                                "
RETURN
790 IF LEFT$(df$(i), 1) <> gp$ THEN RETURN
ip = ip + 1
    LOCATE ip, 1: PRINT mess$(i)
    RETURN

700 ON ERROR GOTO 200
    RESUME 151
800 LOCATE 15, 1: PRINT "Really kill image? Y/n"
a$ = INKEY$: IF a$ = "" THEN 800
IF a$ = "Y" THEN KILL q$ + ".pic": CLOSE : KILL q$ + ".dat"
LOCATE 15, 1: PRINT "                         "
RETURN
810 LOCATE 1, 1: PRINT "      "
    PRINT MID$(vh$(dd \ 4 + 1), B \ 4 + 1, 1)
    RETURN
820 B = 50: dd = 50: BEEP
    'LOCATE 20, 1: PRINT ERL, ERR
    RESUME 572
890 CLOSE : GOSUB 891
895 LOCATE 16, 1: PRINT "Saving specials"
CLOSE
OPEN q$ + ".dat" FOR OUTPUT AS #1
WRITE #1, fit
FOR i = 1 TO 5
WRITE #1, qa(i), qb(i), x(i), y(i)
NEXT i
WRITE #1, gen$, da$(1), da$(2), da$(3), da$(4), da$(5), da$(6)
FOR i = 1 TO 50
WRITE #1, vh$(i)
NEXT i
 FOR i = 1 TO 30
 WRITE #1, mess$(i), ky$(i), bs(i), CS(i), st(i), df$(i)
 NEXT i
RETURN
891 RETURN
815 SOUND 100, .1
GOTO 621
777 GET (mz, mx)-(nz, nx), c(3)
  DEF SEG = VARSEG(c(1))
  c(1) = mz: c(2) = mx
  BSAVE q$ + ".pic", VARPTR(c(1)), (mz - nz) * (mx - nx)
  DEF SEG
  'GOSUB 895
  RETURN
778 GET (2, 10)-(310, 198), c
  DEF SEG = VARSEG(c(1))
  BSAVE q$ + ".pic", VARPTR(c(1)), 57000
  DEF SEG
  'GOSUB 895
  RETURN
780 CLS
'------- LOADING OF THE PICTURE -------
GET (2, 10)-(310, 199), c
DEF SEG = VARSEG(c(1))
BLOAD q$ + ".pic", VARPTR(c(1))
DEF SEG = 0
c = 0
882 PUT (2, 10), c, PSET'places picture in certain postion
GOTO 883
RETURN
781 CLS
'------- LOADING OF THE PICTURE -------
GET (2, 10)-(310, 199), c
DEF SEG = VARSEG(c(1))
BLOAD q$ + ".pic", VARPTR(c(1))
DEF SEG = 0
c = 0
PUT (c(1), c(2)), c(3), PSET 'places picture in certain postion

'-------- END OF LOAD -------------
883 ON ERROR GOTO 900
'IF fca$ <> "c" THEN GOSUB 709
884 GOSUB 120
ON ERROR GOTO 200
RETURN
900 RESUME 884
121 OPEN fg$ FOR INPUT AS #1
FOR i = 1 TO 255 STEP 1
INPUT #1, pl(i)
NEXT i
PALETTE USING pl(0)
CLOSE
RETURN
'----------------------All about guy------------------------
2 x = 165: y = 145: g = 178: f = 167: j = -120: fh = 3: bob = 0
CS = 180: CS = 33: cp = 32: cp = 204: ch = 175: ch = 24: cf = 120: cf = 150
WINDOW SCREEN (1 + j * 3, 1 + j * 2)-(320 - j * 3, 200 - j * 2)
vg = 0
310 GET (x - 22, y - 36)-(x + 11, g + 10), c
bob = bob + fh: IF bob = 6 THEN fh = -3 ELSE IF bob < -5 THEN fh = 3
FOR i = 0 TO 5
LINE (x + i, y)-(f + i - 1, g + bob), cp - i * 1.5
LINE (x - i, y)-(f - i + 1, g + bob), cp - i * 1.5
NEXT i
FOR i = 0 TO 4
LINE (x + i - 9, y)-(f + i - 1 - 9, g - bob), cp - i * 1.5
LINE (x - i - 9, y)-(f - i + 1 - 9, g - bob), cp - i * 1.5
NEXT i
IF vg = 0 THEN GOSUB 420
GOTO 421
420 x = x - 5
FOR i = 0 TO 10
LINE (x + i - 2, y - 2)-(x + i, y - 20 + i / 2), CS - i
LINE (x - i + 2, y - 2)-(x - i, y - 20 + i / 2), CS - i
NEXT i
x = x + 5
LINE (x - 13, y)-(x + 4, y), 4
LINE (x - 13, y - 1)-(x + 4, y - 1), 12
RETURN
421 FOR i = 0 TO 3
LINE (x + 4 + i, y - 17 + i)-(x + 7 + i, y + 5 - bob / 1.5), CS - 2 - i
LINE (x + 4 - i, y - 17 + i)-(x + 9 - i, y + 5 - bob / 1.5), CS - 2 - i
LINE (x - 15 + i, y - 17 + i)-(x - 20 + i, y + 5 + bob / 1.5), CS - i
LINE (x - 15 - i, y - 17 + i)-(x - 18 - i, y + 5 + bob / 1.5), CS - i
NEXT i
FOR i = 0 TO 2
LINE (x + 9, y + 6 + i - bob / 1.5)-(x + 5 + i, y + 6 + i - bob / 1.5), cf
LINE (x - 17 - i, y + 6 + i + bob / 1.5)-(x - 20, y + 6 + i + bob / 1.5), cf
LINE (f + 4 + i, g + 1 + i + bob)-(f - 1, g + 1 + i + bob), cf - i * 2
LINE (f - 12 - i, g + 1 + i - bob)-(f - 8, g + 1 + i - bob), cf - i * 2
NEXT i
IF vg = 1 THEN GOSUB 420
IF vg = 0 THEN 415
CIRCLE (x - 5, y - 25), 6, ch, , , 1.5
PAINT (x - 5, y - 25), ch, ch
FOR i = 0 TO 3
CIRCLE (x - 5, y - 25 - i), 6, ch + 1, .5 - (i / 5), 2.5 + (i / 5), 1.5
NEXT i
GOTO 405
415 CIRCLE (x - 5, y - 25), 6, cf, , , 1.5
PAINT (x - 5, y - 25), cf, cf
FOR i = 0 TO 3
CIRCLE (x - 5, y - 25 - i), 6, ch, .5 - (i / 5), 2.5 + (i / 5), 1.5
NEXT i
PSET (x - 8, y - 26), 0: PSET (x - 2, y - 26), 0
GOTO 405
405 FOR i = 1 TO 6400: NEXT i: a$ = "8"
IF vg = 0 THEN j = j + 3 ELSE j = j - 3
PUT (x - 22, y - 36), c, PSET
WINDOW SCREEN (1 + j * 3, 1 + j * 2)-(320 - j * 3, 200 - j * 2)
IF j > 0 THEN vg = 1
IF j < -120 THEN WINDOW SCREEN (1, 1)-(320, 200): RETURN
GOTO 310
'-------------------Sideways guy----------------------
14 x = 165: y = 145: g = 178: f = 167: j = 0: fh = 4: dg = 0: bob = 0
CS = 180: CS = 33: cp = 32: cp = 204: ch = 175: ch = 24: cf = 120: cf = 150
IF dg = 1 THEN lk = 1: pk = 0 ELSE pk = 1: lk = 0
WINDOW SCREEN (1 + j * 3, 1 + j * 2)-(320 - j * 3, 200 - j * 2)
vg = 0
510 GET (x - 30, y - 36)-(x + 18, g + 10), c
bob = bob + fh: IF bob > 7 THEN fh = -4 ELSE IF bob < -5 THEN fh = 4
FOR i = 0 TO 3
LINE (x - 13 + i, y - 17 + i)-(x - 18 + i + bob, y + 5), CS - i
LINE (x - 13 - i, y - 17 + i)-(x - 16 - i + bob, y + 5), CS - i
NEXT i
FOR i = 0 TO 2
LINE (x - 15 - i + bob, y + 6 + i)-(x - 18 + bob, y + 6 + i), cf
LINE (f - 12 - i * pk - bob, g + 1 + i)-(f - 8 - bob + i * lk, g + 1 + i), cf - i * 2
NEXT i
FOR i = 0 TO 4
LINE (x + i - 9, y)-(f + i - 1 - 9 - bob, g), cp - i * 1.5
LINE (x - i - 9, y)-(f - i + 1 - 9 - bob, g), cp - i * 1.5
NEXT i
FOR i = 0 TO 5
LINE (x - 8 + i, y)-(f - 8 + i - 1 + bob, g + 2), cp - i * 1.5
LINE (x - 8 - i, y)-(f - 8 - i + 1 + bob, g + 2), cp - i * 1.5
NEXT i
IF vg = 0 THEN GOSUB 520
GOTO 521
520 x = x - 5
FOR i = 0 TO 5
LINE (x + i - 6, y - 2)-(x + i - 4, y - 20 + i), CS - i
LINE (x - i - 2, y - 2)-(x - i - 4, y - 20 + i), CS - i
NEXT i
x = x + 5
LINE (x - 13, y)-(x - 4, y), 4
LINE (x - 13, y - 1)-(x - 4, y - 1), 12
RETURN
521 FOR i = 0 TO 3
LINE (x - 6 + i, y - 17 + i)-(x - 3 + i - bob, y + 5), CS - 2 - i
LINE (x - 6 - i, y - 17 + i)-(x - 4 - i - bob, y + 5), CS - 2 - i
NEXT i
FOR i = 0 TO 2
LINE (x - 3 - bob, y + 6 + i)-(x - 6 + i - bob, y + 6 + i), cf
LINE (f - 11 - i * pk + bob, g + 3 + i)-(f - 6 + bob + i * lk, g + 3 + i), cf - i * 2
NEXT i
IF vg = 1 THEN GOSUB 520
IF dg = 0 THEN 515
CIRCLE (x - 8, y - 25), 6, ch, , , 1.5
PAINT (x - 8, y - 25), ch, ch
FOR i = 0 TO 2
CIRCLE (x - 9 + i, y - 25), 6, cf, 5, 1, 1.5
NEXT i
PSET (x - 3, y - 26), 0
GOTO 505
515 CIRCLE (x - 9, y - 25), 6, ch, , , 1.5
PAINT (x - 9, y - 25), ch, ch
FOR i = 0 TO 3
CIRCLE (x - 9 + i, y - 25), 6, cf, 2.5, 4.5, 1.5
NEXT i
PSET (x - 12, y - 26), 0
GOTO 505
505 FOR i = 1 TO 6200: NEXT i: a$ = "8"
PUT (x - 30, y - 36), c, PSET
IF dg = 1 THEN x = x + 4: f = f + 4 ELSE x = x - 4: f = f - 4
IF vg = 0 THEN j = j + 0 ELSE j = j - 0
WINDOW SCREEN (320 - j * 3, 1 + j * 2)-(j * 3, 200 - j * 2)
IF j > 0 THEN vg = 1
IF j < -120 OR x < 34 THEN WINDOW SCREEN (1, 1)-(320, 200): RETURN
GOTO 510

