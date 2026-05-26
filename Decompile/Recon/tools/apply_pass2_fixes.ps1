# Applies all manual Pass 2 fixes to GAME.BAS in a repeatable way.
# Run AFTER pass1_mechanical.ps1 to apply all the manual reconstructions.
param(
  [string]$BasPath = "C:\Code\darkv-bas\Decompile\Recon\GAME.BAS"
)

$content = [System.IO.File]::ReadAllText($BasPath)

function Replace-Once($from, $to, $description) {
  $script:content = [regex]::Replace($script:content, [regex]::Escape($from), { $to }, 1)
  "  $description"
}

"Applying Pass 2 fixes..."

# 1. DIM block (after COMMON SHARED, before line 110)
$dimBlock = @"

' PASS2-RECON: DIM block for arrays. Spring kept COMMON SHARED but dropped DIM.
' Sizes generous; the parallel action arrays (I386..L395) match Dream-Giver's 40-entry pattern.
DIM SHARED L33(300)
DIM SHARED L278(100)
DIM SHARED L301(400)
DIM SHARED L403(100)
DIM SHARED L415(100)
DIM SHARED L417(100)
DIM SHARED L419(100)
DIM SHARED L421(100)
DIM SHARED L423(100)
DIM SHARED L425(100)
DIM SHARED L427(100)
DIM SHARED L429(100)
DIM SHARED L455(100)
DIM SHARED L457(100)
DIM SHARED L459(100)
DIM SHARED L461(100)

' PASS2-RECON: DIMs for COMMON SHARED arrays missing DIM in original decompile.
DIM I15(150)
DIM L16(300)
DIM L17(300)
DIM L18(300)
DIM I192(500)
DIM I300(100)
DIM L302(100)
DIM L311(500)
DIM L312(150)
DIM L314(500)
DIM L315`$(150)
DIM I316(100)
DIM I318(100)
DIM L319(150)
DIM L322`$(150)
DIM L323`$(150)
DIM L339`$(100)
DIM I386(50)
DIM L387(50)
DIM L388(50)
DIM L389(50)
DIM L390(50)
DIM L391(50)
DIM L392(50)
DIM L393(50)
DIM L394(50)
DIM L395(50)
DIM I404(150)
DIM L405(300)
DIM I431(150)
DIM L432(300)
DIM L433(300)
DIM L434(300)
DIM L435(300)
DIM L436(300)
DIM L437(300)
DIM L438(300)
DIM L476`$(50)

' PASS2-RECON: SOUND-frequency var inits (DATA blocks lost). Values from symbol-table addresses.
L87 = 50
L88 = 500
L95 = 100
L113 = 200
L134 = 1000
L281 = 700
L143 = 60
L144 = 60
L145 = 59
L191 = 71

"@
Replace-Once "COMMON SHARED L623,L628,L629,L630,L631,L632,L633,L634`r`n110 Rem COM() statements in this programme" `
  "COMMON SHARED L623,L628,L629,L630,L631,L632,L633,L634`r`n$dimBlock`r`n110 Rem COM() statements in this programme" `
  "DIM block + var inits"

# 2. I107$ -> I107 (global rename - drop incorrect string suffix)
$beforeI107 = ([regex]::Matches($content, 'I107\$')).Count
$content = $content -replace 'I107\$', 'I107'
"  I107`$ -> I107 ($beforeI107 occurrences)"

# 3. Round -> CINT (global)
$beforeRound = ([regex]::Matches($content, '\bRound\(')).Count
$content = $content -replace '\bRound\(', 'CINT('
"  Round( -> CINT( ($beforeRound occurrences)"

# 4. Specific line replacements
Replace-Once "2280 SWAP TIMER,'Might be BEEP instead!" `
  "2280 BEEP 'PASS2-RECON: was SWAP TIMER" `
  "2280 SWAP TIMER -> BEEP"

Replace-Once "14120 GOTO ????'????" `
  "14120 'PASS2-RECON-HOLE: original instruction unknown" `
  "14120 GOTO ???? -> no-op"

Replace-Once "15290   GOTO ????'????" `
  "15290   GOTO 15320 'PASS2-RECON: exit outer FOR loop on keypress" `
  "15290 GOTO ???? -> GOTO 15320"

Replace-Once "16800 ON KEY(16) GOSUB S????'????" `
  "16800 REM PASS2-RECON: ON KEY(16) handler disabled (QB45 disallows in SUB)" `
  "16800 ON KEY disabled"

