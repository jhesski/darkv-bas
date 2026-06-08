# Dark Visions  DARKV.BAS -> darkv_v2.bas  line-number -> label mapping (Tier C)

> **Transform:** dense per-line numbering -> Kreuzer house style (SPARSE line numbers +
> lowercase descriptive LABELS). Only numbering/labels change; every executable statement is
> byte-identical. Riskiest part is re-pointing jumps, so the rule is **conservative**: give a
> descriptive label only to genuine *major routine entry points*; **keep the bare number** for
> every dense internal target (matches DARKV2, which mixes `load:`/`cursor:` labels with bare
> `5`/`6`/`7`/`98`/`144` numeric targets). Numbers that are never referenced are dropped
> entirely (the line becomes unnumbered).

## Method
1. Built the COMPLETE referenced-number set by grepping every `GOTO n`, `GOSUB n`,
   `ON STRIG(k) GOSUB n`, `ON ERROR GOTO n` in DARKV.BAS. (No `RESUME`, no bare `THEN n`,
   no `ON x GOTO a,b,c` lists exist in this file.)
2. Classified each referenced number as **label** (major routine entry) or **keep** (dense
   internal target).
3. On a labeled target line, the leading number is replaced by `labelname:` on its own line
   above the statement. Kept-number targets keep their number. Non-target lines lose the
   number entirely.
4. Every reference re-pointed: labeled targets -> `GOTO/GOSUB labelname`; kept targets keep
   the numeric ref.

## Labeled targets (major routine entries)

| Old # | Label | Role |
|-------|-------|------|
| 530   | `rules`       | "want instructions" full instruction text block (GOSUB 530) |
| 1540  | `dial`        | safe-dial routine (GOSUB 1540 from the df$="dial" action) |
| 1760  | `dialdown`    | dial rotate one notch (di-10) + tumbler logic (GOSUB 1760) |
| 2030  | `dialup`      | dial rotate one notch (di+10) + tumbler logic (GOSUB 2030) |
| 2280  | `errhand`     | ON ERROR handler / diagnostic (ON ERROR GOTO 2280) |
| 2440  | `inv`         | inventory screen (GOSUB/GOTO 2440) |
| 5650  | `reload`      | load/restore saved game (GOSUB/GOTO 5650) |
| 5830  | `save`        | save game (GOSUB/GOTO 5830) |
| 5970  | `quit`        | quit confirm (GOSUB 5970) |
| 6060  | `action`      | verb/action dispatch on hotspot (GOSUB 6060) |
| 6880  | `gotoroom`    | room transition + death/end dispatch (GOSUB/GOTO 6880) |
| 7050  | `mainloop`    | main game/cursor-move loop (GOTO 7050) |
| 7750  | `loadpac`     | load .pac colors for credits/title screen (GOSUB 7750) |
| 7860  | `loadroom`    | room loader: read .pac + .pic, palettes, hotspots (GOSUB/GOTO 7860) |
| 8130  | `walkout`     | walk-out-of-room animation dispatcher (GOSUB/GOTO 8130) |
| 9230  | `face`        | draw player facing sprite from lf$/a$ (GOSUB 9230) |
| 9570  | `joeface`     | load joed.pct + compute facing toward Joe (GOSUB 9570) |
| 9910  | `wilb`        | Wilbur death animation (GOSUB 9910) |
| 10140 | `golf`        | golf-swing death animation (GOSUB 10140) |
| 10780 | `gridwrap`    | inventory-grid column wrap helper (GOSUB 10780) |
| 10820 | `events`      | timed room-event checker (GOSUB 10820) |
| 11590 | `invcur`      | inventory cursor move + select (GOSUB 11590) |
| 11860 | `joy`         | joystick (STICK) read -> direction key (GOSUB 11860) |
| 12170 | `strigon`     | enable all STRIG buttons (GOSUB 12170) |
| 12220 | `vlook`       | STRIG(0) look verb latch |
| 12280 | `vact`        | STRIG(2) action verb latch |
| 12340 | `vget`        | STRIG(4) get verb latch |
| 12400 | `vuse`        | STRIG(6) use verb latch |
| 12460 | `strigoff`    | disable all STRIG buttons (GOSUB 12460) |
| 12510 | `loadnames`   | load object.pac display names (GOSUB 12510) |
| 12600 | `usecombine`  | use/combine inventory items (GOSUB 12600) |
| 13930 | `trigger`     | room-entry trigger / syringe-doctor setup (GOSUB 13930) |
| 14330 | `fight`       | doctor-fight reaction (GOSUB 14330) |
| 14580 | `death`       | death screen + restart (GOTO 14580) |
| 14940 | `lookmap`     | look at map/notes item dispatch (GOSUB 14940) |
| 15130 | `burn`        | house-burn timeout ending (GOTO 15130) |
| 14260 | `endgame`     | end-credits dispatch after win (GOTO 14260) |

> **Keyword-collision renames (after QB load test):** two labels were exact QB 4.5 reserved
> words and threw "Expected: label or line number" on load — renamed to keyword-free forms:
> `instr` -> `rules` (collides with INSTR), `restore` -> `reload` (collides with RESTORE).
> All 35 other labels were re-checked against the QB keyword/function list and are clear
> (names that merely *contain* a keyword, e.g. `endgame`/`strigon`/`walkout`, are read as
> whole identifiers by QB and are fine).

## Labeled targets inside SUBs

