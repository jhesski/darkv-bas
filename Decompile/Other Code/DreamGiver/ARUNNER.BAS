DECLARE SUB logo ()
DECLARE SUB intro ()
DECLARE SUB ending ()
DECLARE SUB hint ()
COMMON SHARED x
logo
IF x <> 1 THEN intro
CLOSE
DEFINT A-K
zog = 10800
DIM b(1 TO zog)
DIM a(500): DIM c(450): DIM d(450)
DIM e(450): DIM f(450): DIM g(450)
DIM h(1 TO 5200), i(451), j(2000), k(2000)
DIM CS(31): DIM bs(31): DIM mess$(32)
DIM tran$(31): DIM ky$(31): DIM df$(31)
DIM st(31), vh$(31)
DIM su(100), sm(100)
DIM si(100), ob(160), iv(15), iv$(15)
DIM tv(15), tv$(15), dil$(16), da$(6)
DIM qa(6), qb(6), fx(6), fy(6)
'-----------------Joystick-----------------
OPEN "Joy.dat" FOR INPUT AS #1
INPUT #1, jo$, x4, y4, x5, y5, x6, y6
CLOSE
GOTO 1
200 SCREEN 0: WIDTH 80
LOCATE 1, 1: PRINT "There has been an error. Dream giver terminated."
PRINT "#", ERR, ERL, i; "Hit a key": a$ = INKEY$: IF a$ = "" THEN 200
SYSTEM
1 SCREEN 1: SCREEN 13: SO$ = "y"
lj = 10: sx = 1
ON STRIG(4) GOSUB 122
ON STRIG(0) GOSUB 121
ON STRIG(2) GOSUB 120
ON ERROR GOTO 200
STRIG(0) ON: STRIG(4) ON: STRIG(2) ON
' defines variables
RANDOMIZE TIMER
zl = 8: j = 6: k = 6
q$ = "sub1"
CLS
FOR i = 1 TO 25
vh$(i) = "                                              "
NEXT i
DRAW "bm3,1c153l3d3e3c155g1l1f4"
' ------------------initiates images-----------------
GET (0, 0)-(4, 6), a: GET (0, 0)-(4, 6), b
GET (0, 0)-(4, 6), c: GET (0, 0)-(4, 6), d
GET (0, 0)-(4, 6), e: GET (0, 0)-(4, 6), f
GET (0, 0)-(4, 6), g: GET (0, 0)-(4, 6), h: GET (0, 0)-(4, 6), i
CLOSE
3 ' --------------creates specialized palette----------
LOCATE 1, 1: PRINT "Figuring palette"
OPEN "256colo.pal" FOR INPUT AS #1
FOR i = 1 TO 255 STEP 1
INPUT #1, p
IF p = 0 AND i > 10 THEN i = 255
PALETTE i + 16, p
IF i > 120 AND i < 122 THEN LOCATE 1, 1: PRINT "Calculating screen"
NEXT i
CLOSE
LOCATE 1, 1: PRINT "                         "
IF q$ = "cty11" OR LEFT$(mess$(vb), 1) = "|" THEN RETURN
GOSUB 10
ig = 4
GOSUB 11
GOSUB 13
i = 1: mess$(1) = "Active text"
GOSUB 60
gen$ = "Pure malovelence     eminates from the oldhouse. Lightning     flashes hauntingly inthe dark sky. "
2 IF bh = 1 THEN bh = 2
STRIG(0) ON
GOSUB 12
wa = zl: GOSUB 76
GOSUB 8
GOSUB 9
GOSUB 55
GOSUB 74
IF ob(0) = 0 THEN i = 0: ai = 1: bi = 3: d$ = "invenw": GOSUB 126
iv$(6) = "i31invenw": iv(6) = 83: tv$(6) = "i31invenw": tv(6) = 83
ob(0) = 1
tim = TIMER
GOTO 183
9 ' -----------Loads screen's push/open/use/look-----------
t = TIMER
CLOSE
910 OPEN q$ + ".dat" FOR INPUT AS #1
INPUT #1, rt
FOR i = 1 TO 5
911 INPUT #1, qa(i), qb(i), fx(i), fy(i)
NEXT i
912 INPUT #1, gen$, da$(1), da$(2), da$(3), da$(4), da$(5), da$(6)
FOR i = 1 TO 25
913 INPUT #1, vh$(i)
NEXT i
 FOR i = 1 TO 75
914 INPUT #1, si(i), su(i), sm(i)
 NEXT i
 FOR i = 1 TO 30
915 INPUT #1, tran$(i), mess$(i), ky$(i), bs(i), CS(i), st(i), df$(i)
 NEXT i
