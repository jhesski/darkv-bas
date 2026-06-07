DECLARE SUB initCursors ()
DECLARE SUB inter ()
DECLARE SUB ship ()
DECLARE SUB animateWalkFromSide ()
DECLARE SUB AnimateWalkFromTop ()
DECLARE SUB intro ()
DECLARE SUB logo ()
DECLARE SUB getMachineSpeed ()
DECLARE SUB INT86OLD (intnum AS INTEGER, inarray() AS INTEGER, outarray() AS INTEGER)


DEFINT A-E, I
CONST BOUSE = 51 'Mouse initialization value'
CONST ACTION_LOOK = 1
CONST ACTION_INSPECT = 2
CONST ACTION_GET = 3
CONST ACTION_USE = 4
CONST AVI_WALK_TOP = 1, AVI_WALK_SIDE = 2, AVI_NO_WALK = 0
CONST TRUE = -1, FALSE = 0
DIM inary(7) AS INTEGER, outary(7) AS INTEGER
CONST ax = 0, bx = 1, cx = 2, dx = 3, bp = 4, si = 5, di = 6, FL = 7
gef = 32300
DIM SHARED c(1 TO gef)
DIM SHARED r, shPaletteFilename$, shMachineSpeed, shShowGuyAnimation$, shErrorMessage$
DIM d(1 TO 5000)
DIM scene.interactionMap$(50)
DIM SHARED pl(260)  AS LONG

DIM SHARED curImg(200)
DIM SHARED curLook(200)
DIM SHARED curInspect(200)
DIM SHARED curGet(200)
DIM SHARED curUse(200)
DIM scene.text$(50): DIM scene.interactionType$(50): DIM scene.itemId(50)
DIM cs(50): DIM st(50): DIM scene.interactionsMap$(50)
DIM itemList(100): itemList(0) = 1

RANDOMIZE TIMER
SCREEN 13
tl = 0
shMachineSpeed = 0
qi = 0

CLOSE
OPEN "speed.dat" FOR INPUT AS #1
INPUT #1, shMachineSpeed, shShowGuyAnimation$
CLOSE

IF shMachineSpeed = 0 OR UCASE$(LTRIM$(COMMAND$)) = "-RETEST" THEN
  getMachineSpeed
  CLOSE
  OPEN "speed.dat" FOR OUTPUT AS #1
  WRITE #1, shMachineSpeed, shShowGuyAnimation$
  CLOSE
END IF

IF shMachineSpeed > .15 AND shShowGuyAnimation$ = "" THEN logo
LOCATE 2, 1: PRINT "Intro y/n"

'--------------Input Y/N for show intro'
51 'wait for input'
  userKeyInput$ = INKEY$: IF userKeyInput$ = "" THEN 51
  IF userKeyInput$ = "y" THEN intro
  
  initCursors
  sceneToLoad$ = "1bed"
  activeCursor = ACTION_LOOK
  
  IF MID$(sceneToLoad$, 1, 1) = "1" THEN
    shPaletteFilename$ = "house2.pal"
  ELSE
    shPaletteFilename$ = "ship2.pal"
  END IF

  sceneToLoad$ = MID$(sceneToLoad$, 2, 8)
  
  SCREEN 13
  COLOR 50
  GOSUB LoadPalette

UpdateScene:
  IF sceneToLoad$ = "ship1" AND currScene$ = "out2" THEN inter: GOSUB 15
  IF sceneToLoad$ = "earth" THEN ship
  'GET (2, 2)-(56, 66), c
  GET (2, 10)-(310, 199), c
  DEF SEG = VARSEG(c(1))
  BLOAD sceneToLoad$ + ".pic", VARPTR(c(1))
  DEF SEG = 0
  CLS
  SHELL "midplay /q /r " + sceneToLoad$ + ".mid"
  GOSUB LoadSceneInteractionFile
  PUT (c(1), c(2)), c(3), PSET 'places picture in certain postion'
  
  characterAnimation = AVI_NO_WALK
  ' update newly loaded scene
  SELECT CASE sceneToLoad$
    CASE "bed"
      GET (119, 46)-(171, 71), c                        'Get cord image
      LINE (118, 46)-(172, 71), 0, BF                   'Cover image with black
      IF itemList(4) <> 1 THEN PUT (231, 153), c, PSET  'If user does not have cord then place image
      LINE (0, 182)-(319, 199), 0, BF                   'Cover jank with black
      r = 1
      characterAnimation = AVI_WALK_TOP
    CASE "fom2"
      GET (175, 50)-(182, 63), c
      LINE (175, 50)-(182, 63), 0, BF
      GET (160, 50)-(174, 68), d
      LINE (160, 50)-(174, 68), 0, BF
    CASE "ship1"
      IF itemList(28) = 0 THEN GOSUB 23
    CASE "hall"
      IF currScene$ = "bed" THEN
        r = 2
        characterAnimation = AVI_WALK_TOP
      ELSEIF currScene$ = "office" THEN
        r = 4
        characterAnimation = AVI_WALK_SIDE
      ELSEIF currScene$ = "kich" THEN
        r = 5
        characterAnimation = AVI_WALK_SIDE
      END IF
      LINE (16, 194)-(290, 199), 0, BF 'Cover jank with black
    CASE "ship4"
      r = 17
      characterAnimation = AVI_WALK_TOP
    CASE "office"
      IF currScene$ = "hall" THEN
        r = 3
        characterAnimation = AVI_WALK_SIDE
      ELSE
        r = 19
        characterAnimation = AVI_WALK_TOP
      END IF
      LINE (42, 196)-(269, 199), 0, BF 'Cover jank with black
    CASE "kich"
      IF currScene$ = "hall" THEN
        r = 6
        characterAnimation = AVI_WALK_SIDE
      END IF
      LINE (9, 183)-(310, 199), 0, BF 'Cover jank with black
    CASE "baser"
      IF currScene$ = "kich" THEN r = 7: characterAnimation = AVI_WALK_TOP
    CASE "kich"
      IF currScene$ = "baser" THEN r = 8: characterAnimation = AVI_WALK_SIDE
    CASE "out1"
      IF currScene$ = "baser" THEN r = 9: characterAnimation = AVI_WALK_SIDE
    CASE "baser"
      IF currScene$ = "out1" THEN r = 10: characterAnimation = AVI_WALK_TOP
    CASE "out1"
      IF currScene$ = "out2" THEN r = 11: characterAnimation = AVI_WALK_TOP
    CASE "out2"
      IF currScene$ = "out1" THEN r = 12: characterAnimation = AVI_WALK_TOP
    CASE "ship1"
      r = 13
      characterAnimation = AVI_WALK_SIDE
    CASE "ship2", "after"
      IF currScene$ = "ship1" THEN r = 14: characterAnimation = AVI_WALK_SIDE
    CASE "ship2", "after"
      IF currScene$ = "ship3" THEN r = 15: characterAnimation = AVI_WALK_SIDE
    CASE "ship2", "after"
      IF currScene$ = "ship4" THEN r = 16: characterAnimation = AVI_WALK_TOP
  END SELECT

  IF characterAnimation = AVI_WALK_TOP THEN
    AnimateWalkFromTop
  ELSEIF characterAnimation = AVI_WALK_SIDE THEN
    animateWalkFromSide
  END IF
  prevScene$ = currScene$: currScene$ = sceneToLoad$
  sceneToLoad$ = "": x = 1: y = 1

