# Dark Visions (GAME.BAS) -> DARKV.BAS  variable / name mapping

> **Method note.** The transform was specified as a deterministic PowerShell pass, but the
> sandbox in this environment blocked every PowerShell/Bash command that read GAME.BAS or did
> regex text processing (simple shell ops were allowed; the transform-shaped ones were denied).
> The refactor was therefore applied via the editor, but it remains fully **deterministic and
> mapping-driven**: this table is the single source of truth (one old name -> one new name,
> word-boundary-safe, sigils preserved), and every fold below follows one fixed rule set.
> Verification (target-preservation, leftover-Spring scan, SUB/DECLARE/CALL integrity, line
> counts) was done with ripgrep over the output. See the report for results.

Driver table for the deterministic refactor of `GAME.BAS` into Kreuzer house style.
One old name -> exactly one new name, applied with word-boundary matching so `L16`
never touches `L160`, `I300` never touches `I3000`, etc. Sigils (`$`, `()`) preserved.

Target vocabulary mirrors `Other Code\DARKV2\DARKV.BAS` wherever the point-and-click
engine corresponds (room id, object/flag array, action-table fields, verb-hotspot grid,
cursor verb key, inventory, clock).

Legend for the "Kind" column:
- **code** = referenced in executable statements (mapped + kept).
- **sub** = referenced only inside a SUB body (mapped + kept as `DIM SHARED`).
- **array** = a DIM'd array (mapped + DIM kept; size preserved exactly).
- **dead-decl** = appears ONLY in the original `COMMON SHARED` list and the trailing
  symbol-table comment block; never read or written by any statement. These were
  no-op scalar declarations (no DIM, no assignment, no use). They are renamed for
  consistency but NOT re-declared in DARKV.BAS, matching DARKV2 (which has no
  `COMMON SHARED` at all). Removing an unused scalar declaration is behavior-neutral.

---

## 1. Core engine variables (DARKV2-matched)

| Spring | Kreuzer | Kind | Role / DARKV2 correspondence |
|--------|---------|------|------------------------------|
| `L36$` | `q$`   | code  | current room id. DARKV2 `q$`. (decompile comment confirms it.) |
| `I300()` | `ob()` | array | object/flag state array. DARKV2 `ob()`. |
| `L22$` | `a$`   | code  | INKEY$ / current key & verb. DARKV2 `a$`. |
| `I24`  | `b`    | code  | cursor screen X. DARKV2 cursor X is `B`. |
| `I25`  | `a`    | code  | cursor screen Y. DARKV2 cursor Y is `a`. |
| `L33`  | `d`    | array | the 4x4 cursor GET-sprite. DARKV2 cursor sprite is `d()` (`GET (1,1)-(4,4), d(0)`). |
| `L270$`| `done$`| code  | "y" = an action resolved this frame (skip-redraw flag). |
| `L274$`| `tt$`  | code  | transition pending flag ("y"). |
| `L275$`| `lf$`  | code  | last facing key (numpad dir of last frame). DARKV2 keeps a last-face char. |
| `L325$`| `sl$`  | code  | save-letter / death-cause state ("a","s","z"). |
| `L348$`| `dop$` | code  | door-opened latch ("d"). |
| `L482$`| `vk$`  | code  | STRIG verb latch (l/a/g/u). |
| `L448$`| `sy$`  | code  | syringe-used-in-time survive flag ("y"). |
| `L357$`| `tk$`  | code  | "y" once the 43-flag timer armed. |
| `L142$`| `m$`   | code  | scratch time string (set to "" at 2480; DARKV2 `mess$` family). |
| `L406$`| `sf$`  | code  | saved facing during walk-out (8420). |
| `L294` | `sn`   | code  | save/load slot number 1-4. DARKV2 `sn` (save number). |
| `I272` | `doc`  | code  | doctor-encounter state (0/1/2). |
| `I317` | `sel`  | code  | currently selected inventory item id. DARKV2 `selec`. |

## 2. Game clock

| Spring | Kreuzer | Kind | Role |
|--------|---------|------|------|
| `L144` | `cl`   | code | clock counter (minutes-units past 8:00). |
| `L143` | `cr`   | sub-typed SINGLE | clock rate (1/60). Kept SINGLE (truncates to 0 as int). |
| `L145` | `h9`   | code | hour-boundary threshold 8->9 (59). |
| `L149` | `h10`  | code | threshold 9->10 (119). |
| `L150` | `h11`  | code | threshold 10->11 (179). |
| `L146` | `hr`   | code | displayed hour. |
| `L147` | `mn`   | code | displayed minute. |
| `L466` | `t1`   | code | timed-death threshold. |
| `L467` | `t2`   | code | timed-death threshold. |
| `L468` | `t3`   | code | timed-death threshold. |
| `L299` | `pt`   | code-typed SINGLE | play-time accumulator (saved). |
| `L0`   | `t0`   | code-typed SINGLE | TIMER baseline. |
| `L137` | `ti`   | code-typed SINGLE | TIMER snapshot (death/intro pacing). |
| `L138` | `td`   | code-typed SINGLE | TIMER snapshot. |
| `I359` | `cv`   | code | CINT(cl) snapshot for the 43-flag window. |