916 CLOSE
153 IF ob(54) <> 0 AND q$ = "ware1" THEN qa(1) = -1: qb(1) = -1
IF ob(105) <> 0 AND q$ = "cty8" THEN qa(5) = -1: qb(5) = -1
IF q$ = "terc6" AND ob(133) <> 0 THEN qb(1) = -1: qa(1) = -1 ELSE IF q$ = "apar1" AND ob(122) <> 0 THEN qa(5) = -1: qb(5) = -1
IF ob(123) = 1 AND q$ = "apar1" THEN FOR i = 1 TO 4: qa(i) = -1: qb(i) = -1: NEXT i: da$(2) = "8apar2": da$(3) = "6apar4"
IF da$(1) = "8s" THEN IF sx = 1 THEN da$(1) = "8sub1" ELSE da$(1) = "8cty6": IF ob(130) = 0 THEN FOR i = 1 TO 3: qa(i) = 0: qb(i) = 0: NEXT i
IF q$ = "dremdrk2" AND ob(6) = 1 THEN da$(3) = "9dremdrk4" ELSE IF q$ = "cty11" AND ob(129) = 1 THEN da$(2) = "8base1"
IF q$ = "dremdrk5" AND ob(6) = 1 THEN da$(1) = "8dremdrk4" ELSE IF q$ = "east" AND ob(88) = 1 AND ob(90) = 0 THEN qa(2) = .1: qb(2) = 0
IF q$ = "terc5" AND ob(135) = 1 THEN da$(2) = "1terc6"
IF da$(1) = "7apar1" THEN IF e$ = "" THEN e$ = "d": GOSUB 131 ELSE e$ = "": GOSUB 131
IF q$ = "base4" THEN IF ob(150) = 1 THEN qa(1) = 0: qb(1) = .1
5 IF q$ <> "base2" THEN RETURN
IF ob(147) = 1 THEN da$(2) = "4base3": GOSUB 74: qa(3) = 0: qb(3) = .1
IF ob(146) = 1 THEN da$(3) = "8base4": qa(4) = -1: qb(4) = -1: qa(5) = 0: qb(5) = .1: GOSUB 74
IF ob(145) = 1 THEN da$(4) = "6base5": GOSUB 74: qa(1) = 0: qb(1) = .1
RETURN
8 ' ----------------Load and display picture-------------
GET (2, 2)-(180, 100), b
DEF SEG = VARSEG(b(1))
BLOAD q$ + ".pic", VARPTR(b(1))
GET (184, 3)-(206, 106), h
PUT (5, 5), b, PSET
GET (5, 5)-(183, 103), b
GOSUB 6
RETURN
10 ' -------------------Draw screen------------------
FOR i = 1 TO 4
LINE (5 - i, 5 - i)-(315 + i, 195 + i), 77 + i, B
NEXT i
FOR i = 1 TO 4
LINE (5 - i, 5 - i)-(183 + i, 103 + i), 75 + i, B
NEXT i
FOR i = 1 TO 5
LINE (188, 104 + i)-(316, 104 + i), 33 + i
NEXT i
FOR i = 1 TO 5
LINE (5, 145 + i)-(183, 145 + i), 110 + i
NEXT i
FOR i = 1 TO 5
LINE (183 + i, 108)-(183 + i, 196), 45 + i
NEXT i
FOR i = 1 TO 4
LINE (210 + i, 5)-(210 + i, 104), 169 + i
NEXT i
LINE (4, 106)-(4, 146), 56
RETURN
11 '-----------------Draw inventory boxes---------------
ffi = i
cc = 0
FOR a = 0 TO 160 STEP 30
cc = cc + 1
IF iv(cc) <> 0 THEN 14
FOR i = 1 TO 10
LINE (4 + i + a, 107 + i)-(34 - i + a, 127 - i), i / 1.5 + 20, BF
NEXT i
IF rg = 5 AND cc = 5 THEN RETURN
iv$(cc) = ""
14 NEXT a
FOR a = 0 TO 160 STEP 30
cc = cc + 1
IF iv(cc) <> 0 THEN 48
IF cc = 12 THEN 48
FOR i = 1 TO 10
LINE (4 + i + a, 126 + i)-(34 - i + a, 146 - i), i / 1.5 + 19, BF
NEXT i
48 NEXT a
i = ffi
RETURN
12 '---------------Draw compass--------------
COLOR 103
LOCATE 15, 26: PRINT "NW    N    NE"
COLOR 104
LOCATE 19, 26: PRINT "W           E"
COLOR 105
LOCATE 24, 26: PRINT "SW    S    SE";
RETURN
13 CLOSE
GET (2, 2)-(180, 100), b
DEF SEG = VARSEG(b(1))
BLOAD "cursr.pic", VARPTR(b(1))
DEF SEG
PUT (189, 4), b, PSET
RETURN
6 'Create animation
GET (185, 5)-(203, 22), i
GET (185, 24)-(203, 42), d: GET (185, 44)-(203, 62), e
GET (185, 64)-(203, 82), f: GET (185, 84)-(203, 102), g
PUT (184, 3), h, PSET
RETURN
' ------------Get input & move cursor-------------
183 DEF SEG = 0: POKE 1047, 32
IF q$ = "sub3" AND sb = 0 THEN sb = 1: GOSUB 94
IF q$ = "east" AND ea = 0 THEN ea = 1: GOSUB 94 ELSE IF q$ = "terc2" AND ob(137) = 0 OR q$ = "base5" AND ob(150) = 0 THEN GOSUB 142
15 PUT (j, k), a, XOR: IF q$ = "dream23" AND zj < .1 OR q$ = "cty10" AND zj < .1 THEN GOSUB 64
IF j <= 184 AND k <= 104 THEN ga = 12: GOSUB 28 ELSE ga = 11: GOSUB 28
16 a$ = INKEY$
IF q$ <> "dream23" OR zj > .1 THEN IF a$ = "" AND jo$ <> "n" THEN GOSUB 1400
qf = TIMER - tim: qf = INT(qf * 10) / 10
IF qf <> pf THEN IF s$ = "" THEN a$ = "yt" ELSE a$ = a$ + "t"
IF x4 = 0 THEN IF a$ = "" THEN 16
IF x4 = 0 THEN PUT (j, k), a, XOR ELSE GOSUB 320
IF MID$((a$), 2, 1) = "t" THEN a$ = LEFT$(a$, 1): GOSUB 72
IF bc$ = "l" OR bc$ = "L" THEN bc$ = "": GOTO 2
IF i = 1 THEN IF df$(i) = "button" THEN q$ = "button": GOTO 127
29 IF i > 1 AND i < 32 THEN IF df$(i) = "return" THEN a$ = INKEY$: IF a$ = "" THEN 29 ELSE GOTO 138
IF wa <> 0 THEN 76
IF LEFT$(a$, 1) = "y" THEN 15
IF a$ = "s" OR a$ = "s" THEN IF SO$ = "" THEN SO$ = "y" ELSE SO$ = ""
IF a$ = "8" THEN k = k - ig
IF a$ = "5" THEN ig = ig + 8: IF ig > 19 THEN ig = 4
IF a$ = "2" THEN k = k + ig
IF a$ = "6" THEN j = j + ig
IF a$ = "4" THEN j = j - ig
IF a$ = "7" THEN j = j - ig: k = k - ig
IF a$ = "1" THEN j = j - ig: k = k + ig
IF a$ = "3" THEN j = j + ig: k = k + ig
IF a$ = "9" THEN j = j + ig: k = k - ig
IF a$ = " " THEN GOSUB 17
ggo = 1
IF a$ = "j" THEN GOSUB 18 ELSE IF a$ = "m" THEN GOSUB 319
IF a$ = CHR$(13) OR PEN(3) = 0 AND x4 = 1 AND j + k <> fd THEN fd = j + k: GOSUB 20
IF j < 6 THEN j = 6 ELSE IF j > 310 THEN j = 310
IF k < 6 THEN k = 6 ELSE IF k > 190 THEN k = 190
GOTO 15
17 lj = lj + 20: IF lj > 100 THEN lj = 10
fk = k: k = lj: GOSUB 25
k = fk
RETURN
18 IF jo$ = "" THEN jo$ = "n": SOUND 50, 1 ELSE jo$ = "": x4 = 0: PEN OFF: SOUND 800, 1
GOTO 112
319 IF x4 = 0 THEN x4 = 1: jo$ = "n": SOUND 1000, 1 ELSE x4 = 0: PEN OFF: SOUND 50, 1
GOTO 112
20 '----------figures screen segment clicked on------------
k = INT(k / 4) * 4 + 2: j = INT(j / 4) * 4 + 2
IF j = 6 AND k > 104 AND k < 144 THEN GOTO 19
IF k <= 102 AND j <= 182 THEN 30
IF k >= 106 AND k <= 126 AND j < 190 THEN zx = 2: GOTO 21
IF k >= 130 AND k <= 142 AND j < 190 THEN zx = 1: GOTO 21
IF j >= 186 AND j <= 210 AND k <= 104 THEN 25
IF j >= 242 AND j <= 262 AND k >= 142 AND k <= 162 THEN 23
ja = k \ 8 + 1: ka = j \ 8 + 1
' ----------Looks for directional arrow clicked on----------
bh = 1
IF ja = 15 AND ka = 26 OR ja = 15 AND ka = 27 THEN IF di(7) <> 0 THEN wa = 7: RETURN
IF ja = 15 AND ka = 32 OR ja = 15 AND ka = 32 THEN IF di(8) <> 0 THEN wa = 8: RETURN
IF ja = 15 AND ka = 37 OR ja = 15 AND ka = 38 THEN IF di(9) <> 0 THEN wa = 9: RETURN
IF ja = 19 AND ka = 26 OR ja = 19 AND ka = 26 THEN IF di(4) <> 0 THEN wa = 4: RETURN
IF ja = 19 AND ka = 38 OR ja = 19 AND ka = 38 THEN IF di(6) <> 0 THEN wa = 6: RETURN
IF ja = 24 AND ka = 26 OR ja = 24 AND ka = 27 THEN IF di(1) <> 0 THEN wa = 1: RETURN
IF ja = 24 AND ka = 32 OR ja = 24 AND ka = 32 THEN IF di(2) <> 0 THEN wa = 2: RETURN
IF ja = 24 AND ka = 37 OR ja = 24 AND ka = 38 THEN IF di(3) <> 0 THEN wa = 3: RETURN
IF SO$ = "y" THEN SOUND 1600, 1 ELSE RETURN
SOUND 1000, .5
SOUND 500, .2
RETURN
19 'Box switch
FOR d = 1 TO 4
SWAP iv$(d), iv$(d + 11): fj = iv(d): iv(d) = iv(d + 11): iv(d + 11) = fj
NEXT d
rg = 5
rg = i: FOR i = 1 TO 4: rf$(i) = df$(i): rt(i) = st(i): NEXT i
IF bx > 0 THEN 176 ELSE bx = 1
GET (6, 109)-(122, 126), j
GOSUB 11
FOR i = 1 TO 4
st(i) = iv(i): iv(i) = 0
df$(i) = iv$(i): IF df$(i) <> "" AND st(i) <> 0 THEN GOSUB 125
NEXT i
GET (6, 109)-(122, 126), k
62 i = rg: rg = 0: FOR i = 1 TO 4: df$(i) = rf$(i): st(i) = rt(i): NEXT i
BEEP: RETURN
176 lgk = lgk + 1: IF lgk > 2 THEN lgk = 1
IF lgk = 1 THEN PUT (6, 109), j, PSET ELSE PUT (6, 109), k, PSET
GOTO 62
23 'Guy is clicked on
IF ca$ = "l" THEN i = 31: mess$(i) = "You are     wearing a   light brown jacket and  darker brownpants."
IF ca$ = "g" THEN i = 31: mess$(i) = "You've      already got everything  you're      carrying!"
IF ca$ = "p" THEN i = 31: mess$(i) = "You can moveyourself    just fine   with the    compass."
IF ca$ = "u" AND ca = 6 THEN i = 32: mess$(i) = "S-Save      L-Load      R-Restart   H-Hint      Q-Quit      X-Return"
IF i <> 31 AND i <> 32 THEN RETURN
LINE (216, 8)-(312, 100), 0, BF
GOSUB 60
IF i <> 32 THEN RETURN
GOSUB 78
24 a$ = INKEY$: IF a$ = "" THEN 24
IF a$ = "Q" OR a$ = "q" THEN SYSTEM ELSE IF a$ = "H" OR a$ = "h" THEN hint: SYSTEM
IF a$ = "r" OR a$ = "R" THEN RUN
IF a$ = "x" OR a$ = "X" THEN RETURN
IF a$ <> "S" AND a$ <> "s" AND a$ <> "l" AND a$ <> "L" THEN 24
LOCATE 11, 28: IF a$ = "s" THEN PRINT "Save #1-4?" ELSE PRINT "Load #1-4?"
bc$ = a$
26 a$ = INKEY$: IF a$ = "" THEN 26
IF a$ = "1" THEN sn = 1 ELSE IF a$ = "2" THEN sn = 2 ELSE IF a$ = "3" THEN sn = 3 ELSE IF a$ = "4" THEN sn = 4 ELSE RETURN
IF bc$ = "S" OR bc$ = "s" THEN GOTO 75
IF bc$ = "L" OR bc$ = "l" THEN GOTO 77
RETURN
21 '----------Looks for inventory box clicked on----------
fca = ca
IF j >= 6 AND j <= 34 THEN IF zx = 2 THEN ca = 1 ELSE ca = 7
IF j >= 38 AND j <= 62 THEN IF zx = 2 THEN ca = 2 ELSE ca = 8
IF j >= 66 AND j <= 94 THEN IF zx = 2 THEN ca = 3 ELSE ca = 9
IF j >= 98 AND j <= 122 THEN IF zx = 2 THEN ca = 4 ELSE ca = 10
IF j >= 126 AND j <= 154 THEN IF zx = 2 THEN ca = 5 ELSE ca = 11
IF j >= 158 AND j <= 182 THEN IF zx = 2 THEN ca = 6 ELSE ca = 12
IF ca$ = "l" THEN GOSUB 145
GOSUB 27
IF iv(fca) = 76 AND iv(ca) = 86 THEN iv(fca) = 0: ob(112) = 1: iv(ca) = 112: GOSUB 11: PLAY "mb>>>>c60e60g60<<<<": RETURN
IF SO$ = "" THEN RETURN
FOR i = 4000 TO 100 STEP -350
SOUND i, .1
SOUND 6000 - i, .07
NEXT i
RETURN
25 '----------Looks for cursor icons clicked on----------
IF k >= 6 AND k <= 22 THEN ca$ = "l": GET (188, 11)-(208, 18), c: LINE (158, 140)-(178, 140), 0
IF k >= 26 AND k <= 42 THEN ca$ = "g": GET (188, 31)-(208, 38), c: LINE (158, 140)-(178, 140), 0
IF k >= 46 AND k <= 62 THEN ca$ = "o": GET (188, 50)-(208, 58), c: LINE (158, 140)-(178, 140), 0
IF k >= 66 AND k <= 82 THEN ca$ = "p": GET (188, 71)-(208, 78), c: LINE (158, 140)-(178, 140), 0
IF k >= 86 AND k <= 102 THEN ca$ = "u": GET (189, 91)-(209, 98), c: LINE (158, 140)-(178, 140), 0
PUT (158, 132), c, PSET
IF SO$ <> "y" THEN RETURN
FOR i = 15000 TO 5000 STEP -200
SOUND i, .04: NEXT i
RETURN
27 IF SO$ = "y" THEN SO$ = "g": lj = 70: IF ca$ <> "l" THEN GOSUB 17
IF SO$ = "g" THEN SO$ = "y"
IF ca = 1 THEN LINE (5, 108)-(33, 126), 53, B ELSE IF fca = 1 THEN LINE (5, 108)-(33, 126), 21, B
IF ca = 2 THEN LINE (35, 108)-(63, 126), 53, B ELSE IF fca = 2 THEN LINE (35, 108)-(63, 126), 21, B
IF ca = 3 THEN LINE (65, 108)-(93, 126), 53, B ELSE IF fca = 3 THEN LINE (65, 108)-(93, 126), 21, B
IF ca = 4 THEN LINE (95, 108)-(123, 126), 53, B ELSE IF fca = 4 THEN LINE (95, 108)-(123, 126), 21, B
IF ca = 5 THEN LINE (125, 108)-(153, 126), 53, B ELSE IF fca = 5 THEN LINE (125, 108)-(153, 126), 21, B
IF ca = 6 THEN LINE (155, 108)-(183, 126), 53, B ELSE IF fca = 6 THEN LINE (155, 108)-(183, 126), 21, B
IF ca = 7 THEN LINE (5, 127)-(33, 145), 55, B ELSE IF fca = 7 THEN LINE (5, 127)-(33, 145), 20, B
IF ca = 8 THEN LINE (35, 127)-(63, 145), 55, B ELSE IF fca = 8 THEN LINE (35, 127)-(63, 145), 20, B
IF ca = 9 THEN LINE (65, 127)-(93, 145), 55, B ELSE IF fca = 9 THEN LINE (65, 127)-(93, 145), 20, B
IF ca = 10 THEN LINE (95, 127)-(123, 145), 55, B ELSE IF fca = 10 THEN LINE (95, 127)-(123, 145), 20, B
IF ca = 11 THEN LINE (125, 127)-(153, 145), 55, B ELSE IF fca = 11 THEN LINE (125, 127)-(153, 145), 20, B
28 IF ga = 12 THEN LINE (155, 127)-(183, 145), 155, B ELSE IF ga = 11 THEN LINE (155, 127)-(183, 145), 20, B
RETURN
'------------Specials---------------
30 LINE (216, 8)-(312, 100), 0, BF
sp$ = MID$(vh$((k - 4) \ 4 + 1), (j - 4) \ 4 + 1, 1)
IF sp$ <> " " THEN GOTO 50
31 sam = 2: FOR i = 1 TO 80
IF k - 4 = su(i) AND j - 4 = si(i) THEN 35
37 IF si(i) = 0 THEN i = 80
 NEXT i: GOSUB 52: RETURN
