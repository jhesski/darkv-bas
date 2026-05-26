DEFINT A-O, U-Z
'--Programmed in Quick Basic 4.5 by Jon Kreuzer----    
'Type: qb /l qb.qlb
'to load Quick Basic with the library for Call Int86old
CONST BOUSE = 51
DECLARE SUB INT86OLD (intnum AS INTEGER, inarray() AS INTEGER, outarray() AS INTEGER)
DIM inary(7) AS INTEGER, outary(7) AS INTEGER
CONST ax = 0, bx = 1, cx = 2, dx = 3, bp = 4, si = 5, di = 6, FL = 7
'$DYNAMIC
RANDOMIZE TIMER
DIM pl(256) AS LONG
DIM lp(256) AS LONG
DIM c(1 TO 26000)
DIM B(-4 TO 12000)
DIM cd(1 TO 4000)
DIM ca(1 TO 2600)
DIM cscroll(1 TO 4000)
DIM d(50)
DIM vh$(50), ob(200)
DIM mess$(40), ky$(40), bs(40), cs(40), st(40), df$(40), inv(-26 TO 26), dir$(5)
DIM des$(40), in(40), ip(40)
q$ = "out": ob(0) = 1: cur$ = "a": bq$ = "house5"
a = 5: B = 5: la = 5: lb = 5: first = 0: linv = 1
SCREEN 13
CLS
hour = 1: minute = 0
OPEN "data.swp" FOR OUTPUT AS #1: PRINT #1, "f": CLOSE
SHELL "intro"
CLOSE
DRAW "bm1,1c36r3d1l3d1r3"
GET (1, 1)-(4, 4), d(0)
DRAW "bm5,1c36r3d3l3u3"
GET (5, 1)-(9, 4), d(20)


ON STRIG(0) GOSUB l
ON STRIG(4) GOSUB B
load:
IF bq$ = q$ THEN OPEN "data.swp" FOR OUTPUT AS #1: PRINT #1, "e": CLOSE : SHELL "intro": GOTO ender
OPEN q$ + ".dv" + CHR$(168) FOR INPUT AS #1
INPUT #1, fit
FOR i = 1 TO 10
INPUT #1, qa(i), qb(i), x(i), y(i), x2(i), y2(i), lits(i)
IF qa(i) = 0 THEN qa(i) = -1: qb(i) = -1
NEXT i
INPUT #1, gen$, da$(1), da$(2), da$(3), da$(4), da$(5), da$(6)
FOR i = 1 TO 40
INPUT #1, vh$(i)
NEXT i
FOR i = 1 TO 40
 INPUT #1, mess$(i), ky$(i), bs(i), cs(i), st(i), df$(i)
 IF EOF(1) = -1 THEN ts = i: i = 41
 NEXT i
 CLOSE
GOSUB bowing
DO: LOOP UNTIL TIMER - tool > .8
GOSUB load2
GOSUB music
IF plumber > 60 AND ob(22) = 1 AND ob(55) = 1 AND ob(44) = 0 AND q$ = "house#3" THEN bq$ = "house#1": SOUND 100, .1: mess$ = "Someone's right outside the door! You'retrapped unless you do something!        (Hit a key)": GOSUB message: WHILE INKEY$ = _
 "": WEND
GOTO 5
load2:
PUT (lb, la), d(crn), XOR
DEF SEG = VARSEG(c(1))
BLOAD q$ + ".dv", VARPTR(c(1))
DEF SEG = 0
PUT (44, 28), c, PSET
GOSUB startanim
RETURN
5 tle = 0: FOR i = 1 TO 10
IF lits(i) = 0 THEN tle = i - 1: i = 11: GOTO 6
GET (x(i) + 42, y(i) + 17)-(x2(i) + 42, y2(i) + 17), B(lits(i) - 16220.5)
aa(i) = lits(i) - 16220.5
NEXT i: IF tle = 0 THEN tle = 10
6 PUT (lb, la), d(crn), XOR
rim = TIMER: tr = TIMER
FOR i = 1 TO 10: tim(i) = TIMER: NEXT i
IF pp <> 0 THEN RETURN
FOR F = 17 TO 19
LINE (24 + F, F + 8)-(293 - F, 188 - F), F + 160, B
NEXT F
FOR F = 17 TO 19
LINE (1, F + 8)-(320, F + 8), F + 160, B
NEXT F
DEF SEG = VARSEG(ca(1))
BLOAD "cursor.dv", VARPTR(ca(1))
PUT (1, 172), ca(3.5), PSET
PUT (305, 172), ca(1143), PSET
DEF SEG = VARSEG(cd(1))
BLOAD "cand.dv", VARPTR(cd(1))
PUT (1, 28), cd(307.5), PSET
PUT (281, 28), cd(307.5), PSET
FOR i = 61 TO 270 STEP 40
LINE (i, 172)-(i + 40, 199), 100, B
NEXT i
COLOR 157: pp = 1