UpdateCursorLocation:
  PUT (x, y), curImg, XOR

InputLoop:
  userKeyInput$ = INKEY$
  IF userKeyInput$ = "q" THEN END

  IF book$ = "1" THEN
    IF userKeyInput$ = "" THEN
      LOCATE 1, 1
      PRINT "Press a key...";
      LINE (14, 194)-(310, 199), 0, BF
      LINE (147, 192)-(310, 193), 0, BF
      GOTO InputLoop
    ELSE
      sceneToLoad$ = "office"
      book$ = ""
      GOTO UpdateScene
    END IF
  END IF
  
  IF userKeyInput$ = " " OR buttons = 2 THEN GOSUB UpdateCursorType
  GOSUB Mouse
  
  tim = TIMER
  ' Keep mouse in bounds'
  IF x > 310 THEN x = 310
  IF y > 194 THEN y = 194
  IF x < 5 THEN x = 5
  IF y < 25 THEN y = 25

  PUT (x, y), curImg, XOR
  userClicked = userKeyInput$ = CHR$(13) OR buttons = 1
  IF activeCursor = ACTION_LOOK THEN GOSUB CursorLoc2SceneInteractionMap
  IF userClicked THEN fm$ = "%": GOSUB CursorLoc2SceneInteractionMap

  IF sceneToLoad$ <> "" THEN GOTO UpdateScene
  IF userKeyInput$ = "l" THEN GOSUB LoadGame: GOTO UpdateScene
  IF userKeyInput$ = "a" THEN r = 16: AnimateWalkFromTop
  IF userKeyInput$ = "s" THEN GOSUB SaveGame
  IF userKeyInput$ = "n" THEN GOSUB ListInventory
  IF userKeyInput$ = "i" THEN GOSUB PrintItemList
  IF userKeyInput$ = "g" THEN GOSUB ToggleShowAnimation
  IF currScene$ = "out1" THEN
    FOR i = 15 TO 18
      PALETTE i, RND * 60 + 1
    NEXT i
  END IF

24 IF TIMER - tim < .01 THEN 24
  GOTO UpdateCursorLocation

ToggleShowAnimation:
  IF shShowGuyAnimation$ = "" THEN shShowGuyAnimation$ = "n" ELSE shShowGuyAnimation$ = ""
  CLOSE : OPEN "speed.dat" FOR OUTPUT AS #1
  WRITE #1, shMachineSpeed, shShowGuyAnimation$
  CLOSE
RETURN

ListInventory:
  itemText$ = ""
  los = 0
  FOR i = so + 1 TO 50
    IF i > 49 THEN
      i = 0
      los = los + 1
      IF los = 2 THEN
        CLOSE
        RETURN
      END IF
    END IF
    IF itemList(i) = 1 THEN GOSUB GetItemText
    IF itemText$ <> "" THEN GOSUB clearText
  NEXT i

clearText:
  IF currScene$ <> "out1" THEN LOCATE 1, 1: PRINT SPACE$(119)
  IF currScene$ = "out1" THEN LOCATE 1, 1: PRINT SPACE$(81)
  so = i
  LOCATE 1, 1: PRINT RIGHT$(STRING$(2, "0") + LTRIM$(STR$(i)), 2); " "; itemText$
1337 userKeyInput$ = INKEY$: IF userKeyInput$ = "" AND itemText$ <> "" THEN 1337
  itemText$ = ""
RETURN

GetItemText:
  CLOSE : OPEN "items.dat" FOR INPUT AS #1
  FOR pi = 1 TO 22
    INPUT #1, oop, itemText$
    IF oop <> i THEN itemText$ = ""
    IF itemText$ <> "" THEN pi = 23 'If text is found then exit loop
  NEXT pi
  CLOSE
RETURN

PrintItemList:
  FOR iii = 1 TO 5
    LOCATE 1, 1: PRINT SPACE$(118)
    LOCATE 1, 1: PRINT RIGHT$(STRING$(2, "0") + LTRIM$(STR$(iii)), 2); " "; itemList(iii)
    SOUND 0, 10
  NEXT iii
RETURN

15
  IF itemList(24) = 1 THEN itemList(24) = 2: RETURN
  CLS
  LOCATE 1, 1: PRINT "You never wake up again."
  PRINT "Hit a key"

35 userKeyInput$ = INKEY$: IF userKeyInput$ = "" THEN 35 ' loop until key is pressed
RUN

22
  FOR i = 1 TO 40
    IF itemList(i) = 3 THEN itemList(i) = 1
  NEXT i
RETURN

23
  PALETTE 18, 60 * 65536 + (20) * 256 + (20)
  FOR i = 1 TO 40
    IF itemList(i) = 1 THEN itemList(i) = 3
  NEXT i