Replace-Once "16870 ON KEY(16) GOSUB S????'????" `
  "16870 REM PASS2-RECON: ON KEY(16) handler disabled" `
  "16870 ON KEY disabled"

Replace-Once "18210 ON KEY(16) GOSUB S????'????" `
  "18210 REM PASS2-RECON: ON KEY(16) handler disabled" `
  "18210 ON KEY disabled"

# 5. The Palette I375/I376/I377 fixes
Replace-Once "8010 Palette 1, 12104" "8010 Palette 1, I375 'PASS2-RECON: 12104 = I375 address" "8010 Palette I375"
Replace-Once "8020 Palette 2, 12106" "8020 Palette 2, I376 'PASS2-RECON" "8020 Palette I376"
Replace-Once "8030 Palette 3, 12108" "8030 Palette 3, I377 'PASS2-RECON" "8030 Palette I377"

# 6. READ -> INPUT (death.pac has 7 fields, INPUT reads first 3, READ -> INPUT reads remaining 4)
Replace-Once "7970   READ I316(I14), I318(IR14), L319(IR12), L323`$(IR12)" `
  "7970   Input #1, I316(I14), I318(IR14), L319(IR12), L323`$(IR12) 'PASS2-RECON: was READ - Spring lost DATA, file has these fields" `
  "7970 READ -> INPUT"

# 7. EOF guards on INPUT loops for variable-size .pct files
Replace-Once "8370 GET (1,8)-(9,18),L403`r`n8380 For I14 = 0 To 125`r`n8390   IR12 = (I14 * 2)" `
  "8370 GET (1,8)-(9,18),L403`r`n8380 For I14 = 0 To 125`r`n8385   IF EOF(1) THEN GoTo 8420 'PASS2-RECON: joew4 EOF`r`n8390   IR12 = (I14 * 2)" `
  "joew4 EOF guard"

Replace-Once "9660 Open `"joed.pct`" For Input As #1`r`n9670 For I14 = 0 To 125`r`n9680   IR12 = (I14 * 2)" `
  "9660 Open `"joed.pct`" For Input As #1`r`n9670 For I14 = 0 To 125`r`n9675   IF EOF(1) THEN GoTo 9710 'PASS2-RECON: joed EOF`r`n9680   IR12 = (I14 * 2)" `
  "joed EOF guard"

Replace-Once "9920 Open `"wilb.pct`" For Input As #1`r`n9930 For I14 = 0 To 125`r`n9940   Input #1, I404(I14)" `
  "9920 Open `"wilb.pct`" For Input As #1`r`n9930 For I14 = 0 To 125`r`n9935   IF EOF(1) THEN GoTo 9960 'PASS2-RECON: wilb EOF`r`n9940   Input #1, I404(I14)" `
  "wilb EOF guard"

Replace-Once "10150 Open `"golf.pct`" For Input As #1`r`n10160 For I14 = 0 To 125`r`n10170   IR12 = (I14 * 2)" `
  "10150 Open `"golf.pct`" For Input As #1`r`n10160 For I14 = 0 To 125`r`n10165   IF EOF(1) THEN GoTo 10200 'PASS2-RECON: golf EOF`r`n10170   IR12 = (I14 * 2)" `
  "golf EOF guard"

# 8. OBJECT.PAC load: replace error handler with EOF check
Replace-Once "12530 On Error GoTo 12570`r`n12540 For I14 = 1 To 50`r`n12550   Input #1, I24, L476`$(I24)`r`n12560 Next`r`n12570 LOCATE 1, 1`r`n12580 Close" `
  "12530 'PASS2-RECON: removed On Error handler`r`n12540 For I14 = 1 To 50`r`n12545   IF EOF(1) THEN GoTo 12580 'PASS2-RECON: EOF check`r`n12550   Input #1, I24, L476`$(I24)`r`n12560 Next`r`n12570 'PASS2-RECON`r`n12580 Close" `
  "OBJECT.PAC EOF check"

# 9. R28 placeholder GET (was broken GET with bad coords)
Replace-Once "16930 GET (20148,20148)-(20156,0),L629" `
  "16930 GET (0, 0)-(15, 15), R28 'PASS2-RECON: original GET had garbage coords; placeholder" `
  "R28 placeholder GET"

# 10. R76 = 50 init (lost by Spring)
Replace-Once "17070 GoTo 17140 '????" `
  "17070 R76 = 50 'PASS2-RECON: from Rem error 12 (50 ) hint" `
  "17070 R76 init"

