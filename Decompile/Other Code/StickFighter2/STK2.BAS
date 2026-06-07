DECLARE SUB logo ()
DECLARE SUB tar ()
DEFINT C
COMMON SHARED gu, sip
COMMON SHARED f1, e1, lle1, lf1, lj1, llh1, le1, lh1, s4, s3, m4, m3
jk = 65: bl = 35: f = 800
g = 32000: pood = 2: blo = 3
DIM pl(256) AS LONG: DIM lp(256) AS LONG
DIM u(jk): DIM x(jk): DIM cx(20): DIM cy(20): DIM cc(20)
DIM y(jk): DIM d(3200): DIM spec(20)
DIM d$(12): DIM fp(12): DIM gc(6): DIM sofa(6)
DIM f(f): DIM e(f): DIM le(f): DIM lh(f): DIM lle(f): DIM llh(f)
DIM lf(f): DIM lj(f): DIM s(f): DIM s2(f): DIM m(f): DIM m2(f)
DIM c(1 TO g): DIM dx(f): DIM dy(f)
RANDOMIZE TIMER
OPEN "startup.dat" FOR INPUT AS #1: INPUT #1, name$, a$, sip: CLOSE
SCREEN 13
IF sip <> 0 THEN 813
tim = TIMER: LOCATE 1, 1: PRINT "SPEED TESTING"
FOR x = 1 TO 5
FOR i = 1 TO 28000
NEXT i
NEXT x
g = TIMER - tim
g = 1 / g: g = g * 100: g = INT(g): g = g / 100
sip = g
PRINT sip
813 IF name$ <> "" THEN 814
'logo
814 IF name$ = "" THEN INPUT "What is your fighting name?"; name$
ON ERROR GOTO 180
5 GOSUB 143
4 pg = pg + 1: ON ERROR GOTO 0
p = pg
jam = 1
IF p = 1 THEN gu = 1: pv = 1 ELSE IF p = 2 THEN gu = 6: pv = 1
IF p = 3 THEN gu = 9: pv = 1 ELSE IF p = 4 THEN gu = 10: pv = 5
IF p = 5 THEN gu = 14: pv = 2 ELSE IF p = 6 THEN gu = 7: pv = 5
IF p = 7 THEN gu = 13: pv = 3 ELSE IF p = 8 THEN gu = 8: pv = 2
IF p = 9 THEN gu = 11: pv = 2 ELSE IF p = 10 THEN gu = 3: pv = 3
IF p = 11 THEN gu = 15: pv = 2 ELSE IF p = 12 THEN gu = 12: pv = 4
IF p = 13 THEN gu = 4: pv = 6 ELSE IF p = 14 THEN gu = 5: pv = 4
IF a$ = "s" THEN gu = 16: pv = 3
gc(2) = 122: gc(1) = 102: gc(3) = 81: gc(5) = 151: gc(4) = 26: gc(6) = 151
v7 = INT(RND * 4)
tiv = 95: v = 24
sofa(0) = 1: sofa(1) = 212: sofa(2) = 16: sofa(3) = 42.5: sofa(4) = 71.5: sofa(5) = 174
d = 1: ab = 2
CLOSE
OPEN "256co.pal" FOR INPUT AS #1
FOR i = 1 TO 255 STEP 1
INPUT #1, pl(i)
NEXT i
PALETTE USING pl(0): vt = 5
DEF SEG = VARSEG(c(1))
GET (2, 2)-(56, 66), c
BLOAD "logo3.pic", VARPTR(c(1))
PUT (2, 10), c, PSET
CLOSE : COLOR 53
DEF SEG = 0: POKE 1047, 32
LOCATE 1, 1: PRINT "Loading ....."
OPEN "people.dat" FOR INPUT AS #1
7 FOR i = 1 TO 7: INPUT #1, d$(i): NEXT i
INPUT #1, c, jam, mim, lvl, sp$
IF c <> p THEN 7 ELSE IF gu = 16 AND p <> 15 THEN mam = jam: jim = mim: bvl = lvl: pse$ = sp$: p = 15: GOTO 7
IF gu = 16 THEN jam = mam: mim = jim: lvl = bvl: sp$ = pse$
FOR f = 1 TO 4
IF MID$(sp$, f, 1) <> " " THEN spec(ASC(MID$(sp$, f, 1)) - 96) = 1
NEXT f
IF gu = 5 THEN FOR x = 1 TO 19: spec(x) = 1: NEXT x
IF lvl = 1 THEN tko = .6
IF lvl = 2 THEN lvl = 1: tko = 1.2
IF lvl = 3 THEN lvl = 1: tko = 1.8
IF lvl = 4 THEN lvl = 1: tko = 2.3
lvl = 0
CLOSE
OPEN "bank1.mov" FOR INPUT AS #1
FOR i = 1 TO 399
INPUT #1, lf(i), lle(i), lj(i), f(i), le(i), lh(i), e(i), llh(i), s(i), s2(i), m(i), m2(i), dx(i), dy(i)
NEXT i
FOR i = 1 TO 399
hi = i + 399
lf(hi) = lf(i)
lle(hi) = lle(i)
lj(hi) = lj(i)
f(hi) = f(i)
le(hi) = le(i)
lh(hi) = lh(i)
e(hi) = e(i)
llh(hi) = llh(i)
s(hi) = s(i)
s2(hi) = s2(i)
m(hi) = m(i)
m2(hi) = m2(i)
dx(hi) = dx(i)
dy(hi) = dy(i)
GOSUB 200
NEXT i
IF pv <> 6 THEN GOTO 3
FOR i = 1 TO 255
rm = INT(pl(i) MOD 65536 / 256)
rm2 = rm MOD 256
rm3 = INT(pl(i) / 65536)
av = (rm + rm2 + rm3) / 3
av = INT(av)
pl(i) = av \ 2 + av * 256 + av * 65536
NEXT i
PALETTE USING pl(0): pv = 6
3 CLOSE
COLOR 53
250 LOCATE 1, 1: PRINT "Press a key .."
a$ = INKEY$: IF a$ = "" THEN 250
sip = 1
b = b + 1
IF a$ = "2" AND b = 1 THEN 250
IF a$ = "8" AND b = 2 THEN 250
IF a$ = "4" AND b = 3 THEN 250
IF a$ = "4" AND b = 4 THEN 250
IF a$ = "a" AND b = 5 THEN 250
IF a$ = "6" AND b = 6 THEN 250
IF a$ = "2" AND b = 7 THEN 250
IF b = 8 THEN code = 1: FOR i = 1000 TO 200 STEP -40: SOUND i, .1: NEXT i
CLS
FOR tp = 1 TO 256: lp(tp) = 0: NEXT tp
PALETTE USING lp(0)
DEF SEG = VARSEG(c(1))
BLOAD "fight.pic", VARPTR(c(1))
PUT (2, 10), c, PSET 'places picture in certain postion
gu = gu - 1
xc = INT(RND * 5): xc = (gu MOD 5)
xc = xc * 48
xd = INT(RND * 3): xd = INT(gu \ 5): xd = xd * 50
gu = gu + 1
GET (3 + 48, 12)-(4 + 48 + 47, 12 + 50), c
IF gu < 16 THEN GET (3 + xc, 12 + xd)-(4 + 47 + xc, 12 + 50 + xd), d ELSE GET (244, 11)-(316, 107), d
CLS
FOR i = 1 TO 290
CIRCLE (RND * 260 + 30, RND * 160 + 30), RND * 20, gc(pv) + RND * 20
NEXT i
PUT (58, 50), c, PSET
LOCATE 9, 17: PRINT "VERSUS"
IF gu < 16 THEN PUT (200, 50), d, PSET ELSE PUT (195, 32), d, PSET
PALETTE USING pl(0)
LOCATE 15, 7: PRINT "   JOE   "
FOR i = 1 TO 7
COLOR 30 + i * 3
LOCATE 15 + i, 4: PRINT d$(i)
NEXT i
SELECT CASE gu
CASE IS = 6: LOCATE 15, 25: PRINT " ARBUTU "
CASE IS = 7: LOCATE 15, 25: PRINT " KEWAN "
CASE IS = 1: LOCATE 15, 25: PRINT "  GUY   "
CASE IS = 2: LOCATE 15, 25: PRINT " USA JOE"
CASE IS = 3: LOCATE 15, 25: PRINT "  HOCHI "
CASE IS = 4: LOCATE 15, 25: PRINT " LOCOTH "
CASE IS = 5: LOCATE 15, 25: PRINT "  LARRY  "
CASE IS = 9: LOCATE 15, 25: PRINT " PIERRE"
CASE IS = 10: LOCATE 15, 25: PRINT "  YURI  "
CASE IS = 11: LOCATE 15, 25: PRINT "  RAUL "
CASE IS = 12: LOCATE 15, 25: PRINT "LUCIFER "
CASE IS = 13: LOCATE 15, 25: PRINT "THAI CHIN"
CASE IS = 15: LOCATE 15, 25: PRINT " INDIRU "
CASE IS = 8: LOCATE 15, 25: PRINT " MONTY "
CASE IS = 14: LOCATE 15, 25: PRINT " PASCAL"
END SELECT
FOR i = 1 TO 40 STEP 2
LINE (2 + i \ 2, 10 + i \ 2)-(315 - i \ 2, 200 - i \ 2), i + 20, B
NEXT i
251 LOCATE 1, 1: PRINT "Press a key .."
a$ = INKEY$: IF a$ = "" THEN 251
CLS
DEF SEG = VARSEG(c(1))
781 BLOAD "bar.pic", VARPTR(c(1))
882 PUT (10, 2), c, PSET 'places picture in certain postion
tig = TIMER: sj = 12
COLOR 55
gh = 1: st = 95 + mim: sit = 95
fi = 2: ab = 2
IF gu = 12 THEN yp = 1
i = 2
IF gc(pv) = 26 THEN gc = 1 ELSE gc = 2
FOR i = 1 TO 26
LINE (0, 173 + i)-(321, 173 + i), gc(pv) + i / gc
NEXT i
gc(1) = 79: gc(3) = 86: gc(4) = 22: gc(2) = 102: gc(5) = 151
FOR i = 0 TO 10
IF pv = 3 THEN top = 100 - (RND * 2 + 1) * i ELSE top = 50
LINE (i, top)-(i, 174), gc(pv) + i
IF pv = 3 THEN top = 100 - (RND * 2 + 1) * i ELSE top = 50
LINE (320 - i, top)-(320 - i, 174), gc(pv) + i
NEXT i
IF pv <> 5 THEN 1
FOR i = 0 TO 10
top = 130 - (RND * 2 + 1) * i
LINE (i, 50)-(i, top), 79 + i
top = 130 - (RND * 2 + 1) * i
LINE (320 - i, 50)-(320 - i, top), 79 + i
NEXT i
1 IF pv = 2 THEN add = 15 ELSE add = 0
VIEW (12, 38)-(308, 173), , 0
WINDOW SCREEN (308, 173 - add)-(12, 38 - add)
PALETTE 0, 65536 * 12
IF pv = 4 THEN PALETTE 0, 12
IF pv = 3 THEN PALETTE 0, 8 + 8 * 65536 + 8 * 256
GOSUB 71
GOSUB 72
17 'IF hgk <> 0 THEN RETURN
IF ab = 2 THEN sj = sj + 399
i = sj * 2 + fi - 1
11 LINE (m + jki - 1, m2)-(m + jki, m2), 0, BF
ti = INT(i / 2)
IF i / 2 = i \ 2 THEN 13
ti = ti + 1
m = (m(ti) + m(ti - 1)) \ 2 + v: m2 = (m2(ti) + m2(ti - 1)) \ 2 + vg
s = (s(ti) + s(ti - 1)) \ 2 + v: s2 = (s2(ti) + s2(ti - 1)) \ 2 + vg
f1 = (f(ti) + f(ti - 1)) \ 2: e1 = (e(ti) + e(ti - 1)) \ 2
lf1 = (lf(ti) + lf(ti - 1)) \ 2: lj1 = (lj(ti) + lj(ti - 1)) \ 2
le1 = (le(ti) + le(ti - 1)) \ 2: lh1 = (lh(ti) + lh(ti - 1)) \ 2
llh1 = (llh(ti) + llh(ti - 1)) \ 2: lle1 = (lle(ti) + lle(ti - 1)) \ 2
ti = ti - 1
GOTO 14
35 non = ti: IF d = 1 AND i / 2 <> i \ 2 THEN ti = ti + 1
IF ab = 2 THEN IF d = 1 OR i + 1 > sj * 2 + gh * 2 THEN gjk = dx(ti - 1) + v + 1 ELSE gjk = dx(ti + 1) + v + 1
IF ab = 1 THEN IF d = 1 OR i + 1 > sj * 2 + gh * 2 THEN gjj = dx(ti - 1) + v - 1 ELSE gjj = dx(ti + 1) + v - 1
IF dy(ti) + vg < s4 AND d$ <> "uppercut" OR (d$ = "uppercut" AND dy(ti) + vg < s4 - 5) THEN 40 ELSE IF dy(ti) + vg > m4 + 12 THEN 40 ELSE IF dy(ti) + vg < s4 + 15 THEN m4 = s4
IF dx(ti) <> 0 AND ibm <> 5 THEN IF ab = 2 AND v < tiv OR ab = 1 AND v > tiv THEN 211
GOTO 40
211 IF vg < 0 OR d = 1 THEN IF (ab = 2 AND dx(ti) + v + 3 > m3) OR (ab = 1 AND dx(ti) + v - 3 < m3) THEN SOUND 100, .1: GOSUB 39: GOSUB 60: GOSUB 80
40 IF dx(ti) + v > 310 OR dx(ti) + v < 10 THEN IF ibm <> 5 THEN d = -1:  SOUND 200, .1: SOUND 100, .5: SOUND 50, .5: sit = sit - 1: GOSUB 66
ti = non
RETURN
39 IF yp = 1 THEN bl = 79
RETURN
13 m = m(ti) + v: m2 = m2(ti) + vg: s = s(ti) + v: s2 = s2(ti) + vg
f1 = f(ti): e1 = e(ti): lf1 = lf(ti): lj1 = lj(ti)
le1 = le(ti): lh1 = lh(ti): llh1 = llh(ti)
lle1 = lle(ti): IF code <> 1 THEN 14
IF a$ = "s" THEN IF yip = 0 THEN mam = jam: jam = 0: yip = 1 ELSE yip = 0: jam = mam
IF a$ = "h" THEN st = st - 10: GOSUB 60
IF a$ = "e" AND code = 1 THEN lvl = 1: tko = tko + .3: jam = jam - .1: SOUND 1000, 1: IF tko > 3.2 THEN tko = 3.2
IF a$ = "w" THEN INPUT "Warp(1-14) ?", a: a = a - 1: qt = 3: OPEN name$ + ".sav" FOR OUTPUT AS #1: WRITE #1, a * 27: CLOSE : GOTO 246
IF a$ = "g" THEN pood = pood + 1: IF pood > 16 THEN pood = 1
IF a$ = "t" THEN FOR x = 1 TO 19: spec(x) = 0: NEXT x: SOUND 50, 1
IF a$ = "f" THEN SOUND 3000, 1: IF yfire = 0 THEN yfire = 1 ELSE yfire = 0
IF a$ = "b" THEN SOUND 400, 1: IF blo <> 12 THEN blo = 12: sip = sip / 1.1 ELSE blo = 3: sip = sip * 1.1
14 IF ab = 2 THEN gjj = m - 50 ELSE IF ab = 1 THEN gjj = m - 34 - ext
IF ab = 2 THEN gjk = m + 33 + ext ELSE IF ab = 1 THEN gjk = m + 50
IF d$ = "fall" THEN IF ab = 2 THEN gjk = m + 52 ELSE gjj = m - 52
fgh = s2 - 22: IF d$ = "uppercut" OR df$ = "uppercut" THEN fgh = s2 - 33 ELSE IF fgh > 100 THEN fgh = 100
IF dx(ti) <> 0 THEN IF dx(ti - 1) <> 0 OR d = -1 THEN GOSUB 35
IF dx(ti) = 0 THEN ibm = 0
LINE (gjj, 38 - add)-(gjk, 173), 0, BF: lp = gjk: pl = gjj
IF pople = 1 THEN IF dx(ti) <> 0 THEN GOSUB 51
SWAP s2, s4: SWAP s, s3: SWAP m, m3: SWAP m2, m4
yu = gu: gu = pood
tar
gu = yu
SWAP s2, s4: SWAP s, s3: SWAP m, m3: SWAP m2, m4
IF yfire = 1 AND dx(ti) <> 0 THEN SWAP sfi, ti: SWAP jg, vg: SWAP tiv, v: fbb = bb: bb = ab + 1: GOSUB 51: bb = fbb: SWAP jg, vg: SWAP sfi, ti: SWAP tiv, v
IF yip = 1 THEN GOSUB 50
IF win = 3 THEN RETURN
IF df$ <> "gimp" THEN GOSUB 24 ELSE IF dd = 1 THEN GOSUB 98 ELSE IF dd = -1 THEN GOSUB 99
IF win = 1 THEN RETURN
FOR x = 1 TO 2600 * sip: NEXT x
LOCATE 3, 18: PRINT 99 - INT(TIMER - tig): IF 99 - INT(TIMER - tig) < 0 THEN SOUND 500, 5: BEEP: a$ = "q": win = 1: GOTO 245
aa$ = INKEY$: bb$ = INKEY$
IF aa$ <> "" THEN IF ASC(aa$) > 96 AND ASC(aa$) < 96 + 26 THEN al$ = aa$ ELSE a$ = aa$
IF bb$ <> "" THEN IF ASC(bb$) > 96 AND ASC(bb$) < 96 + 26 THEN al$ = bb$ ELSE a$ = bb$
IF aa$ <> "" AND st > 3 THEN gh$ = aa$: IF bb$ = "q" THEN qt = qt + 1: IF qt = 2 THEN bb$ = "q": win = 1: GOTO 245
IF d$ = "jump" OR op = 0 AND jh = 2 THEN GOSUB 29
IF jh = 1 OR jh = 2 THEN IF hgk = 0 THEN RETURN ELSE RETURN
IF b <> 22 AND leg <> 2 THEN i = i + 1 * d
IF i + 1 > gh * 2 + sj * 2 THEN IF gk <> 2 THEN d = -1: dam = 0 ELSE GOTO 15
IF sit < 2 AND leg = 2 AND oo = -1 THEN GOTO 15
IF i / 2 < sj OR d = 0 THEN IF joe = 0 THEN GOTO 15 ELSE joe = 0: GOTO 70
GOTO 11
29 IF a$ = "1" AND ab = 2 OR a$ = "3" AND ab = 1 THEN hgk = 1: gh$ = "": IF op = 0 THEN GOTO 30
IF a$ = "6" AND ab = 2 OR a$ = "4" AND ab = 1 THEN IF op = 1 THEN dl = 1: lo = 1: gh$ = ""
IF a$ = "4" AND ab = 2 OR a$ = "6" AND ab = 1 THEN IF op = 1 THEN dl = 1: lo = -.8: gh$ = ""
IF a$ = "7" AND ab = 2 OR a$ = "9" AND ab = 1 THEN hgk = 4: gh$ = "": IF op = 0 THEN GOTO 30
RETURN
30 IF hgk = 1 THEN sj = 147: d$ = "": dam = 4: at$ = "h" ELSE IF hgk = 4 THEN d$ = "": sj = 97: dam = 10: at$ = "h"
IF ab = 2 THEN sj = sj + 399
sj = sj * 2
y = sj + .6: d = 1
RETURN
15 dam = 0: IF vg >= 0 THEN IF bb = 1 THEN ab = 1 ELSE ab = 2
IF sit < 2 AND leg <> 2 AND pv <> 5 THEN leg = 2: GOSUB 88: GOTO 11
IF sit < 2 AND oo = -1 THEN win = 1: IF pv = 5 THEN GOTO 91 ELSE IF pv = 2 THEN 404
IF sit < 2 AND oo = -1 THEN win = 1: IF pv = 1 THEN 400 ELSE IF pv = 4 THEN 403 ELSE IF pv = 3 THEN 402 ELSE IF pv = 6 THEN 401
IF d$ = "jump" AND gh = 3 THEN GOSUB 20: d$ = ""
IF ab = 2 THEN v = v + hl: hl = 0 ELSE v = v - hl: hl = 0
IF v > 180 THEN v = 180 ELSE IF v < -65 THEN v = -65
ext = 0: sofa = sofa(dc): sj = 1000
IF st >= 4 OR oo <> -1 THEN IF oo <> 0 AND gh$ = "" AND fg$ = "" THEN d = 0: IF ab = 1 THEN i = sofa * 2: GOTO 11 ELSE i = (399 + sofa) * 2: GOTO 11
sj = 0
al$ = "": a$ = INKEY$: IF gh$ <> "" THEN a$ = gh$: gh$ = ""
IF st < 4 AND dead <> 1 AND pv <> 5 THEN dead = 1: GOSUB 89: GOTO 11
IF st < 4 AND ipg = 0 AND oo = -1 THEN a$ = "": gh$ = "": sj = 1000: d = 0: GOSUB 90: IF ab = 1 THEN i = 2: GOTO 11 ELSE i = (226 + 13) * 2: GOTO 11
i = 1
IF ab = 1 THEN GOSUB 195
IF fg$ = "9" OR fg$ = "3" THEN fg$ = "": GOTO 15
IF fg$ <> "" THEN a$ = fg$: fg$ = ""
IF ab = 2 THEN v = v + hl: hl = 0 ELSE v = v - hl: hl = 0
IF v > 175 THEN v = 175 ELSE IF v < -60 THEN v = -60
fi = 2: d$ = "": d = 1: gk = 1
IF dc = 0 THEN 18 ELSE IF dc = 1 THEN 19
IF dc = 2 THEN dc = 0: fi = 9: d = -1: fg$ = a$: sj = 12: GOTO 17
IF dc = 3 THEN dc = 0: fi = 10: d = -1: fg$ = a$: sj = 37: GOTO 17
IF dc = 4 THEN dc = 1: fi = 10: d = -1: fg$ = a$: sj = 66: GOTO 17
IF a$ = "8" AND dc = 5 THEN dc = 1: gh = 16: gk = 2: hl = -8: sj = 176: d$ = "fall"
IF a$ = "f" THEN FOR i = 200 TO 50 STEP -10: SOUND i, .1: SOUND 350 - i, .1: NEXT i: GOTO 404
GOTO 16
19 IF a$ = "9" THEN gh = 6: dc = 4: gk = 2: sj = 66
IF a$ = "6" THEN gh = 10: gk = 2: hl = 10: sj = 75
IF a$ = "4" THEN sj = 75: gh = 10: d = -1: fi = 20: ext = 5: IF ab = 2 THEN v = v - 10 ELSE v = v + 10
IF a$ = "7" THEN gh = 7: sj = 45: dam = 2: at$ = "l"
IF a$ = "8" THEN gh = 17: fi = 14: d = -1: dc = 0: sj = 206: GOTO 17
IF a$ = "2" THEN d$ = "uppercut": gh = 9: sj = 136: dam = 6: at$ = "h"
IF a$ = "1" THEN gh = 9: sj = 55: dam = 4: at$ = "l"
GOTO 16
18 IF a$ = "2" THEN gh = 7: dc = 1: gk = 2: sj = 206
IF a$ = "1" THEN gh = 8: sj = 27: dam = 3: at$ = "l"
IF a$ = "+" THEN gh = 9: sj = 1: dam = 6: at$ = "l"
IF a$ = "6" THEN sj = 123: gk = 2: gh = 10: hl = 18: sm = 1 ELSE IF a$ = "7" THEN d$ = "punch": gh = 7: sj = 19: dam = 3: at$ = "h"
IF a$ = "4" THEN sj = 123: gk = 2: d = -1: fi = 20: gh = 11: sm = 2: IF ab = 2 THEN v = v - 18 ELSE v = v + 18
IF a$ = "8" THEN d$ = "jump": gh = 3: op = 1: sj = 115
IF a$ = "9" THEN gh = 5: dc = 2: gk = 2: sj = 12
IF a$ = "3" THEN gh = 6: dc = 3: gk = 2: sj = 37
IF a$ = "5" THEN gh = 7: sj = 88: d$ = "shove": dam = 2: at$ = "h"
16 IF sj = 0 THEN 15
GOTO 17
200 m(i) = 205 - m(i): s(i) = 205 - s(i)
lf(i) = 360 - lf(i): lj(i) = 360 - lj(i): lle(i) = 360 - lle(i): f(i) = 360 - f(i)
llh(i) = 360 - llh(i): le(i) = 360 - le(i): e(i) = 360 - e(i): lh(i) = 360 - lh(i)
IF dx(i) <> 0 THEN dx(i) = 205 - dx(i)
RETURN
195 IF a$ = "9" THEN a$ = "7" ELSE IF a$ = "7" THEN a$ = "9"
IF a$ = "6" THEN a$ = "4" ELSE IF a$ = "4" THEN a$ = "6"
IF a$ = "3" THEN a$ = "1" ELSE IF a$ = "1" THEN a$ = "3"
RETURN
'--------Jumping--------
20 op = 0: sj = 115: d$ = ""
IF hgk = 1 THEN sj = 147: d$ = "": dam = 4: at$ = "h" ELSE IF hgk = 4 THEN d$ = "": sj = 97: dam = 10: at$ = "h"
IF ab = 2 THEN sj = sj + 399
sj = sj * 2
y = sj + .6: d = 1
FOR vg = -2 TO -60 STEP -4.5
IF gh$ = "6" AND ab = 1 THEN lo = lo - .1 ELSE IF gh$ = "4" AND ab = 2 THEN lo = lo - .1
gh$ = ""
fg = fg + .16: IF dl = 1 THEN IF ab = 2 THEN v = v + 1.4 * lo ELSE v = v - 1.4 * lo
IF v < -65 THEN v = -65 ELSE IF v > 180 THEN v = 180
vg = vg + fg: IF hgk = 0 THEN y = y + .5 ELSE y = y + 1: IF y > 15 + sj THEN y = sj + 15
jh = 2: i = INT(y): GOSUB 11
NEXT vg
FOR vg = -57 TO 0 STEP 4.5
d = -1
fg = fg - .14: IF dl = 1 THEN IF ab = 2 THEN v = v + 1.4 * lo ELSE v = v - 1.4 * lo
IF v < -65 THEN v = -65 ELSE IF v > 180 THEN v = 180
vg = vg - fg: y = y - .7: IF y < sj + 1 THEN y = 1 + sj
IF vg < -50 AND hgk = 1 THEN y = y + .7
IF hgk = 4 THEN IF vg < -25 THEN y = y + .7 ELSE y = y - 1
jh = 1: i = INT(y): GOSUB 11
NEXT vg
vg = 0: jh = 0: d$ = "": gh = 3: sj = 115
fg = 0: i = 2: hgk = 0: d = 1
SOUND 150, .1: SOUND 100, .2: SOUND 50, .3
dl = 0: lo = 0
GOTO 17
34 IF ab = 2 THEN jki = 15 ELSE jki = -15
IF ab = 2 THEN jki = jki + ssg ELSE jki = jki - ssg
IF sss = 1 THEN ssg = ssg + 2
PSET (m + jki, m2), 85: PSET (m + jki - 1, m2), 82
IF m + jki > 308 OR m + jki < 12 THEN sss = 0: ssg = 0
RETURN
'--------------------Player Two-------------------------
26 pople = 0: beet = 0
IF ed = 3 THEN IF st - sit > 12 THEN IF RND > .1 THEN b = 0: GOTO 27
IF lvl = 1 AND sc <> 6 AND RND < .3 * (tko) THEN b = 0 ELSE GOSUB 110
IF df$ = "jump" AND dd = -1 THEN df$ = "gimp": GOTO 134
IF b = 8 AND st > 3 THEN sc = 1: oo = 176: sjs = 176: ogh = 15: mno = 0: dd = 1: IF bb = 1 THEN spl = spl - 8 ELSE spl = spl + 8
IF df$ = "call" THEN IF bb = 1 THEN spl = spl - 8 ELSE spl = spl + 8
IF df$ = "call" AND b = 8 THEN sc = 1: sjs = 176: oo = 181: sjs = 176: ogh = 15: mno = 0: dd = 1:  df$ = "tall"
IF b = 1 THEN oo = 19: ogh = 7: sjs = 19: mno = 1: dd = 1: dad = 3
IF b = 4 THEN ogh = 8: df$ = "": mno = 1: sjs = 27: dad = 3: oo = 27:  dd = 1 'lowkick
IF b = 6 THEN ogh = 9: df$ = "": mno = 1: sjs = 1: dad = 6: oo = 1:  dd = 1'highkick
IF b = 2 THEN ogh = 10: df$ = "": mno = 0: sjs = 123: oo = 123:  dd = 1: IF bb = 1 THEN spl = 18 ELSE spl = -18'walk
IF b = 20 THEN ogh = 8: df$ = "": mno = 1: sjs = 391: oo = 391:  dad = 6: dd = 1'Special #1
IF b = 21 THEN ogh = 9: df$ = "": mno = 1: sjs = 354: oo = 354:  dad = 6: dd = 1'Special #4
IF b = 22 THEN sc = 0: ogh = 8: df$ = "": mno = 1: sjs = 294: oo = 298: sit = sit - 3: dd = 1: SOUND 50, .2: SOUND 120, .2: SOUND 100, .3: GOSUB 66: IF bb = 1 THEN v = v - 4 ELSE v = v + 4'Special #5
IF b = 23 THEN ogh = 8: df$ = "": mno = 1: sjs = 344: oo = 344: dad = 6: dd = 1'Special #7
IF b = 24 THEN ogh = 10: df$ = "": mno = 1: sjs = 267: dad = 10: oo = 267: dd = 1'Special #6
IF b = 25 OR b = 29 THEN ogh = 9: df$ = "": mno = 1: sjs = 365: oo = 365: dd = 1: IF b = 29 THEN frz = 1'Special #8
IF b = 26 THEN ogh = 9: df$ = "": mno = 1: sjs = 256: oo = 256: dd = 1: dad = 6'Special #11
IF b = 27 THEN ogh = 7: df$ = "": mno = 1: sjs = 382: oo = 382: dd = 1: dad = 3'Special #14
IF b = 28 THEN ogh = 4: df$ = "": mno = 1: sjs = 376: oo = 376: dd = 1: dad = 4'Special #10
IF spec(9) = 1 AND RND * 100 < 50 OR spec(18) = 1 AND RND * 100 < 50 THEN IF hop = 1 AND dc = 0 AND sc = 0 AND vg = 0 THEN b = 31
IF b = 30 OR b = 31 THEN ogh = 8: df$ = "": mno = 1: dd = 1: sjs = 328: oo = 328: IF b = 31 THEN leg = 1: GOSUB 149: dad = 7: IF bb = 1 THEN v = tiv + 15 ELSE v = tiv - 15'Sheild
IF b = 3 OR jump = 1 THEN ogh = 3: b = 100: mno = 1: sjs = 115: oo = 115:  dd = 1: IF jump <> 1 THEN df$ = "jump" ELSE jump = 0'jump
IF b = 9 AND sc = 0 THEN ogh = 5: sc = 2: df$ = "": mno = 0: sjs = 12: oo = 12:  dd = 1'highblock
IF b = 10 AND sc = 0 THEN ogh = 6: sc = 3: df$ = "": mno = 0: sjs = 37: oo = 37:  dd = 1'lowblock
IF b = 5 THEN ogh = 7: df$ = "shove": mno = 1: sjs = 88: oo = 88: dad = 2:  dd = 1'shove
IF b = 9 AND sc = 6 THEN ogh = 6: sc = 0: df$ = "": mno = 0: sjs = 12: oo = 17:  dd = -1'highblock
IF b = 10 AND sc = 6 THEN ogh = 7: sc = 0: df$ = "": mno = 0: sjs = 37: oo = 43:  dd = -1'lowblock
IF b = 13 THEN df$ = "": sc = 0: oo = 212: sjs = 206: ogh = 17: dd = -1
IF b = 14 THEN df$ = "": sc = 1: oo = 206: sjs = 206: ogh = 6: dd = 1: mno = 0 'duck
IF b = 11 AND sc = 1 THEN df$ = "": sc = 4: oo = 66: sjs = 66: ogh = 6: dd = 1: mno = 0 ' block
IF b = 11 AND sc = 6 THEN df$ = "": sc = 1: oo = 72: sjs = 66: ogh = 7: dd = -1: mno = 0' block
IF b = 15 THEN df$ = "": mno = 0: oo = 75: sjs = 75: ogh = 10: dd = 1:  IF bb = 1 THEN spl = 10 ELSE spl = -10'duckwalk
IF b = 19 THEN df$ = "": mno = 0: oo = 85: sjs = 75: ogh = 11: dd = -1:  IF bb = 1 THEN tiv = tiv + 10 ELSE tiv = tiv - 10'duckwalk
IF b = 16 THEN df$ = "": mno = 1: oo = 45: sjs = 45: dad = 2: ogh = 7: dd = 1 'punch
IF b = 17 THEN df$ = "uppercut": mno = 1: oo = 136: sjs = 136: dad = 6: ogh = 9: dd = 1 'uppercut
IF b = 18 THEN df$ = "": oo = 55: mno = 1: sjs = 55: ogh = 9: dad = 4: dd = 1 'duckkick
IF b = 32 THEN df$ = "": oo = 304: sjs = 304: mno = 1: ogh = 7: dd = 1: fire = 2: fir = m3
IF sit < 2 THEN oo = -1
gop = 0
IF spec(2) = 1 AND RND * 100 < 10 THEN dad = dad * 1.4: pople = 1
IF oo = -1 THEN 27
24 IF dc = 5 THEN lop = lop + 1 ELSE lop = 0
IF lop > 200 THEN sit = -1
IF df$ <> "gimp" AND oo = -1 AND sc <> 5 THEN IF tiv < v THEN bb = 1 ELSE bb = 2
   IF oo = -1 OR jump = 1 THEN sfi = sofa(sc): gop = 0: GOTO 26 ELSE sfi = oo: oo = oo + dd * 1: gop = gop + 1