DEF SEG = VARSEG(c(1))
BLOAD "ober.dv", VARPTR(c(1))
DEF SEG = 0
FOR i = 0 TO 5: PUT (62 + 40 * i, 173), c(1 + 510 * 28), PSET: NEXT i
OPEN "objects.dv" + CHR$(168) FOR INPUT AS #1
i = 0
FOR i = 1 TO 36
INPUT #1, des$(i), in(i), ip(i)
NEXT i
CLOSE

cursor:
a$ = INKEY$
a$ = RIGHT$(a$, 1): IF a$ <> "" THEN joy = 0
jo = jo + 1
'IF joy = 1 OR jo >= 200 THEN IF joyss = 0 THEN GOSUB joy
xb = B: ya = a
'IF g = 0 THEN lop = 1: GOTO 1
GOSUB mouse: IF B = lmb AND a = lma THEN B = xb: a = ya ELSE lmb = B: lma = a: joy = 0
1 IF a$ = "4" OR a$ = "K" THEN B = B - 4 * p
IF a$ = "6" OR a$ = "M" THEN B = B + 4 * p
IF a$ = "8" OR a$ = "H" THEN a = a - 4 * p
IF a$ = "2" OR a$ = "P" THEN a = a + 4 * p
IF a$ = "7" OR a$ = "G" THEN B = B - 4 * p: a = a - 4 * p
IF a$ = "9" OR a$ = "I" THEN B = B + 4 * p: a = a - 4 * p
IF a$ = "1" OR a$ = "O" THEN a = a + 4 * p: B = B - 4 * p
IF a$ = "3" OR a$ = "Q" THEN a = a + 4 * p: B = B + 4 * p
IF a$ = "s" THEN GOSUB scroll ELSE IF a$ = "j" THEN IF joyss = 0 THEN SOUND 60, 1: joyss = 1 ELSE SOUND 600, 1: joyss = 0
IF a$ = "r" THEN mess$ = last$: GOSUB message
IF a$ = "y" OR a$ = "Y" THEN GOSUB action
IF a$ <> "" THEN IF (ASC(a$) > 96 AND ASC(a$) < 96 + 15) THEN IF action$ = "s" THEN GOSUB savegame ELSE IF action$ = "l" THEN GOSUB loadgame
IF B > 315 THEN B = 315 ELSE IF B < 1 THEN B = 1
IF a > 195 THEN a = 195 ELSE IF a < 1 THEN a = 1
IF p = 2 THEN p = 1: GOTO 2 ELSE p = 1
IF xsb > B + 1 OR xsb < B - 1 OR ysa > a + 1 OR ysa < a - 1 THEN ysa = a: xsb = B: GOSUB special
IF less$ <> mess$ THEN GOSUB message
IF a$ <> "" THEN B$ = a$
IF a$ = laa$ AND a$ = la$ AND laa$ <> "" THEN p = 2: GOTO 1
2 IF TIMER - rim > .1 THEN laa$ = la$: la$ = B$: B$ = "": rim = TIMER
STRIG(0) ON
STRIG(4) ON
IF a$ = CHR$(13) OR g = -1 AND lop = 1 OR buttons = 1 THEN hog = 1: GOSUB click
hog = 0
IF a$ = " " OR po = 1 OR buttons = 2 THEN pp = pp + 1: SOUND 600, .5: IF pp > 3 THEN pp = 1: GOSUB p ELSE GOSUB p
po = 0
STRIG(0) STOP
STRIG(4) STOP
IF first <> 0 THEN PUT (lb, la), d(crn), XOR
ra = INT((TIMER - tr) * 10) / 10
anim:
IF ra = .3 AND cn <> 1 THEN PUT (14, 51), cd(156), PSET: PUT (294, 51), cd(156), PSET: cn = 1
IF ra = .6 AND cn <> 2 THEN PUT (14, 51), cd(3.5), PSET: PUT (294, 51), cd(3.5), PSET: cn = 2
IF ra >= 1.2 THEN PUT (14, 51), cd(3.5), PSET: tr = TIMER: PUT (294, 51), cd(3.5), PSET: cn = 4
IF ra = .9 AND cn <> 3 THEN PUT (1, 28), cd(307.5), PSET: PUT (281, 28), cd(307.5), PSET: cn = 3
IF q$ = "mill2" AND cn <> lcn AND ob(58) = 0 THEN SOUND 400, .05: SOUND 32676, .2: SOUND 75, .08: lcn = cn
IF q$ = "mill4" AND cn <> lcn AND ob(58) = 0 THEN SOUND 32676, .2: SOUND 155, .05: lcn = cn
FOR bb = 1 TO tle
pa = INT((TIMER - tim(bb)) * 10) / 10
IF qa(bb) = 0 AND tusk = 0 THEN GOTO 9
IF pa = qa(bb) OR tusk = bb THEN PUT (x(bb) + 42, y(bb) + 17), c(lits(bb)), PSET
IF pa >= qb(bb) AND qb(bb) > 0 AND tusk = 0 THEN tim(bb) = TIMER: PUT (x(bb) + 42, y(bb) + 17), B(aa(bb)), PSET
9 NEXT bb
first = 1
IF tusk = 0 THEN PUT (B, a), d(crn), XOR
IF tusk = 0 THEN lb = B: la = a
IF tusk = 0 THEN GOTO cursor ELSE RETURN