# 11. RETURN at 17150 (sound subroutine end)
Replace-Once "17140 If R76 <= 200 Then GoTo 17080`r`n17150`r`nRem error 12 (1 )" `
  "17140 If R76 <= 200 Then GoTo 17080`r`n17150 RETURN 'PASS2-RECON: sound subroutine end`r`nRem error 12 (1 )" `
  "17150 RETURN"

# 12. RETURN at 12210 (STRIG setup end)
Replace-Once "12200 STRIG(6) ON`r`n12210`r`n12220 If L482`$ <> `"l`" Then GoTo 12250" `
  "12200 STRIG(6) ON`r`n12210 RETURN 'PASS2-RECON: STRIG setup end`r`n12220 If L482`$ <> `"l`" Then GoTo 12250" `
  "12210 RETURN"

# 13. L36$ = "joew2" default (before broken direction cascade)
Replace-Once "8240 Close`r`n8250 Palette 2, 1" `
  "8240 Close`r`n8245 IF L36`$ <> `"title`" AND L36`$ <> `"death`" AND L36`$ <> `"dindead`" THEN RETURN 'PASS2-RECON: skip joe-anim for normal rooms`r`n8250 Palette 2, 1" `
  "8245 skip joe-anim for normal rooms"
Replace-Once "8260 Palette 1, 8`r`n8270 If L22`$ <> `"1`" Then GoTo 8290" `
  "8260 Palette 1, 8`r`n8265 L36`$ = `"joew2`" 'PASS2-RECON: default joe sprite filename`r`n8270 If L22`$ <> `"1`" Then GoTo 8290" `
  "8265 L36`$ default"

# 13a. RETURN at 9560 - critical, breaks song-looping infinite loop
Replace-Once "9550 L275`$ = L22`$`r`n9560`r`n9570 GET (1,1)-(3,18),L421" `
  "9550 L275`$ = L22`$`r`n9560 RETURN 'PASS2-RECON: end of GOSUB 9230 cursor display - prevents fallthrough into 9570 intro routine`r`n9570 GET (1,1)-(3,18),L421" `
  "9560 RETURN (breaks song loop)"

# 13b. Skip broken joe-walking animation loop (R46/R64 corrupted by INPUT)
Replace-Once "Rem error 12 (150 )`r`n18410 GoTo 18620 '????" `
  "Rem error 12 (150 )`r`n18410 RETURN 'PASS2-RECON: return from GOSUB 18310/18200 instead of GoTo End Sub" `
  "18410 RETURN (intro flow)"

Replace-Once "17830 SOUND 32676, 1`r`nRem error 12 (0  ,0 )`r`n17840 GoTo 18020" `
  "17830 SOUND 32676, 1`r`nRem error 12 (0  ,0 )`r`n17840 GoTo 18640 'PASS2-RECON: skip palette fade + System, exit SUB cleanly" `
  "17840 GoTo 18640 (skip System exit)"

Replace-Once "17570 GOSUB 18310`r`nRem error 12 (0  ,0 )`r`n17580 GoTo 17780" `
  "17570 GOSUB 18310`r`nRem error 12 (0  ,0 )`r`n17580 REM PASS2-RECON: was 'GoTo 17780' skipping TALK+ENTER" `
  "17580 fall through (don't skip TALK/ENTER)"

Replace-Once "Rem error 12 (50 )`r`n17850 GoTo 17890 '????" `
  "Rem error 12 (50 )`r`n17850 R84 = 50 'PASS2-RECON: from Spring hint + loop context" `
  "17850 R84 = 50 init"

Replace-Once "17900 If R84 <= 250 Then GoTo 17860`r`n17910 If R88 <> 1 Then GoTo 17930" `
  "17900 If R84 <= 250 Then GoTo 17860`r`n17902 SOUND 32576, Int(Rnd * 9) 'PASS2-RECON: random silence between bursts`r`n17905 RETURN 'PASS2-RECON: end of sound subroutine`r`n17910 If R88 <> 1 Then GoTo 17930" `
  "17902 random silence + 17905 RETURN"

# SLEEP after ENTER scene BLOADs (so user can see the scene)
Replace-Once "17565 DEF SEG = &HB800: BLOAD `"enter.pic`", 0: DEF SEG 'PASS2-RECON: scene 3 Joe walks in`r`n17570 GOSUB 18310" `
  "17565 DEF SEG = &HB800: BLOAD `"enter.pic`", 0: DEF SEG 'PASS2-RECON: scene 3 Joe walks in`r`n17566 SLEEP 2 'PASS2-RECON: brief delay for visibility`r`n17570 GOSUB 18310" `
  "SLEEP 2 after ENTER (1st)"