27 IF bb = 1 THEN sfi = sfi + 399
IF gop / 2 = gop \ 2 THEN 23
IF dd = 1 THEN sfi = sfi + 1 ELSE sfi = sfi
m3 = (m(sfi) + m(sfi - 1)) \ 2 + tiv: m4 = (m2(sfi) + m2(sfi - 1)) \ 2 + jg
s3 = (s(sfi) + s(sfi - 1)) \ 2 + tiv: s4 = (s2(sfi) + s2(sfi - 1)) \ 2 + jg
f1 = (f(sfi) + f(sfi - 1)) \ 2: e1 = (e(sfi) + e(sfi - 1)) \ 2
lf1 = (lf(sfi) + lf(sfi - 1)) \ 2: lj1 = (lj(sfi) + lj(sfi - 1)) \ 2
le1 = (le(sfi) + le(sfi - 1)) \ 2: lh1 = (lh(sfi) + lh(sfi - 1)) \ 2
llh1 = (llh(sfi) + llh(sfi - 1)) \ 2: lle1 = (lle(sfi) + lle(sfi - 1)) \ 2
GOTO 25
23 IF dd = 1 THEN oo = oo - 1 ELSE IF dd = -1 THEN oo = oo + 1
m3 = m(sfi) + tiv: m4 = m2(sfi) + jg: s3 = s(sfi) + tiv: s4 = s2(sfi) + jg
f1 = f(sfi): e1 = e(sfi): lf1 = lf(sfi): lj1 = lj(sfi)
le1 = le(sfi): lh1 = lh(sfi): llh1 = llh(sfi)
lle1 = lle(sfi)
25 gj = 173: IF m4 + 50 < gj THEN gj = m4 + 50
gjj = 11: IF bb = 2 AND m3 - 53 > gjj THEN gjj = m3 - 53 ELSE IF bb = 1 AND m3 - 50 > gjj THEN gjj = m3 - 50
gjk = 309: IF bb = 2 AND m3 + 50 < gjk THEN gjk = m3 + 50 ELSE IF bb = 1 AND m3 + 53 < gjk THEN gjk = m3 + 53
fgh = s4 - 33
IF dx(sfi) <> 0 THEN IF dx(sfi - 1) <> 0 OR dd = -1 THEN GOSUB 86
IF dx(sfi) = 0 THEN sod = 0
IF plo <> 3 THEN IF gjj < lp AND v < tiv THEN gjj = lp ELSE IF v > tiv AND gjk > pl THEN gjk = pl
LINE (gjj, fgh)-(gjk, gj), 0, BF
IF dx(sfi) <> 0 AND pople = 1 THEN GOSUB 51
IF invis = 1 AND tl = 0 AND spec(15) = 1 AND RND * 100 < 5 THEN tl = 1: IF tiv < v AND v < 150 THEN tiv = v + 35: bb = 2 ELSE IF tiv > v AND v > -50 THEN tiv = v - 35: bb = 1
IF invis = 1 THEN IF RND * 100 > 2 THEN GOTO 45 ELSE invis = 0: tl = 0
tar
IF shl > 0 THEN SWAP m, m3: SWAP m2, m4: GOSUB 50: SWAP m, m3: SWAP m2, m4
45 IF plo = 3 THEN RETURN
46 IF oo + 1 > sjs + ogh THEN IF b = 25 THEN GOSUB 53 ELSE IF frz = 1 THEN frz = 0: GOSUB 149
IF leg = 1 AND dd = 1 THEN vg = (oo - sjs) * -2 ELSE IF leg = 1 AND dd = -1 THEN IF oo - sjs < 3 THEN vg = vg + 4: IF vg > 0 THEN vg = 0: leg = 0: dc = 5: GOSUB 108: GOSUB 22
IF beet > 4 THEN beet = -1: oo = 335: sjs = 328: dd = -1: ogh = 8
IF leg = 1 AND spec(18) = 1 AND dd = -1 AND beet <> -1 THEN mno = 1: dd = 1: oo = 339: sjs = 338: df$ = "": ogh = 4: SOUND 100, .1: SOUND 50, .2: sit = sit - 1: GOSUB 66: beet = beet + 1
IF oo + 1 > sjs + ogh THEN dd = -1: IF mno = 0 THEN oo = -1: tiv = tiv + spl: spl = 0
IF oo - 1 < sjs AND df$ <> "gimp" THEN oo = -1
GOSUB 81
IF fire = 1 THEN GOSUB 52 ELSE IF fire = 2 THEN GOSUB 54
RETURN
'-----Special Moves
50 CIRCLE (m, m2), 25, 28 + pi, , , 2
CIRCLE (m, m2), 24, 35 + pi, , , 2: IF pi > 30 THEN lk = -1: pi = 30 ELSE IF pi < 0 THEN lk = 1: pi = 0 ELSE pi = pi + lk
RETURN
51 FOR x = 1 TO 5
IF bb = 1 OR bb = 3 THEN LINE (dx(sfi) + tiv, dy(sfi) - x + jg)-(dx(sfi) - RND * 8 + tiv, dy(sfi) - x + jg), 35 + x * 3
IF bb = 2 THEN LINE (dx(sfi) + tiv, dy(sfi) - x + jg)-(dx(sfi) + RND * 8 + tiv, dy(sfi) - x + jg), 35 + x * 3
NEXT x
RETURN
54 IF bbb = 2 THEN LINE (fir, 115)-(fir + 18, 115), 0
IF bbb = 1 THEN LINE (fir, 115)-(fir - 18, 115), 0
IF bbb = 1 THEN fir = fir + 6 ELSE fir = fir - 6
IF bbb = 2 THEN LINE (fir, 115)-(fir + 18, 115), 80
IF bbb = 1 THEN LINE (fir, 115)-(fir - 18, 115), 80
IF fir > 310 THEN fire = 0: fir = 1
IF dc = 2 OR dc = 3 OR dc = 4 THEN poo = .2 ELSE poo = 1
IF fir + 16 > m AND fir + 10 < m THEN IF m2 + 20 > 115 AND dc <> 5 THEN sit = sit - 5 * poo: SOUND 100, .2: fire = 0: GOSUB 66
RETURN
55 spec(RND * 19 + 1) = 0: RETURN
52 FOR x = 1 TO 3
IF bbb = 2 THEN LINE (fir, 150 - x)-(fir - 5, 150 - x), 0
IF bbb = 1 THEN LINE (fir, 150 - x)-(fir + 5, 150 - x), 0
NEXT x
IF bbb = 1 THEN fir = fir + 3 ELSE fir = fir - 3
FOR x = 1 TO 3
IF bbb = 2 THEN LINE (fir, 150 - x)-(fir - RND * 5, 150 - x), 35 + x * 3
IF bbb = 1 THEN LINE (fir, 150 - x)-(fir + RND * 5, 150 - x), 35 + x * 3
NEXT x
IF fir > 310 THEN fire = 0: fir = 1
IF fir + 2 > m AND fir - 2 < m THEN IF m2 + 30 > 150 AND dc <> 5 THEN sit = sit - 4: SOUND 100, .2: fire = 0: GOSUB 66
RETURN
53 FOR x1 = 1 TO 5
FOR x = 1 TO 5
LINE (m - RND * 15 + RND * 15, 1)-(m, m2), 126 + RND * 8
NEXT x
FOR g = 1 TO 2000 * sip: NEXT g
SOUND RND * 200 + 50, .1: SOUND 50, .1
NEXT x1: sit = sit - 2: GOSUB 66
RETURN
22 ogh = 9: df$ = "": mno = 1: sjs = 365: oo = 366: dd = 1
RETURN
60 block = 0
IF at$ = "h" AND sc = 2 THEN dam = dam / 4: block = 1
IF at$ = "l" AND sc = 3 THEN dam = dam / 4: block = 1: IF spec(5) = 1 THEN b = 22: oo = -1
IF sc = 4 THEN dam = dam / 4: block = 1
IF jg < 0 AND dad = 0 THEN dam = dam / 2
IF yfire = 1 THEN dam = dam * 3
IF gu = 5 AND block <> 1 THEN scp = scp + 1: IF scp / 2 = scp \ 2 THEN SOUND 3000, .5: GOSUB 55
st = st - dam: IF shl > 0 THEN sit = sit - dam / 2: GOSUB 66
ibm = 5
GOSUB 65
IF jg < 0 THEN RETURN
df$ = ""
IF block = 1 THEN RETURN
vt = INT(RND * 10) + 1: IF st < 6 THEN vt = 10
IF sc = 2 OR sc = 4 OR sc = 3 THEN sc = 0
IF sc = 1 AND df$ <> "uppercut" AND st >= 6 THEN 68
IF vt <= 8 THEN 62
sc = 5: df$ = "call"
IF m3 > 270 THEN tiv = 172: oo = 238: ogh = 16: gop = 0: mno = 0: sjs = 238: dd = 1: RETURN
IF m3 < 40 THEN tiv = -60: oo = 238: ogh = 16: gop = 0: mno = 0: sjs = 238: dd = 1: RETURN
df$ = "fall": dd = 1: oo = 158: sjs = 158: ogh = 16: gop = 0: mno = 0
RETURN
62 IF vt < 4 THEN 64 ELSE IF m3 > 288 OR m3 < 35 THEN 67
dd = 1: gop = 0: sjs = 194: oo = 194: ogh = 10: mno = 0: IF bb = 1 THEN spl = -9 ELSE spl = 9
RETURN
64 IF d$ = "shove" THEN vt = 5: GOTO 62
67 sjs = 107: ogh = 5: dd = 1: oo = 107: gop = 0: mno = 1
RETURN
68 ogh = 4: mno = 1: sjs = 215: oo = 215: dd = 1: gop = 0
RETURN
65 VIEW (1, 1)-(315, 40), , 0
IF viw = 0 THEN WINDOW SCREEN (1, 1)-(315, 40) ELSE WINDOW (1, 1)-(315, 40)
IF st > 0 AND st < 95 THEN LINE (295, 17)-(200 + st, 16), 0, BF
VIEW (12, 38)-(308, 173), , 0
IF viw = 0 THEN WINDOW SCREEN (308, 173 - add)-(12, 38 - add) ELSE WINDOW (308, 173 - add)-(12, 38 - add)
RETURN
66 sod = 4
VIEW (1, 1)-(315, 42), , 0
IF viw = 0 THEN WINDOW SCREEN (1, 1)-(315, 42) ELSE WINDOW SCREEN (1, 1)-(315, 42)
IF sit > 0 THEN LINE (115, 17)-(21 + sit, 16), 0, BF
IF sit < 10 THEN FOR x = 1 TO 19: spec(x) = 0: NEXT x
VIEW (12, 38)-(308, 173), , 0
IF viw = 0 THEN WINDOW SCREEN (308, 173 - add)-(12, 38 - add) ELSE WINDOW (308, 173 - add)-(12, 38 - add)
op = 0: d$ = ""
IF ti = sfi THEN GOSUB 100
RETURN
88 ogh = 12: df$ = "": mno = 0: sjs = 314: oo = 315: dd = 1
RETURN
89 sj = 314: gh = 12: IF ab = 2 THEN sj = sj + 399
gk = 2: hl = 0: d = 1: i = sj * 2 + fi - 1
RETURN
90 GOSUB 89
IF pv = 1 THEN 400 ELSE m = m3: IF pv = 2 THEN 404 ELSE IF pv = 6 THEN 401 ELSE IF pv = 4 THEN 403
oo = 176
gop = 1
jg = jg + 1: IF jg = 14 THEN 95
FOR x = 1 TO 9000 * sip: NEXT x
RETURN
91 i = 176: sj = 176
IF ab = 2 THEN i = i + 399
vg = vg + 1: IF vg = 14 THEN 95
i = i * 2
FOR x = 1 TO 9000 * sip: NEXT x
GOSUB 11
GOTO 91
95 VIEW: WINDOW
FOR i = 1 TO jk
u(i) = (RND * 3) * -1
f(i) = RND * 1.8 - RND * 2: f(i) = f(i) * 2: u(i) = u(i) * 2
IF win = 0 THEN x(i) = m3 ELSE x(i) = m
y(i) = 174
NEXT i
FOR i = 1 TO 160
FOR f = 1 TO jk
PSET (x(f), y(f)), 0
IF y(f) < 175 THEN x(f) = x(f) + f(f)
IF y(f) < 175 THEN y(f) = y(f) + u(f): IF y(f) > 174 THEN u(f) = u(f) * -.57: y(f) = 174: IF u(f) < -.2 THEN SOUND 50, .05
PSET (x(f), y(f)), 25 + f / 2
u(f) = u(f) + .15
IF f(f) > 0 THEN f(f) = f(f) - .03 ELSE f(f) = f(f) + .03
IF x(f) < 12 OR x(f) > 308 THEN f(f) = f(f) * -.7
NEXT f
NEXT i
COLOR 40
245 LOCATE 6, 10: IF win = 0 THEN PRINT "CONTESTANT # 1  WINS!" ELSE PRINT "THE ENEMY IS VICTORIOUS!"
a$ = INKEY$: IF a$ = "" THEN 245
VIEW: WINDOW: CLS
IF win <> 0 THEN LOCATE 1, 1: PRINT " DEATH IS BUT A STAGE IN DEVELOPEMENT." ELSE LOCATE 1, 1: PRINT "   VICTORY IS THE MOTHER OF DEFEAT."
DEF SEG = VARSEG(c(1))
IF win <> 0 THEN BLOAD "death.pic", VARPTR(c(1)) ELSE BLOAD "vic.pic", VARPTR(c(1))
PUT (2, 10), c, PSET
246 IF win = 0 THEN pg = pg ELSE pg = pg - 3: IF pg < 0 THEN pg = 0
IF gu <> 16 AND qt <> 3 THEN a$ = name$: GOSUB 141
LOCATE 25, 1: PRINT "L-load/new Q-quit P-play S-sensi";
247 IF qt <> 3 THEN a$ = INKEY$: IF a$ = "" THEN 247
IF a$ = "l" THEN LOCATE 25, 1: PRINT "                                      "; : RUN
IF a$ = "q" OR qt = 2 THEN OPEN "startup.dat" FOR OUTPUT AS #1: WRITE #1, up$, up$, sip: CLOSE : END
IF a$ = "p" OR a$ = "s" OR qt = 3 THEN OPEN "startup.dat" FOR OUTPUT AS #1: WRITE #1, name$, a$, sip: CLOSE : RUN
GOTO 247
END
'-----Fall and bow------------
70 tim = TIMER
DO: cl = cl + 1: COLOR cl + 20
FOR x = 1 TO 2000 * sip: NEXT x
LOCATE 10, 18: PRINT "Fight"
LOOP UNTIL TIMER - tim > 1
LOCATE 10, 18: PRINT "     ": COLOR 40
sj = 222: sjs = 222: gh = 15:  d = 1: sfi = 222: oo = 222: ogh = 15: mno = 1: gop = 0
GOTO 17
72 ogh = 6: gh = 6: mno = 1: dd = 1: sj = 115: sjs = 115: sfi = 115: oo = 115: gop = 0
joe = 1
RETURN
71 FOR vg = -130 TO 0 STEP 2
jg = vg: ab = 2
sj = 2 + 399: oo = 2: sfi = 2: i = (1 + 399) * 2: win = 1
GOSUB 11
NEXT vg
SOUND 150, .2: SOUND 100, .3: SOUND 50, .4: SOUND 100, .1
win = 0: vg = 0
RETURN
79 IF dc = 2 THEN IF lab = 1 THEN dad = dad / 4: pk = 0: RETURN
IF dc = 3 AND lab = 0 OR dc = 4 THEN dad = dad / 4: pk = 0: RETURN
IF vg < 0 AND hgk = 0 THEN dad = dad / 2
IF df$ = "shove" THEN RETURN
IF bb = 2 THEN bb = 1 ELSE bb = 2
fti = ti: pk = m: ti = sfi: lnon = 1
80 IF block = 1 THEN block = 0: RETURN
IF fti = 0 THEN fti = ti
IF d$ = "shove" AND pk = 0 THEN RETURN
lk = lk - 1
IF pk = 0 THEN pk = m3
FOR ip = 1 TO blo
PSET (x(ip), y(ip)), 0
u(ip) = (RND * 2) * -1
fp(ip) = RND * 2: fp(ip) = fp(ip) * 2: u(ip) = u(ip) * 2
IF bb = 1 THEN fp(ip) = fp(ip) * -1
x(ip) = pk: y(ip) = dy(ti) + vg
ipg = 1
NEXT ip
IF lnon = 1 THEN IF bb = 2 THEN bb = 1 ELSE bb = 2
ti = fti: pk = 0: lnon = 0
RETURN
81 IF ipg = 0 THEN RETURN ELSE ip = 0
82 ip = ip + 1
PSET (x(ip), y(ip)), 0
IF y(ip) < 175 THEN x(ip) = x(ip) + fp(ip): y(ip) = y(ip) + u(ip) ELSE b = b + 1: GOTO 83
PSET (x(ip), y(ip)), bl
u(ip) = u(ip) + .15
IF fp(ip) > 0 THEN fp(ip) = fp(ip) - .03 ELSE fp(ip) = fp(ip) + .03
IF x(ip) < 13 OR x(ip) > 308 THEN fp(ip) = fp(ip) * -1
83 IF ip < blo THEN 82
IF b = blo THEN ipg = 0: b = 0 ELSE b = 0
RETURN
'-------Hit player------
86 abc = 0: bl = 35
non = ti: ti = sfi
IF bb = 1 THEN ti = ti - 399: IF dd = 1 OR ti + 1 > sjs + ogh THEN gjk = dx(sfi - 1) + tiv + 1: ti = ti + 399 ELSE gjk = dx(sfi + 1) + tiv + 1: ti = ti + 399
IF bb = 2 THEN IF dd = 1 OR sfi + 1 > sjs + ogh THEN gjj = dx(sfi - 1) + tiv - 1 ELSE gjj = dx(sfi + 1) + tiv - 1
IF sod = 4 THEN ti = non: RETURN ELSE lab = 0
IF dy(ti) + jg < s2 - 2 AND df$ <> "uppercut" OR (df$ = "uppercut" AND dy(ti) + jg < s2 - 5) THEN 41 ELSE IF dy(ti) + jg > m2 + 12 THEN 41 ELSE IF dy(ti) + jg < s2 + 15 THEN m2 = s2: lab = 1
IF dx(ti) <> 0 THEN IF bb = 1 AND tiv < v OR bb = 2 AND v < tiv THEN IF jg < 0 OR dd = 1 THEN 279
GOTO 41
279 IF (bb = 1 AND dx(ti) + tiv + 3 > m) OR (bb = 2 AND dx(ti) + tiv - 2 < m) THEN SOUND 100, .1: GOSUB 79: sit = sit - dad * jam: GOSUB 66: abc = 1
41 IF abc <> 1 THEN IF dx(ti) + tiv > 310 OR dx(ti) + tiv < 10 THEN dd = -1: oo = oo - 1: SOUND 200, .1: SOUND 100, .5: SOUND 50, .5: st = st - 1: GOSUB 65
ti = non
RETURN
'--You flinch-------------------
100 IF yip = 1 OR leg = 1 THEN RETURN
IF vg = 0 THEN dam = 0
IF sit < 5 OR b = 23 THEN GOTO 108
IF dc = 2 THEN IF lab = 1 THEN abc = 0: RETURN
IF vg <> 0 THEN d$ = "": op = 0: RETURN
fi = 0
IF dc = 3 AND lab = 0 OR dc = 4 THEN abc = 0: RETURN
IF ab = 2 THEN v = v + hl / 2 ELSE v = v - hl / 2
IF dc = 1 AND d$ <> "uppercut" THEN 107
dc = 0: vt = INT(RND * 10) + 1
IF vt <= 8 THEN 102
108 d$ = "fall": IF m > 270 THEN v = 172: gh = 16: gk = 2: sit = sit - 1: sj = 238: d = 1: dc = 5: hl = 0: GOTO 106
IF m < 40 THEN v = -60: gh = 16: gk = 2: sj = 238: d = 1: dc = 5: sit = sit - 1: hl = 0: GOTO 106
gk = 2: d = 1: sj = 158: gh = 16: dc = 5: hl = 0
106 IF ab = 2 THEN sj = sj + 399
i = sj * 2 + fi - 1
RETURN
102 IF m > 288 OR m < 35 THEN 105
ti = 0
IF vt < 4 THEN 105
gk = 2
d = 1: sj = 194: gh = 10: hl = -9
IF ab = 2 THEN sj = sj + 399
i = sj * 2 + fi - 1
RETURN
104 IF df$ = "shove" THEN vt = 5: GOTO 102
105 sj = 107: gh = 5: d = 1: gk = 0: hl = 0
IF ab = 2 THEN sj = sj + 399
i = sj * 2 + fi - 1
RETURN
107 gh = 4: sj = 215: d = 1: gk = 0: hl = 0
IF ab = 2 THEN sj = sj + 399
i = sj * 2 + fi - 1: RETURN
149 gh = 12: sj = 280: d = 1
IF ab = 2 THEN sj = sj + 399
gk = 0: hl = 0: d = 1: i = sj * 2 + fi - 1
RETURN
'----------------Artificial Intelligence-----------------
110 b = 0
IF bb = 2 THEN GOSUB wierd
IF sc = 1 THEN 212
IF sc <> 0 THEN 213
IF al$ = "w" THEN b = 1
IF al$ = "f" THEN b = 2
IF al$ = "c" THEN b = 14
IF al$ = "d" THEN b = 5
IF al$ = "x" THEN b = 4
IF al$ = "t" THEN b = 6
IF al$ = "r" THEN b = 9
IF al$ = "v" THEN b = 10
IF al$ = "e" THEN pgk = 1: b = 3: el = 1
RETURN
212
IF al$ = "e" THEN b = 13
IF al$ = "w" THEN b = 16
IF al$ = "f" THEN b = 15
IF al$ = "s" THEN b = 19
IF al$ = "x" THEN b = 18
IF al$ = "c" THEN b = 17
IF al$ = "r" THEN b = 11
RETURN
213 IF sc = 5 AND al$ = "e" THEN b = 8
IF al$ = "r" AND sc = 2 THEN b = 9: sc = 6
IF al$ = "v" AND sc = 3 THEN b = 10: sc = 6
IF al$ = "r" AND sc = 4 THEN b = 11: sc = 6
RETURN
wierd:
IF al$ = "f" THEN al$ = "s" ELSE IF al$ = "s" THEN al$ = "f"
IF al$ = "w" THEN al$ = "r" ELSE IF al$ = "r" THEN al$ = "w"
IF al$ = "v" THEN al$ = "x" ELSE IF al$ = "x" THEN al$ = "v"
RETURN
rd = RND * 100: hop = 0
IF spec(3) = 1 AND rd < 8 OR spec(15) = 1 AND rd < 12 THEN invis = 1
IF spec(13) = 1 AND rd > 85 AND sc = 0 THEN shl = 6: b = 30: RETURN ELSE shl = shl - 1: IF shl < 0 THEN shl = 0
IF tko <> 0 THEN lvl = 1
IF ab = 1 THEN 112
IF tiv - v > 58 THEN ed = 3: GOTO 111
IF tiv - v > 32 THEN ed = 2: GOTO 111
ed = 1: hop = 1
GOTO 111
112 IF v - tiv > 58 THEN ed = 3: GOTO 111
IF v - tiv > 32 THEN ed = 2: GOTO 111
ed = 1: hop = 1: GOTO 111
111 vt = RND * 100
IF spec(19) = 1 AND fire = 0 AND RND * 100 < 15 AND ed <> 1 AND sit > 10 THEN fire = 1: fir = m3: bbb = bb: RETURN
IF lvl = 1 AND RND < .15 * tko THEN ed = INT(RND * 3) + 1
IF ed = 3 THEN 125
IF lvl = 1 AND RND < .2 * tko THEN 125
IF sc <> 0 THEN 124
uat$ = at$: IF lvl = 1 AND RND < .4 * tko THEN IF RND < .5 THEN uat$ = "h" ELSE uat$ = "l"
IF d = 1 AND uat$ = "h" AND dam > 0 THEN IF vt <= 80 THEN b = 9: RETURN'highblock
IF d = 1 AND uat$ = "l" AND dam > 0 THEN IF vt <= 80 THEN b = 10: RETURN'lowblock
124 IF sc = 1 AND d = 1 AND uat$ = "l" AND dam > 0 THEN IF vt <= 80 THEN b = 11: RETURN 'duckblock
125 IF sc = 0 AND vg < 0 THEN 119
fc = dc
IF lvl = 1 AND RND < .25 * tko THEN fc = INT(RND * 5): IF RND * 100 < 10 THEN fc = 6
IF ed = 2 THEN fff = 15 ELSE IF ed = 1 THEN fff = 25
IF fc = 0 AND sc = 0 AND spec(6) = 1 AND RND * 100 < fff THEN b = 24: RETURN
IF sc = 0 AND spec(8) = 1 THEN IF ed = 3 AND RND * 100 < 30 OR ed = 2 AND RND * 100 < 10 THEN b = 25: RETURN
IF sc = 0 AND spec(12) = 1 THEN IF ed = 3 AND RND * 100 < 23 OR ed = 2 AND RND * 100 < 15 THEN b = 29: RETURN
IF sc = 0 AND spec(17) = 1 THEN IF ed = 3 AND RND * 100 < 43 OR ed = 2 AND RND * 100 < 13 THEN b = 32: bbb = bb: RETURN
IF sc = 0 AND fc = 2 THEN IF ed < 3 THEN 123 ELSE 115
IF sc = 0 AND fc = 3 THEN IF ed < 3 THEN 126 ELSE 115
IF sc = 0 AND fc = 0 THEN 115
IF sc = 0 AND fc = 1 OR sc = 0 AND fc = 4 THEN 116
IF sc = 0 AND fc = 5 THEN 118
IF sc = 1 AND vg < 0 OR fc = 6 THEN 119
IF sc = 1 AND fc = 0 OR fc = 2 AND sc = 1 OR fc = 3 AND sc = 1 THEN 120
IF sc = 1 AND fc = 1 OR fc = 4 AND sc = 1 THEN 121
IF sc = 1 AND fc = 5 THEN 122
IF sc = 5 AND sps <> 1 AND spec(10) = 1 THEN b = 28: sps = 1: IF v < tiv THEN tiv = tiv - 4: RETURN ELSE tiv = tiv + 4: RETURN
IF sc = 5 THEN sps = 0: b = 8: RETURN'gettup
GOTO 128
123 IF vt < 20 THEN b = 1'punch
IF vt > 20 AND vt < 45 THEN b = 6'kick
IF vt > 45 AND vt < 75 THEN b = 4'lowkick
IF vt >= 75 THEN IF ed <> 1 THEN b = 2 ELSE b = 6
RETURN
126 IF vt < 20 THEN b = 4'lowkick
IF vt > 20 AND vt < 45 THEN b = 5'shove
IF vt > 45 AND vt < 75 THEN b = 1'punch
IF vt >= 75 THEN IF ed <> 1 THEN b = 2 ELSE b = 1
RETURN
115 IF ed = 1 AND vt > 66 OR ed = 2 AND vt > 70 THEN b = 1'punch
IF ed = 3 AND vt >= 40 THEN b = 2'advance
IF ed = 3 AND vt <= 40 AND vt > 10 THEN pgk = 1: b = 3: el = 1'jumpkick
IF ed = 2 AND vt < 30 THEN b = 4'lowkick
IF ed = 3 AND vt < 10 OR ed = 2 AND vt <= 70 AND vt >= 50 OR ed = 1 AND vt < 15 THEN b = 5'shove
IF ed = 1 AND vt >= 15 AND vt <= 55 OR ed = 2 AND vt >= 30 AND vt < 50 THEN b = 6 'high kick
IF ed = 1 AND vt > 55 AND vt < 66 THEN b = 14'duck
IF ed = 1 OR ed = 2 THEN IF RND * 100 < 24 AND spec(11) = 1 THEN b = 26'Knife hand
IF spec(14) = 1 THEN IF RND * 100 < 40 AND ed = 3 OR RND * 100 < 20 AND ed = 2 THEN b = 27'Extend
RETURN
128 IF vg < 0 THEN IF ab = 1 AND tiv < v OR ab = 2 AND tiv > v THEN RETURN
IF d <> -1 AND dam <> 0 THEN RETURN
129 IF sc = 2 THEN b = 9: sc = 6
IF sc = 3 THEN b = 10: sc = 6
IF sc = 4 THEN b = 11: sc = 6
RETURN
116 IF ed = 3 THEN b = 2'advance
IF ed = 2 AND vt < 40 OR ed = 1 AND vt < 60 THEN b = 6 'highkick
IF ed = 2 AND vt >= 40 OR ed = 1 AND vt >= 60 THEN b = 4'lowkick
IF ed = 2 AND vt < 20 AND dc = 4 THEN b = 2'advance
IF ed = 2 OR ed = 1 THEN IF spec(1) = 1 AND RND * 100 < 35 THEN b = 20'Sweep 
IF ed = 1 OR ed = 2 THEN IF RND * 100 < 14 AND spec(11) = 1 THEN b = 26'Knife hand
RETURN
117 IF ed = 1 THEN b = 1
RETURN
118 IF ed <> 1 THEN b = 2'advance
IF ed = 1 AND vt < 20 THEN b = 6'highkick
IF ed = 1 AND vt > 20 AND vt < 30 THEN b = 4'lowkick
RETURN
119 IF sc = 0 AND vt < 20 THEN b = 14'duck
IF sc = 0 AND ed = 2 OR sc = 0 AND ed = 2 THEN IF vt > 30 AND vt < 60 THEN b = 1'punch
IF sc = 0 AND vt > 60 THEN b = 3: pgk = 4: IF ed = 3 THEN el = 1 ELSE el = 0 'fly elbow
IF sc = 1 AND vt > 90 THEN ed = 15'advance
IF sc = 1 AND vt < 30 THEN b = 17'uppercut
IF sc = 0 AND spec(6) = 1 AND RND * 100 < 35 THEN b = 24'Hand swing
RETURN
120 IF dc = 0 THEN fff = 35 ELSE IF dc = 3 THEN fff = 15 ELSE IF dc = 2 THEN fff = 60
IF ed = 1 AND vt >= fff AND vt <= 90 THEN b = 17'uppercut
IF ed = 1 AND vt < fff THEN b = 18'duckkick
IF ed = 2 AND vt < 70 OR ed = 1 AND vt > 90 THEN b = 16'duckpunch
IF ed = 3 AND vt > 40 OR ed = 2 AND vt >= 70 THEN b = 15'advance
IF ed = 3 AND vt <= 40 THEN b = 13'gettup
IF ed <> 3 THEN IF spec(4) = 1 AND RND * 100 < 35 THEN b = 21'Roll Kick
IF ed <> 3 THEN IF spec(7) = 1 AND RND * 100 < 25 THEN b = 23'Trip up
RETURN
121 IF ed = 2 AND vt > 10 OR ed = 1 AND vt > 70 THEN b = 16'punch
IF ed = 3 AND vt > 30 OR ed = 2 AND vt < 20 THEN b = 15'advance
IF ed = 2 AND vt < 10 OR ed = 3 AND vt < 30 OR vt < 20 AND ed = 1 THEN b = 13'gettup
IF ed = 1 AND vt < 70 AND vt > 20 THEN b = 18'duckkick
IF ed <> 3 THEN IF spec(4) = 1 AND RND * 100 < 35 THEN b = 21'Roll Kick
IF ed <> 3 THEN IF spec(7) = 1 AND RND * 100 < 25 THEN b = 23'Trip up
RETURN
122 RETURN
'------------Enemy Jumping---------------
134 sjs = 115: jg = 0
IF pgk = 1 THEN sjs = 147: dad = 4 ELSE IF pgk = 4 THEN sjs = 97: dad = 10
py = .6
dd = 1
98 jg = jg - 4.5: sfg = sfg + .15: IF el = 1 THEN IF bb = 1 THEN tiv = tiv + 1.3 ELSE tiv = tiv - 1.3
IF tiv < -65 THEN tiv = -65 ELSE IF tiv > 180 THEN tiv = 180
jg = jg + sfg: IF pgk = 0 THEN py = py + .5 ELSE py = py + 1: IF py > 15 THEN py = 15
gy = py / 2
IF INT(py) / 2 <> INT(py) \ 2 THEN gop = 1 ELSE gop = 2
sjh = 1: sfi = INT(gy + sjs)
IF jg >= -58 THEN GOTO 27