B: IF TIMER - rgrim < .2 THEN RETURN
rgrim = TIMER
po = 1
RETURN

l: IF TIMER - rgrim < .2 THEN RETURN
rgrim = TIMER
GOTO click
RETURN

click:
lop = 0: cu$ = cur$
IF action$ = "cursor" THEN pp = pp + 1: PUT (lb, la), d(crn), XOR:  GOSUB p: PUT (lb, la), d(crn), XOR
IF action$ = "right" THEN GOSUB scroll
IF action$ = "left" THEN GOSUB scroll2
scp = 1
IF B < 44 OR B > 269 OR a < 28 OR a > 168 THEN RETURN
B = B - 44: a = a - 28
hog = 1: GOSUB 7
cu$ = ""
RETURN

action:
IF action$ = "q" THEN GOTO quit
IF action$ = "n" THEN RUN
IF action$ = "t" THEN minute = minute + 10: less$ = "": GOSUB citymap: GOSUB citymap
IF minute > 30 AND hour = 2 THEN ob(74) = 1
IF minute >= 60 THEN minute = minute - 60: hour = hour + 1
IF minute >= 45 AND hour > 4 THEN OPEN "data.swp" FOR OUTPUT AS #1: PRINT #1, "h": CLOSE : SHELL "intro": OPEN "data.swp" FOR OUTPUT AS #1: GOTO ender
RETURN

quit: OPEN "data.swp" FOR OUTPUT AS #1: PRINT #1, "g": CLOSE : RUN "intro.exe"

p:
LINE (36, 184)-(55, 194), 0, BF
SOUND 400, .3: SOUND 250, .5
IF pp > 3 THEN pp = 1
IF B < 10 + 44 AND B > -8 + 44 THEN IF a + 28 > 156 THEN action$ = "cursor": IF pp = 1 THEN mess$ = "Action cursor (push/pull/reach/walk)" ELSE IF pp = 2 THEN mess$ = "Get object" ELSE mess$ = "Use selected object(One with red border)"
IF pp = 3 THEN PUT (36, 186), ca(892), PSET: cur$ = "u"
IF pp = 2 THEN PUT (36, 184), ca(954), PSET: cur$ = "g"
IF pp = 1 THEN PUT (36, 184), ca(1051), PSET: cur$ = "a"
RETURN

count:
mess$ = "You're-"
IF less$ = "You're-" THEN RETURN
plumber = 0
FOR i = 1 TO 100: IF ob(i) = 1 THEN plumber = plumber + 1
NEXT i
plumber = plumber / 76: plumber = INT(plumber * 100)
RETURN

special:
IF a = ta AND B = tb THEN RETURN
ta = a: tb = B: B = B - 44: a = a - 28
mess$ = "": action$ = "": onn = 0
IF B > 0 AND B < 225 AND a > 0 AND a < 140 THEN 98
IF B < 0 OR B > 225 THEN IF a > 0 AND a < 140 THEN mess$ = "The time is ú": action$ = "t"
IF a > 140 AND a < 156 THEN IF B < -30 THEN mess$ = "SAVE under what letter? Type (a-g)": action$ = "s"
IF a > 155 THEN IF B < -30 THEN mess$ = "LOAD which saved letter? Type (a-g)     (n) to load last game to be saved over": action$ = "l"
IF a > 140 AND a < 156 THEN IF B < -15 AND B > -30 THEN mess$ = "Start a new game? (type 'Y')": action$ = "n"
IF a > 155 THEN IF B < -15 AND B > -30 THEN mess$ = "Quit to DOS? (type 'Y')": action$ = "q"
IF a > 143 AND a < 155 THEN IF B > 260 THEN mess$ = "Scroll inventory to the left": action$ = "left"
IF a > 155 THEN IF B > 260 THEN mess$ = "Scroll inventory to the right": action$ = "right"
IF a > 143 AND a < 155 THEN IF B > 260 THEN mess$ = "Scroll inventory to the left": action$ = "left"
IF B < 10 AND B > -8 THEN IF a > 147 AND a < 156 THEN mess$ = "Automatic look"
IF B < 10 AND B > -8 THEN IF a > 156 THEN action$ = "cursor": IF pp = 1 THEN mess$ = "Action cursor (push/pull/reach/walk)" ELSE IF pp = 2 THEN mess$ = "Get object" ELSE mess$ = "Use selected object(One with red border)"
IF B > 62 - 44 AND B < 256 AND a > 173 - 28 THEN display = 2: crinv = pinv: pinv = 1 + INT((B - 18) / 40): pin = inv(pinv): IF pin > 0 THEN GOSUB objects ELSE pinv = crinv
IF a < -3 THEN GOSUB count
B = B + 44: a = a + 28
RETURN
98
g$ = MID$(vh$(a / 4 + 3), B / 4 + 1, 1)
IF g$ = " " OR g$ = "" THEN B = B + 44: a = a + 28: RETURN
scp = 1
7 FOR n = scp TO ts
 IF g$ = LEFT$(df$(n), 1) THEN IF hog <> 1 THEN onn = 3: GOTO 8 ELSE IF hog = 1 AND ky$(n) <> "l" THEN onn = 9: GOTO 8
 NEXT n