Replace-Once "17765 DEF SEG = &HB800: BLOAD `"enter.pic`", 0: DEF SEG 'PASS2-RECON: scene 5 Joe walks up`r`n17770 DEF SEG 'PASS2-RECON: was Print 0" `
  "17765 DEF SEG = &HB800: BLOAD `"enter.pic`", 0: DEF SEG 'PASS2-RECON: scene 5 Joe walks up`r`n17766 SLEEP 2 'PASS2-RECON: brief delay for visibility`r`n17770 DEF SEG 'PASS2-RECON: was Print 0" `
  "SLEEP 2 after ENTER (2nd)"

# 13c. RETURN at 10130 (end of GOSUB 9570 intro routine) - prevents forced death cutscene
Replace-Once "10130 GoTo 6880" `
  "10130 RETURN 'PASS2-RECON: end of GOSUB 9570 - prevents forced death cutscene" `
  "10130 RETURN (end of intro)"

# 13d. Bypass L455-L461 animation routine (sprite arrays never initialized)
Replace-Once "10510 IR12 = (I449 = 0)`r`n10520 IR14 = ((L36`$ <> `"room3`") Or (I449 = 0))" `
  "10510 RETURN 'PASS2-RECON: bypass animation - L455-L461 sprites never initialized`r`n10515 IR12 = (I449 = 0)`r`n10520 IR14 = ((L36`$ <> `"room3`") Or (I449 = 0))" `
  "10510 RETURN (bypass broken anim)"

# 13e. RETURN at 11890 - early return when joystick is centered (preserves INKEY$ in L22$)
Replace-Once "11880 If ((L478 = 0#) And (I477 = 0)) = 0 Then GoTo 11900`r`n11890`r`n11900 If I477 >= 40 Then GoTo 11920" `
  "11880 If ((L478 = 0#) And (I477 = 0)) = 0 Then GoTo 11900`r`n11890 RETURN 'PASS2-RECON: joystick centered - preserve INKEY`$ in L22`$`r`n11900 If I477 >= 40 Then GoTo 11920" `
  "11890 RETURN (preserve keyboard input)"

# 13f. Gate room-load music to title scene only
Replace-Once "8060 Print 0`r`n8070 PLAY `"<d5f5g+5A+5d5f5G+5A+5e5g5a+5b5a5>c+5d5c+5`"" `
  "8060 Print 0`r`n8061 IF L36`$ <> `"title`" THEN GoTo 8130 'PASS2-RECON: gate music to title scene`r`n8070 PLAY `"<d5f5g+5A+5d5f5G+5A+5e5g5a+5b5a5>c+5d5c+5`"" `
  "Music gated to title scene"

# 14. L278 GET placeholder (sprite header init)
Replace-Once "9950 Next`r`n9960 PUT (110,128),L278,XOR" `
  "9950 Next`r`n9955 GET (0, 0)-(7, 7), L278 'PASS2-RECON: placeholder sprite header`r`n9960 PUT (110,128),L278,XOR" `
  "9955 L278 GET placeholder"

# 15. Error handler diagnostic (replace generic message with ERR/ERL display)
Replace-Once "2280 BEEP 'PASS2-RECON: was SWAP TIMER`r`n2290 Cls`r`n2300 LOCATE 5, 12`r`n2310 Print `"There has been`"`r`n2320 LOCATE 8, 15`r`n2330 Print `"an error!`"`r`n2340 LOCATE 15, 10`r`n2350 Print `"Program terminated!`"" `
  "2280 BEEP`r`n2290 SCREEN 0: WIDTH 80: Cls`r`n2300 LOCATE 5, 5: Print `"PASS2-RECON DIAGNOSTIC -- error handler triggered`"`r`n2310 LOCATE 7, 5: Print `"ERR  (code) =`"; ERR`r`n2320 LOCATE 8, 5: Print `"ERL  (line) =`"; ERL`r`n2330 LOCATE 10, 5: Print `"Common QB4.5 codes: 5=IllFnCall 6=Overflow 9=SubscriptOOR`"`r`n2335 LOCATE 11, 5: Print `"  11=DivByZero 13=TypeMismatch 53=FileNotFound 54=BadMode`"`r`n2336 LOCATE 12, 5: Print `"  55=FileOpen 57=DevIOErr 62=InputPastEOF 68=DeviceUnavail`"`r`n2340 LOCATE 14, 5: Print `"Press any key to exit...`"`r`n2345 L22`$ = INPUT`$(1)`r`n2350 Print `"Program terminated!`"" `
  "Error handler diagnostic"

[System.IO.File]::WriteAllText($BasPath, $content)
Replace-Once "8040 DEF SEG = -18432`r`n8050 KEY ON" `
  "8040 DEF SEG = -18432`r`n8045 BLOAD L36`$ + `".pic`", 0 'PASS2-RECON: load room .pic image`r`n8050 KEY ON" `
  "BLOAD room.pic at 8045"