## 3. Inventory grid (the LOCATE-based item grid)

| Spring | Kreuzer | Kind | Role |
|--------|---------|------|------|
| `I192()` | `gr()` | array | verb/inventory grid array, indexed `(L191*I188)+I186`. |
| `L191` | `gw`   | code | grid row stride (71). |
| `I186` | `gy`   | code | grid row cursor. |
| `I188` | `gx`   | code | grid column cursor. |
| `L476$()` | `dn$()` | array | per-item display name (loaded from object.pac). |
| `L302()` | `gp()` | array | previous grid-cell snapshot (InvGrid markers). |
| `I574` | `gm`   | sub  | grid-marker match flag (InvGrid). |
| `I566` | `pc`   | sub  | percent-complete item count (PctComplete). |
| `I567` | `pp2`  | sub  | percent value (PctComplete). |

## 4. Action / object table (per-room, loaded in S7860)

| Spring | Kreuzer | Kind | Role / DARKV2 field |
|--------|---------|------|---------------------|
| `L312()` | `ox()` | array | object hotspot X. |
| `L311()` | `oy()` | array | object hotspot Y. |
| `L314()` | `oi()` | array | object index redirect. |
| `L339$()`| `df$()`| array | action descriptor / destination room. DARKV2 `df$()`. |
| `L322$()`| `ms$()`| array | action message text. DARKV2 `mess$()`. |
| `L315$()`| `ky$()`| array | verb key for the action. DARKV2 `ky$()`. |
| `I316()` | `bs()` | array | required object (prereq). DARKV2 `bs()`. |
| `I318()` | `cs()` | array | blocker object. DARKV2 `cs()`. |
| `L319()` | `st()` | array | object id to set on success. DARKV2 `st()`. |
| `L323$()`| `tg$()`| array | trailing tag ("wX","fX","Xc"). |
| `I313` | `oh`   | code | saved hotspot row index in the action scan. |
| `I327` | `ohs`  | code | saved index across the walk-out. |
| `I340` | `pz`   | code | pause-loop counter (6800). |
| `L305`,`L306` | (dead-decl) | dead | never used. |

## 5. Sprite buffers (GET/PUT, AS INTEGER kept)

| Spring | Kreuzer | Kind | Role |
|--------|---------|------|------|
| `I15()` | `do1()` | array | door.pct frame 1. |
| `L16()` | `do2()` | array | door.pct frame 2. |
| `L17()` | `do3()` | array | door.pct frame 3. |
| `L18()` | `do4()` | array | door.pct frame 4. |
| `I404()`| `wa()`  | array | walk frame A / wilb / golf death sprite. |
| `L405()`| `wb()`  | array | walk frame B / death sprite. |
| `I431()`| `fd()`  | array | joed facing: down. |
| `L432()`| `fu()`  | array | facing: up. |
| `L433()`| `fr()`  | array | facing: right. |
| `L434()`| `fl()`  | array | facing: left. |
| `L435()`| `fdl()` | array | facing: down-left. |
| `L436()`| `fdr()` | array | facing: down-right. |
| `L437()`| `ful()` | array | facing: up-left. |
| `L438()`| `fur()` | array | facing: up-right. |
| `L278()`| `bk()`  | array | blank-corner backstop sprite (GET at 8055). Plain (SINGLE), size 100 -- matches original (NOT AS INTEGER). |
| `L403()`| `bk2()` | array | second backstop sprite. Plain (SINGLE), size 100 -- matches original. |

## 5b. dev object-data save arrays (I386..L395)

Used only in the unreachable dev tool at 8150-8230 (preceded by `8140 SYSTEM`, jumped
over by `8130 GOTO 8240`). Declared + written there only; preserved as executable code.

| Spring | Kreuzer | Kind | Role |
|--------|---------|------|------|
| `I386()`| `sv1()` | array | object-data column 1. |
| `L387()`| `sv2()` | array | column 2. |
| `L388()`| `sv3()` | array | column 3. |
| `L389()`| `sv4()` | array | column 4. |
| `L390()`| `sv5()` | array | column 5. |
| `L391()`| `sv6()` | array | column 6. |
| `L392()`| `sv7()` | array | column 7. |
| `L393()`| `sv8()` | array | column 8. |
| `L394()`| `sv9()` | array | column 9. |
| `L395()`| `sv10()`| array | column 10. |