B = B + 44: a = a + 28
RETURN
8 scp = n + 1
IF cu$ = LEFT$(ky$(n), 1) OR cu$ = RIGHT$(ky$(n), 1) OR ky$(n) = "l" THEN kop = koper ELSE GOTO 7
l2 = 0: l = bs(n): IF bs(n) > 100 THEN l = INT(bs(n) / 100): l2 = bs(n) - l * 100
IF ob(l) = 0 OR ob(l2) = 0 THEN GOTO 7
IF ky$(n) = "u" AND l <> selec THEN 7
IF ob(cs(n)) > 0 AND cs(n) <> 0 THEN GOTO 7
B = B + 44: a = a + 28
crn = 0
mess$ = mess$(n): onn = 3
IF RIGHT$(mess$, 1) = "*" AND LEN(mess$) > 2 THEN talk$ = "(" + MID$(mess$, LEN(mess$) - 4, 4): GOSUB talk: mess$ = "": IF pon = 1 THEN 32
IF ob(st(n)) = 0 THEN ob(st(n)) = 1: GOSUB points
IF MID$(df$(n), 2, 1) = "E" THEN GOSUB winner
IF MID$(df$(n), 2, 1) = "L" THEN rinv = inv: inv = pinv - 1: pin = 0: display = 1: GOSUB objects: inv = rinv
IF MID$(df$(n), 2, 1) = "g" THEN GOSUB setinv: pin = st(n): display = 1: GOSUB objects
IF MID$(df$(n), 2, 1) = "l" THEN rinv = inv: inv = pinv - 1: pin = st(n): display = 1: GOSUB objects: inv = rinv
32 ola = ASC(RIGHT$(df$(n), 1))
IF ola > 47 AND ola < 58 AND MID$(df$(n), 2, 1) <> "t" AND lola <> ola THEN PUT (lb, la), d(crn), XOR: tusk = ola - 48: GOSUB anim: tusk = 0: lola = ola: PUT (lb, la), d(crn), XOR
scp = 1
IF MID$(df$(n), 2, 1) = "t" AND ky$(n) <> "l" THEN q$ = MID$(df$(n), 3, 8): STRIG(0) OFF: GOSUB message: GOSUB sounds: GOSUB load: scp = 1: RETURN
RETURN

points: FOR i = 1 TO 3: SOUND 450 + i * 200, .4: SOUND 450 + i * 50, .3: SOUND 32676, .2: NEXT i
PUT (lb, la), d(crn), XOR: GOSUB startanim: PUT (lb, la), d(crn), XOR
RETURN

setinv:
i = 1
WHILE inv(i) <> 0
i = i + 1
WEND
i = i - 1
SWAP inv, i: RETURN

message:
IF onn > 0 THEN seconds = seconds + onn: IF seconds > 60 THEN seconds = seconds - 60: minute = minute + 1: IF minute / 3 = minute \ 3 THEN GOSUB citymap
IF minute >= 60 THEN minute = minute - 60: hour = hour + 1
IF minute > 30 AND hour = 2 THEN ob(74) = 1
IF minute >= 45 AND hour > 4 THEN OPEN "data.swp" FOR OUTPUT AS #1: PRINT #1, "h": CLOSE : SHELL "intro": GOTO ender
LOCATE 1, 1
GOSUB clr: last$ = less$
LOCATE 1, 1: IF mess$ = "*" THEN GOSUB puddle ELSE PRINT mess$;
IF RIGHT$(mess$, 1) = CHR$(250) THEN PRINT hour; ":"; minute: PRINT "Wait 10 minutes? (type 'Y')"
IF RIGHT$(mess$, 1) = CHR$(255) THEN FOR i = 50 TO 160 STEP 20: SOUND RND * 50 + 50, .2: NEXT i: SOUND 75, .5: SOUND 50, 1: bq$ = ""
IF RIGHT$(mess$, 1) = "-" THEN PRINT plumber; "% complete in Dark Visions II"
less$ = mess$
RETURN

'joy:
'hh = STICK(0): vv = STICK(1): jo = 0
'IF hh = 0 AND vv = 0 THEN joy = 0: RETURN
'IF vv > 199 THEN vv = 77
'IF hh > 199 THEN hh = 77
'IF hh < 40 THEN a$ = "4": joy = 1
'IF hh > 120 THEN a$ = "6": joy = 1
'IF vv < 40 THEN a$ = "8": joy = 1
'IF vv > 120 THEN a$ = "2": joy = 1
'IF hh > 120 AND vv < 40 THEN a$ = "9": joy = 1
'IF hh < 40 AND vv < 40 THEN a$ = "7": joy = 1
'IF vv > 120 AND hh > 120 THEN a$ = "3": joy = 1
'IF vv > 120 AND hh < 40 THEN a$ = "1": joy = 1
'RETURN

