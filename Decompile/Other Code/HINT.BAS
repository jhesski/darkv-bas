100 PRINT "That saved game does not exist."
RESUME 200
200 PRINT "Hit a key to continue"
201 a$ = INKEY$: IF a$ = "" THEN 201
END

SUB hint
CLS
SCREEN 0
WIDTH 80
DIM iv(15): DIM iv$(15): DIM tv(15): DIM tv$(15)
DIM ob(160)
ON ERROR GOTO 100
PRINT "What is the password(non caps please)"
INPUT q$
IF q$ <> "sesame road" THEN 300
1 PRINT "What is your saved game number? (1-4)"
INPUT sn: IF sn < 1 OR sn > 4 THEN 1
OPEN "save" + CHR$(96 + sn) + ".dat" FOR INPUT AS #1
INPUT #1, iv(1), iv(2), iv(3), iv(4), iv(5), iv(6), iv(7), iv(8), iv(9), iv(10), iv(11), iv(12), iv(13), iv(14), iv(15)
INPUT #1, iv$(1), iv$(2), iv$(3), iv$(4), iv$(5), iv$(6), iv$(7), iv$(8), iv$(9), iv$(10), iv$(11), iv$(12), iv$(13), iv$(14), iv$(15)
INPUT #1, tv(1), tv(2), tv(3), tv(4), tv(5), tv(6), tv(7), tv(8), tv$(1), tv$(2), tv$(3), tv$(4), tv$(5), tv$(6), tv$(7), tv$(8)
INPUT #1, tv(9), tv(10), tv(11), tv(12), tv$(9), tv$(10), tv$(11), tv$(12), tv$(13), tv$(14), tv$(15), tv(13), tv(14), tv(15)
INPUT #1, q$, d1, d2, d3, el$, sx
FOR i = 1 TO 155
INPUT #1, ob(i)
NEXT i
CLOSE
IF LEFT$(q$, 5) = "dream" THEN 2
IF LEFT$(q$, 4) = "drem" THEN 4
IF LEFT$(q$, 5) = "house" THEN 3
IF ob(70) = 0 THEN PRINT "Click get on yellow card at subway loading station": GOTO 300
IF ob(71) = 0 THEN PRINT "Click push on garbage at subway loading station": GOTO 300
IF ob(82) = 0 THEN PRINT "Use clearance card on green strip in subway tunnel": GOTO 300
IF ob(83) = 0 THEN PRINT "Use the name card on the green strip in the subway tunnel": GOTO 300
IF ob(61) = 0 THEN PRINT "Click get on person's stomach in subway alcove": GOTO 300
IF ob(62) = 0 THEN PRINT "Click get on person's ring in subway alcove": GOTO 300
IF ob(69) = 0 THEN PRINT "Click get on paper on left sidewalk at city by subway": GOTO 300
IF ob(84) = 0 THEN PRINT "Click look on door in front of Travel 1": GOTO 300
IF ob(85) = 0 THEN PRINT "Click push on garbage in front of Travel 1": GOTO 300
IF ob(86) = 0 THEN PRINT "Click get on garbage in front of Travel 1": GOTO 300
IF ob(63) = 0 THEN PRINT "Click get on stomach by doctor Paws": GOTO 300
IF ob(93) = 0 THEN PRINT "Click open on garbage by city tunnel": GOTO 300
IF ob(77) = 0 THEN PRINT "Click look on door at city outside of warehouse": GOTO 300
IF ob(54) = 0 THEN PRINT "Click get on screwdriver at warehouse entrance": GOTO 300
IF ob(55) = 0 THEN PRINT "Click push on intercom at warehouse entrance": GOTO 300
IF ob(56) = 0 THEN PRINT "Click get on mini-roms in warehouse office": GOTO 300
IF ob(57) = 0 THEN PRINT "Use mini-roms on disk drive in warehouse office": GOTO 300
IF ob(60) = 0 THEN PRINT "Click get on lower right desk drawer at warehouse office": GOTO 300
IF ob(73) = 0 THEN PRINT "Click push on lever at warehouse crane": GOTO 300
IF ob(74) = 0 THEN PRINT "Click push on lever again at warehouse crane": GOTO 300
IF ob(75) = 0 THEN PRINT "Click look on bottom of crate at warehouse crane": GOTO 300
IF ob(66) = 0 THEN PRINT "Use screwdiver on switch at warehouse dock": GOTO 300
IF ob(67) = 0 THEN PRINT "Click Push on switch at warehouse dock": GOTO 300
IF ob(68) = 0 THEN PRINT "Click get on pipe box at warehouse dock": GOTO 300
IF ob(72) = 0 THEN PRINT "Use key on door at the back of warehouse crane": GOTO 300
IF ob(76) = 0 THEN PRINT "Click get on bullets at lower left shelf at warehouse storeroom": GOTO 300
IF ob(58) = 0 THEN PRINT "Click get on cd-roms in upper left shelf at warehouse storeroom": GOTO 300
IF ob(59) = 0 THEN PRINT "Use cd-roms on computer in warehouse office": GOTO 300
IF ob(87) = 0 THEN PRINT "Click get on paper on desk inside of Traver 1": GOTO 300
IF ob(88) = 0 THEN PRINT "Use screwdriver on mirror inside of Travel 1": GOTO 300
IF ob(89) = 0 THEN PRINT "Use combination slip on safe inside of Travel 1": GOTO 300
IF ob(90) = 0 THEN PRINT "Click get on remote inside of Travel 1": GOTO 300
IF ob(92) = 0 THEN PRINT "Click get on glass shard in park": GOTO 300
IF ob(91) = 0 THEN PRINT "Use glass shard on wire inside of Travel 1": GOTO 300
IF ob(64) = 0 THEN PRINT "Use stomach on rat hole in subway alcove": GOTO 300
IF ob(65) = 0 THEN PRINT "Click reach on rat hole in subway alcove": GOTO 300
IF ob(94) = 0 THEN PRINT "Click open on door to building at park": GOTO 300
IF ob(95) = 0 THEN PRINT "Click get on shovels in building at park": GOTO 300
IF ob(105) = 0 THEN PRINT "Click get on leaf at goto 300 of elevated road": GOTO 300
IF ob(99) = 0 THEN PRINT "Use shovel on dirt by tree by hotel": GOTO 300
IF ob(100) = 0 THEN PRINT "Use look on dirt by tree by hotel": GOTO 300
IF ob(96) = 0 THEN PRINT "Click push on intercom again": GOTO 300
IF ob(97) = 0 THEN PRINT "Click open on door in front of appartment": GOTO 300
IF ob(123) = 0 THEN PRINT "Use gun on yellow wall in apartment lobby": GOTO 300
IF ob(122) = 0 THEN PRINT "Click get on phone in apartment lobby": GOTO 300
IF ob(114) = 0 THEN PRINT "Click open on door by appartment cave-in": GOTO 300
IF ob(115) = 0 THEN PRINT "Click look on purple card by appartment cave-in": GOTO 300
IF ob(119) = 0 THEN PRINT "Click look on man's head in messy apartment": GOTO 300
IF ob(124) = 0 THEN PRINT "Press button on pad in elevator": GOTO 300
IF ob(125) = 0 THEN PRINT "Click look on key chain on ground in upper apartment hall": GOTO 300
IF ob(127) = 0 THEN PRINT "Click look on cloth on ground in upper apartment hall": GOTO 300
IF ob(126) = 0 THEN PRINT "Click get on key in pot in upper apartment hall": GOTO 300
IF ob(128) = 0 THEN PRINT "Use key in pot on second door in upper apartment hall": GOTO 300
IF ob(107) = 0 THEN PRINT "Click get on wallet in fancy apartment room": GOTO 300
IF ob(121) = 0 THEN PRINT "Click get on cloth in closet in fancy apartment": GOTO 300
IF ob(108) = 0 THEN PRINT "Use car key on car at elevated intersection": GOTO 300
IF ob(109) = 0 THEN PRINT "Click get on last car at elevated intersection": GOTO 300
IF ob(116) = 0 THEN PRINT "Click look on police-man's head by police station": GOTO 300
IF ob(104) = 0 THEN PRINT "Click get on blaster in front of TERC building": GOTO 300
IF ob(135) = 0 THEN PRINT "Click push on switch in TERC office": GOTO 300
IF ob(136) = 0 THEN PRINT "Use the finger on the finger-printing kit in TERC office": GOTO 300
IF ob(133) = 0 THEN PRINT "Use blaster on powerpak at secret stairs in TERC": GOTO 300
IF ob(134) = 0 THEN PRINT "Use wire on break at secret stairs in TERC": GOTO 300
IF ob(137) = 0 THEN PRINT "Walk NW in the TERC secret stairs": GOTO 300
IF ob(149) = 0 THEN PRINT "Use finger print on scanner at TERC hall 1": GOTO 300
IF ob(140) = 0 THEN PRINT "Click get on the red liquid in the TERC hall2": GOTO 300
IF ob(138) = 0 THEN PRINT "Use blaster with powerpak on coat in TERC secret lab": GOTO 300
IF ob(101) = 0 THEN PRINT "Click get on scientist's body in TERC secret laboratory": GOTO 300
IF ob(102) = 0 THEN PRINT "Click remote on black car on far view of tunnel": GOTO 300
IF ob(103) = 0 THEN PRINT "Click open on black car on far view of tunnel": GOTO 300
IF ob(142) = 0 THEN PRINT "Click push on the seventh button at TERC table closeup": GOTO 300
IF ob(143) = 0 THEN PRINT "Click push on fifth button at TERC table close-up": GOTO 300
IF ob(141) = 0 THEN PRINT "Use red liquid on container at TERC table close-up": GOTO 300
IF ob(106) = 0 THEN PRINT "Click get on syringe on the beach": GOTO 300
IF ob(144) = 0 THEN PRINT "Use syringe on container at TERC table close-up": GOTO 300
IF ob(112) = 0 THEN PRINT "Click on bullets in inventory then on pistol": GOTO 300
IF ob(113) = 0 THEN PRINT "Use remote on square at top of tunnel": GOTO 300
IF ob(98) = 0 THEN PRINT "Use money on vendor by last building on left in front of appartment": GOTO 300
IF ob(120) = 0 THEN PRINT "Use leaf on man's head in messy appartment": GOTO 300
IF ob(117) = 0 THEN PRINT "Click get on scarab in second drawer in messy apartment": GOTO 300
IF ob(118) = 0 THEN PRINT "Use scarab on police man by police station": GOTO 300
IF ob(78) = 0 THEN PRINT "Click get on subway ticket in subway car": GOTO 300
IF ob(79) = 0 THEN PRINT "Click open on back left overhead compartment at subway car": GOTO 300
IF ob(80) = 0 THEN PRINT "Click push on the destination buttons in subway car": GOTO 300
IF ob(81) = 0 THEN PRINT "Click push on the lever in the subway car": GOTO 300
IF ob(110) = 0 THEN PRINT "Click push on tire at second subway city": GOTO 300
IF ob(111) = 0 THEN PRINT "Use gun on red in window at second subway city": GOTO 300
IF ob(129) = 0 THEN PRINT "Use pipe on spider droid at far base": GOTO 300
IF ob(130) = 0 THEN PRINT "Use spider-droid key on droid at far base": GOTO 300
IF ob(131) = 0 THEN PRINT "Click look on buttons at door to base": GOTO 300
IF ob(132) = 0 THEN PRINT "Use Base ID on scanner at door to base": GOTO 300
IF ob(139) = 0 THEN PRINT "Use glass shard on lower wire at trapped base hall": GOTO 300
IF ob(145) = 0 THEN PRINT "Use cutter on top wire at trapped base entrance": GOTO 300
IF ob(146) = 0 THEN PRINT "Use blanket on fire at trapped base entrance": GOTO 300
IF ob(150) = 0 THEN PRINT "Walk NE at trapped base entrance": GOTO 300
IF ob(148) = 0 THEN PRINT "Click push on lower right of control-pad at robotics base lab": GOTO 300
IF ob(151) = 0 THEN PRINT "Click look on paper on left wall at base robotics lab": GOTO 300
IF ob(152) = 0 THEN PRINT "Click push on button in base observation room": GOTO 300
IF ob(153) = 0 THEN PRINT "Click look on monitor with a dead scientist": GOTO 300
IF ob(147) = 0 THEN PRINT "Use mirror on laser at trapped base entrance": GOTO 300
IF ob(154) = 0 THEN PRINT "Use blaster on brain": GOTO 300
GOTO 300
2 IF ob(37) = 0 THEN PRINT "Click get on ice plant by cliff": GOTO 300
IF ob(29) = 0 THEN PRINT "Click reach on hole by far village": GOTO 300
IF ob(28) = 0 THEN PRINT "Use get on stump by far village": GOTO 300
IF ob(22) = 0 THEN PRINT "Use ice plant on monkey by monkey": GOTO 300
IF ob(27) = 0 THEN PRINT "Use rod on rock in light forest": GOTO 300
IF ob(23) = 0 THEN PRINT "Use cup on near water pool at waterfall": GOTO 300
IF ob(24) = 0 THEN PRINT "Use cup again on near water at waterfall": GOTO 300
IF ob(36) = 0 THEN PRINT "Click push on rock or tree limb by cliff": GOTO 300
IF ob(19) = 0 THEN PRINT "Use spear on ground by rock on beach": GOTO 300
IF ob(20) = 0 THEN PRINT "Click push on rock on beach": GOTO 300
IF ob(21) = 0 THEN PRINT "Click get on bright rope on beach": GOTO 300
IF ob(30) = 0 THEN PRINT "Click look on rune": GOTO 300
IF ob(26) = 0 THEN PRINT "Use snare on snake in light forest": GOTO 300
IF ob(25) = 0 THEN PRINT "Use water on snake in light forest": GOTO 300
IF ob(31) = 0 THEN PRINT "Use snake one on statue's neck in village": GOTO 300
IF ob(35) = 0 THEN PRINT "Use snare on snake by cliff": GOTO 300
IF ob(34) = 0 THEN PRINT "Use water on snake by cliff": GOTO 300
IF ob(32) = 0 THEN PRINT "Use snake two on statue's neck in village": GOTO 300
IF ob(33) = 0 THEN PRINT "Click pull on statues left arm in village": GOTO 300
GOTO 300
3 IF ob(40) = 0 THEN PRINT "Click push on the Fortuneteller ball in entrance": GOTO 300
IF ob(46) = 0 THEN PRINT "Click get on journal in bedroom": GOTO 300
IF ob(38) = 0 THEN PRINT "Click get on table drawer by mirror in entrance": GOTO 300
IF ob(39) = 0 THEN PRINT "Use wire on knob of closed door in entrance": GOTO 300
IF ob(41) = 0 THEN PRINT "Click get on top shelf of open closet in entrance": GOTO 300
IF ob(42) = 0 THEN PRINT "Use full paper on mirror in entrance": GOTO 300
IF ob(44) = 0 THEN PRINT "Click push on compass in bedroom": GOTO 300
IF ob(45) = 0 THEN PRINT "Use half page on other half in bedroom": GOTO 300
IF ob(47) = 0 THEN PRINT "Click get where journal was in bedroom": GOTO 300
IF ob(48) = 0 THEN PRINT "Click get on feathers in ballroom": GOTO 300
IF ob(43) = 0 THEN PRINT "Use key on door in ballroom": GOTO 300
IF ob(49) = 0 THEN PRINT "Use feather on vase on back porch": GOTO 300
IF ob(50) = 0 THEN PRINT "Click look on rune": GOTO 300
IF ob(51) = 0 THEN PRINT "Use push on third board left of carving in gazebo": GOTO 300
IF ob(52) = 0 THEN PRINT "Use feather on candle in gazebo": GOTO 300
IF ob(53) = 0 THEN PRINT "Use powder on feather in gazebo": GOTO 300
GOTO 300
4 IF ob(1) = 0 THEN PRINT "Click push on far right x once then far left x twice": GOTO 300
IF ob(5) = 0 THEN PRINT "Click get on femur at high lava path": GOTO 300
IF ob(7) = 0 THEN PRINT "Click push on blood pool at low lava path": GOTO 300
IF ob(2) = 0 THEN PRINT "Click get on bones in left corner at low lava path": GOTO 300
IF ob(3) = 0 THEN PRINT "Use skull on bone splitter in pit": GOTO 300
IF ob(6) = 0 THEN PRINT "Use key on hidden keyhole (middle right wall) at high path": GOTO 300
IF ob(16) = 0 THEN PRINT "Use dust on fire trap by far altar": GOTO 300
IF ob(17) = 0 THEN PRINT "Use bone on pit by far altar": GOTO 300
IF ob(4) = 0 THEN PRINT "Use half skull on blood on floor in pit": GOTO 300
IF ob(9) = 0 THEN PRINT "Use bowl on fungus with arm at low lava path": GOTO 300
IF ob(10) = 0 THEN PRINT "Click pull on fungus with arm at low lava path": GOTO 300
IF ob(11) = 0 THEN PRINT "Use femur on fungus by skull at low lava path": GOTO 300
IF ob(12) = 0 THEN PRINT "Click look on rune by altar": GOTO 300
IF ob(13) = 0 THEN PRINT "Use filled half skull on bowl": GOTO 300
IF ob(14) = 0 THEN PRINT "Use filled half skull on other bowl": GOTO 300
IF ob(15) = 0 THEN PRINT "Use fungus on dagger on altar": GOTO 300
300 PRINT "Hit at key to continue"
303 a$ = INKEY$: IF a$ = "" THEN 303
END SUB