jg = -57
99 jg = jg + 4.5: dd = -1
oo = 4
sfg = sfg - .15: IF el = 1 THEN IF bb = 1 THEN tiv = tiv + 1.3 ELSE tiv = tiv - 1.3
IF tiv < -65 THEN tiv = -65 ELSE IF tiv > 180 THEN tiv = 180
jg = jg - sfg: py = py - .7: IF py < 1.6 THEN py = 1.6
IF jg < -50 AND pgk = 1 THEN py = py + .6
IF pgk = 4 THEN IF jg < -25 THEN py = py + .6 ELSE py = py - 1
gy = py / 2
IF INT(py) / 2 = INT(py) \ 2 THEN gop = 1 ELSE gop = 2
sjh = 1: sfi = INT(gy + sjs)
IF jg <= 1 THEN GOTO 27

jump = 1: jg = 0
SOUND 150, .1: SOUND 100, .2: SOUND 50, .3
el = 0: df$ = ""
RETURN
'===============Fatalities!==================
400 VIEW
WINDOW
FOR i = 0 TO -92 STEP -5
ip = i * -1
DRAW "c87bm11,174ta=" + VARPTR$(i) + "nu125l1nu125c86l1nu125c85l1nu125c84l1nu125c83l1nu125c82l1nu125c81l1nu125c80l1nu125l1nu125c79l1nu125l1nu125"
DRAW "c87bm309,174ta=" + VARPTR$(ip) + "nu125r1nu125c86r1nu125c85r1nu125c84r1nu125c83r1nu125c82r1nu125c81r1nu125c80r1nu125r1nu125c79r1nu125r1nu125"
FOR x = 1 TO 2600 * sip: NEXT x
IF i > -90 THEN DRAW "c0bm11,174ta=" + VARPTR$(i) + "nu125l1nu125l1nu125l1nu125l1nu125l1nu125l1nu125l1nu125l1nu125l1nu125l1nu125l1nu125"
IF i > -90 THEN DRAW "c0bm309,174ta=" + VARPTR$(ip) + "nu125r1nu125r1nu125r1nu125r1nu125r1nu125r1nu125r1nu125r1nu125r1nu125r1nu125r1nu125"
NEXT i
FOR i = 250 TO 50 STEP -20
SOUND i, .1
SOUND 50, .1: SOUND 400 - i, .05
NEXT i
GOTO 245
401 d = 1
FOR g = 1 TO 20
cx(g) = RND * 320: cy(g) = RND * 70: cc(g) = INT(RND * 19)
d(g) = 1
NEXT g
FOR i = 1 TO 250
FOR g = 1 TO 20
CIRCLE (cx(g), cy(g)), cc(g), 0
IF cx(g) < m THEN cx(g) = cx(g) + 1 ELSE IF cx(g) > m THEN cx(g) = cx(g) - 1
IF cy(g) < 174 THEN cy(g) = cy(g) + 1 ELSE IF RND < .05 THEN SOUND 100, .1
IF cc(g) > 20 THEN d(g) = -1 ELSE IF cc(g) < 2 THEN d(g) = 1
cc(g) = cc(g) + 1 * d(g)
CIRCLE (cx(g), cy(g)), cc(g), 73 + cc(g)
NEXT g
FOR x = 1 TO 2000 * sip: NEXT x
NEXT i
GOTO 245
402 gin = win: win = 3: ext = 20
FOR vg = 0 TO -160 STEP -2
IF plo = 3 THEN m = m3: m2 = m4
i = 176: sj = 176: LINE (1, 200)-(m, m2), 132: LINE (320, 200)-(m, m2), 132
IF ab = 2 THEN i = i + 399
i = i * 2: o = 176: gop = 0: sfi = 176: jg = vg
FOR x = 1 TO 2000 * sip: NEXT x
IF plo = 3 THEN m = m3: m2 = m4
LINE (1, 200)-(m, m2), 0: LINE (320, 200)-(m, m2), 0
IF plo = 0 THEN GOSUB 11 ELSE GOSUB 27
NEXT vg
FOR vg = -160 TO 6 STEP 2
j = j + .05
vg = vg + j
IF plo = 3 THEN m = m3: m2 = m4
i = 176: sj = 176
IF ab = 2 THEN i = i + 399
i = i * 2: o = 176: gop = 0: sfi = 176: jg = vg
FOR x = 1 TO 500 * sip: NEXT x
IF plo = 3 THEN m = m3: m2 = m4
IF plo = 0 THEN GOSUB 11 ELSE GOSUB 27
NEXT vg
FOR i = 250 TO 50 STEP -20
SOUND i, .1
SOUND 50, .1: SOUND 400 - i, .05
NEXT i
win = gin: GOTO 245
403 IF ab = 2 THEN m = m + 3 ELSE m = m - 3
FOR g = 1 TO 60
FOR i = 1 TO 20 + g
h = i
IF i > (g + 20) / 2 THEN h = 21 + g - i
LINE (m - 10 + i - g / 2, 173)-(m - 10 + i - g / 2, 70), 0
LINE (m - 10 + i - g / 2, 173)-(m - 10 + i - g / 2, 173 - h - RND * 12), h + 20
NEXT i: IF RND < .4 THEN SOUND RND * 50 + 50, .2: SOUND 100, .1
FOR x = 1 TO 3000 * sip: NEXT x
NEXT g
FOR g = 61 TO -18 STEP -1
FOR i = 0 TO 20 + g + 1
h = i
IF i > (g + 20) / 2 THEN h = 21 + g - i
LINE (m - 10 + i - g / 2, 173)-(m - 10 + i - g / 2, 70), 0
IF i < 19 + g AND i > 0 THEN LINE (m - 10 + i - g / 2, 173)-(m - 10 + i - g / 2, 173 - h - RND * 12), h + 20
NEXT i: IF RND < .4 THEN SOUND RND * 50 + 50, .2: SOUND 100, .1
FOR x = 1 TO 3000 * sip: NEXT x
NEXT g
GOTO 245
404 FOR i = 50 TO 200 STEP 20
SOUND i, .1: SOUND i * 2, .1: SOUND 50, .3
NEXT i
FOR i = 1 TO 3
f(i) = RND * 8 - RND * 8: u(i) = RND * 2 + 2
x(i) = m: y(i) = 174
NEXT i
2 FOR i = 1 TO 3: o = p - 3
PSET (x(i), y(i)), 0
IF i = 1 OR i = 2 THEN DRAW "c0ta=" + VARPTR$(o) + "u22" ELSE DRAW "c0ta=" + VARPTR$(o) + "u18"
u(i) = u(i) - .1
IF f(i) < 0 THEN f(i) = f(i) + .1 ELSE f(i) = f(i) - .1
x(i) = x(i) - f(i)
y(i) = y(i) - u(i)
PSET (x(i), y(i)), 0
IF i = 1 OR i = 2 THEN DRAW "ta=" + VARPTR$(p) + "c30u22" ELSE DRAW "ta=" + VARPTR$(p) + "c35u18"
NEXT i: p = p + 3
FOR x = 1 TO 3000 * sip: NEXT x
IF y(1) < 180 OR y(2) < 180 OR y(3) < 180 THEN GOTO 2
ph = ph + 1: IF ph < 3 THEN p = 0: GOTO 404
GOTO 245
'==========Saving & Loading=================="
140 INPUT "SAVE-???????-SAVE"; a$
141 CLOSE : OPEN name$ + ".sav" FOR OUTPUT AS #1
pg = pg * 27
WRITE #1, pg
pg = pg / 27
CLOSE
RETURN
142 INPUT "LOAD-???????-LOAD (N go back)"; a$
INPUT "What name?"; name$
IF name$ = "n" OR name$ = "N" THEN RETURN
143 CLOSE : OPEN name$ + ".sav" FOR INPUT AS #1
INPUT #1, pg
pg = pg / 27
CLOSE
RETURN
180 RESUME 4

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
FOR i = 100 TO 1 STEP -1
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