35 AQ = i: i = sm(i)
36 IF df$(i) = "j" THEN IF ob(31) <> 1 THEN 45
IF ca$ = LEFT$(ky$(i), 1) OR ca$ = RIGHT$(ky$(i), 1) THEN 38
i = AQ: IF sam = 2 THEN GOTO 37 ELSE GOTO 31
38 IF df$(i) = "i02invena" THEN IF ob(23) = 1 AND ob(24) = 1 AND iv(ca) = 36 THEN 41
IF ky$(i) = "u" THEN IF iv(ca) = 140 AND bs(i) = 143 THEN 41 ELSE IF iv(ca) = 51 AND bs(i) = 52 THEN 41
IF ky$(i) = "u" THEN IF iv(ca) = bs(i) OR bs(i) = 4 AND iv(ca) = 8 OR bs(i) = 10 AND iv(ca) = 8 THEN 41 ELSE 45
41 IF bs(i) = 61 AND ob(83) <> 1 THEN 45
IF ob(bs(i)) = 1 OR bs(i) = 0 THEN 39
45 i = AQ: IF sam = 2 THEN GOTO 37 ELSE GOTO 31
39 IF ob(CS(i)) = 0 OR CS(i) = 0 THEN 40
 i = AQ: IF sam = 2 THEN GOTO 37 ELSE GOTO 31