## 6. SOUND-frequency constants (set in InitVars)

| Spring | Kreuzer | Kind | Value | Role |
|--------|---------|------|-------|------|
| `L87`  | `f1`   | sub  | 50    | sound freq. |
| `L88`  | `f2`   | sub  | 500   | sound freq. |
| `L95`  | `f3`   | sub  | 100   | sound freq (the workhorse click tone). |
| `L113` | `f4`   | sub  | 200   | sound freq. |
| `L134` | `f5`   | sub  | 1000  | sound freq. |
| `L279` | `f6`   | sub  | 300   | sound freq. |
| `L280` | `f7`   | sub  | 450   | sound freq. |
| `L281` | `f8`   | sub  | 700   | sound freq. |
| `L287` | `f9`   | sub  | 10000 | siren under-tone. |
| `L632` | `f10`  | sub  | 75    | thunder freq. |
| `L355` | `pk`   | code | 1047  | POKE target address (keyboard buffer). |
| `L439` | `jx`   | code | 150   | Joe X for facing calc. |
| `L441` | `jy`   | code | 156   | Joe Y for facing calc. |
| `I440` | `dx2`  | code | -     | dx = jx - b (facing delta X). |
| `I442` | `dy2`  | code | -     | dy = jy - a (facing delta Y). |

## 7. Safe-dial routine (S1540 / rotate subs)

| Spring | Kreuzer | Kind | Role |
|--------|---------|------|------|
| `I107` | `di`   | code | dial angle (0..350). |
| `L109` | (dead-decl) | dead | never used. |
| `L110` | `dn1`  | code | dial tumbler 1 latched. |
| `L111` | `dn2`  | code | dial tumbler 2 latched. |
| `L112` | `dn3`  | code | dial tumbler 3 latched. |

## 8. Misc code-referenced scalars

| Spring | Kreuzer | Kind | Role |
|--------|---------|------|------|
| `L370` | `co`   | code | foreground COLOR loaded from .pac. |
| `L371` | `co2`  | code | background COLOR. |
| `I375` | `pa1`  | code | PALETTE value 1. |
| `I376` | `pa2`  | code | PALETTE value 2. |
| `I377` | `pa3`  | code | PALETTE value 3. |
| `I408` | `j`    | code | inner SOUND-delay loop counter. |
| `I477` | `js0`  | code | STICK(0) horizontal read. |
| `L478` | `js1`  | code | STICK(1) vertical read. |
| `L301()` | `er1()` | array | ERASE'd on load (cleared inventory snapshot). |
| `L33(...)` | (see d) | array | cursor sprite (mapped to `d` above). |

## 9. Sound-SUB locals (Snd5220..Snd5520, NotesSub)

| Spring | Kreuzer | Kind | Role |
|--------|---------|------|------|
| `L282` | `sa`   | sub  | Snd5280 loop counter. |
| `L284` | `sb`   | sub  | Snd5330 loop counter. |
| `I286` | `sc`   | sub  | Snd5410/Snd5520 loop counter. |

## 10. End-credits SUB locals (S15540, R-names)

| Spring | Kreuzer | Kind | Role |
|--------|---------|------|------|
| `R28()`| `e0()` | array | end-credit GET/PUT car sprite. |
| `R30`  | `e1`   | sub  | car X loop. |
| `R31`  | `e2`   | sub  | wipe column loop (15650). |
| `R32`  | `e3`   | sub  | sound/loop counter. |
| `R36`  | `e4`   | sub  | palette index loop. |
| `R38`  | `e5`   | sub  | palette value. |
| `R42`  | `e6`   | sub  | outer palette loop. |
| `L579` | `mt`   | sub  | DeathMusic random tune select (0-3). |

## 11. Intro SUB locals (S16760, R-names)

| Spring | Kreuzer | Kind | Role |
|--------|---------|------|------|
| `R28()`| `ec()` | array | intro car GET/PUT sprite. |
| `R46()`| `r1()` | array | intro walk frame A. |
| `R64()`| `r2()` | array | intro walk frame B. |
| `R68`  | `cy`   | sub  | car Y (float). |
| `R76`  | `tc`   | sub  | tone/delay counter (heavily reused). |
| `R80$` | `k$`   | sub  | intro INKEY$. |
| `R84`  | `tw`   | sub  | warble tone (17850). |
| `R88`  | `tf`   | sub  | talk-done flag. |
| `R92`  | `tn`   | sub  | talk tone repeat count. |
| `R96`  | `pi`   | sub  | palette-fade index. |
| `R100$`| `w$`   | sub  | walk sprite filename. |
| `R104` | `wc`   | sub  | walk pass counter. |
| `IR70` | (fold) | temp | intro FOR counter -> reuse `i`-equivalent local `n`. |
| `IR72` | `cx`   | sub  | car X loop. |