RETURN

25
  FOR ui = 60 TO 10 STEP -2
    PALETTE 18, ui * 65536 + (ui \ 3) * 256 + (ui \ 3)
    tim = TIMER
    DO: LOOP UNTIL TIMER - tim > 0
  NEXT ui
RETURN

'Load Palette'
LoadPalette:
  OPEN shPaletteFilename$ FOR INPUT AS #1
  FOR i = 1 TO 255 STEP 1
  INPUT #1, pl(i)
  NEXT i
  PALETTE USING pl(0)
  CLOSE
RETURN

UpdateCursorType:
  userKeyInput$ = INKEY$: userKeyInput$ = INKEY$     'clears user input
  activeCursor = activeCursor + 1: IF activeCursor > 4 THEN activeCursor = 1
  SELECT CASE activeCursor
    CASE ACTION_LOOK
      LOCATE 5, 31: PRINT "   Look"
      FOR curi = 0 TO 200
        curImg(curi) = curLook(curi)
      NEXT curi
    CASE ACTION_INSPECT
      LOCATE 5, 31: PRINT "Inspect"
      FOR curi = 0 TO 200
        curImg(curi) = curInspect(curi)
      NEXT curi
    CASE ACTION_GET
      LOCATE 5, 31: PRINT "    Get"
      FOR curi = 0 TO 200
        curImg(curi) = curGet(curi)
      NEXT curi
    CASE ACTION_USE
      LOCATE 5, 31: PRINT "    Use"
      FOR curi = 0 TO 200
        curImg(curi) = curUse(curi)
      NEXT curi
  END SELECT
RETURN

'------------Interperts specials into a known language--------------'
CursorLoc2SceneInteractionMap:
  scenceMap.currentActionKey$ = MID$(scene.interactionMap$(y \ 4 + 1), x \ 4 + 1, 1)
  IF scenceMap.currentActionKey$ = fm$ THEN RETURN

  ' Clear text area'
  IF currScene$ <> "out1" THEN
    LOCATE 1, 1: PRINT SPACE$(80)
  ELSE
    LOCATE 1, 1: PRINT SPACE$(70)
  END IF

  IF scenceMap.currentActionKey$ = " " THEN fm$ = "": RETURN
  
  FOR i = 1 TO 35
    IF LEFT$(scene.interactionsMap$(i), 1) = scenceMap.currentActionKey$ THEN GOSUB 30
  NEXT i
RETURN

30
  thisInteractionIdx = i
  
  SELECT CASE activeCursor
    CASE ACTION_LOOK
      IF scene.interactionType$(thisInteractionIdx) <> "l" THEN RETURN
    CASE ACTION_GET
      IF LEFT$(scene.interactionType$(thisInteractionIdx), 1) <> "g" AND RIGHT$(scene.interactionType$(thisInteractionIdx), 1) <> "g" THEN RETURN
    CASE ACTION_INSPECT
      IF LEFT$(scene.interactionType$(thisInteractionIdx), 1) <> "a" AND RIGHT$(scene.interactionType$(thisInteractionIdx), 1) <> "a" THEN RETURN
    CASE ACTION_USE
      IF LEFT$(scene.interactionType$(thisInteractionIdx), 1) <> "u" AND RIGHT$(scene.interactionType$(thisInteractionIdx), 1) <> "u" THEN
        RETURN
      ELSEIF scene.itemId(thisInteractionIdx) <> so THEN
        RETURN
      ELSE
        itemList(scene.itemId(thisInteractionIdx)) = 2
      END IF
  END SELECT

  IF itemList(scene.itemId(thisInteractionIdx)) <> 1 THEN RETURN
  IF itemList(cs(thisInteractionIdx)) = 0 OR cs(thisInteractionIdx) = 0 THEN PRINT "";  ELSE RETURN
  
  IF thisInteractionIdx > 0 AND thisInteractionIdx < 35 THEN
    fm$ = scenceMap.currentActionKey$
    LOCATE 1, 1
    PRINT scene.text$(thisInteractionIdx)
  ELSE
    fm$ = " "
  END IF
  
  IF st(thisInteractionIdx) = 39 THEN
    PUT (112, 54), d, PSET
    PUT (x, y), curImg, XOR
  END IF
  
  IF st(thisInteractionIdx) = 38 THEN
    PUT (143, 54), c, PSET
    PUT (x, y), curImg, XOR
    tim = TIMER: DO: LOOP UNTIL TIMER - tim > 1
  END IF

  IF itemList(st(thisInteractionIdx)) <> 1 AND MID$(scene.interactionsMap$(i), 2, 1) <> "p" THEN
    SHELL "midplay /q /r getob": GOSUB ResumeSceneMusic
  END IF
  
  IF st(thisInteractionIdx) = 4 AND itemList(st(thisInteractionIdx)) <> 1 THEN
    itemList(st(thisInteractionIdx)) = 1
    currScene$ = "hall"
    sceneToLoad$ = "bed"
    itemList(15) = 1
    GOTO UpdateScene
  END IF
  
  itemList(st(thisInteractionIdx)) = 1
  
  IF st(thisInteractionIdx) = 28 THEN GOSUB 25

  IF MID$(scene.interactionsMap$(i), 3, 1) <> "" THEN
    sceneToLoad$ = MID$(scene.interactionsMap$(i), 2, 8)
    IF sceneToLoad$ = "end" THEN ship
  ELSE
    IF MID$(scene.interactionsMap$(i), 2, 1) = "b" THEN book$ = "1": sceneToLoad$ = "book"
  END IF
  IF MID$(scene.interactionsMap$(i), 2, 1) = "j" THEN GOSUB 22 'Seems to never be used.
RETURN

ResumeSceneMusic:
  tim = TIMER
21 IF TIMER - tim < 1.5 THEN 21
  SHELL "midplay /q /r " + currScene$ + ".mid"
RETURN