40 IF ob(st(i)) = 0 AND SO$ = "y" AND LEFT$(df$(i), 1) <> "i" THEN PLAY "mb>>>>c60e60g60<<<<"
ob(st(i)) = 1: IF st(i) = 79 THEN st(i) = 65
IF ob(79) = 1 THEN IF ob(65) = 1 THEN IF st(i) = 79 OR st(i) = 65 THEN st(i) = 79: df$(i) = "i02invenc": GOTO 43
GOTO 835
43 FOR d = 1 TO 12: IF iv(d) = 65 THEN iv(d) = 0: GOSUB 11
NEXT d
835 GOSUB 60
IF st(i) = 66 OR st(i) = 88 THEN IF ob(66) = 1 AND ob(88) = 1 THEN tran$(i) = "l"
IF tran$(i) = "l" THEN ob(bs(i)) = 2: iv(ca) = 0: GOSUB 11: tran$(i) = ""
IF LEFT$(df$(i), 1) = "i" THEN GOSUB 125: GOSUB 98: IF st(i) = 79 AND df$(i) <> "i02invenc" THEN iv(ca) = 65
IF st(i) = 3 THEN st(i) = 8: df$(i) = "i10invenw": ob(8) = 1: GOSUB 125
IF LEFT$(df$(i), 1) = "x" THEN GOSUB 56
IF MID$(df$(i), 2, 1) = "b" THEN GOSUB 57 ELSE IF df$(i) = "shot" THEN FOR i = 1 TO 4: qa(i) = -1: qb(i) = -1: NEXT i: GOSUB 137: df$(i) = "s": da$(2) = "6apar4": da$(3) = "8apar2"
IF LEFT$(df$(i), 1) = "s" OR LEFT$(RIGHT$(df$(i), 2), 1) = "s" THEN GOSUB 135
IF df$(i) = "music" THEN GOSUB 63
IF df$(i) = "die" THEN 108 ELSE IF LEFT$(df$(i), 3) = "com" THEN GOSUB 143
IF df$(i) = "s42" THEN GOSUB 113 ELSE IF df$(i) = "pid" THEN FOR i = 1 TO 3: qa(i) = 1: qb(i) = 1: NEXT i: da$(2) = "8base1"
IF df$(i) = "crash" THEN GOSUB 97
IF df$(i) = "crate" THEN GOSUB 115 ELSE IF df$(i) = "tab" THEN tim = TIMER - 3: rt = 5.2
IF df$(i) = "tercb" THEN tim = TIMER - 2: rt = -1 ELSE IF LEFT$(df$(i), 4) = "talk" THEN tim = TIMER - 2: rt = 5.3
IF df$(i) = "el" THEN di = i: GOSUB 123: i = di ELSE IF df$(i) = "sub" THEN GOSUB 124
IF df$(i) = "talk2" OR df$(i) = "pot" THEN GOSUB 142
IF tran$(i) = "" THEN RETURN
174 IF tran$(i) = "end" THEN a$ = INKEY$: IF a$ = "" THEN 174 ELSE 780
IF df$(i) = "1" THEN b = 1 ELSE IF df$(i) = "5" THEN b = 5 ELSE b = 6
da$(b) = tran$(i): GOSUB 74
845 'GOSUB 1051
850 RETURN
56 IF df$(i) = "x3" THEN PUT (fx(3) + 3, fy(3) + 3), e, PSET: tim = TIMER: DO: LOOP UNTIL TIMER - tim > .1: PUT (5, 5), b, PSET: but = 1
IF df$(i) = "x2" THEN PUT (fx(2) + 3, fy(2) + 3), d, PSET: tim = TIMER: DO: LOOP UNTIL TIMER - tim > .1: PUT (5, 5), b, PSET: but = 0
IF df$(i) = "x1" THEN PUT (fx(1) + 3, fy(1) + 3), i, PSET: tim = TIMER: DO: LOOP UNTIL TIMER - tim > .1: PUT (5, 5), b, PSET: IF but > 0 AND but < 3 THEN but = but + 1 ELSE but = 0
IF but = 3 THEN ob(1) = 1: PLAY "mb>>>>c60e60g60<<<<" ELSE ob(1) = 0
RETURN
57 SOUND 50 + RND * 1000, 2: IF df$(i) = "sb1" THEN but = 1
IF df$(i) = "sb2" THEN IF but = 1 THEN but = 2 ELSE df$(i) = "die"
IF df$(i) = "sb3" THEN IF but = 2 THEN but = 3 ELSE df$(i) = "die"
IF df$(i) = "bb" THEN df$(i) = "die"
IF df$(i) = "die" THEN mess$(i) = "Four millionvolts of    high ampage electricity course      through yourbody!": GOSUB 60
RETURN
50 ' --------Scans special map--------------
sam = 1
FOR d = 1 TO 35
IF sp$ = CHR$(d + 96) THEN i = d: GOTO 36
NEXT d
GOTO 31
52 '-------Prints generic message------------
IF ca$ = "l" THEN mess$(32) = "You do not  see anythingof interest there. "
IF ca$ = "g" THEN mess$(32) = "There is    nothing     there that  you can     possibly    get. "
IF ca$ = "o" THEN mess$(32) = "There is no pratical wayto open     that. "
IF ca$ = "p" THEN mess$(32) = "Pushing on  that will   not aid you in any way. "
IF ca$ = "u" THEN mess$(32) = "That object is of no    particular  use there. "
i = 32
60 LINE (216, 8)-(312, 100), 0, BF
COLOR 44
a$ = "a": 'GOSUB 51
LOCATE 2, 28: PRINT MID$(mess$(i), 1, 12)
LOCATE 3, 28: PRINT MID$(mess$(i), 13, 12)
COLOR 45
LOCATE 4, 28: PRINT MID$(mess$(i), 25, 12)
LOCATE 5, 28: PRINT MID$(mess$(i), 37, 12)
COLOR 46
LOCATE 6, 28: PRINT MID$(mess$(i), 49, 12)
LOCATE 7, 28: PRINT MID$(mess$(i), 61, 12)
COLOR 47
LOCATE 8, 28: PRINT MID$(mess$(i), 73, 12)
LOCATE 9, 28: PRINT MID$(mess$(i), 85, 12)
LOCATE 10, 28: PRINT MID$(mess$(i), 97, 12)
COLOR 48
LOCATE 11, 28: PRINT MID$(mess$(i), 109, 12)
LOCATE 12, 28: PRINT MID$(mess$(i), 121, 12)
164 IF MID$(mess$(i), 134, 1) <> "" THEN a$ = INKEY$: IF a$ = "" THEN 164 ELSE mess$(i) = MID$(mess$(i), 133, 134): GOTO 60
RETURN
55 '-----Print general description----------
a$ = "b": ' GOSUB 51
LINE (7, 152)-(180, 194), 0, BF
COLOR 143
LOCATE 20, 2: PRINT MID$(gen$, 1, 21)
LOCATE 21, 2: PRINT MID$(gen$, 22, 21)
COLOR 144
LOCATE 22, 2: PRINT MID$(gen$, 43, 21)
LOCATE 23, 2: PRINT MID$(gen$, 64, 21)
COLOR 145
LOCATE 24, 2: PRINT MID$(gen$, 85, 21);
RETURN
'---------------Picture animation------------
70 tim = TIMER
qf = (TIMER - tim) * 1
IF rt = 5.3 THEN rt = 2 ELSE IF rt = 5.2 THEN rt = 3
PUT (5, 5), b, PSET
72 IF qf > rt AND rt <> -1 THEN 70
IF da$(2) = "1dremdrk2" AND ob(16) = 1 THEN 73
IF q$ = "terc6" AND ob(134) = 1 THEN 79
IF qf = qa(1) OR qf = qb(1) THEN PUT (fx(1) + 3, fy(1) + 3), i, PSET
IF qf = qa(2) OR qf = qb(2) THEN PUT (fx(2) + 3, fy(2) + 3), d, PSET
IF qf = qa(3) OR qf = qb(3) THEN PUT (fx(3) + 3, fy(3) + 3), e, PSET
IF qf = qa(4) OR qf = qb(4) THEN PUT (fx(4) + 3, fy(4) + 3), f, PSET
IF qf = qa(5) OR qf = qb(5) THEN PUT (fx(5) + 3, fy(5) + 3), g, PSET: IF q$ = "housef2" OR q$ = "cty9" THEN GOSUB 90 ELSE IF q$ = "base3" THEN GOSUB 69
73 pf = qf
RETURN
79 PUT (fx(5) + 3, fy(5) + 3), g, PSET: pf = qf
IF qf = qa(1) OR qf = qb(1) THEN PUT (fx(1) + 3, fy(1) + 3), i, PSET
RETURN
74 '-----highlights compass directions-------
FOR i = 1 TO 6
COLOR 100
IF LEFT$(da$(i), 1) = "7" THEN LOCATE 15, 26: PRINT "NW": di(7) = i
IF LEFT$(da$(i), 1) = "8" THEN LOCATE 15, 32: PRINT "N": di(8) = i
IF LEFT$(da$(i), 1) = "9" THEN LOCATE 15, 37: PRINT "NE": di(9) = i
COLOR 101
IF LEFT$(da$(i), 1) = "4" THEN LOCATE 19, 26: PRINT "W": di(4) = i
IF LEFT$(da$(i), 1) = "6" THEN LOCATE 19, 38: PRINT "E": di(6) = i
IF LEFT$(da$(i), 1) = "1" THEN LOCATE 24, 26: PRINT "SW"; : di(1) = i
IF LEFT$(da$(i), 1) = "2" THEN LOCATE 24, 32: PRINT "S"; : di(2) = i
IF LEFT$(da$(i), 1) = "3" THEN LOCATE 24, 37: PRINT "SE"; : di(3) = i
NEXT i
RETURN
78 '------Mision complete percentage--------
wc = 0
FOR d = 1 TO 154: IF ob(d) <> 0 THEN wc = wc + 1
NEXT:  wc = wc / 154 * 1000: wc = INT(wc): wc = wc / 10
LOCATE 9, 29: PRINT "%"; wc: RETURN
' -----------Save and load game------------
75 lf = i
IF LEFT$(q$, 5) = "house" OR LEFT$(q$, 5) = "dream" OR LEFT$(q$, 5) = "dremd" THEN FOR i = 1 TO 15: SWAP iv$(i), tv$(i): fj = iv(i): iv(i) = tv(i): tv(i) = fj: NEXT i
OPEN "save" + CHR$(96 + sn) + ".dat" FOR OUTPUT AS #1
WRITE #1, iv(1), iv(2), iv(3), iv(4), iv(5), iv(6), iv(7), iv(8), iv(9), iv(10), iv(11), iv(12), iv(13), iv(14), iv(15)
WRITE #1, iv$(1), iv$(2), iv$(3), iv$(4), iv$(5), iv$(6), iv$(7), iv$(8), iv$(9), iv$(10), iv$(11), iv$(12), iv$(13), iv$(14), iv$(15)
WRITE #1, tv(1), tv(2), tv(3), tv(4), tv(5), tv(6), tv(7), tv(8), tv$(1), tv$(2), tv$(3), tv$(4), tv$(5), tv$(6), tv$(7), tv$(8)
WRITE #1, tv(9), tv(10), tv(11), tv(12), tv$(9), tv$(10), tv$(11), tv$(12), tv$(13), tv$(14), tv$(15), tv(13), tv(14), tv(15)
WRITE #1, q$, d1, d2, d3, el$, sx
FOR i = 1 TO 151 STEP 10
WRITE #1, ob(i), ob(i + 1), ob(i + 2), ob(i + 3), ob(i + 4), ob(i + 5), ob(i + 6), ob(i + 7), ob(i + 8), ob(i + 9)
NEXT i
GOSUB 201
CLOSE
SOUND 9554, 1
IF LEFT$(q$, 5) = "house" OR LEFT$(q$, 5) = "dream" OR LEFT$(q$, 5) = "dremd" THEN FOR i = 1 TO 15: SWAP iv$(i), tv$(i): fj = iv(i): iv(i) = tv(i): tv(i) = fj: NEXT
i = lf: RETURN
77 losa$ = "y": OPEN "save" + CHR$(96 + sn) + ".dat" FOR INPUT AS #1
INPUT #1, iv(1), iv(2), iv(3), iv(4), iv(5), iv(6), iv(7), iv(8), iv(9), iv(10), iv(11), iv(12), iv(13), iv(14), iv(15)
INPUT #1, iv$(1), iv$(2), iv$(3), iv$(4), iv$(5), iv$(6), iv$(7), iv$(8), iv$(9), iv$(10), iv$(11), iv$(12), iv$(13), iv$(14), iv$(15)
INPUT #1, tv(1), tv(2), tv(3), tv(4), tv(5), tv(6), tv(7), tv(8), tv$(1), tv$(2), tv$(3), tv$(4), tv$(5), tv$(6), tv$(7), tv$(8)
INPUT #1, tv(9), tv(10), tv(11), tv(12), tv$(9), tv$(10), tv$(11), tv$(12), tv$(13), tv$(14), tv$(15), tv(13), tv(14), tv(15)
INPUT #1, q$, d1, d2, d3, el$, sx
lf = i
FOR i = 1 TO 155
INPUT #1, ob(i)
NEXT i
CLOSE : bx = 0
IF LEFT$(q$, 5) = "house" OR LEFT$(q$, 5) = "dream" OR LEFT$(q$, 5) = "dremd" THEN FOR i = 1 TO 15: SWAP iv$(i), tv$(i): fj = iv(i): iv(i) = tv(i): tv(i) = fj: NEXT i
SOUND 6554, 1
FOR i = 1 TO 9: di(i) = 0
NEXT i
bh = 0
GOSUB 202: losa$ = "n": i = lf
RETURN
139 GOSUB 11
FOR i = 1 TO 11
st(i) = iv(i): iv(i) = 0
df$(i) = iv$(i): IF df$(i) <> "" AND st(i) <> 0 THEN GOSUB 125
NEXT i
losa$ = "n": i = lf
RETURN
' --------Character animations-----------
76 zl = wa: wa = 0
IF q$ = "dremdrk4" AND LEFT$(da$(di(zl)), 1) = "8" THEN IF ob(16) <> 1 THEN i = 16: GOSUB 60: wa = 0: GOTO 29
IF MID$(da$(di(zl)), 2, 8) = "trap" OR MID$(da$(di(zl)), 2, 8) = "spike" THEN 128
DEF SEG = VARSEG(b(1))
IF bh = 2 THEN 80
GOSUB 84
BLOAD "chracter.pic", VARPTR(b(1))
DEF SEG
GET (216, 106)-(314, 195), h
PUT (216, 106), b, PSET
GET (xc, yc)-(xd, yd), i
GET (xc2, yc2)-(xd2, yd2), d
GET (xc3, yc3)-(xd3, yd3), e
PUT (216, 106), h, PSET
d = 242: i = 146
LINE (242, 147)-(266, 167), 0, BF
IF bh = 0 THEN GOTO 80 ELSE GOTO 81
80 PUT (242, 147), i, PSET
RETURN
81 IF i < 115 OR i > 173 OR d < 205 OR d > 277 THEN 82
i = i + si: d = d + sd
PUT (d, i), i, PSET: GOSUB 83
IF SO$ = "y" THEN SOUND 150, .1: SOUND 32676, .1: SOUND 50, .1: SOUND 3276, .1: SOUND 50, .1
LINE (d, i)-(d + 20, i + 17), 0, BF: i = i + si: d = d + sd
PUT (d, i), d, PSET: GOSUB 83
LINE (d, i)-(d + 20, i + 17), 0, BF: i = i + si: d = d + sd
IF i < 115 OR i > 173 OR d < 205 OR d > 277 THEN 82
PUT (d, i), e, PSET: GOSUB 83
IF SO$ = "y" THEN SOUND 150, .1: SOUND 50, .2
LINE (d, i)-(d + 20, i + 17), 0, BF: i = i + si: d = d + sd
PUT (d, i), d, PSET: GOSUB 83
LINE (d, i)-(d + 20, i + 17), 0, BF
GOTO 81
RETURN
83 t = TIMER
85 IF TIMER - t < .2 THEN 85 ELSE RETURN
82 q$ = MID$(da$(di(zl)), 2, 8)
IF q$ = "blood" THEN GOTO 93 ELSE IF q$ = "shot" THEN 141 ELSE IF q$ = "droid" THEN i = 17: GOSUB 60: GOTO 108
IF q$ = "cty2" AND d1 = 0 OR q$ = "cty11" AND d3 = 0 OR q$ = "terc1" AND d2 = 0 THEN GOTO 138
IF q$ = "base1" AND ob(130) = 0 THEN GOSUB 780: GOTO 108
127 FOR i = 1 TO 9: di(i) = 0
NEXT i
GOTO 2
84 '-----------Character animation data---------
CLOSE
OPEN "charanim.dat" FOR INPUT AS #1
FOR i = 1 TO 8
INPUT #1, xc, yc, xd, yd
INPUT #1, xc2, yc2, xd2, yd2
INPUT #1, xc3, yc3, xd3, yd3
INPUT #1, si, sd, dg
IF dg = zl THEN CLOSE : RETURN
NEXT i
141 GOSUB 134: i = 32: mess$(i) = "Your last   feeling is  that of a   bullet      entering    your skull. (Hit a key)"
GOSUB 60: GOTO 108
'-------------Inventory pictures-----------
125 b$ = MID$(df$(i), 2, 1): lkj$ = MID$(df$(i), 3, 1)
IF b$ = "0" THEN bi = 0 ELSE IF b$ = "1" THEN bi = 1 ELSE IF b$ = "2" THEN bi = 2 ELSE bi = 3
IF lkj$ = "0" THEN ai = 0 ELSE IF lkj$ = "1" THEN ai = 1 ELSE ai = 2
d$ = MID$(df$(i), 4, 6)
IF losa$ <> "y" AND q$ <> "apar1" THEN PUT (5, 5), b, PSET
IF ob(54) <> 0 AND q$ = "ware1" THEN qa(1) = -1: qb(1) = -1
IF ob(105) <> 0 AND q$ = "cty8" THEN qa(5) = -1: qb(5) = -1
IF q$ = "terc6" AND ob(133) <> 0 THEN qb(1) = -1: qa(1) = -1 ELSE IF q$ = "apar1" AND ob(122) <> 0 THEN qa(5) = -1: qb(5) = -1
126 DEF SEG = VARSEG(b(1))
BLOAD d$ + ".pic", VARPTR(b(1))
DEF SEG
GET (220, 110)-(310, 190), h
PUT (220, 110), b, PSET
GET (221 + ai * 29, 111 + bi * 19)-(247 + ai * 29, 127 + bi * 19), c
PUT (220, 110), h, PSET
GET (5, 5)-(183, 103), b
FOR d = 1 TO 11
IF iv(6) = 0 THEN d = 6
IF iv(d) = 0 THEN iv(d) = st(i): iv$(d) = df$(i): IF d < 7 THEN PUT (6 + 30 * d - 30, 109), c, PSET: RETURN ELSE IF d > 6 THEN iv$(d) = df$(i): iv(d) = st(i): PUT (6 + 30 * (d - 6) - 30, 128), c, PSET: RETURN
NEXT d: rg = i: mess$(32) = "No free     boxes!": ob(st(i)) = 0: i = 32: GOSUB 60
i = rg: BEEP
RETURN
'---------------Sounds---------------
114 IF SO$ <> "y" THEN RETURN
FOR d = 1 TO 40
SOUND 200, .1: SOUND 32676, .5
NEXT d: RETURN
113 IF SO$ <> "y" THEN RETURN
FOR d = 1 TO 25 STEP 1
SOUND 400, .05
SOUND 32676, .5
NEXT d
RETURN
107 IF SO$ <> "y" THEN RETURN
FOR d = 100 TO 150 STEP 5
SOUND d - RND * 50, .2: SOUND 32676, .1
NEXT d
SOUND 50, 1
RETURN
63 IF SO$ = "y" THEN PLAY "mb<<<c10d10c10d10c<b5a5p10a5>>>>e10f10e5g10p10g10"
RETURN
97 IF SO$ <> "y" THEN RETURN
FOR i = 300 TO 50 STEP -30
SOUND i, .1: SOUND 50, .1: SOUND 100, .1
NEXT i
RETURN
69 IF SO$ <> "y" THEN RETURN
bs3 = bs3 + 1: IF bs3 > 6 THEN RETURN
FOR i = 200 TO 50 STEP -12
SOUND i, .2: SOUND 13676 - 10, .05: SOUND 100, .1
NEXT i
RETURN
65 IF SO$ <> "y" THEN SOUND 32676, 7: SOUND 100, .1: RETURN
FOR i = 50 TO 500 STEP 2
SOUND i, .1
SOUND i * 2 - i + 25, .1: SOUND 32676, .1
NEXT i
FOR i = 1 TO 100
SOUND 500, .1: SOUND 525, .1: SOUND 32676, .1
NEXT i
FOR i = 500 TO 50 STEP -2
SOUND i, .1
SOUND i * 2 - i + 25, .1: SOUND 32676, .1
NEXT i
RETURN
64 IF SO$ <> "y" THEN RETURN
g = 1: FOR i = 1 TO 450
g = g + 1: IF zj < g - 30 THEN zj = zj + .01: RETURN
SOUND RND * 900 + g + 50, .05
SOUND 32676, .1 + zj
NEXT i
GOTO 64
90 IF SO$ <> "y" THEN RETURN
FOR di = 1 TO 200 STEP 20
SOUND RND * 300 + 50, .1
NEXT di
SOUND 100, .2: SOUND 32676, 2: SOUND 100, .2
RETURN
92 FOR i = 50 TO 230 STEP 10
SOUND i, .2: SOUND 50, .3
NEXT i
FOR i = 230 TO 50 STEP -14
SOUND i, .2: SOUND 32676, .2: SOUND 80, .3
NEXT i
FOR i = 100 TO 400 STEP 20
SOUND i, .1: SOUND 50 + i / 2, .05
NEXT i
RETURN
94 IF SO$ <> "y" THEN RETURN ELSE PLAY "mba40b40a7>c8e7<b7>d6p11e42c42e42c5<b5a4"
RETURN
98 IF SO$ <> "y" THEN RETURN
SOUND 300, 1: SOUND 100, .5: SOUND 450, 1
SOUND 500, .1: SOUND 700, .5: RETURN
99 IF SO$ <> "y" THEN SOUND 32676, 3: PLAY "p2": RETURN
IF e$ = "d" THEN 101
FOR i = 500 TO 700
SOUND i, .05
SOUND 32676, .1
NEXT i: GOTO 102
101 FOR i = 700 TO 500 STEP -1
SOUND i, .05
SOUND 32676, .1
NEXT i
102 SOUND 1000, .5
FOR i = 1000 TO 600 STEP -5
IF RND * 1 < .1 THEN SOUND 1000, .05
SOUND i, .05: SOUND 100 + RND * 100, .05
NEXT i
FOR i = 600 TO 500 STEP -1
SOUND i, .05: SOUND 100 + RND * 100, .05
NEXT i
RETURN
137 IF SO$ <> "y" THEN RETURN
FOR d = 200 TO 50 STEP -2
SOUND d, .05: SOUND 75, .05
NEXT d
RETURN
134 IF SO$ <> "y" THEN RETURN
FOR d = 600 TO 150 STEP -35
SOUND d, .1: SOUND 50 + RND * 100, .1
NEXT d
RETURN
'------------Talking(Intercom)
143 DEF SEG = VARSEG(h(1))
BLOAD "commy.pic", VARPTR(h(1))
PUT (6, 30), h, PSET
LINE (5, 29)-(85, 79), 114, B
GET (5, 107)-(183, 145), h: GET (242, 147)-(262, 167), c
LINE (5, 109)-(314, 195), 0, BF
IF RIGHT$(df$(i), 1) = "2" THEN 147
LOCATE 15, 2: PRINT "You shoudn't be following me! Did you"
LOCATE 16, 2: PRINT "see what happened to the others? Here"
LOCATE 17, 2: PRINT "is some advice. Get out of town! If "
LOCATE 18, 2: PRINT "learn anything more you may have to "
LOCATE 19, 2: PRINT "dealt with. <crackle>": GOTO 144
147 COLOR 46: LOCATE 15, 2: PRINT "`I know who you are Rick!'": COLOR 48
LOCATE 16, 2: PRINT "`Who?' echoes from the intercom.": COLOR 46
LOCATE 17, 2: PRINT "`You're the killer Oslo.'": COLOR 48
LOCATE 18, 2: PRINT "`Well then. Meet me at the Skyview"
LOCATE 19, 2: PRINT "`Appartment. Soon...'"
144 a$ = INKEY$: IF RND < .01 THEN PALETTE 48, RND * 20 + 35: PALETTE 47, RND * 20 + 35
IF a$ = "" THEN 144 ELSE PALETTE 48, 398337: PALETTE 47, 399361
LINE (5, 109)-(314, 195), 0, BF: GOSUB 10: GOSUB 12: GOSUB 74: GOSUB 55
PUT (5, 107), h, PSET: PUT (5, 5), b, PSET: PUT (242, 147), c
RETURN
142 '-------Talking with human-------
GET (5, 107)-(183, 145), h: GET (242, 147)-(262, 167), c
LINE (5, 109)-(314, 195), 0, BF
GOSUB 150
148 a$ = INKEY$: IF q$ = "apar3" THEN rt = 5.3 ELSE IF q$ = "base5" THEN rt = 5.2 ELSE IF q$ = "cty17" THEN rt = 6.2 ELSE IF q$ = "terc2" THEN rt = 3.2
qf = TIMER - tim: qf = INT(qf * 10) / 10
IF qf <> pf THEN GOSUB 72
IF a$ = "" THEN 148 ELSE IF i = 0 THEN LINE (5, 109)-(314, 195), 0, BF: i = 1: GOTO 152
LINE (5, 109)-(314, 195), 0, BF: GOSUB 10: GOSUB 12: GOSUB 74: GOSUB 55
PUT (5, 107), h, PSET: PUT (242, 147), c
IF q$ = "cty17" THEN rt = 3.2 ELSE IF q$ = "terc2" THEN rt = 2: ob(137) = 1
IF q$ = "base5" THEN ob(150) = 1
RETURN
150 CLOSE : OPEN "Dilog.dat" FOR INPUT AS #1
FOR i = 1 TO 80
INPUT #1, a$
IF MID$(a$, 2, 8) = q$ THEN 151
NEXT i
151 FOR i = 1 TO 20
152 IF i = 10 THEN i = 0: GOTO 148
INPUT #1, dil$(i)
IF LEFT$(dil$(i), 1) = "|" THEN CLOSE : RETURN
IF LEFT$(dil$(i), 1) = "<" THEN COLOR 33 ELSE COLOR 47
LOCATE 14 + i, 2
PRINT MID$(dil$(i), 2, 38);
NEXT i
CLOSE : RETURN
'------------dead---------
108 COLOR 48: LOCATE 13, 28: PRINT "Hit a key": a$ = INKEY$: IF a$ = "" THEN 108
103 i = 32: mess$(i) = "You're Dead!L-Load      R-Restart   Q-Quit "
LINE (216, 8)-(312, 100), 0, BF
GOSUB 60
FOR i = 1 TO 150: ob(i) = 0: NEXT i: FOR i = 1 TO 12: iv(i) = 0: NEXT i
i = 0
104 a$ = INKEY$: IF a$ = "" THEN 104
IF a$ = "Q" OR a$ = "q" THEN SYSTEM
IF a$ = "r" OR a$ = "R" THEN RUN
IF a$ <> "l" AND a$ <> "L" THEN 104
LOCATE 11, 28: PRINT "Load #1-4?"
105 a$ = INKEY$: IF a$ = "" THEN 105
CLS : GOSUB 12: GOSUB 10: GOSUB 11: GOSUB 13
IF a$ = "1" THEN sn = 1 ELSE IF a$ = "2" THEN sn = 2 ELSE IF a$ = "3" THEN sn = 3 ELSE IF a$ = "4" THEN sn = 4 ELSE RETURN
GOSUB 77: GOTO 2
'---------blood--------
93 i = 1: mess$(i) = "When you    step furtherinto the    forest you  hear a      growling    sound and   quick       movement... (Hit a key)"
GOSUB 60
67 a$ = INKEY$: IF a$ = "" THEN 67
GOSUB 92: i = 0
tr = TIMER
FOR t = 15 TO 320 STEP 1.6
i = i + 1
gt = t - (RND * t)
gi = i - (RND * i)
cl = 53 + RND * 3
CIRCLE (gt, gi), 2 + RND * 22, cl, , , RND * 3
PAINT (gt, gi), cl
NEXT t
95 IF TIMER - tr < 1.3 THEN SOUND 32676, 9: PLAY "p9"
GOTO 103
100 '-----------------Falling---------------
q$ = "dremdrk": GOSUB 8
GET (5, 5)-(96, 30), b
GET (97, 5)-(183, 27), h
PUT (5, 72 + 5), b, PSET
PUT (97, 75 + 5), h, PSET
FOR i = 1 TO 200
PUT (5, RND * 60 + 5), b, PSET
PUT (97, RND * 63 + 5), h, PSET
SOUND 32676, .1
NEXT i
GOSUB 8
FOR i = 1 TO 50
PUT (2 + RND * 5, 2 + RND * 5), b, PSET
SOUND RND * 100 + 50, .2
NEXT i
PUT (5, 5), b, PSET
FOR i = 1 TO 4
LINE (5 - i, 5 - i)-(183 + i, 103 + i), 31 + i, B
NEXT i
GOSUB 9
RETURN
'------------Elevator------------
123 LINE (44, 9)-(94, 5), 25: LINE (44, 96)-(94, 85), 25
PAINT (70, 52), 25
LINE (70, 7)-(70, 90), 23
GOSUB 99
PUT (5, 5), b, PSET
131 IF e$ = "" THEN qf = -.1
GOSUB 72
IF e$ = "" THEN e$ = "d": da$(1) = "7apar5" ELSE e$ = "": da$(1) = "7apar1"
RETURN '-Subway-'
124 PAINT (95, 50), 26
GOSUB 65: i = 1
IF sx = 0 THEN mess$(i) = "After a short ride the car stops and you exit back out into the city.": sx = 1: da$(1) = "8sub1": RETURN
IF sx = 1 THEN mess$(i) = "After a short ride you exit into the station.": sx = 0: da$(1) = "8cty6"
RETURN
'----------Special Cells-------------
135 df$ = RIGHT$(df$(i), 1)
136 IF df$ = "5" THEN df = 5 ELSE IF df$ = "4" THEN df = 4 ELSE IF df$ = "3" THEN df = 3 ELSE IF df$ = "2" THEN df = 2 ELSE IF df$ = "1" THEN df = 1
qa(df) = 0: GOSUB 70
IF MID$(df$(i), 2, 1) <> df$ THEN df$ = MID$(df$(i), 2, 1): GOTO 136
IF df$(i) = "s12" THEN df$(i) = "s35": GOTO 135
IF df$(i) = "s5" AND q$ = "base2" THEN qa(4) = -1: qb(4) = -1
GOSUB 5
RETURN
'-----------Dremdrk die----------
128 i = 32
IF MID$(da$(di(zl)), 2, 8) = "trap" THEN mess$(i) = "A pit opens under you   sending you hurtling to the spiked  bottom.": GOSUB 60 ELSE 129
PUT (fx(3) + 3, fy(3) + 3), e, PSET
GOSUB 107
tim = TIMER
130 IF TIMER - tim < 2 THEN 130
GOTO 103
129 mess$(i) = "A spike     comes       crashing    down on yourhead!": GOSUB 60
tim = TIMER: DO
LOOP UNTIL TIMER - tim > .2
PUT (fx(4) + 3, fy(4) + 3), f, PSET
tim = TIMER: DO
LOOP UNTIL TIMER - tim > .2
PUT (fx(5) + 3, fy(5) + 3), g, PSET
PUT (fx(5) + 3, fy(5) + 3), g, PSET
GOSUB 107
tim = TIMER: DO
LOOP UNTIL TIMER - tim > 3
GOTO 103
115 GOSUB 114
PUT (fx(4) + 3, fy(4) + 3), f, PSET
tim = TIMER
DO: LOOP UNTIL TIMER - tim > .3
PUT (fx(5) + 3, fy(5) + 3), g, PSET
qa(5) = 0
RETURN
'------------Joystick--------
1400 IF jo$ = "n" THEN RETURN
hh = STICK(0): vv = STICK(1)
IF hh > 40 AND hh < 120 AND vv < 120 AND vv > 40 OR hh = 0 AND vv = 0 THEN RETURN
IF hh < 40 THEN a$ = "4"
IF hh > 120 AND hh < 190 THEN a$ = "6"
IF vv < 40 THEN a$ = "8"
IF vv > 120 AND vv < 190 THEN a$ = "2"
IF hh > 120 AND vv < 40 THEN a$ = "9"
IF hh < 40 AND vv < 40 THEN a$ = "7"
IF vv > 120 AND vv < 190 AND hh > 120 AND hh < 190 THEN a$ = "3"
IF vv > 120 AND hh < 40 THEN a$ = "1"
RETURN
121 IF TIMER - lk < .3 THEN RETURN
PUT (j, k), a
GOSUB 20: lk = TIMER
PUT (j, k), a: RETURN
122 IF TIMER - lk < .3 THEN RETURN
ig = ig + 8: IF ig = 20 THEN ig = 4
lk = TIMER
RETURN
120 IF TIMER - lk < .2 THEN RETURN
GOSUB 17
lk = TIMER
RETURN
112 CLOSE
OPEN "Joy.dat" FOR OUTPUT AS #1
WRITE #1, jo$, x4, y4, x5, y5, x6, y6
CLOSE
IF ggo = 1 THEN RETURN
GOTO 1
'-----------Looking at items----------
145 OPEN "ob1.dat" FOR INPUT AS #1
FOR i = 1 TO 61
INPUT #1, d, mess$(32)
IF d = iv(ca) THEN 146
NEXT i
146 i = 32: GOSUB 60
CLOSE
RETURN
'-----------Dream entrance---------
138 IF q$ = "cty11" THEN GOSUB 780
IF q$ = "cty2" OR q$ = "terc1" OR q$ = "cty11" THEN popl = 1 ELSE 149
mess$(31) = "You are     overcome by sleep       disturbinglyeasily and  the sur-    roundings   you awake inare even    more dis-   turbing."
FOR i = 1 TO 5: tv$(i) = "": tv(i) = 0: NEXT i: FOR i = 7 TO 12: tv$(i) = "": tv(i) = 0: NEXT i
149 IF q$ = "housef6" OR q$ = "dream26" OR q$ = "dremdrk3" THEN mess$(31) = "You awake   exactly     where you   drifted off.Was it      really just a dream?"
IF q$ = "cty2" THEN q$ = "housef": d1 = 1 ELSE IF q$ = "terc1" THEN q$ = "dream21": d2 = 1
IF q$ = "housef6" THEN q$ = "cty2" ELSE IF q$ = "dream26" THEN q$ = "terc1"
FOR i = 1 TO 15: SWAP iv$(i), tv$(i):  fj = iv(i): iv(i) = tv(i): tv(i) = fj: NEXT i
FOR i = 18 TO 30
LINE (5, 5)-(183, 103), i, BF
lk = TIMER: DO: LOOP UNTIL TIMER - lk > .05
NEXT i
FOR i = 30 TO 24 STEP -1
LINE (5, 5)-(183, 103), i, BF
lk = TIMER: DO: LOOP UNTIL TIMER - lk > .05
NEXT i
i = 31
GOSUB 60
IF q$ = "cty11" THEN d3 = 1: GOSUB 100 ELSE IF q$ = "dremdrk3" THEN q$ = "cty11"
losa$ = "y"
GOSUB 139: losa$ = "n"
GOTO 127
END
'-----------Talking head----------
780 f$ = "head2": sn = 0: IF q$ = "base1" THEN 783
IF ob(118) = 0 THEN i = 32: mess$(32) = "A young man emerges fromthe bushes, sending a   couple of   shots into  your chest. If only you had some    protection!": GOSUB 60: GOSUB 134: GOTO 108
IF ob(113) = 0 THEN i = 32: mess$(32) = "A young man emerges fromthe bushes, shooting youtwice in thechest. If   only you    recognized  him in timeto use the  shield!": GOSUB 60: GOSUB 134: GOTO 108
783 CLOSE : OPEN "Dilog.dat" FOR INPUT AS #1
FOR i = 1 TO 80
INPUT #1, a$
IF MID$(a$, 2, 8) = q$ THEN 154
NEXT i
154 FOR i = 1 TO 20
IF i = 10 THEN i = 0: GOTO 148
INPUT #1, mess$(i)
IF LEFT$(mess$(i), 1) = "|" THEN mess$(i) = ":": CLOSE : GOTO 155
LOCATE 14 + i, 2
PRINT MID$(dil$(i), 2, 38);
NEXT i
155 SCREEN 12
GET (201, 201)-(291, 301), h
DEF SEG = VARSEG(h(1))
BLOAD f$ + ".pic", VARPTR(h(1))
DEF SEG
PUT (1, 1), h, PSET
GET (1, 1)-(30, 48), d
GET (31, 1)-(60, 48), e
GET (61, 1)-(90, 48), f
GET (1, 49)-(30, 96), g
GET (31, 49)-(60, 96), c
GET (61, 49)-(90, 96), i
LINE (1, 1)-(100, 100), 0, BF
f$ = "head"
GET (201, 201)-(291, 301), h
DEF SEG = VARSEG(h(1))
781 BLOAD f$ + ".pic", VARPTR(h(1))
DEF SEG
882 PUT (251, 201), h, PSET
GET (251, 201)-(341, 302), h
OPEN "16colo.pal" FOR INPUT AS #1
FOR i = 1 TO 15 STEP 1
INPUT #1, p
IF p = 0 AND i > 10 THEN i = 255
PALETTE i, p
NEXT i
FOR i = 201 TO 15 STEP -2
PUT (251, i), h, PSET
NEXT i
vb = 1
LINE (100, 120)-(500, 250), 0, BF
89 a$ = INKEY$
v = INT(RND * 5): IF LEFT$(mess$(vb), 1) = "<" THEN 190 ELSE IF q$ = "base3" THEN IF RND < .5 THEN v = 5 ELSE v = 3
IF v = 0 THEN PUT (287, 48), d, PSET
IF v = 1 THEN PUT (287, 48), e, PSET
IF v = 2 THEN PUT (287, 48), f, PSET
IF v = 3 THEN PUT (287, 48), g, PSET
IF v = 4 THEN PUT (287, 48), c, PSET
IF v = 5 THEN PUT (287, 48), i, PSET
190 sf = sf + 1
IF MID$(mess$(vb), sf + sn * 60, 1) = ":" OR a$ = "s" THEN mess$(vb) = "|": SOUND 32676, 10: SOUND 32676, 10: SCREEN 13: CLOSE : IF q$ = "base3" THEN 205 ELSE GOSUB 3: GOSUB 10: GOSUB 13: RETURN
IF MID$(mess$(vb), sf + sn * 60, 1) <> " " THEN SOUND 32676, 2: SOUND 32676, 1
LOCATE 10 + sn, sf + 10: PRINT MID$(mess$(vb), sf + sn * 61, 1)
IF MID$(mess$(vb), sf + sn * 60, 1) = "," OR MID$(mess$(vb), sf + sn * 60, 1) = "." THEN SOUND 32676, 5: SOUND 32676, 1
IF sf > 60 THEN sf = 0: IF sn = 0 THEN sn = 1 ELSE sn = 2
IF MID$(mess$(vb), sf + sn * 60, 1) = "ú" THEN sn = 0: vb = vb + 1: sf = 0: SOUND 32676, 8: SOUND 32676, 3: LINE (80, 120)-(600, 250), 0, BF
GOTO 89
'-----------Mouse Handler--------------
320 lj = j: lk = k
PEN ON
j = PEN(4): IF j < 6 THEN j = 6 ELSE IF j > 310 THEN j = 310
k = PEN(5): IF k < 6 THEN k = 6 ELSE IF k > 190 THEN k = 190
PUT (lj, lk), a, XOR
RETURN
201 '------------Save inventory---------
GET (5, 108)-(183, 145), h
DEF SEG = VARSEG(h(1))
BSAVE "save" + CHR$(96 + sn) + ".pic", VARPTR(h(1)), 7000
DEF SEG = 0
RETURN
202 DEF SEG = VARSEG(h(1))
BLOAD "save" + CHR$(96 + sn) + ".pic", VARPTR(h(1))
DEF SEG
PUT (5, 108), h, PSET
RETURN
205 IF ob(144) = 0 THEN LOCATE 1, 1: PRINT "YOU HAVE WON! YET SINCE YOU DID NOT FINDTHE ANTIDOTE TO THE PLAGUE, THE         REMAINING SYMPTOMS WILL KILL YOU WITHIN A DAY.": a$ = INKEY$: IF a$ = "" THEN GOTO 205 ELSE SYSTEM
ending