sounds:
tool = TIMER
PLAY "mb"
FOR i = 1 TO 4
SOUND 150, .1: SOUND 32676, .2: SOUND 100, .2: SOUND 32676, .2: SOUND 50, .3
SOUND 32676, 3
NEXT i
seconds = seconds + 18: IF seconds > 60 THEN seconds = seconds - 60: minute = minute + 1: IF minute / 3 = minute \ 3 THEN GOSUB citymap
RETURN

music:
IF q$ = "house#5" AND ms1 = 0 THEN PLAY "mbo5c12e-12g10p10d12f10e-12d12c12p12c12p12c12<b12>c6": ms1 = 1
IF q$ = "out7" AND ms2 = 0 THEN PLAY "mbo4e-8p13e-8d7f10e-10g10a-11g10p10f8e-5c4p8d8c8p8<c8p8<c8<b4>c4": ms2 = 1
IF q$ = "mill1" AND ms3 = 0 THEN PLAY "mbo5e8c7e8p10<a8>c7<a8a+3p10a4": ms3 = 1
IF q$ = "townhal1" AND ms4 = 0 THEN PLAY "mbo1a5b6>c8p10c6p10<b5>d9p10d7p10c5f9p10f7p10d5g4f7e-7d7c7<b7a3": ms4 = 1
RETURN

errr: IF eorr = 0 THEN RESUME 323 ELSE RESUME 324

savegame:
ON ERROR GOTO errr: eorr = 0
mess$ = "The game was saved": total = ASC(RIGHT$(q$, 1))
KILL "n.sav"
323 eorr = 1: NAME a$ + ".sav" AS "n.sav"
324 OPEN a$ + ".sav" FOR OUTPUT AS #1
PRINT #1, "------Dark Visions saved game-----"
WRITE #1, q$, hour, minute, actual, bq$
FOR i = 1 TO 150 STEP 5
WRITE #1, ob(i), ob(i + 1), ob(i + 2), ob(i + 3), ob(i + 4)
IF ob(i) = 1 THEN total = total + 1
IF ob(i + 2) = 1 THEN total = total + 3
NEXT i
FOR i = -25 TO 25
WRITE #1, inv(i)
NEXT i: WRITE #1, total
CLOSE
GOSUB message
RETURN
er:
mess$ = "No game under that letter."
SOUND 300, .5: SOUND 100, .2
RESUME 22

loadgame:
ON ERROR GOTO er:
mess$ = "The game was loaded"
OPEN a$ + ".sav" FOR INPUT AS #1
ON ERROR GOTO 0
LINE INPUT #1, needless$
INPUT #1, q$, hour, minute, actual, bq$: tatal = ASC(RIGHT$(q$, 1))
FOR i = 1 TO 150 STEP 5
INPUT #1, ob(i), ob(i + 1), ob(i + 2), ob(i + 3), ob(i + 4)
IF ob(i) = 1 THEN tatal = tatal + 1
IF ob(i + 2) = 1 THEN tatal = tatal + 3
NEXT i
FOR i = -25 TO 25
INPUT #1, inv(i)
NEXT i
INPUT #1, total
CLOSE
GOSUB count
IF total <> tatal THEN PRINT "Warning! saved game altered!": WHILE INKEY$ = "": WEND: GOTO quit
DEF SEG = VARSEG(c(1))
BLOAD "ober.dv", VARPTR(c(1))
DEF SEG = 0
FOR i = 0 TO 5: PUT (62 + 40 * i, 173), c(1 + 510 * 28), PSET: NEXT i
inv = 0
FOR gi = 1 TO 25
pin = inv(gi): display = 1: GOSUB objects: inv = inv + 1
NEXT gi
GOSUB load: 
22 GOSUB message
RETURN

objects:
FOR i = 1 TO 40
IF in(i) = pin THEN des$ = des$(i): in = in(i): ip = ip(i): i = 51
NEXT i
IF display = 2 THEN GOTO display2
inv(inv + 1) = in
IF inv >= 6 OR inv < 0 THEN RETURN
DEF SEG = VARSEG(c(1))
BLOAD "ober.dv", VARPTR(c(1))
LINE (21 + linv * 40, 172)-(61 + linv * 40, 199), 100, B
DEF SEG = 0
PUT (62 + inv * 40, 173), c(1 + 510 * (ip - 1)), PSET
RETURN
display2: mess$ = des$
selec = in
IF linv <> pinv THEN LINE (21 + linv * 40, 172)-(61 + linv * 40, 199), 100, B
linv = pinv
LINE (21 + pinv * 40, 172)-(61 + pinv * 40, 199), 34, B
RETURN

citymap:
IF ob(43) = 1 THEN RETURN
GOSUB again
44 needless = 0
WHILE dir$(needless) = ""
needless = INT(RND * 5) + 1
WEND
IF bqq$ = dir$(needless) THEN bqq$ = "": GOTO 44
bqq$ = bq$
bq$ = dir$(needless)
bowing: IF ob(43) = 1 THEN RETURN
SWAP bq$, q$
GOSUB again
SWAP bq$, q$
FOR needless = 1 TO 5
IF dir$(needless) = bq$ THEN SOUND 32676, 1: FOR i = 1 TO 5: SOUND 32676, .1: SOUND 50 + RND * 50, .1: NEXT i: SOUND 50, .3: SOUND 32676, .3: SOUND 75, .3
NEXT needless
CLOSE
IF bq$ = q$ THEN OPEN "data.swp" FOR OUTPUT AS #1: PRINT #1, "e": CLOSE : SHELL "intro": GOTO ender
RETURN