LoadSceneInteractionFile: ' -------------Loads screens push/open/use/look------------------'
  ON ERROR GOTO 800
  CLOSE
  
  IF sceneToLoad$ = "ship2" THEN
    OPEN "after.dat" FOR INPUT AS 1
  ELSE
    OPEN sceneToLoad$ + ".dat" FOR INPUT AS 1
  END IF

  INPUT #1, fit ' NOT USED
  FOR i = 1 TO 5
    INPUT #1, qa(i), qb(i), x(i), y(i) ' NOT USED
  NEXT i

  INPUT #1, gen$, da$(1), da$(2), da$(3), da$(4), da$(5), da$(6) ' NOT USED
  
  FOR i = 1 TO 50
    INPUT #1, scene.interactionMap$(i)
  NEXT i
  
  ' 1 - scene.text$:            example: "You snatch the trap-door key from your dresser.",
  ' 2 - scene.interactionType$: example: "g"; "l" | "g" | "a" | "u" other than "l" g, a, u can be at the start of end,
  ' 3 - scene.itemId:           example: 13; This is the id of the item in inventory,
  ' 4 - cs:                     example: 3,
  ' 5 - st:                     example: 3,
  ' 6 - scene.interactionsMap$: example: "h" first char is sceneMapId, if string length is > 2 then action includes scene to load.
  FOR i = 1 TO 39
    INPUT #1, scene.text$(i), scene.interactionType$(i), scene.itemId(i), cs(i), st(i), scene.interactionsMap$(i)
  NEXT i
  CLOSE
  ON ERROR GOTO 0
RETURN

80
  LOCATE 1, 1: PRINT "NO SAVED GAME IS UNDER THAT NUMBER.                   "
  GOTO UpdateCursorLocation

7 RETURN 'Infinate loop


800 'Error Handler
  'ERR = 3: RETURN without GOSUB'
  'ERR = 7: Out of memory'
  'ERR = 53: File not found'
  'ERR = 62: input past end of file'

  LOCATE 1, 1: PRINT ERR

  IF ERR = 3 AND ERL = 7 THEN
    RESUME 80
  END IF

  'IF ERR = 53 THEN 7
  RESUME 7

802
  PRINT ERR, ERL

SaveGame:
  LOCATE 1, 1
  PRINT "(SAVE)What number (1-9) 10 none             "
  LOCATE 2, 1: INPUT l
  IF l = 10 THEN RETURN
  IF l < 1 OR l > 9 THEN BEEP: GOTO SaveGame
  CLOSE : OPEN "sav" + CHR$(l + 97) FOR OUTPUT AS #1
  FOR i = 1 TO 50
    WRITE #1, itemList(i)
  NEXT i
  WRITE #1, currScene$, prevScene$
  CLOSE
RETURN

LoadGame:
  LOCATE 1, 1
  PRINT "(LOAD)What number (1-9) 10 none            "
  LOCATE 2, 1: INPUT l
  IF l = 10 THEN RETURN
  IF l < 1 OR l > 9 THEN BEEP: GOTO LoadGame
  CLOSE : OPEN "sav" + CHR$(l + 97) FOR INPUT AS #1
  FOR i = 1 TO 50
    INPUT #1, itemList(i)
  NEXT i
  INPUT #1, sceneToLoad$, currScene$
  CLOSE
  shPaletteFilename$ = "house2.pal"
  IF MID$(sceneToLoad$, 1, 2) = "sh" OR MID$(sceneToLoad$, 1, 2) = "af" OR MID$(sceneToLoad$, 1, 2) = "fo" THEN shPaletteFilename$ = "ship2.pal"
  CLOSE : GOSUB LoadPalette
RETURN

Mouse:
  inary(ax) = 3
  CALL INT86OLD(BOUSE, inary(), outary())
  x = outary(cx) / 2
  y = outary(dx)
  bbb = outary(bx)
  buttons = 0
  IF bbb = 1 AND blt = 1 THEN buttons = 1: blt = 0
  IF bbb = 2 AND blt = 1 THEN buttons = 2: blt = 0
  IF bbb = 0 THEN blt = 1
RETURN

SUB animateWalkFromSide ()
14
  x = 165: y = 145: g = 175: f = 167: j = 0: fh = 4: dg = 0: bob = 0
  IF shPaletteFilename$ = "ship2.pal" THEN cs = 180: cs = 33: cp = 32: cp = 204: ch = 175: ch = 24: cf = 120: cf = 150
  IF shPaletteFilename$ = "house2.pal" THEN cs = 180: cp = 32: ch = 175: cf = 120
  IF r = 3 THEN dg = 1: j = -18: x = 65: f = 67: y = y + 10: g = g + 10
  IF r = 6 THEN dg = 0: j = -18: x = 281: f = 282: y = y - 18: g = g - 18
  IF r = 4 THEN dg = 0: j = -25: x = 281: f = 282: y = y + 6: g = g + 6
  IF r = 5 THEN dg = 1: j = -25: x = 60: f = 62: y = y + 6: g = g + 6
  IF r = 8 THEN dg = 1: j = -18: x = 70: f = 70: y = y - 18: g = g - 18
  IF r = 9 THEN dg = 1: f = 70: x = 70: j = -32: g = g: y = y - 3
  IF r = 13 THEN dg = 0: j = -18: x = 281: f = 282: y = y + 2: g = g + 2
  IF r = 14 THEN dg = 1: j = -22: x = 65: f = 67: y = y + 25: g = g + 28
  IF r = 15 THEN dg = 0: j = -22: x = 271: f = 272: y = y + 25: g = g + 28
  IF r = 18 THEN dg = 1: j = -13: x = 30: f = 32: y = y + 20: g = g + 22
  IF shShowGuyAnimation$ = "" THEN GOTO 509
  x = 165: f = 166
509
  IF dg = 1 THEN lk = 1: pk = 0 ELSE pk = 1: lk = 0
  WINDOW SCREEN (1 + j * 3, 1 + j * 2)-(320 - j * 3, 200 - j * 2)
  vg = 0
