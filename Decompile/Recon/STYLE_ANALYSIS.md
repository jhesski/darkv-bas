# Kreuzer Brothers QuickBASIC 4.5 House Style (~1991)

**Purpose:** A concrete, example-driven style guide for refactoring the Dark Visions
decompile (`GAME.BAS`) so it reads as if Rob & Jon Kreuzer wrote it natively in QB 4.5.
This is the reference the refactor pass should be measured against.

**Sources read** (under `C:\Code\darkv-bas\Decompile\Other Code\`):

| Game | Files | Timeline position | Weight |
|------|-------|-------------------|--------|
| **Space** | DARN/DRAGG/DRAW/RESTORE/SOUND/START.BAS | EARLIEST | HEAVY (closest ancestor) |
| **Dark Visions** | *(the target — being reconstructed)* | the subject | — |
| **DreamGiver** | ARUNNER/INTRO/ENDING/HINT/LOGO.BAS | right AFTER Dark Visions | HEAVY (closest neighbor) |
| **DARKV2** | DARKV.BAS | the SEQUEL, same engine | **HEAVIEST (gold standard)** |
| Space2 | RORIG/RUNNER/TRUCK/UFO/LOGO/point.bas | later | sample only (see caveats) |
| StickFighter2 | STICK2/STK2/CREATE4/LOGO/TAR.BAS | later | sample only |
| Create4 | CREATE4.BAS | tool, later | sample only |

> **Authorship is confirmed in the bytes.** Space/DARN.BAS credits read
> `"Designed by" / "ROB KREUZER" / "Jon Kreuzer"`, `"Programmed by" / " JON KREUZER"`,
> `"Graphics by" / "Rob Kreuzer" / "Jon Kreuzer"`, `"Music and sound by" / "Jon Kreuzer"`.
> `GAME.BAS` (our decompile) prints `"A Kreuzer Production"` at line 320 and
> `"...premier point and click game by Kreuzer productions"`. DARKV2 line 2 reads
> `'--Programmed in Quick Basic 4.5 by Jon Kreuzer----`. Same authors, same series.

---

## ⚠️ Read this first: which files are the model, which are NOT

The engine visibly **evolved** over time. Dark Visions sits EARLY (just before DreamGiver),
so the terse early style is the target. Two traps:

1. **`Space2\RUNNER.BAS` is a LATER REWRITE and must NOT be imitated.** It is the same
   point-and-click engine as `RORIG.BAS`/DARKV2 but modernized by a later hand:
   `CONST ACTION_LOOK = 1`, `SELECT CASE sceneToLoad$`, block `IF…ELSEIF…END IF`, and
   descriptive camelCase/dotted names like `sceneToLoad$`, `activeCursor`,
   `shMachineSpeed`, `characterAnimation`, `scene.interactionMap$()`. Compare its sibling
   `Space2\RORIG.BAS` — the *same program* before the rewrite — which is pure Kreuzer style
   (`q$`, `ob()`, `mess$()`, bare line-number `GOSUB 3 / GOSUB 709`, `5`/`51` labels). The
   refactor should land at **RORIG/DARKV2 terseness, not RUNNER verbosity.**

2. **`Space2\point.bas` is THIRD-PARTY code, not Kreuzer style.** Its own header says so:
   `'The following are SUB programs that WEREN'T written by Acidus Software` … `'It is NOT
   written by Acidus`. It is a stock QB mouse-driver library (`MouseDriver`, `GetMouse`,
   `Initialize%`, `DIM SHARED`, descriptive comments). The Kreuzers pulled in mouse drivers
   verbatim — in DARKV2 they instead call `INT86OLD`. Do not use `point.bas` naming as a model.

Everything below describes the **native Kreuzer style** = **Space + DreamGiver + DARKV2 +
RORIG**, the cluster that actually surrounds Dark Visions.

---

## 1. VARIABLE NAMING — the most important thing

**The scheme: terse, lowercase, type-sigil strings, no Hungarian, no descriptive names.**

### The alphabet they actually use
Variables are **1–4 characters**, almost always **lowercase**, formed from the *meaning's
initials* or just grabbed off the keyboard. Strings get a `$`. Almost nothing else carries a
sigil in gameplay code (`%`/`!`/`#` are rare and appear mostly in borrowed/INT86 code).

DARKV2 module-level declarations (the canonical set):
```basic
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
```

**Single letters** are heavily used for hot variables and coordinates:
- `a`, `B` = the cursor's screen X/Y (yes, capital `B` — see casing note below).
- `i`, `d`, `n`, `bb`, `gi` = loop counters.
- `c`, `B`, `d`, `cd`, `ca` = the big GET/PUT image buffers (arrays).
- `p` = step/paging counter; `s` = score/scratch.

**Short "initialism" words** name the domain arrays/flags — this is the signature move:
- `q$` = current room/scene id (`"out"`, `"house5"`, `"mill2"`). **Every game uses `q$` for
  the room.** `bq$` = "bad-guy" room.
- `ob()` = **ob**ject/flag state array (`ob(22)`, `ob(55)`…). Universal across DARKV2,
  DreamGiver, RORIG.
- `mess$` / `mess$()` = the message text shown to the player.
- `ky$()` = verb **key** ("l"/"g"/"u"/"o"/"p"), `bs()` = required object, `cs()` = blocker
  object, `st()` = state to set, `df$()` = the "definition"/action descriptor string.
- `vh$()` = the per-room **v**erb-**h**otspot map (a grid of letters; see §7).
- `inv()` / `iv()` / `iv$()` = inventory slots. `cur$` = current cursor mode.
- `cscroll`, `crn`, `tusk`, `plumber`, `linv`, `pinv`, `selec` = misc engine scratch, all
  short lowercase nouns.

DreamGiver matches almost 1:1: `q$`, `ob()`, `iv()`, `iv$()`, `tv()`, `tv$()`, `mess$()`,
`ky$()`, `bs()`, `CS()`, `st()`, `df$()`, `vh$()`, `da$()`, `qa()`, `qb()`, `fx()`, `fy()`,
`dil$()`, `ca$` (cursor action), `sn` (save number), `sp$` (special).

StickFighter2 (terse to the extreme): `jk = 65`, `bl = 35`, `rf = 800`, `g = 32000`,
`pood = 2`, `blo = 3`, `gu` (guy id), `sofa()`, `gc()`, `tko`, `lvl`, `spec()`.

### Casing of variable names (important and quirky)
QB is **case-insensitive** for identifiers, and the Kreuzers exploit this carelessly. The
same logical variable appears as both `B` and `b`, `CS` and `cs`, depending on which `DIM`/
assignment the editor saw first. In DARKV2, `B` (the cursor Y and the big buffer array
`B(-4 TO 12000)`) is consistently uppercase because of `DIM B(...)`; in DreamGiver the same
role is lowercase `b`. **Loop counters are lowercase `i`/`d`** *unless* a `DEFINT` capital
range forces a letter — ENDING.BAS does `DEFINT A-C` then loops `FOR I = … : FOR D = …`
(uppercase), purely because those letters got DEFINT'd. Treat casing as "whatever the editor
first tokenized," leaning lowercase.

### Type declarations
- **`DEFINT` is used at the top of most files** to make untyped vars integers:
  - DARKV2: `DEFINT A-O, U-Z` (note the gap — **P,Q,R,S,T stay single-precision**, which is
    why `p`, `q$`, `s`, `t`/timers, `tr`, `rim`, `ra` work as fractions).
  - DreamGiver ARUNNER: `DEFINT A-K`; INTRO: `DEFINT A-I`; ENDING: `DEFINT A-C`.
  - Space2 UFO/TRUCK: `DEFINT A-E`; RORIG: `DEFINT A-E, I`; Create4: `DEFINT B-C`.
  - **`DEFSNG`/`DEFSTR`/`DEFDBL` are essentially never used.** Strings are typed purely by the
    `$` suffix; singles are whatever falls outside the `DEFINT` range.
- **`AS INTEGER` / `AS LONG`** are used in `DIM`/`COMMON` for buffers and for the mouse
  interop, e.g. DARKV2:
  ```basic
  DIM inary(7) AS INTEGER, outary(7) AS INTEGER
  DIM pl(256) AS LONG
  ```
  StickFighter2 declares many `AS INTEGER` arrays explicitly. `AS SINGLE`/`AS STRING` keywords
  are not idiomatic (they'd write a bare name or a `$`).

### Arrays
- `DIM`med one per line or several per line with `:` separators
  (`DIM a(500): DIM c(450): DIM d(450)`).
- Lower bound often given explicitly when it matters: `DIM c(1 TO 26000)`,
  `DIM b(1 TO zog)`, `inv(-26 TO 26)`, `DIM B(-4 TO 12000)`.
- Array size frequently held in a short scalar declared just above:
  `zog = 10800: DIM b(1 TO zog)`; `gef = 32300: DIM SHARED c(1 TO gef)`;
  `g = 32000: DIM c(1 TO g)`.

### Loop counters
Almost always `i` (and nested `d`, `n`, `bb`, `gi`, `f`, `gf`). `FOR i = 1 TO 40 … NEXT i`.
Inner cleanup loops reuse `d`. There is **no `j`/`k` convention** except where `j`,`k` are
the cursor coords in DreamGiver (`PUT (j, k), a, XOR`).

---

## 2. LINE NUMBERS

**They line-number SPARINGLY, as GOTO/GOSUB targets only — NOT every line — and they freely
mix bare numbered lines with named labels.** Numbers are *not* uniformly incremented; they
are whatever was free when the target was needed, so they appear out of order.

- **DARKV2** is mostly **named labels** with a sprinkle of bare-number targets:
  ```basic
  load:                 ' label
  ...
  61 GOTO 5             ' bare-number target
  62 load2:             ' (number AND label share a line region)
  ...
  5 tle = 0: FOR i = 1 TO 10
  6 PUT (lb, la), d(crn), XOR
  ...
  98 g$ = MID$(vh$(a / 4 + 3), B / 4 + 1, 1)
  ...
  323 eorr = 1: NAME a$ + ".sav" AS "n.sav"
  ```
  Targets seen: `1,2,5,6,7,8,9,22,32,44,66,98,144,323,324` — clearly "next free small number,"
  not a 10/100 grid.

- **DreamGiver ARUNNER/INTRO** are the opposite extreme: **almost entirely bare line-number
  targets**, often non-sequential, with apostrophe section headers between them:
  ```basic
  9 ' -----------Loads screen's push/open/use/look-----------
  ...
  910 OPEN q$ + ".dat" FOR INPUT AS #1
  911 INPUT #1, qa(i), qb(i), fx(i), fy(i)
  ...
  153 IF ob(54) <> 0 AND q$ = "ware1" THEN qa(1) = -1: qb(1) = -1
  ```
  Note numbers like `910/911/912` interleaved with `153`, `5`, `8`, `10` — purely
  as-needed labels, **not** monotonically increasing.

- **Space (earliest)** used classic per-line numbering in places but the recovered logic is
  still target-driven (`"pic0":`, `"pic1":` string labels mark rooms).

- **Named labels are common** and lowercase: `load:`, `load2:`, `cursor:`, `click:`,
  `action:`, `quit:`, `mouse:`, `points:`, `message:`, `talk:`, `scroll:`, `winner:`,
  `ender:`, `bowing:`, `again:`, `puddle:`. RORIG uses `5`/`51`/`UpdateScene:`-style mixes.

**Takeaway for the refactor:** real Kreuzer code is NOT numbered on every line. It uses
**named labels for the major routines** and **a few bare numbers as local jump targets**,
sized "small and as-needed," not on a 10-spaced grid.

---

## 3. FORMATTING

- **Keyword case: UPPERCASE.** `IF/THEN/ELSE/FOR/NEXT/GOSUB/RETURN/GOTO/PRINT/OPEN/CLOSE/
  DIM/INPUT/LINE/PUT/GET/SOUND/PLAY/DRAW/PALETTE/SCREEN/LOCATE/COLOR/DEF SEG/BLOAD`. This is
  partly QB's editor auto-capitalizing keywords, but it is the consistent look.
- **Indentation: essentially NONE at module level.** Lines start at column 0. The only
  indentation seen is occasional accidental single leading spaces inside `FOR` bodies
  (DARKV2 line 51 ` INPUT #1, ...`, line 159 `9 NEXT bb`) and INTRO.BAS's stray
  `    BLOAD ...`. RUNNER.BAS's clean 2-space block indentation is the *modern rewrite* — do
  not imitate it.
- **Multi-statement colon lines are PERVASIVE and a defining trait.** They pack an entire
  conditional reaction onto one physical line:
  ```basic
  IF a$ = "s" THEN GOSUB scroll ELSE IF a$ = "j" THEN IF joyss = 0 THEN SOUND 60, 1: joyss = 1 ELSE SOUND 600, 1: joyss = 0
  q$ = "out": ob(0) = 1: cur$ = "a": bq$ = "house5"
  points: FOR i = 1 TO 3: SOUND 450 + i * 200, .4: SOUND 450 + i * 50, .3: SOUND 32676, .2: NEXT i
  IF a > 140 AND a < 156 THEN IF B < -30 THEN mess$ = "SAVE under what letter? Type (a-g)": action$ = "s"
  ```
  Deeply nested `IF … THEN IF … THEN … ELSE IF …` chains on one line are normal.
- **Spacing:** spaces **around `=`** in assignments and comparisons (`a = 5`, `IF q$ = "out"`),
  spaces **after commas** (`SOUND 100, .1`, `LINE (1, 1)-(4, 4)`), spaces around `+ - * /`
  (`B = B - 4 * p`). Coordinate pairs written `(x, y)-(x2, y2)`. Fractions written
  **without a leading zero**: `.1`, `.3`, `.05`, `.8` (never `0.1`).
- **Line-continuation underscore** is used only to wrap a genuinely long single statement
  (DARKV2 line 59 `… WHILE INKEY$ = _` / `60  "": WEND`). Rare.
- **Blank lines:** sparse. A blank line or two separates major routines (DARKV2 puts one
  blank line between each labeled GOSUB block). No blank lines inside a routine.

---

## 4. STRUCTURE & PROGRAM ORGANIZATION

- **GOSUB/RETURN subroutines are the primary structuring tool — NOT `SUB`/`FUNCTION`.**
  The entire DARKV2 engine is one module-level program of labeled `GOSUB` routines
  (`GOSUB message`, `GOSUB mouse`, `GOSUB action`, `GOSUB load2`, `GOSUB startanim`…). Each
  ends in `RETURN`.
- **`SUB`/`FUNCTION` are used only for top-level program *phases* / separately-loaded modules**,
  driven by `DECLARE SUB` and a `COMMON SHARED` hand-off, e.g. DreamGiver's main `ARUNNER.BAS`:
  ```basic
  DECLARE SUB logo ()
  DECLARE SUB intro ()
  DECLARE SUB ending ()
  DECLARE SUB hint ()
  COMMON SHARED x
  logo
  IF x <> 1 THEN intro
  ```
  `logo`, `intro`, `ending`, `hint` are each whole files (LOGO.BAS, INTRO.BAS, ENDING.BAS,
  HINT.BAS) defined as `SUB logo` … `END SUB`. **Crucially, even inside those SUBs they keep
  using bare line numbers + GOSUB/RETURN** (INTRO.BAS: `SUB intro` then `19 GOSUB 6` …
  `GOSUB 4` … `177 END SUB`). So a `SUB` is just a big named chunk, not a structured
  function.
- **`DECLARE SUB`** appears at the very top when SUBs/external libs are used. DARKV2 declares
  exactly one — the assembly interop:
  ```basic
  DECLARE SUB INT86OLD (intnum AS INTEGER, inarray() AS INTEGER, outarray() AS INTEGER)
  ```
  StickFighter2/Space2 declare their phase SUBs (`DECLARE SUB logo ()`, `DECLARE SUB tar ()`,
  etc.).
- **`COMMON SHARED`** carries state *between the chained modules/EXEs* (the games `CHAIN`/
  `RUN`/`SHELL` between phases). LOGO.BAS: `COMMON SHARED x`; StickFighter2 STICK2:
  ```basic
  COMMON SHARED gu AS INTEGER, sip
  COMMON SHARED f1 AS INTEGER, e1 AS INTEGER, lle1 AS INTEGER, ...
  ```
- **`DIM SHARED`** is used when there really are SUBs in the same file that must see globals
  (Space2 UFO `DIM SHARED c(1 TO gef)`, RORIG `DIM SHARED c(...)`, `DIM SHARED pl(260) AS LONG`).
  In a pure-GOSUB module (DARKV2) there is **no `SHARED` at all** — everything is module-level
  global by default.
- **`CONST`** is used lightly for hardware/interop values, not for game data:
  DARKV2 `CONST BOUSE = 51`, `CONST ax = 0, bx = 1, cx = 2, dx = 3, bp = 4, si = 5, di = 6, FL = 7`.
  (The flood of semantic `CONST ACTION_LOOK = …` in RUNNER.BAS is the modern rewrite, not the
  house style.)

### Top-to-bottom file layout (the DARKV2 template)
1. `DEFINT …` line.
2. 1–4 line apostrophe header (author / how to compile). *(DARKV2 lines 2–4.)*
3. `CONST` + `DECLARE SUB` for any interop.
4. `DIM` block — interop arrays, then the big image buffers, then the parallel game-data
   arrays (`mess$`, `ky$`, `bs`, `cs`, `st`, `df$`, `inv`, …).
5. Scalar initialization, often colon-packed (`q$ = "out": ob(0) = 1: cur$ = "a": …`).
6. `SCREEN 13: CLS`, `RANDOMIZE TIMER`, one-time file setup, `SHELL "intro"`.
7. `ON STRIG(n) GOSUB …` event wiring.
8. The `load:` / room-loader routine.
9. The main `cursor:` input loop.
10. A long sequence of `RETURN`-terminated GOSUB routines: `click`, `action`, `special`,
    `message`, `points`, `objects`, `talk`, `scroll`, `savegame`/`loadgame`, `music`,
    `sounds`, `startanim`, `mouse`, `ender`, `winner`.

---

## 5. COMMENTS — density and tone (critical for the refactor)

**They barely comment. When they do, it's an apostrophe `'`, lowercase-ish, terse, and used
as a section banner — never line-by-line narration.**

- **`'` (apostrophe), almost never `REM`.** `REM` essentially does not appear in the native
  game code. (The lone `REM`s in our decompile are decompiler artifacts.)
- **Density in pure-engine code is near zero.** DARKV2's 620 lines contain only:
  - a 3-line header (`'--Programmed in Quick Basic 4.5 by Jon Kreuzer----` / `'Type: qb /l
    qb.qlb` / `'to load Quick Basic with the library for Call Int86old`),
  - a few `'$DYNAMIC` / `'$STATIC` metacommands,
  - and a block of **commented-out dead code** (the disabled joystick routine, lines
    292–305: `'joy:` / `'hh = STICK(0): vv = STICK(1): jo = 0` …).
  That's it. No explanatory comments on the actual logic.
- **DreamGiver comments slightly more — as dashed section banners**, which is the most
  "commented" the Kreuzers get:
  ```basic
  ' defines variables
  ' ------------------initiates images-----------------
  3 ' --------------creates specialized palette----------
  85 9 ' -----------Loads screen's push/open/use/look-----------
  119 8 ' ----------------Load and display picture-------------
  186 6 'Create animation
  ```
  Tone: clipped, functional, frequently misspelled, no punctuation, lowercase first word.
- **Occasional inline trailing note**, rare and terse, e.g. StickFighter2/RUNNER:
  `PUT (2, 10), c, PSET 'places picture in certain postion` (note the typo "postion").
- **Spelling/typos are characteristic** — `malovelence`, `eminates`, `pssesive`, `Missle`,
  `judmental`, `suspicous`, `postion`, `Appartment`. Authentic Kreuzer text is *not*
  spell-checked.

**Refactor rule:** strip essentially all comments. Keep at most a 1–3 line author/compile
header and the occasional dashed section banner above a major routine. Match DARKV2's
near-zero density — definitely no per-line or per-fix annotations.

---

## 6. IDIOMS (quote-matched patterns to reproduce)

### Screen / palette / clear
```basic
SCREEN 13                       ' 320x200x256 is the house default for the adventures
SCREEN 1                        ' 320x200x4 used for some logo/menu/intro bits
SCREEN 12: SCREEN 13            ' double-set seen in INTRO/ENDING to force a mode reset
CLS
COLOR 157                       ' attribute numbers, raw
PALETTE 255, 60
PALETTE i + 16, p               ' palette loaded from a .pal text file in a FOR loop
PALETTE USING pl(0)             ' bulk palette set from a LONG array (Space2/StickFighter2)
```
Custom palettes come from a text file read with `INPUT #`:
```basic
OPEN "256colo.pal" FOR INPUT AS #1
FOR i = 1 TO 255 STEP 1
INPUT #1, p
IF p = 0 AND i > 10 THEN i = 255
PALETTE i + 16, p
NEXT i
CLOSE
```

### BLOAD / BSAVE images, GET/PUT sprites
The signature graphics idiom — load a packed image straight into an integer array's segment,
then `PUT` it:
```basic
DEF SEG = VARSEG(c(1))
BLOAD q$ + ".dv", VARPTR(c(1))
DEF SEG = 0
PUT (44, 28), c, PSET
```
DreamGiver/Space variant uses `.pic` files and a working buffer `b`:
```basic
GET (2, 2)-(180, 100), b
DEF SEG = VARSEG(b(1))
BLOAD q$ + ".pic", VARPTR(b(1))
DEF SEG
PUT (5, 5), b, PSET
```
`BSAVE` mirrors it (DreamGiver save-thumbnail):
`BSAVE "save" + CHR$(96 + sn) + ".pic", VARPTR(h(1)), 7000`.
Sprites are grabbed and stamped with `GET (x1,y1)-(x2,y2), arr` / `PUT (x,y), arr, PSET|XOR`.
The cursor is animated by `PUT … XOR` then `PUT … XOR` again to erase.

### Sound & music
Two eras:
- **Early/Dark-Visions era: `SOUND` + `PLAY` strings inline.** Frequency `32676` (≈32 kHz,
  inaudible) is their standard **silence/delay** trick between audible `SOUND`s:
  ```basic
  SOUND 150, .1: SOUND 32676, .2: SOUND 100, .2: SOUND 32676, .2: SOUND 50, .3
  PLAY "mbo5c12e-12g10p10d12f10e-12d12c12p12c12p12c12<b12>c6"
  ```
  `PLAY "mb"` (music background) starts most tunes; `PLAY "p9"` for a rest. Space stored its
  tunes as bare `PLAY` strings (`"g05d04b-08g02g08f04g08a-08b-08c03a-04"`).
- **Later era (Space2/StickFighter2): external MIDI player via `SHELL`:**
  `SHELL "midplay /q /r " + q$ + ".mid"`. (Dark Visions predates this; prefer `SOUND`/`PLAY`.)

### DRAW (vector shapes / the tiny cursor sprites)
Heavy use of `DRAW` macro strings, including the `=` + `VARPTR$()` substitution to feed a
variable into a DRAW command:
```basic
DRAW "bm1,1c36r3d1l3d1r3"
GET (1, 1)-(4, 4), d(0)
DRAW "ta=" + VARPTR$(la)
DRAW "s=" + VARPTR$(s)
```

### DATA / READ / RESTORE
Used sparingly. The clearest example is the **borrowed** mouse asm in point.bas
(`READ a$` over `DATA 55,89,E5,…` hex), and palette/sprite DATA in LOGO/point. The adventures
mostly keep game data in **external files**, not `DATA` statements (which is exactly why our
decompile lost them — see §8).

### INKEY$ / input handling
The universal "wait for a key" and dispatch:
```basic
a$ = INKEY$
...
24 a$ = INKEY$: IF a$ = "" THEN 24
WHILE a$ = "": a$ = INKEY$: WEND
WHILE INKEY$ = "": WEND
```
Movement/verb dispatch is a stack of single-line `IF a$ = "…"` tests (numeric keypad for 8
directions), exactly as in Space's `IF A$ = "north"` parser evolved into DARKV2's
`IF a$ = "4" OR a$ = "K" THEN B = B - 4 * p`. Numeric `INPUT` for menus:
`INPUT q$`, `INPUT sn: IF sn < 1 OR sn > 4 THEN 1`, `INPUT "What is your fighting name?"; name$`.

### File I/O
```basic
OPEN "data.swp" FOR OUTPUT AS #1: PRINT #1, "f": CLOSE
OPEN q$ + ".dv" + CHR$(168) FOR INPUT AS #1      ' note the CHR$() obfuscation on data files
INPUT #1, qa(i), qb(i), x(i), y(i), x2(i), y2(i), lits(i)
WRITE #1, q$, hour, minute, actual, bq$
LINE INPUT #1, needless$
```
Patterns: always `CLOSE` before/after; save files via `OPEN … FOR OUTPUT`/`WRITE #1`; load
via `INPUT #1`/`LINE INPUT #1`; data filenames built by string concat (`q$ + ".pic"`,
`"save" + CHR$(96 + sn) + ".dat"`). `SHELL "intro"` / `RUN "intro.exe"` to jump between EXEs;
a one-byte `data.swp` flag file passes a code to the next program.

### Error handling
`ON ERROR GOTO <label/number>` with a tiny handler that `RESUME`s:
```basic
ON ERROR GOTO errr: eorr = 0
...
errr: IF eorr = 0 THEN RESUME 323 ELSE RESUME 324
er: mess$ = "No game under that letter.": SOUND 300, .5: SOUND 100, .2: RESUME 22
```

### Timing
Busy-wait on `TIMER`, never a `SLEEP`:
```basic
DO: LOOP UNTIL TIMER - tool > .8
tim = TIMER: DO: LOOP UNTIL TIMER - tim > .5
rim = TIMER: ... IF TIMER - rim > .1 THEN ...
```
Some early files spin a `FOR d = 1 TO 1000: NEXT d` delay (machine-speed dependent; later
files measure speed into `sip`/`shMachineSpeed`).

---

## 7. THE POINT-AND-CLICK ENGINE (DARKV2 = the gold-standard template)

Dark Visions shares this engine, so mirror DARKV2's structure exactly. Key pieces:

**Room/scene id:** `q$` (string like `"room4"`, `"house5"`, `"mill2"`). Room change =
set `q$` then `GOSUB load`. `bq$` tracks the "bad guy" / pursuer room.

**Per-room data files:** loaded in `load:` from `q$ + ".dv"` (DARKV2) / `q$ + ".dat"`
(DreamGiver):
- a hotspot/animation header (`fit`, then 10× `qa,qb,x,y,x2,y2,lits` — animation timing + the
  sprite rects),
- the general description `gen$` + exits `da$(1..6)`,
- the **verb-hotspot grid** `vh$(i)` — one string per 4-pixel row; each character encodes
  which hotspot letter occupies that cell,
- the action table rows: `mess$(i), ky$(i), bs(i), cs(i), st(i), df$(i)`.

**Cursor & verbs:** a single character holds the active verb mode — DARKV2 `cur$`
(`"a"`=action, `"g"`=get, `"u"`=use), cycled by the spacebar through `pp`=1/2/3; DreamGiver
uses `ca$` with `"l"/"g"/"o"/"p"/"u"` (look/get/open/push/use). The cursor is a GET-sprite
PUT with `XOR` at `(B, a)` and erased by re-PUT. Mouse position comes from `GOSUB mouse`,
which calls `INT86OLD(BOUSE, inary(), outary())` and reads `outary(cx)/2`, `outary(dx)`.

**The dispatch (DARKV2 `special:` / label `98` / `7`/`8`):**
1. `special:` fires when the cursor moved; it maps screen (B,a) to UI regions (time, save,
   load, new, quit, inventory scroll, cursor-mode box) or, inside the play area, to `98`.
2. `98` reads the hotspot letter under the cursor from the grid:
   `g$ = MID$(vh$(a / 4 + 3), B / 4 + 1, 1)`.
3. `7` scans the action table for a row whose `df$(n)` starts with that letter and whose
   verb `ky$(n)` matches the current cursor (`cu$`), checking prerequisites
   (`bs()` present, `cs()` blocker absent), then jumps to `8`.
4. `8` performs the hit: sets `mess$ = mess$(n)`, flips `ob(st(n)) = 1`, awards points
   (`GOSUB points`), and dispatches on the `df$` "tag" second char — `"E"`=winner,
   `"g"/"l"`=inventory get/look, `"t"`=room transition (`q$ = MID$(df$(n), 3, 8): … GOSUB
   load`), trailing digit = play a facing/walk animation frame (`tusk = ola - 48`).

**Inventory:** `inv(-26 TO 26)` ring with a 6-slot visible window; `objects:` looks up the
item's description/picture index from parallel arrays `des$()/in()/ip()` and PUTs its
icon; `scroll`/`scroll2` rotate the ring; `combine` checks for craftable pairs.

**Save/Load:** lettered slots `a`–`g` via `a$ + ".sav"`; `WRITE #1` the room, clock, and
`ob()`/`inv()` arrays; a checksum (`total`) guards against tampering.

**Clock / pacing:** `hour`/`minute`/`seconds` advance per action and per message; crossing
thresholds triggers events (`ob(74) = 1`) and time-out endings.

Map of DARKV2 routines to reproduce: `load` / `load2` / `cursor` (main loop) / `click` /
`action` / `special` / `points` / `setinv` / `message` / `sounds` / `music` / `savegame` /
`loadgame` / `objects` / `citymap`/`bowing`/`again` (pursuer AI) / `puddle` / `talk` /
`talkanimation` / `scroll`/`scroll2` / `combine` / `startanim` / `ender` / `winner` / `mouse`.

---

## 8. HEADER / COPYRIGHT / AUTHOR-TAG CONVENTIONS

- **Top-of-file header is 1–4 apostrophe lines, max** — author + how-to-compile, nothing
  fancy. The canonical example (DARKV2):
  ```basic
  DEFINT A-O, U-Z
  '--Programmed in Quick Basic 4.5 by Jon Kreuzer----
  'Type: qb /l qb.qlb
  'to load Quick Basic with the library for Call Int86old
  ```
  Many files have **no header at all** (LOGO.BAS, UFO.BAS, ENDING.BAS just dive into
  `SUB`/`DEFINT`/`DIM`).
- **The studio/“production” credit lives in-game as a printed string**, not a file comment:
  `PRINT "A Kreuzer Production"`, `"...by Kreuzer productions"`, and the rolling credits in
  Space (`"Designed by" / "ROB KREUZER" / "Jon Kreuzer"`, etc.). Later games rebrand:
  `"Kreuzer" + "Industries"` (DreamGiver/StickFighter logos draw the word "Industries"),
  and Space2/RUNNER mention `Acidus Software` / `Voices Of Libertys`.
- The DreamGiver ENDING even signs off with the author's dev path as flavor:
  `PRINT "C:\JON\EGADRAW>"`.
- **No `'Copyright (c)` / license boilerplate anywhere.** Don't add any.

---

## HOUSE STYLE SUMMARY (the cheat-sheet)

1. **Names:** terse, **lowercase**, meaning-initials (`q$`, `ob()`, `mess$`, `ky$`, `bs`,
   `cs`, `st`, `df$`, `inv`, `vh$`, `cur$`). Single letters for hot vars/coords (`a`,`B`,`i`,
   `d`,`c`) and loop counters (`i`,`d`,`n`). `$` for strings; almost no `%`/`!`/`#`.
2. **Types:** one `DEFINT A-?` line near the top; `AS INTEGER`/`AS LONG` only on buffers/
   interop. No `DEFSNG`/`DEFSTR`. Casing of identifiers is sloppy (`B`==`b`).
3. **Line numbers:** sparse, **as-needed targets only**, non-monotonic; freely mixed with
   lowercase **named labels** (`cursor:`, `action:`). Most lines are unnumbered.
4. **Layout:** UPPERCASE keywords, **no indentation**, **dense colon-packed multi-statement
   lines**, deeply nested one-line `IF…THEN…ELSE IF`. Spaces around `=`/operators/commas;
   fractions written `.1` not `0.1`.
5. **Structure:** **GOSUB/RETURN** for everything inside a module; `SUB`/`FUNCTION` only for
   whole top-level phases wired by `DECLARE SUB` + `COMMON SHARED`; `DIM SHARED` only where a
   same-file SUB needs globals; `CONST` only for hardware values.
6. **Comments:** **almost none.** `'` not `REM`. At most a 1–3 line header and occasional
   dashed section banners. Authentic typos. Strip everything else.
7. **Graphics/sound:** `SCREEN 13`; `DEF SEG = VARSEG(arr(1))` + `BLOAD file$, VARPTR(arr(1))`
   + `PUT …, PSET`; `GET/PUT … XOR` cursors; `SOUND`/`PLAY` with `32676` as silence (Dark-
   Visions era), `SHELL "midplay"` only later; `DRAW` macro strings with `VARPTR$()`.
8. **I/O:** external `.pic`/`.pac`/`.dv`/`.dat` files via `OPEN`/`INPUT #`/`WRITE #`; `CLOSE`
   religiously; `TIMER` busy-wait for delays; `ON ERROR GOTO`+`RESUME`; `INKEY$` loops.

---

## WHAT OUR DECOMPILE DOES DIFFERENTLY

Concrete deltas between `C:\Code\darkv-bas\Decompile\Recon\GAME.BAS` (the Spring "lossy"
decompile) and the Kreuzer house style above. Each is a refactor task.

### A. Machine-generated variable names (the biggest tell)
The decompile names every variable `<TypeLetter><SourceLineNumber>`:
`L36$`, `I272`, `R32`, `I300()`, `L448$`, `I14`, `L22$`, `L339$()`, plus temp accumulators
`IR12`, `IR14`. Example (GAME.BAS 250–290, 320, 9230):
```basic
250 OPEN "door.pct " FOR INPUT AS #1
260 FOR I14 = 0 TO 125
280   INPUT #1, I15(I14), L16(I14), L17(I14), L18(I14)
320 PRINT "A Kreuzer Production"
9240 PUT (140, 130), L434, XOR
```
**House style would be:** `q$` for the room (their actual name — the decompile even comments
that `L36$` *is* the room id), `ob()` for `I300()` (the object/flag array), `a$` for the
`INKEY$` var `L22$`, `i`/`d` for loop counter `I14`, `mess$`/`df$()`/`ky$()`/`st()` for the
action arrays, single letters for the door/joe/wilb/golf sprite buffers. **Every `L###`/
`I###`/`R##`/`S####` must be renamed** to the terse lowercase Kreuzer vocabulary. The `IR12`/
`IR14` scratch temporaries should disappear entirely (they only exist to hold expanded
boolean sub-expressions — see C).

### B. Uniform line numbers on EVERY line, in strict +10 increments
The decompile numbers **every physical line** `110, 120, 130 … 9200, 9210 …` monotonically.
Real Kreuzer code numbers *sparingly and non-monotonically*, and most lines are **unnumbered
under named labels**. The refactor should:
- delete the vast majority of line numbers,
- introduce lowercase named labels for the major routines (the decompile's comments already
  identify them: "cursor display routine", "room3 door routine", "intro routine", "Wilbur
  death animation", "completion-percent"), matching DARKV2's `cursor:`/`click:`/`action:`/
  `message:`/`points:`/`ender:`/`winner:` set,
- keep only the handful of bare numbers that are real local jump targets.

### C. Decompiler-expanded boolean / control flow
Spring rewrote the Kreuzers' compact conditionals into verbose, fully-parenthesized,
goto-threaded forms:
```basic
2840 IR14 = ((L36$ = "window") OR (L36$ = "room3"))
2850 IF ((L36$ = "safe") OR (IR14)) = 0 THEN GOTO 2870
2860 PRINT "storage hall."
```
and the direction calc as eight identical `IF ((I442 > I440) AND …) = 0 THEN GOTO …` lines
(9740–9890). Native style collapses these to one colon-packed line, e.g.
`IF q$ = "window" OR q$ = "room3" OR q$ = "safe" THEN PRINT "storage hall."` and the
`= 0 THEN GOTO` double-negatives back into positive `IF … THEN <action>` (often with `ELSE`).
The `IRnn` temp vars vanish in the process.

### D. Dense `'PASS2-RECON:` reconstruction comments (must be stripped)
The file is saturated with multi-line reconstruction notes that have **no place in native
code** — they're 5–10× the comment density the Kreuzers ever used and describe the
*reconstruction process*, not the game:
```basic
14 ' PASS2-RECON: DEFINT I,L,R,X removed - it BACKFIRED on this float-heavy code...
280 ... 'PASS2-RECON: de-strided L16/L17/L18 (were at IR12=I14*2 - same Spring stride...)
9220 RETURN 'PASS2-RECON-AUTO: lost RETURN. Nothing jumps to 9220...
```
Plus `REM error 17 (2 )`, `REM PASS2-RECON: bogus GET removed`, `110 REM COM() statements in
this programme`. **All of these get deleted.** The end state should have DARKV2-level
comment density: a tiny header and maybe a few dashed banners, nothing else.

### E. `REM` instead of `'`
The decompile uses `REM` in many spots (`110 REM …`, `220`-area `REM error 17`,
`REM PASS2-RECON …`). The Kreuzers use the apostrophe `'` exclusively; convert any surviving
comment to `'`.

### F. Over-explicit `DIM SHARED … AS SINGLE/INTEGER` + giant `COMMON SHARED` blocks
Because Spring promoted every variable to module scope, the file front-loads ~20 lines of
`COMMON SHARED L10, I14, L22$, …` and dozens of `DIM SHARED Lnnn(…) AS …`. Native single-
module code (DARKV2) has **no `COMMON SHARED`/`DIM SHARED` at all** — module-level vars are
just global. After renaming, most of this block should collapse to ordinary terse `DIM`s
(`DIM ob(200)`, `DIM mess$(40), ky$(40), bs(40), …`) with no `SHARED`, mirroring DARKV2
lines 11–21. (Keep `AS INTEGER` only on the genuine GET/PUT sprite buffers, which is itself
authentic.)

### G. Logic split into `SUB`s purely to dodge the 64 KB limit
The decompile extracted `InitVars`, `DeathMusic`, `PctComplete`, `InvGrid`, `DoorOpen`,
`NotesSub`, `S15540`, `Snd5220…` into `SUB`s "to keep module-level code under QB's 64KB
code-segment limit," converting their `RETURN`s to `EXIT SUB`. The Kreuzers kept this content
as **inline GOSUB routines** (DARKV2's `points:`, `music:`, `sounds:`, `savegame:` are all
module-level `GOSUB`s ending in `RETURN`). Where the 64 KB ceiling genuinely forces a split,
fine — but the *naming* must change (`Snd5220` → a real label/name; `DeathMusic`/`PctComplete`
are actually acceptable-flavored names, `S15540`/`S16760`/`Snd5410` are not), and prefer
GOSUB/`RETURN` over `SUB`/`EXIT SUB` wherever it fits. The decompiler's `CALL S16760` /
`DECLARE SUB S15540 ()` machine names are tells.

### H. Lost external DATA / init values hard-coded with explanations
Spring lost the original `DATA`/file-loaded constants (sound frequencies, clock thresholds,
the `POKE 1047,32` address) and the recon re-injected them in `SUB InitVars` with provenance
comments:
```basic
1578 L87 = 50: L88 = 500: L95 = 100: ... 'SOUND freqs (DATA lost)
1580 L355 = 1047   'POKE target ADDRESS ...
```
In native form these would have terse real names and live near their use (e.g. the Kreuzers
just write `POKE 1047, 32` inline, as DreamGiver/StickFighter do: `DEF SEG = 0: POKE 1047,
32`). Fold these back to inline literals / terse-named vars without the archaeology notes.

### I. Cosmetic mismatches
- **Indentation:** the decompile indents `FOR`/`IF` bodies two spaces (`270   IR12 = …`,
  `10580   SOUND 32676, 1`). Native code is flush-left. Remove the indentation.
- **`PRINT ""`** for blank lines (13620 `PRINT ""`) — the Kreuzers do the same, so this one is
  fine.
- **Spacing/`.1` fractions/keyword case** in the decompile already match the house style
  (uppercase keywords, `.3`/`.1` fractions) — those need no change. The work is names, line
  numbers, comments, the SHARED/SUB scaffolding, and collapsing expanded conditionals.

### Priority order for the refactor
1. **Rename all `L###`/`I###`/`R##`/`S####`/`IRnn` → terse lowercase Kreuzer names**
   (start from the decompile's own annotations: `L36$`→`q$`, `I300()`→`ob()`,
   `L22$`→`a$`, `I14`→`i`/`d`, the action arrays → `mess$/ky$/bs/cs/st/df$`).
2. **Delete the `'PASS2-RECON:` / `REM` comment layer** down to DARKV2 density.
3. **Strip line numbers**, introduce lowercase named labels for the major routines, keep only
   real local jump-number targets.
4. **Collapse the expanded `= 0 THEN GOTO` / parenthesized-OR conditionals** back into compact
   colon-packed `IF…THEN…ELSE` lines; drop the `IRnn` temps.
5. **Dissolve the `COMMON SHARED`/`DIM SHARED` wall** into plain terse `DIM`s; un-extract the
   64 KB-driven `SUB`s back to GOSUB routines where size permits, renaming any that must stay.
6. **Remove 2-space body indentation; fold recovered constants inline.**

Target the look of **DARKV2.BAS / RORIG.BAS**, explicitly **not** RUNNER.BAS (modern rewrite)
or point.bas (third-party).