again:
OPEN "badguy.dv" + CHR$(168) FOR INPUT AS #1
ap: FOR needless = 1 TO 5
dir$(needless) = ""
NEXT needless
FOR needless = 1 TO 5
INPUT #1, dir$(needless)
IF LEFT$(dir$(needless), 1) = "p" THEN g$ = dir$(needless): dir$(needless) = "": needless = 6
NEXT needless
IF MID$(g$, 2, 8) <> bq$ THEN GOTO ap
FOR needless = 1 TO 5
INPUT #1, dir$(needless)
IF LEFT$(dir$(needless), 1) = "p" THEN dir$(needless) = "": needless = 6
NEXT needless
CLOSE
RETURN

puddle:
IF LEFT$(bq$, 4) = "mill" OR bq$ = "out4" THEN PRINT "There are footprints in the puddle, the most recent leading straight ahead      (Towards the mill.)": RETURN
IF LEFT$(bq$, 6) = "house#" OR bq$ = "out6" THEN PRINT "There are footprints in the puddle, the most recent leading to your left.       (Towards the house.)": RETURN
PRINT "There are footprints in the puddle, the most recent leading behind you. (Towardsthe gas station and townhall.)"
RETURN

talk:
GET (44, 28)-(118, 108), cscroll
LINE (43, 27)-(112, 101), 55, B
DEF SEG = VARSEG(c(1))
BLOAD "heads.dv", VARPTR(c(1))
DEF SEG = 0
IF talk$ = "(yor." THEN number = 0 ELSE IF talk$ = "(one." THEN number = 4 ELSE IF talk$ = "(dge." THEN number = 3 ELSE IF talk$ = "(cho." THEN number = 2 ELSE IF talk$ = "(bum." THEN number = 1 ELSE number = 2
GOSUB clr
OPEN "talk.dv" + CHR$(168) FOR INPUT AS #1
FOR i = 1 TO 1000
LINE INPUT #1, a$
IF a$ = talk$ THEN i = 1001
NEXT i
REDIM talk$(1 TO 7, 6): REDIM p(7)
FOR i = 1 TO 7: p(i) = -2: NEXT i
LINE INPUT #1, a$
LINE INPUT #1, hab$: pon = 0: IF talk(number) = 1 THEN a$ = hab$ ELSE talk(number) = 1
LOCATE 1, 1: PRINT a$
FOR i = 1 TO 100
LINE INPUT #1, a$
IF LEFT$(a$, 1) = "(" THEN i = 101: GOTO 144
pon = ASC(a$) - 64: p(pon) = p(pon) + 2
LINE INPUT #1, talk$(pon, p(pon))
LINE INPUT #1, talk$(pon, p(pon) + 1)
IF LEFT$(a$, 1) <> RIGHT$(a$, 1) THEN been = ASC(RIGHT$(a$, 1)) - 64: p(been) = p(been) + 2: talk$(been, p(been)) = talk$(pon, p(pon)): talk$(been, p(been) + 1) = talk$(pon, p(pon) + 1)
144 NEXT i
GOSUB talkanimation: l = 1
CLOSE
FOR i = 1 TO 100
GOSUB clr: COLOR 40
IF LEFT$(talk$(l, 4), 1) = " " AND ob(18) <> 1 THEN talk$(l, 4) = "": talk$(l, 5) = "" ELSE IF LEFT$(talk$(l, 2), 1) = CHR$(250) AND ob(19) <> 1 THEN talk$(l, 2) = "": talk$(l, 3) = ""
IF LEFT$(talk$(l, 2), 1) = CHR$(249) AND ob(34) = 0 THEN talk$(l, 2) = "": talk$(l, 3) = ""
LOCATE 1, 1: PRINT "1"; talk$(l, 0)
LOCATE 2, 1: PRINT "2"; talk$(l, 2)
LOCATE 3, 1: PRINT "3"; talk$(l, 4)
a$ = "": COLOR 65
66 WHILE a$ = "": a$ = INKEY$: WEND
IF a$ = "1" THEN a$ = talk$(l, 1)
IF a$ = "2" THEN a$ = talk$(l, 3)
IF a$ = "3" THEN a$ = talk$(l, 5)
IF LEFT$(a$, 15) = "Actually I seen" THEN IF LEFT$(bq$, 7) = "townhal" THEN a$ = LEFT$(a$, 77) ELSE a$ = MID$(a$, 78, 100)
IF LEN(a$) < 2 THEN a$ = "": SOUND 150, 1: SOUND 50, 2: GOTO 66
GOSUB clr
IF LEN(a$) > 120 THEN baa$ = MID$(a$, 121, 121): PRINT LEFT$(a$, 120): a$ = baa$: GOSUB talkanimation: GOSUB clr
LOCATE 1, 1: PRINT LEFT$(a$, LEN(a$) - 1)
GOSUB talkanimation:
IF RIGHT$(a$, 1) = "*" THEN pon = 1: i = 101
IF RIGHT$(a$, 1) = "@" THEN pon = 2: i = 101
l = ASC(RIGHT$(a$, 1)) - 64
NEXT i: COLOR 157
PUT (44, 28), cscroll, PSET
RETURN
clr: LINE (0, 0)-(320, 24), 0, BF: LOCATE 1, 1
RETURN