## 12. The `IRnn` boolean temporaries (Tier B -- ELIMINATED)

These exist only to hold decompiler-expanded boolean sub-expressions. They are folded
back into direct nested `IF ... THEN ...` and DISAPPEAR. None survive in DARKV.BAS.

`IR12, IR14, IR16, IR18, IR20, IR22, IR24, IR26` -> removed by the conditional fold.

## 13. SUB names

The 64KB-driven SUB split is kept (justified deviation -- see report). Machine-named
SUBs are renamed to flavored names; `DeathMusic`/`PctComplete`/`InvGrid`/`DoorOpen`/
`NotesSub`/`InitVars` already read as house-acceptable and are kept verbatim.

| Spring SUB | Kept name | Role |
|------------|-----------|------|
| `S16760`   | `Intro`   | intro cutscene (car/hill/enter/talk/title). |
| `S15540`   | `Credits` | end credits (END1/END2). |
| `Snd5220`  | `Snd1`    | pick-up sound. |
| `Snd5280`  | `Snd2`    | walk sound. |
| `Snd5330`  | `Snd3`    | rising tone. |
| `Snd5410`  | `Snd4`    | up/down siren. |
| `Snd5520`  | `Snd5`    | warble + burst. |
| `InitVars` | `InitVars`| (kept) one-time const init. |
| `DeathMusic`| `DeathMusic`| (kept). |
| `PctComplete`| `PctComplete`| (kept). |
| `InvGrid`  | `InvGrid` | (kept). |
| `DoorOpen` | `DoorOpen`| (kept). |
| `NotesSub` | `NotesSub`| (kept). |

## 14. dead-decl names (renamed for consistency, NOT re-declared)

These appear ONLY in the original `COMMON SHARED` list + symbol-table comment, never in
any statement. Not re-declared in DARKV.BAS (no-op removal, matches DARKV2's no-COMMON
style). Listed here for completeness / audit:

`L10 L30 L39 L81 L105 I114 I139 I140 I141 L154 L156 I189 I193 I195 I197 I199 I201 I203 I205
I207 I209 I211 I213 I215 I217 I219 I221 I223 I225 I228 I230 I232 I234 I236 I238 I239 I241
I243 I245 I247 I250 I252 I255 L261 L263 L265 L276 L305 L306 L320 L321 L336 L338 L341 L343
L364 L367 L384 L407 L411 L444 L445 L452 L453 I449 I451 I471 I358 L109 L587 L586 L612 L613
L614 L615 L616 L617 L623 L628 L629 L630 L631 L633 L634`

(The five SINGLE-typed `DIM SHARED` clock/timer vars L0/L137/L138/L143/L299 ARE used and
are mapped above; only the genuinely-unreferenced COMMON-only scalars are dropped.)

## 15. dead unreferenced ARRAYS (DIM SHARED, dropped)

`L415 L417 L419 L421 L423 L425 L427 L429 L455 L457 L459 L461` are each
`DIM SHARED ...(100)` but are NEVER read or written by any statement. The recon's own
comments (lines 1038, 2079) document them as removed decompiler artifacts -- the bogus
GETs that targeted them were deleted and the door PUTs were redirected to the door.pct
frames (`do1..do4`). Because the whole declaration wall is being rebuilt in DARKV2 style
(delta F) and these allocate memory that is never touched, their DIMs are dropped (a
behavior-neutral removal of unreferenced allocations -- DARKV2 has no such dead arrays).
Renamed-for-audit would be pointless since no reference exists; they simply do not appear
in DARKV.BAS. Flagged here for transparency.

## 16. recon-added readable names (left AS-IS, not Spring artifacts)

`WALKMD` (walk-mode flag, lines 726+/901) is a recon-added flag, not a Spring machine
name, but `WALKMD` is conspicuously non-Kreuzer (no all-caps multi-letter gameplay vars in
DARKV2). Mapped to terse `wk`. The `XYZ` placeholder (a TIMER timeout threshold, DIM
SHARED, value 2, used across SUBs) is likewise mapped to `tmo` (timeout). Both are
DIM SHARED globals; mappings: `WALKMD -> wk`, `XYZ -> tmo`.