| Old # | Label | SUB | Role |
|-------|-------|-----|------|
| (none) | — | — | All SUB-internal targets are dense local jumps; kept as bare numbers. |

## Kept-number targets (dense internal jump targets, left numeric)

These are referenced but kept as bare numbers (local/internal control flow where a descriptive
name would be awkward; conservative choice to minimize re-pointing risk). Each keeps its line
number and every reference to it stays numeric:

Main module:
400, 430, 790, 820, 940, 1440, 1500, 1530, 1550, 1560, 1600, 1650, 1690,
1790, 1820, 1860, 1910, 1940, 1960, 1980, 2000, 2020,
2060, 2110, 2140, 2170, 2190, 2210, 2230, 2250, 2270,
2530, 2550, 2580, 2610,
3020, 3070, 3120, 3170, 3220, 3270, 3320, 3370, 3420, 3470, 3520, 3570, 3620, 3670, 3720, 3770, 3820, 3870,
3930, 3990, 4050, 4110, 4170, 4230, 4290, 4350, 4410, 4470, 4530, 4590, 4650, 4710, 4770, 4830,
4860, 4900, 4940, 4960, 4990, 5010, 5030, 5060, 5100, 5120, 5140, 5190,
5990, 6020,
6130, 6150, 6170, 6210, 6230, 6260, 6280, 6300, 6340, 6400, 6560, 6610, 6660, 6710, 6740,
7100, 7180, 7300, 7330, 7350, 7370, 7390, 7420, 7450, 7480, 7510, 7540, 7560, 7590, 7610, 7630, 7660,
8240, 8265, 8290, 8310, 8330, 8350, 8420, 8490, 8520, 8550, 8570, 8730, 8740, 8880, 8900,
9060, 9070, 9210, 9220, 9250, 9270, 9290, 9310, 9330, 9350, 9370, 9390, 9410, 9430, 9450, 9470, 9490, 9510, 9530, 9550,
9710, 9760, 9780, 9800, 9820, 9840, 9860, 9880, 9900, 9960,
10020, 10030, 10200, 10210, 10400, 10570, 10720, 10750, 10810, 10840,
11580, 11640, 11650, 11670, 11740, 11750, 11850, 11920, 11940, 11960, 11980,
12250, 12310, 12370, 12430, 12580, 12800, 12830,
14010, 14090, 14120, 14250, 14290, 14300, 14360, 14390, 14420, 14450, 14460, 14570,
14600, 14620, 14630, 14660, 14700,
14960, 15030, 15070, 15100, 15300, 15316, 15700, 15704, 16750, 18680,
13970

SUB Credits: 15370, 15400, 15430, 15440, 15460, 15490, 15510, 15592, 15640, 15650, 15660
SUB Intro: 17080, 17130, 17160, 17170, 17180, 17280, 17310, 17340, 17420, 17450, 17510,
17590, 17640, 17690, 17780, 17850, 17860, 17930, 17960, 18010, 18030, 18040, 18080,
18100, 18120, 18140, 18160, 18200, 18310, 18370, 18420, 18530, 18640
SUB NotesSub: 12900, 12920, 12980, 13000, 13020, 13040, 13060, 13070, 13240, 13270, 13280,
13360, 13390, 13400, 13490, 13710
SUB DeathMusic: (none labeled; 15370-15510 listed under Credits range belong here) —
  actual DeathMusic targets: 15370, 15400, 15430, 15440, 15460, 15490, 15510
SUB PctComplete: 14170, 14200, 14220
SUB InvGrid: 14770, 14810
SUB DoorOpen: 10570, 10720, 10750

> NOTE: 15370/15400/15430/15440/15460/15490/15510 are in SUB **DeathMusic**, not Credits
> (corrected here). Listed once above.

## Reference counts (verified against the final darkv_v2.bas)
- Distinct referenced line numbers (jump targets): 319
- Labeled (major routine entries): 37
- Kept as bare numbers: 282
- Numbers on non-target lines: removed (line left unnumbered)
- Numeric GOTO/GOSUB references in output: 325 (all resolve to a kept-number line)
- Label GOTO/GOSUB references in output: every one resolves to one of the 37 labels
- Statement-keyword parity vs DARKV.BAS: PRINT 216=216, PLAY 28=28, SOUND 110=110,
  IF 303=303, GOTO 332=332, GOSUB 87=87, FOR 89=89, NEXT 75=75, PUT 58=58, GET 5=5,
  LOCATE 72=72, PALETTE 47=47, DRAW 6=6, BLOAD 13=13, CALL 17=17, ELSE 4=4,
  CLOSE 14=14, OPEN 12=12, RETURN 49=49, WRITE+INPUT 32=32, SYSTEM+RUN+BEEP+POKE 15=15.
- Output line count 1757 = DARKV.BAS 1720 + 37 label-on-own-line entries.

## Corrections applied during verification (kept-number fixes)
Four target lines initially lost their number during transcription and were restored as
kept numbers (each is a referenced target where a descriptive name was not warranted):
6130 (action scan), 14600 (death-music wait loop), 17080 + 17280 (Intro tone loops).
One non-target number was over-kept and removed: 6320 (sequential `i = oh`, never a target).
One duplicate dead statement `GOTO 15440` (DeathMusic, source 15350+15360) was restored.

> DeathMusic targets are 15370/15400/15430/15440/15460/15490/15510 (NOT in Credits).