scroll2:
IF inv(0) = 0 THEN IF inv(-1) > 0 OR inv(-2) > 0 THEN FOR i = 0 TO -25 STEP -1: inv(i) = inv(i - 1): NEXT i
IF inv(0) = 0 AND inv(-1) = 0 THEN SOUND 600, .5: SOUND 50, 1: RETURN
LINE (21 + linv * 40, 172)-(61 + linv * 40, 199), 100, B
FOR i = 26 TO -25 STEP -1: inv(i) = inv(i - 1): NEXT i
GET (62, 173)-(62 + 5 * 40 - 1, 199), cscroll
PUT (62 + 40, 173), cscroll, PSET
pin = inv(1): inv = 0: display = 1: GOSUB objects
GOSUB combine: RETURN
scroll:
IF inv(7) = 0 THEN IF inv(8) > 0 OR inv(9) > 0 THEN FOR i = 7 TO 25: inv(i) = inv(i + 1): NEXT i
IF inv(7) = 0 AND inv(8) = 0 THEN SOUND 600, .5: SOUND 50, 1: RETURN
LINE (21 + linv * 40, 172)-(61 + linv * 40, 199), 100, B
FOR i = -26 TO 25 STEP 1: inv(i) = inv(i + 1): NEXT i
GET (62 + 40, 173)-(62 + 6 * 40 - 1, 199), cscroll
PUT (62, 173), cscroll, PSET
pin = inv(6): inv = 5: display = 1: GOSUB objects
GOSUB combine: RETURN

talkanimation:
ilk = number
IF ilk = 3 THEN addx = 0: addy = 0: addx2 = 0: addy2 = 0
IF ilk = 0 THEN addx = 2: addy = 13: addx2 = 3: addy2 = 7
IF ilk = 1 THEN addx = 2: addy = 7: addx2 = 2: addy2 = 6
IF ilk = 2 THEN addx = -5: addy = 1: addx2 = -6: addy2 = -1
PUT (1 + 43, 10 + 18), c(1 + 2486 * ilk), PSET
pa$ = ""
WHILE pa$ = ""
tim = TIMER
 DO: pa$ = INKEY$: LOOP UNTIL TIMER - tim > .5 OR pa$ <> ""
IF ilk <> 4 THEN PUT (23 + addx + 43, 36 + addy + 18), c(12431 + 77 * (ilk * 4) + 77 * INT(RND * 4)), PSET
IF ilk = 1 THEN ilk = 2 ELSE IF ilk = 2 THEN ilk = 1
IF ilk <> 4 THEN PUT (23 + addx2 + 43, 25 + addy2 + 18), c(13663 + 108 * (ilk * 4) + 108 * INT(RND * 4)), PSET
IF ilk = 1 THEN ilk = 2 ELSE IF ilk = 2 THEN ilk = 1
WEND: RETURN

combine: pib = -30: pyb = -30
FOR i = -25 TO 25: IF inv(i) = 50 THEN pib = i
IF inv(i) = 66 THEN pyb = i
NEXT i
IF pib = -30 OR pyb = -30 THEN RETURN
inv(pib) = 0: rinv = inv: inv = pib - 1: pin = 0: display = 1: GOSUB objects: inv = rinv
inv(pyb) = 0: rinv = inv: inv = pyb - 1: pin = 0: display = 1: GOSUB objects: inv = rinv
GOSUB setinv: pin = 67: display = 1: GOSUB objects: ob(67) = 1
mess$ = "You combine the poker and hammer to forma chisel."
GOSUB message
RETURN

