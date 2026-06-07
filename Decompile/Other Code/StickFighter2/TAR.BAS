COMMON SHARED gu AS INTEGER, sip
COMMON SHARED f1 AS INTEGER, e1 AS INTEGER, lle1 AS INTEGER, lf1 AS INTEGER, lj1 AS INTEGER, llh1 AS INTEGER, le1 AS INTEGER, lh1 AS INTEGER, s4 AS INTEGER, s3 AS INTEGER, m4 AS INTEGER, m3 AS INTEGER

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