510
  GET (x - 30, y - 36)-(x + 18, g + 10), c
  bob = bob + fh: IF bob > 7 THEN fh = -4 ELSE IF bob < -5 THEN fh = 4
  FOR i = 0 TO 3
    LINE (x - 13 + i, y - 17 + i)-(x - 18 + i + bob, y + 5), cs - i
    LINE (x - 13 - i, y - 17 + i)-(x - 16 - i + bob, y + 5), cs - i
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
520
  x = x - 5
  FOR i = 0 TO 5
    LINE (x + i - 6, y - 2)-(x + i - 4, y - 20 + i), cs - i
    LINE (x - i - 2, y - 2)-(x - i - 4, y - 20 + i), cs - i
  NEXT i
  x = x + 5
  LINE (x - 13, y)-(x - 4, y), 4
  LINE (x - 13, y - 1)-(x - 4, y - 1), 12
RETURN
521
  FOR i = 0 TO 3
    LINE (x - 6 + i, y - 17 + i)-(x - 3 + i - bob, y + 5), cs - 2 - i
    LINE (x - 6 - i, y - 17 + i)-(x - 4 - i - bob, y + 5), cs - 2 - i
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
515
  CIRCLE (x - 9, y - 25), 6, ch, , , 1.5
  PAINT (x - 9, y - 25), ch, ch
  FOR i = 0 TO 3
    CIRCLE (x - 9 + i, y - 25), 6, cf, 2.5, 4.5, 1.5
  NEXT i
  PSET (x - 12, y - 26), 0
  GOTO 505
505
  FOR pi = 1 TO 9000 * shMachineSpeed: NEXT pi: userKeyInput$ = "8"
  IF x >= 165 THEN IF r = 5 OR r = 8 OR r = 3 OR r = 9 OR r = 14 OR r = 18 THEN 511
  IF x <= 165 THEN IF r = 6 OR r = 4 OR r = 13 OR r = 15 THEN 511
  PUT (x - 30, y - 36), c, PSET
  IF dg = 1 THEN x = x + 4: f = f + 4 ELSE x = x - 4: f = f - 4
  IF vg = 0 THEN j = j + 0 ELSE j = j - 0
  WINDOW SCREEN (320 - j * 3, 1 + j * 2)-(j * 3, 200 - j * 2)
  IF j > 0 THEN vg = 1
  IF j < -120 OR x < 34 THEN WINDOW SCREEN (1, 1)-(320, 200): GOTO 511
  GOTO 510

511
  WINDOW SCREEN (1, 1)-(320, 200)
END SUB

SUB AnimateWalkFromTop ()
2
  x = 165: y = 145: g = 178: f = 167: j = -120: fh = 3: bob = 0
  IF shPaletteFilename$ = "ship2.pal" THEN cs = 180: cs = 33: cp = 32: cp = 204: ch = 175: ch = 26: cf = 120: cf = 150
  IF shPaletteFilename$ = "house2.pal" THEN cs = 180: cp = 32: ch = 175: cf = 120
  vg = 0
  IF r = 2 THEN vg = 1: j = 0: g = g + 5: y = y + 5: GOTO 310
  IF r = 17 THEN vg = 1: j = 0: x = x - 30: f = f - 30: g = g + 5: y = y + 5: GOTO 310
  IF r = 7 THEN vg = 1: j = 0: g = g - 3: y = y - 3: GOTO 310
  IF r = 10 THEN vg = 1: j = 0' GOTO 310'
  IF r = 11 THEN vg = 1: j = -10: g = g + 10: y = y + 10
  IF r = 12 THEN j = -140
  IF r = 16 THEN x = x + 20: f = f + 20: y = y + 5: g = g + 5: vg = 0: j = -100
  IF r = 18 THEN x = x - 1: f = f - 1: y = y + 25: g = g + 25: vg = 0: j = -50
  IF r = 19 THEN vg = 1: j = -30: y = y + 10: g = g + 10
  IF r = 18 THEN WINDOW SCREEN (1 + j * 3 + 175, 1 + j * 2)-(320 - j * 3 + 175, 200 - j * 2)
  IF shShowGuyAnimation$ = "" THEN GOTO 309
  IF r = 2 OR r = 12 OR r = 16 OR r = 17 THEN j = -30
  IF r = 1 THEN j = -16
  IF r = 7 OR r = 10 THEN j = -36
  IF r = 11 THEN j = -40
  IF r = 18 THEN 500
309
  IF r <> 18 THEN WINDOW SCREEN (1 + j * 3, 1 + j * 2)-(320 - j * 3, 200 - j * 2)
310
  GET (x - 22, y - 36)-(x + 11, g + 10), c
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
420
  x = x - 5
  FOR i = 0 TO 10
    LINE (x + i - 2, y - 2)-(x + i, y - 20 + i / 2), cs - i
    LINE (x - i + 2, y - 2)-(x - i, y - 20 + i / 2), cs - i
  NEXT i
  x = x + 5
  LINE (x - 13, y)-(x + 4, y), 4
  LINE (x - 13, y - 1)-(x + 4, y - 1), 12
RETURN
421
  FOR i = 0 TO 3
    LINE (x + 4 + i, y - 17 + i)-(x + 7 + i, y + 5 - bob / 1.5), cs - 2 - i
    LINE (x + 4 - i, y - 17 + i)-(x + 9 - i, y + 5 - bob / 1.5), cs - 2 - i
    LINE (x - 15 + i, y - 17 + i)-(x - 20 + i, y + 5 + bob / 1.5), cs - i
    LINE (x - 15 - i, y - 17 + i)-(x - 18 - i, y + 5 + bob / 1.5), cs - i
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
415
  CIRCLE (x - 5, y - 25), 6, cf, , , 1.5
  PAINT (x - 5, y - 25), cf, cf
  FOR i = 0 TO 3
    CIRCLE (x - 5, y - 25 - i), 6, ch, .5 - (i / 5), 2.5 + (i / 5), 1.5
  NEXT i
  PSET (x - 8, y - 26), 0: PSET (x - 2, y - 26), 0
  GOTO 405