startanim:
IF ob(28) = 1 AND q$ = "townhal5" THEN PUT (x(6) + 42, y(6) + 17), c(lits(6)), PSET: dn = 1
IF ob(28) = 1 AND q$ = "townhal2" THEN PUT (x(8) + 42, y(8) + 17), c(lits(8)), PSET: qa(6) = -1: qa(7) = -1: qb(6) = -1: qb(7) = -1: dn = 1
IF ob(74) = 1 AND q$ = "out5" THEN PUT (x(6) + 42, y(6) + 17), c(lits(6)), PSET: dn = 1
IF ob(30) = 1 AND q$ = "townhal2" THEN PUT (x(9) + 42, y(9) + 17), c(lits(9)), PSET: dn = 1
IF ob(24) = 1 AND q$ = "general2" THEN PUT (x(4) + 42, y(4) + 17), c(lits(4)), PSET: dn = 1
IF ob(54) = 1 AND q$ = "house4" THEN PUT (x(6) + 42, y(6) + 17), c(lits(6)), PSET: dn = 1
IF ob(50) = 1 AND q$ = "house5" THEN PUT (x(3) + 42, y(3) + 17), c(lits(3)), PSET: dn = 1
IF ob(53) = 1 AND q$ = "house4" THEN PUT (x(7) + 42, y(7) + 17), c(lits(7)), PSET: dn = 1
IF ob(61) = 1 AND q$ = "mill3" THEN PUT (x(5) + 42, y(5) + 17), c(lits(5)), PSET: dn = 1
IF ob(71) = 1 AND q$ = "mill2" THEN PUT (x(6) + 42, y(6) + 17), c(lits(6)), PSET: dn = 1
IF q$ = "mill5" AND ob(64) = 1 THEN PUT (x(4) + 42, y(4) + 17), c(lits(4)), PSET: dn = 1
IF q$ = "mill5" AND ob(65) = 1 THEN PUT (x(7) + 42, y(7) + 17), c(lits(7)), PSET: dn = 1
IF ob(66) = 1 AND q$ = "mill6" THEN PUT (x(7) + 42, y(7) + 17), c(lits(7)), PSET: dn = 1
IF ob(75) = 1 AND q$ = "mill6" THEN PUT (x(10) + 42, y(10) + 17), c(lits(10)), PSET: dn = 1
IF ob(12) = 1 AND q$ = "out3" THEN PUT (x(6) + 42, y(6) + 17), c(lits(6)), PSET: dn = 1
IF ob(51) = 1 AND q$ = "house3" THEN PUT (x(6) + 42, y(6) + 17), c(lits(6)), PSET: dn = 1
IF q$ = "townhal3" THEN IF ob(33) = 1 THEN PUT (x(4) + 42, y(4) + 17), c(lits(4)), PSET: dn = 1
IF q$ = "townhal3" THEN IF ob(32) = 1 THEN PUT (x(7) + 42, y(7) + 17), c(lits(7)), PSET: dn = 1
IF q$ = "out" THEN IF ob(2) = 1 THEN PUT (x(6) + 42, y(6) + 17), c(lits(6)), PSET: dn = 1
IF q$ = "out" THEN IF ob(3) = 1 THEN PUT (x(5) + 42, y(5) + 17), c(lits(5)), PSET: dn = 1
IF ob(46) = 1 AND q$ = "house#5" THEN PUT (x(8) + 42, y(8) + 17), c(lits(8)), PSET: dn = 1
IF ob(44) = 1 AND q$ = "house#1" THEN PUT (x(5) + 42, y(5) + 17), c(lits(5)), PSET: dn = 1
IF ob(19) = 1 AND q$ = "out7" THEN qa(5) = -1: qb(5) = -1: qa(6) = -1: qb(6) = -1: dn = 1
IF q$ = "mill2" AND ob(58) = 1 THEN qa(7) = -1: qb(7) = -1: qa(6) = -1: qb(6) = -1: qa(8) = -1: qb(8) = -1: qa(9) = -1: qb(9) = -1: dn = 1
IF q$ = "mill7" AND ob(70) = 1 THEN qa(8) = -1: qb(8) = -1: dn = 1
RETURN

ender:
COLOR 255
PALETTE 255, 60
LOCATE 1, 1
PRINT "Q-quit. N-new game (You can easily load"
PRINT "an old game after starting a new game.)"
a$ = ""
WHILE a$ = "": a$ = INKEY$: WEND
IF a$ = "q" THEN GOTO quit
IF a$ = "n" THEN RUN
BEEP: GOTO ender
RETURN

winner:
OPEN "data.swp" FOR OUTPUT AS #1
IF ob(69) <> 1 OR ob(70) <> 1 THEN PRINT #1, "i"
IF ob(69) = 1 AND ob(70) = 1 AND ob(31) <> 1 THEN PRINT #1, "j"
IF ob(69) = 1 AND ob(70) = 1 AND ob(31) = 1 THEN PRINT #1, "k"
CLOSE
VIEW SCREEN (44, 28)-(44 + 229, 28 + 140)
CLS
la = -350: s = 1
FOR i = 1 TO 142
la = la + 5: s = s + .1
DRAW "ta=" + VARPTR$(la)
DRAW "s=" + VARPTR$(s)
DRAW "bm160,100bl28c117u5nh3ne3br5c118bu1e2r2f2d4g2l2h2c119u4br8bu2d6f2r2e2u6br15c120d6f2e2f2e2c121u6br5d8br5c122u8f2d1f2d1f2u8"
SOUND 32676, .3
IF i <> 142 THEN LINE (44, 28)-(44 + 229, 28 + 140), 0, BF
NEXT i
tim = TIMER: DO: LOOP UNTIL TIMER - tim > .5
RUN "intro.exe"

mouse:
inary(ax) = 3
CALL INT86OLD(BOUSE, inary(), outary())
B = outary(cx) / 2
a = outary(dx)
bbb = outary(bx)
buttons = 0
IF bbb = 1 AND blt = 1 THEN buttons = 1: blt = 0
IF bbb = 2 AND blt = 1 THEN buttons = 2: blt = 0
IF bbb = 0 THEN blt = 1
RETURN