# Intro scene 1: CARR.PIC BLOAD
Replace-Once "16910 Dim R64(130)`r`n16920 R68 = 133" `
  "16910 Dim R64(130)`r`n16915 DEF SEG = &HB800: BLOAD `"carr.pic`", 0: DEF SEG 'PASS2-RECON: load intro scene 1 image`r`n16920 R68 = 133" `
  "BLOAD carr.pic at 16915"

# Intro scene 2: HILL.PIC BLOAD (lightning scene)
Replace-Once "17180 If R76 <= 500 Then GoTo 17170`r`n17190 Palette 2, 11" `
  "17180 If R76 <= 500 Then GoTo 17170`r`n17185 DEF SEG = &HB800: BLOAD `"hill.pic`", 0: DEF SEG 'PASS2-RECON: load intro scene 2 (hill+lightning)`r`n17190 Palette 2, 11" `
  "BLOAD hill.pic at 17185"

# Intro scene 3: ENTER.PIC (Joe walks in)
Replace-Once "17560 Key OFF`r`n17570 GOSUB 18310" `
  "17560 Key OFF`r`n17565 DEF SEG = &HB800: BLOAD `"enter.pic`", 0: DEF SEG 'PASS2-RECON: scene 3 Joe walks in`r`n17570 GOSUB 18310" `
  "BLOAD enter.pic at 17565"

# Intro scene 4: TALK.PIC
Replace-Once "17620 Palette 3, 8`r`n17630 R80`$ = INKEY`$" `
  "17620 Palette 3, 8`r`n17625 DEF SEG = &HB800: BLOAD `"talk.pic`", 0: DEF SEG 'PASS2-RECON: scene 4 dialog`r`n17630 R80`$ = INKEY`$" `
  "BLOAD talk.pic at 17625"

# Intro scene 5: ENTER.PIC again
Replace-Once "17760 Palette 3, 6`r`n17770 DEF SEG 'PASS2-RECON: was Print 0" `
  "17760 Palette 3, 6`r`n17765 DEF SEG = &HB800: BLOAD `"enter.pic`", 0: DEF SEG 'PASS2-RECON: scene 5 Joe walks up`r`n17770 DEF SEG 'PASS2-RECON: was Print 0" `
  "BLOAD enter.pic (2nd) at 17765"

# Intro scene 6: TITLE.PIC
Replace-Once "17810 Key OFF`r`n17820 GOSUB 18200" `
  "17810 Key OFF`r`n17815 DEF SEG = &HB800: BLOAD `"title.pic`", 0: DEF SEG 'PASS2-RECON: scene 6 title screen`r`n17820 GOSUB 18200" `
  "BLOAD title.pic at 17815"

# Print 0 -> DEF SEG (Spring mis-decode; was reset of segment after BLOAD)
$beforePrint0 = ([regex]::Matches($content, '(?m)^\d+ Print 0$')).Count
$content = [regex]::Replace($content, '(\d+) Print 0(?=\r?\n)', '$1 DEF SEG ''PASS2-RECON: was Print 0 (Spring mis-decode of segment reset)')
"  Print 0 -> DEF SEG ($beforePrint0 occurrences)"

# KEY ON -> KEY OFF (KEY ON shows F-key labels at row 25 - unwanted in graphics mode)
$beforeKeyOn = ([regex]::Matches($content, '(?m)^\d+ KEY ON$')).Count
$content = [regex]::Replace($content, '(\d+) KEY ON(?=\r?\n)', '$1 KEY OFF ''PASS2-RECON: was KEY ON which displays F-key labels at row 25')
"  KEY ON -> KEY OFF ($beforeKeyOn occurrences)"

[System.IO.File]::WriteAllText($BasPath, $content)
"Done. File size: $((Get-Item $BasPath).Length) bytes"