405
  FOR gi = 1 TO 9000 * shMachineSpeed: NEXT gi: userKeyInput$ = "8"
  IF r <> 18 THEN IF vg = 0 THEN j = j + 3 ELSE j = j - 3
  IF r = 18 THEN IF vg = 0 THEN j = j + 2 ELSE j = j - 2
  IF j > -16 THEN IF r = 1 THEN GOTO 500
  IF r = 2 OR r = 17 THEN IF j < -30 THEN 500
  IF r = 7 OR r = 10 THEN IF j < -36 THEN 500
  IF r = 11 AND j < -40 THEN 500
  IF r = 12 AND j > -30 THEN 500
  IF r = 16 THEN IF j > -30 THEN 500
  IF r = 19 THEN 500
  PUT (x - 22, y - 36), c, PSET
  IF r = 18 AND j > -15 THEN 500
  IF r = 18 THEN WINDOW SCREEN (1 + j * 3 + 175, 1 + j * 2)-(320 - j * 3 + 175, 200 - j * 2)
  IF r <> 18 THEN WINDOW SCREEN (1 + j * 3, 1 + j * 2)-(320 - j * 3, 200 - j * 2)
  IF j > 0 THEN vg = 1
  'IF j < -120 THEN WINDOW SCREEN (1, 1)-(320, 200): GOTO 500'
  GOTO 310
500
  WINDOW SCREEN (1, 1)-(320, 200)
END SUB

SUB getMachineSpeed ()
  tim = TIMER
  FOR qi = 1 TO 30000: NEXT qi
  tl = INT((TIMER - tim) * 1000) / 100
  IF (tl = 0) THEN
    tim = TIMER
    FOR qi = 1 TO 30000: NEXT qi
    tl = INT((TIMER - tim) * 1000) / 100
  END IF
  shMachineSpeed = 2.2 / tl
  IF shMachineSpeed > 10 THEN shMachineSpeed = 5.5
END SUB

SUB initCursors ()


  GOSUB clearCursor
  DRAW "bm1,2c42r1u1nr3d2nr3u1nr4r1c0r1" '1 look
  GET (1, 1)-(7, 6), curLook
  GET (1, 1)-(7, 6), curImg

  GOSUB clearCursor
  DRAW "bm1,2c42r2l1u1d5" '3 GET
  GET (1, 1)-(7, 6), curGet

  GOSUB clearCursor
  DRAW "bm1,2c42bd2r2d1nl2u2r2nf1l2g1f1r1" '2 inspect
  GET (1, 1)-(7, 6), curInspect

  GOSUB clearCursor
  DRAW "bm2,2c42nh1nr6d1nr2d1r1" '1 use
  GET (1, 1)-(7, 6), curUse

  GOSUB clearCursor
  EXIT SUB
clearCursor:
  LINE (1, 1)-(7, 6), 0, BF
RETURN

END SUB

SUB inter ()
  j = 800: v = 800
  WINDOW SCREEN (x - j * 3, y - j * 3 + v)-(x + j * 3, y + j * 3 + v)
189
  FOR i = 1 TO 40 STEP 5
    LINE (x + i, y)-(x + i + 4, y + 20), 186 - i / 3, BF
  NEXT i
  FOR i = 1 TO 40 STEP 5
    LINE (x - i, y)-(x - i + 4, y + 20), 186 - i / 3, BF
  NEXT i
  FOR i = -30 TO 30 STEP 10
    LINE (x + i + 4, y + 9)-(x + i, y + 11), 67 + RND * 20, BF
  NEXT i
  IF j > 0 THEN j = j - 3: v = v - 2.8
  FOR pi = 1 TO 800 * shMachineSpeed: NEXT pi
  LINE (x - 50, y + 20)-(x + 50, y - 10), 0, BF
  IF j < 4 THEN 190
  WINDOW SCREEN (x - j * 3, y - j * 3 + v)-(x + j * 3, y + j * 3 + v)
  GOTO 189
190
  WINDOW SCREEN (1, 1)-(320, 200)
  sceneToLoad$ = "jump": shPaletteFilename$ = "ship2.pal"
  CLOSE : OPEN shPaletteFilename$ FOR INPUT AS #1
  FOR i = 1 TO 255 STEP 1
    INPUT #1, pl(i)
  NEXT i
  PALETTE USING pl(0)
  CLOSE
  GET (2, 10)-(310, 199), c
  DEF SEG = VARSEG(c(1))
  BLOAD sceneToLoad$ + ".pic", VARPTR(c(1))
  CLS
  SHELL "midplay /q /r " + sceneToLoad$ + ".mid"
  PUT (c(1), c(2)), c(3), PSET 'places picture in certain postion'
  tim = TIMER
  DO: LOOP UNTIL TIMER - tim > 5
  sceneToLoad$ = "fom": DEF SEG = VARSEG(c(1))
  BLOAD sceneToLoad$ + ".pic", VARPTR(c(1))
  CLS
  SHELL "midplay /q /r ufo.mid"
  PUT (c(1), c(2)), c(3), PSET 'places picture in certain postion'
  tim = TIMER
  DO: LOOP UNTIL TIMER - tim > 6
  sceneToLoad$ = "rat"
  GET (2, 10)-(310, 199), c
  DEF SEG = VARSEG(c(1))
  BLOAD sceneToLoad$ + ".pic", VARPTR(c(1))
  CLS
  SHELL "midplay /q /r " + sceneToLoad$ + ".mid"
  PUT (c(1), c(2)), c(3), PSET 'places picture in certain postion'
  tim = TIMER
  DO: LOOP UNTIL TIMER - tim > 5.2
  sceneToLoad$ = "ship1"
  CLS
  LOCATE 1, 1: PRINT "After the horrifying images of your     intermittent awaking, you settle into a deep slumber. "
  tim = TIMER
  DO: LOOP UNTIL TIMER - tim > 6
END SUB