SUB tar ()
IF gu = 12 THEN GOSUB 49
IF gu = 1 THEN GOSUB 450
IF gu = 9 THEN GOSUB 451
IF gu = 16 THEN GOSUB 452
IF gu = 8 THEN GOSUB 94
IF gu = 3 THEN GOSUB 96
IF gu = 15 THEN GOSUB 97
IF gu = 14 THEN GOSUB 101
IF gu = 4 THEN GOSUB 103
IF gu = 13 THEN GOSUB 109
IF gu = 6 THEN GOSUB 113
IF gu = 2 THEN GOSUB 114
IF gu = 10 THEN GOSUB 127
IF gu = 11 THEN GOSUB 139
IF gu = 5 THEN GOSUB 130
IF gu = 7 THEN GOSUB 131
GOTO 900
'=================Kewan
131 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c160u5r1nd5l1c161u5r1nd5l1c162u4c163u4" + "ta=" + VARPTR$(e1) + "c100u20"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c160u22r1nd22" + "ta=" + VARPTR$(llh1) + "c100u22r1nd22"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c159u22l1nd22r2nd22" + "ta=" + VARPTR$(lj1) + "c101u22r1nd22"
LINE (m3, m4)-(s3, s4), 158
LINE (m3, m4)-(s3 - 1, s4 + 1), 159
LINE (m3 + 1, m4 + 1)-(s3 + 1, s4 + 1), 157
LINE (m3 + 1, m4 + 1)-(s3 - 2, s4 + 1), 160
DRAW "ta=" + VARPTR$(le1) + "c158u18r1nd18l1r2nu3" + "ta=" + VARPTR$(lh1) + "c100nu20l1u10"
RETURN
'===============Lucifer===================
49 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "bu4c80u14" + "ta=" + VARPTR$(e1) + "c81bu4u16"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "bu4c82u18" + "ta=" + VARPTR$(llh1) + "c82bu4u18"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "bu4c76u18" + "ta=" + VARPTR$(lj1) + "c77bu4u18"
LINE (m3, m4)-(s3, s4), 78
DRAW "ta=" + VARPTR$(le1) + "bu4c78u14" + "ta=" + VARPTR$(lh1) + "c79bu4u16"
RETURN
'============Larry==================
130 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c112u18l1c111nd18r2nd10" + "ta=" + VARPTR$(e1) + "c101u20l1nd18"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c54l1nu8r1u22r1nd10" + "ta=" + VARPTR$(llh1) + "c100u22c101l1nd20l1nd19"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c56l1nu8r1u22r1nd10" + "ta=" + VARPTR$(lj1) + "c99u22l1nd20l1nd19"
LINE (m3, m4)-(s3, s4), 111
LINE (m3 + 1, m4)-(s3, s4), 111
LINE ((m3 + s3) / 2 + 1, (m4 + s4) / 2)-(m3, m4), 110
LINE ((m3 + s3) / 2 + 2, (m4 + s4) / 2 + 1)-(m3 + 1, m4), 112
LINE ((m3 + s3) / 2 - 1, (m4 + s4) / 2 + 1)-(m3 - 1, m4), 109
LINE (m3, m4)-(s3 + 1, s4 + 1), 112
DRAW "ta=" + VARPTR$(le1) + "c110u18l1c109nd18r2nd10" + "ta=" + VARPTR$(lh1) + "c100u20l1nd18"
RETURN
'=======================Raul=======================
139 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c40u5r1nd5l1c38u5r1nd5l1c36u4c34u4" + "ta=" + VARPTR$(e1) + "c155nu20d5"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c25u22r1nd22" + "ta=" + VARPTR$(llh1) + "c155nu22d5"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c28u22l1nd22" + "ta=" + VARPTR$(lj1) + "c155nu22d5"
LINE (m3, m4)-(s3, s4), 35
LINE (m3, m4)-(s3 - 1, s4 + 1), 40
LINE (m3 + 1, m4 + 1)-(s3 + 1, s4 + 1), 30
DRAW "ta=" + VARPTR$(le1) + "c38u18r1nd18l1" + "ta=" + VARPTR$(lh1) + "c155nu20d5"
RETURN
'=======================Yuri=======================
127 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c35u10c38l1c31u4c29u4" + "ta=" + VARPTR$(e1) + "nu17r1u17c82u4l1d4"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c85u22r1nd22" + "ta=" + VARPTR$(llh1) + "c83r1c84nu12l1u19c78u3r1d1"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c87u22l1nd22" + "ta=" + VARPTR$(lj1) + "c85r1c84nu12l1u19c78u3r1d1"
LINE (m3, m4)-(s3, s4), 25
LINE (m3 - 1, m4)-(s3 - 1, s4 + 1), 30
LINE (m3 + 1, m4 + 1)-(s3 + 1, s4 + 1), 20
DRAW "ta=" + VARPTR$(le1) + "c33u18r1nd18l1" + "ta=" + VARPTR$(lh1) + "u16c98u4l1nd9r2nd6l3nd3"
RETURN
'==================USA JOE=================
114 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c30u18" + "ta=" + VARPTR$(e1) + "c100nu20l1nu10"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c118u22" + "ta=" + VARPTR$(llh1) + "c100nu22l1nu10"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c116u22" + "ta=" + VARPTR$(lj1) + "c99nu22l1nu10"
LINE (m3, m4)-(s3, s4), 79
LINE (m3, m4)-(s3 + 1, s4), 85
DRAW "ta=" + VARPTR$(le1) + "c35u18" + "ta=" + VARPTR$(lh1) + "c101nu20l1nu10"
RETURN
'=================Arbutu=====================
113 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c172u5c173u5c174u4c175u4" + "ta=" + VARPTR$(e1) + "c175u20"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c107u22r1" + "ta=" + VARPTR$(llh1) + "c176u22"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c105u22" + "ta=" + VARPTR$(lj1) + "c176u22"
LINE (m3, m4)-(s3, s4), 174
LINE (m3, m4)-(s3 - 1, s4 + 1), 176
DRAW "ta=" + VARPTR$(le1) + "c172u18r1nd8l1" + "ta=" + VARPTR$(lh1) + "c173u20"
RETURN
'=================Thai Chin=====================
109 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c91u5c92u5l1nd5nu5rlc93u8" + "ta=" + VARPTR$(e1) + "c83u20"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c96u14c94l1nd8r1u8" + "ta=" + VARPTR$(llh1) + "c92u22"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c93u14c92l1nd8r1u8" + "ta=" + VARPTR$(lj1) + "c90u12l1nd8r1u10"
LINE (m3, m4)-(s3, s4), 95
LINE (m3, m4)-(s3 - 1, s4 + 1), 90
DRAW "ta=" + VARPTR$(le1) + "c80u18r1nd8l1" + "ta=" + VARPTR$(lh1) + "c80u20"
RETURN
'=================Locoth=====================
103 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c122u10c85u8" + "ta=" + VARPTR$(e1) + "c123u20"
PSET ((s3 + m3) / 2, (s4 + m4) / 2), 0
DRAW "ta=" + VARPTR$(f1) + "c122u5c123u5l1nd5nu5rlc124u8" + "ta=" + VARPTR$(e1) + "c127u20"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c125u22" + "ta=" + VARPTR$(llh1) + "c124u22"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c124u22" + "ta=" + VARPTR$(lj1) + "c123u12l1nd8r1u10"
LINE (m3, m4)-(s3, s4), 124
LINE (m3, m4)-(s3 + 1, s4 + 1), 120
DRAW "ta=" + VARPTR$(le1) + "c79u18r1nd8l1" + "ta=" + VARPTR$(lh1) + "c80u20"
PSET ((s3 + m3) / 2, (s4 + m4) / 2), 0
DRAW "ta=" + VARPTR$(le1) + "c79u18r1nd8l1" + "ta=" + VARPTR$(lh1) + "c80u20"
RETURN
'=================Pascal=====================
101 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c28u5c109u5c30u4c110u4" + "ta=" + VARPTR$(e1) + "u16c163u4r1d4"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c101u12r1nd10c162u10" + "ta=" + VARPTR$(llh1) + "u16c163u8r1"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c101u12r1nd10c161u10" + "ta=" + VARPTR$(lj1) + "u16c162u8r1"
LINE (m3, m4)-(s3, s4), 109
LINE (m3, m4)-(s3 - 1, s4 + 1), 30
LINE (m3 - 1, m4)-(s3 + 1, s4 + 1), 30
DRAW "ta=" + VARPTR$(le1) + "c28u5c109u5c30u4c110u4" + "ta=" + VARPTR$(lh1) + "u16c160u4r1d4"
RETURN
'=================Induru=====================
97 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c161u18" + "ta=" + VARPTR$(e1) + "c25nf2ne2ng2nh2c161u20"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c145u22" + "ta=" + VARPTR$(llh1) + "c144u12l1nd8c160r1u10"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c142u22" + "ta=" + VARPTR$(lj1) + "u12l1nd8c160r1u10"
LINE (m3, m4)-(s3, s4), 160
LINE (m3, m4)-(s3 - 1, s4 + 1), 159
DRAW "ta=" + VARPTR$(le1) + "c159u18c56r1nd8l1" + "ta=" + VARPTR$(lh1) + "c30nf2ne2ng2nh2c161u20"
RETURN
'=================Ho Chi=====================
96 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c99u5c100u5l2c101u8" + "ta=" + VARPTR$(e1) + "c101u20"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c81u22" + "ta=" + VARPTR$(llh1) + "c82u12l2u10"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c79u22" + "ta=" + VARPTR$(lj1) + "c80u12l2u10"
LINE (m3, m4)-(s3, s4), 100
DRAW "ta=" + VARPTR$(le1) + "c100u10l2u8" + "ta=" + VARPTR$(lh1) + "c100u20"
RETURN
'=================Monty=====================
94 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c167u5c168u5c169u8" + "ta=" + VARPTR$(e1) + "c101u20c80nl8c83u1nl15c150nr6d1c152nr6"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c144nu16l1u22" + "ta=" + VARPTR$(llh1) + "u12c100u10"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c145nu16l1u22" + "ta=" + VARPTR$(lj1) + "u12c99u10"
LINE (m3, m4)-(s3, s4), 139
LINE (m3, m4)-(s3 + 1, s4), 138
DRAW "ta=" + VARPTR$(le1) + "c166u10u8" + "ta=" + VARPTR$(lh1) + "c100u20"
RETURN
'=================Guy=====================
450 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c99u18" + "ta=" + VARPTR$(e1) + "c101u20"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c109l1nu18r2nu18l1u22" + "ta=" + VARPTR$(llh1) + "c82u12u10"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c107l1nu18r2nu18l1u22" + "ta=" + VARPTR$(lj1) + "c80u12u10"
LINE (m3, m4)-(s3, s4), 99
LINE (m3 + 1, m4)-(s3 + 2, s4 + 1), 101
LINE (m3 + 1, m4)-(s3 + 1, s4 + 1), 100
LINE (m3, m4)-(s3 - 1, s4 - 1), 98
DRAW "ta=" + VARPTR$(le1) + "c100l1nu10r1u18" + "ta=" + VARPTR$(lh1) + "c100u20"
RETURN
'======================Pierre=======================
451 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c85u3c86u3c87u3c88u3c89u3c90u3" + "ta=" + VARPTR$(e1) + "c98u20"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c122u22r1c123nd15r1nd10l2" + "ta=" + VARPTR$(llh1) + "c98u22"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c125u22" + "ta=" + VARPTR$(lj1) + "c98u22"
LINE (m3, m4)-(s3, s4), 83
LINE (m3, m4)-(s3 + 1, s4 + 1), 81
LINE (m3, m4)-(s3 - 1, s4 + 1), 85
DRAW "ta=" + VARPTR$(le1) + "c80u18c79r1nd12c79r1nd8l2" + "ta=" + VARPTR$(lh1) + "c98u20"
RETURN
'======================Sensi=======================
452 PSET (s3, s4), 0
DRAW "ta=" + VARPTR$(f1) + "c123u3c124u3c125u3c126u3c127u3c128u3" + "ta=" + VARPTR$(e1) + "c127u20"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lle1) + "c127u22" + "ta=" + VARPTR$(llh1) + "c127u22"
PSET (m3, m4), 0
DRAW "ta=" + VARPTR$(lf1) + "c125u22" + "ta=" + VARPTR$(lj1) + "c126u22"
LINE (m3, m4)-(s3, s4), 126
DRAW "ta=" + VARPTR$(le1) + "c124u18" + "ta=" + VARPTR$(lh1) + "c124u10c98u10"
RETURN
900 END SUB