SUB intro ()
  SCREEN 13
  x = 52: y = 150: p = 4
  SHELL "midplay /q /r ufo.mid"
  shPaletteFilename$ = "house2.pal"
  OPEN shPaletteFilename$ FOR INPUT AS #1
  FOR i = 1 TO 255 STEP 1
    INPUT #1, pl(i)
  NEXT i
  PALETTE USING pl(0)
  sceneToLoad$ = "car"
  COLOR 74
  CLS
  LOCATE 1, 1: PRINT "You are driving to your cabin late in   the night. You feel yourself beginning  to drift off into sleep."
  tim = TIMER
  DO: LOOP UNTIL TIMER - tim > 5
  CLS
  GET (2, 10)-(310, 199), c
  DEF SEG = VARSEG(c(1))
  BLOAD sceneToLoad$ + ".pic", VARPTR(c(1))
  PUT (1, 1), c, PSET'places picture in certain postion'
  l = x - 48 - p: IF l < 1 THEN l = 1
  GET (l, y - 15 - p / 2)-(x + 100, y + 28), c
  FOR x = 15 TO 644 STEP 6
    FOR i = 1 TO 15
      LINE (x, y + i)-(x + 100 - p * 3, y + i * .75 - p / 2), 71 - i
    NEXT i
    
    CIRCLE (x + 70 - p * 1.8, y + 10 - p / 1.5), 9, 171, , , p / 6 + .5
    CIRCLE (x + 14 - p / 2, y + 13), 9, 171, , , p / 6 + .5
    PAINT (x + 70 - p * 1.8, y + 10 - p / 1.5), 173, 171
    PAINT (x + 14 - p / 2, y + 13), 172, 171
    
    FOR i = 1 TO 15
      LINE (x, y + i)-(x - 8 - p * 2, y + i * .75 - (20 - p) / 2), 71 - i
    NEXT i
    
    FOR i = 1 TO 10
      LINE (x, y)-(x + 70 - p * 1.8, y - 10 - p / 1.5 + i), 30 + i * 2
      LINE -(x + 100 - p * 3, y - p / 2), 30 + i * 2
    NEXT i
    
    i = 1
    LINE (x, y)-(x + 70 - p * 1.8, y - 10 - p / 1.5 + i), 71 + i
    LINE (x + 70 - p * 1.8, y - p / 1.5 + i)-(x + 70 - p * 1.8, y - 10 - p / 1.5 + i)
    LINE -(x + 100 - p * 3, y - p / 2), 71 + i
    
    FOR i = 1 TO 22
      LINE (x - (i) * p / 10 - 4, y - i / 3 + p / 5)-(x + 70 - p * 1.8 - i, y - 10 - p / 1.5), 60 + i
    NEXT i
    
    FOR pi = 1 TO 5000 * shMachineSpeed: NEXT pi
    PUT (l, y - 15 - p / 2), c, PSET
    l = x - 30 - p: IF l < 1 THEN l = 1
    y = y - .8 - p / 42: IF p < 22 THEN p = p + .3
    WINDOW SCREEN (1 + (y - 149) * 4, 1 + (y - 149) * 4)-(320 - (y - 149) * 4, 200 - (y - 149) * 4)
    GET (l, y - 15 - p / 2)-(x + 100, y + 28), c
  NEXT x
  
  WINDOW SCREEN (0, 0)-(320, 200)
  
  FOR i = 1 TO 200
    LINE (1, i)-(320, i), 20 + i / 6
    FOR p = 1 TO 3000 * shMachineSpeed: NEXT p
  NEXT i
  
  sceneToLoad$ = "1truck"
  IF MID$(sceneToLoad$, 1, 1) = "1" THEN shPaletteFilename$ = "house2.pal" ELSE shPaletteFilename$ = "ship2.pal"
  sceneToLoad$ = MID$(sceneToLoad$, 2, 8)
  CLS
  GET (2, 10)-(310, 199), c
  DEF SEG = VARSEG(c(1))
  BLOAD sceneToLoad$ + ".pic", VARPTR(c(1))
  CLS
  PUT (1, 1), c, PSET
  sceneToLoad$ = "ufo"
  tim = TIMER
26
  FOR p = 0 TO 5 STEP 1
    FOR d = 1 TO 6 STEP 1
      y = d * 10 + p * 10
      IF y > 60 THEN y = y - 60
      PALETTE 25 - d, y
      FOR pl = 1 TO 1000: NEXT pl
    NEXT d
    
    gbg = gbg + 1: IF gbg > 60 THEN gbg = 60
    PALETTE 18, gbg
  NEXT p
  IF TIMER - tim < 8 THEN GOTO 26
11 CLS : COLOR 74: PALETTE 74, 1
  GET (2, 10)-(310, 199), c
  DEF SEG = VARSEG(c(1))
  BLOAD "house.pic", VARPTR(c(1))
  PUT (c(1), c(2)), c(3)
  LOCATE 1, 1: PRINT "When you awake and shake away the       cobwebs you find that you"
               PRINT "have mysteriously appeared at your      summer cabin."
               PRINT "You wrestle with your brain to try to   remember the drive"
               PRINT "but you can recall nothing. Nothing     that is except for a"
               PRINT "bright light. How did you get here?     Who would put you here ..."
               PRINT "and why? (Hit a key)"
  FOR l = 1 TO 60
    PALETTE 74, l
    FOR pd = 1 TO 1000 * shMachineSpeed: NEXT pd
  NEXT l
  tim = TIMER
10
  DO: LOOP UNTIL TIMER - tim > 1
12
  userKeyInput$ = INKEY$: IF userKeyInput$ = "" THEN 12
  CLOSE

END SUB

SUB logo ()
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
451
  LINE (x(1), y(1))-(x(2), y(2)), 50, BF
  FOR i = 100 TO 1 STEP -1
    LINE (x(1) - i, y(1) - i)-(x(2) + i, y(2) + i), 51 - (i / 2), B
  NEXT i
  IF userKeyInput$ = "8" THEN 455 ELSE 456
455
  x(1) = x(1) - 1.7:  x(2) = x(2) + 1.7: y(1) = y(1) - 1.3: y(2) = y(2) + 1.3: GOTO 457
456
  x(1) = x(1) + 1.7:  x(2) = x(2) - 1.7: y(1) = y(1) + 1.3: y(2) = y(2) - 1.3
457
  IF x(2) < -100 THEN 453
  GOTO 451
453
  FOR gi = 1 TO 27 STEP .8
    mn = mn + .8
    DRAW "s=" + VARPTR$(mn)
    DRAW "bm160,100": gf = mn * 13.3
    DRAW "ta=" + VARPTR$(gf)
    DRAW "bl25bd4c2u8d4c7ne4f4br3c10u8r4d4c14l4f4br4u8c17nr4d4nr3c20d4r4br4c24nu8r4nu8c27br8l4u2e4c30u2nl4br4nr4c33d4nr3d4c37r4br4u8c40r4d4l4f4"
452
    FOR g = 1 TO 1000 * shMachineSpeed: NEXT g
    IF gi < 26.5 THEN CLS
  NEXT gi
  COLOR 35: LOCATE 20, 15: PRINT "Industries"
  FOR i = 400 TO 50 STEP -9
    jg = jg + .1
    i = i + jg
  NEXT i
  FOR i = 1 TO 60
    PALETTE 0, i
    FOR pd = 1 TO 300 * shMachineSpeed: NEXT pd
  NEXT i
  FOR i = 60 TO 1 STEP -1
    PALETTE 0, i
    FOR pd = 1 TO 300 * shMachineSpeed: NEXT pd
  NEXT i
  CLS
END SUB

SUB ship ()
  SCREEN 13: CLS
  cp = 3: hg = 1
  SHELL "midplay /q /r earth.mid"
  CLOSE
  OPEN "ship2.pal" FOR INPUT AS #1
  FOR i = 1 TO 255 STEP 1
    INPUT #1, pl(i)
  NEXT i
  CLOSE
  PALETTE USING pl(0)
  LOCATE 1, 1: PRINT "   "
  sceneToLoad$ = "earth"
  GET (2, 2)-(56, 66), c
  DEF SEG = VARSEG(c(1))
781
  BLOAD sceneToLoad$ + ".pic", VARPTR(c(1))
  c = 0
882
  PUT (2, 10), c, PSET 'places picture in certain postion'
  x = 100: y = 100
1 GET (x - 10, y - 30)-(x + 83, y + 23), c
  FOR i = 1 TO 12
    LINE (x + i / 2, y + i)-(x + 70 - i / 2, y + i), i + 18
  NEXT i
  IF cp = 6 THEN 126
  FOR i = 7 TO 1 STEP -1
    CIRCLE (x + 15, y + 6), i, 45 - i
    CIRCLE (x + 55, y + 6), i, 45 - i
  NEXT i
  GOTO 127
126
  FOR i = 7 TO 1 STEP -1
    CIRCLE (x + 30, y + 6), i, 45 - i
    CIRCLE (x + 60, y + 6), i, 45 - i
  NEXT i
127
  IF cp = 6 THEN 125
  FOR i = 1 TO 35
    LINE (x + 70 - i, y - i / 1.5)-(x + i, y - i / 1.5), (i / 3) + 18
  NEXT i
  GOTO 124
125
  FOR i = 1 TO 35
    LINE (x + 70 - i * 2, y - i / 1.5)-(x, y - i / 1.5), (i / 3) + 18
  NEXT i
124
  FOR i = 1 TO 14
    LINE (x + 50 - i, y - 9 + i / 4)-(x + 35, y - 18), 72 + i
    LINE (x + 20 + i, y - 9 + i / 4)-(x + 35, y - 18), 72 + i
  NEXT i
  IF j < -750 THEN hg = 3
  FOR pi = 1 TO 7000 * shMachineSpeed: NEXT pi
    PUT (x - 10, y - 30), c, PSET
    j = j - 4 * hg
    y = y - 4 * hg: x = x - cp * hg
    IF j < -240 THEN cp = 6
    WINDOW SCREEN (j * 3, j * 2)-(320 - j * 3, 200 - j * 2)
    'LINE (x - 10, y - 30)-(x + 83, y + 23), 0, BF'
    IF j < -3300 THEN 129
  GOTO 1
129
    CLS : COLOR 50
    CLOSE : OPEN "house2.pal" FOR INPUT AS #1
    FOR i = 1 TO 255 STEP 1
      INPUT #1, pl(i)
    NEXT i
    PALETTE USING pl(0)
    CLOSE
    GET (2, 10)-(310, 199), c
    DEF SEG = VARSEG(c(1))
    BLOAD "house.pic", VARPTR(c(1))
    WINDOW SCREEN (1, 1)-(320, 200)
    PUT (c(1), c(2)), c(3), PSET
    PRINT "CONCEPT BY                    "
    PRINT "ROB & JON KREUZER & JOSH HESS "
    GOSUB 130
    PRINT "GAME DESIGN BY                "
    PRINT "ROB & JON KREUZER             "
    GOSUB 130
    PRINT "GRAPHICS BY                   "
    PRINT "JOSH HESS                     "
    GOSUB 130
    PRINT "PROGRAMMING BY                "
    PRINT "JON KREUZER                   "
    GOSUB 130
    PRINT "MIDI-MUSIC BY                 "
    PRINT "THE UNKNOWN PIRATES           "
    GOSUB 130
    PRINT "3D OBJECTS BY                 "
    PRINT "JON KREUZER                   "
    GOSUB 130
    PRINT "TEXT BY                       "
    PRINT "JON KREUZER                   "
    GOSUB 130
    tim = TIMER
    DO: LOOP UNTIL TIMER - tim > 2
    SCREEN 0: WIDTH 80
    PRINT "THANK YOU FOR PLAYING"
END
130
    FOR i = 1 TO 60
      PALETTE 50, i
      FOR pd = 1 TO 500 * shMachineSpeed: NEXT pd
    NEXT i
    tim = TIMER
    DO: LOOP UNTIL TIMER - tim > 2
    FOR i = 60 TO 1 STEP -1
      PALETTE 50, i
      FOR pd = 1 TO 500 * shMachineSpeed: NEXT pd
    NEXT i: LOCATE 1, 1
RETURN
END SUB

