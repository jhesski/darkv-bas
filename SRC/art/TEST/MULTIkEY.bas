'===========================================================================
' Subject: SIMULTANEOUS KEY DEMO             Date: 03-18-96 (13:12)
' Author:  Eric Carr                         Code: QB, QBasic, PDS
' Origin:  FidoNet QUIK_BAS Echo           Packet: KEYBOARD.ABC
'===========================================================================
'Ok..Here is the sample keyboard routine I promised..I haven't tested it on any
'other computer excpet mine, but it should work for anyone..  This program lets
'you move a box around by pressing the arrow keys..The acual routine in only 4
'lines as i have marked..This program requires a minimum of a 486sx 25mhz if
'not compiled to run fast enough for all the keys to be updated..I also
'reprogrammed the internal timer from 18.2 to 30, so I could time it to 30 fps.
'To see if a key is being currently pressed, the variable KS is used (IF
'KS(75)=1 THEN button is pressed). Instead of ASCII, this uses scan codes,
'which you can look at in the QB help..Hope you can understand it! :)

DEFINT A-Z: DIM B(300): CLS

N& = 39772 'Reprogram the timer to 30hz
LB& = N& AND &HFF 'instead of 18.2 (for 30 frames
HB& = (N& / 256) AND &HFF 'per second.)
OUT &H43, &H3C: OUT &H40, LB&: OUT &H40, HB&

DIM KS(255), SC(255), DU(255)
FOR E = 0 TO 127 ' Setup key data table KSC()
  SC(E) = E: DU(E) = 1
NEXT
FOR E = 128 TO 255
  SC(E) = E - 128: DU(E) = 0
NEXT

SCREEN 13: COLOR 4
LOCATE 10, 3: PRINT "Keyboard input routine by Eric Carr"
COLOR 7: PRINT: COLOR 2
PRINT "  Use the arrow keys to move the box."
PRINT "Note that you can press two or more keys"
PRINT "    at once for diagnal movement!"
PRINT: COLOR 8: PRINT "          Press [Esc] to quit"
X = 150: Y = 100: BX = X: BY = Y
DEF SEG = 0
POKE (1132), 0
GET (X, Y)-(X + 15, Y + 15), B()
DO 'main loop
  T:
  I$ = INKEY$ ' So the keyb buffer don't get full     \routine/
  I = INP(&H60) ' Get keyboard scan code from port 60h   \lines/
  OUT &H61, INP(&H61) OR &H82: OUT &H20, &H20 '         \!!!/
  KS(SC(I)) = DU(I) ' This says what keys are pressed          \!/

  IF PEEK(1132) < 1 THEN GOTO T 'If not enough time was passed goto T
  POKE (1132), 0 'reset timer again
  BX = X: BY = Y
  IF KS(75) = 1 THEN XC = XC - 2: IF XC < -15 THEN XC = -15
  IF KS(77) = 1 THEN XC = XC + 2: IF XC > 15 THEN XC = 15
  IF KS(72) = 1 THEN YC = YC - 2: IF YC < -15 THEN YC = -15
  IF KS(80) = 1 THEN YC = YC + 2: IF YC > 15 THEN YC = 15
  IF XC > 0 THEN XC = XC - 1 ELSE IF XC < 0 THEN XC = XC + 1
  IF YC > 0 THEN YC = YC - 1 ELSE IF YC < 0 THEN YC = YC + 1
  Y = Y + YC: X = X + XC
  IF X > 300 THEN X = 300 ELSE IF X < 0 THEN X = 0
  IF Y > 180 THEN Y = 180 ELSE IF Y < 0 THEN Y = 0
  IF X <> BX OR Y <> BY THEN
    WAIT 936, 8: PUT (BX, BY), B(), PSET
    GET (X, Y)-(X + 15, Y + 15), B(): LINE (X, Y)-(X + 15, Y + 15), 9, BF
  END IF
LOOP UNTIL KS(1) = 1 'loop until [Esc] (scan code 1) is pressed

N& = 65535 'Program the timer back to
LB& = N& AND &HFF '18.2hz before exiting!
HB& = (N& / 256) AND &HFF
OUT &H43, &H3C: OUT &H40, LB&: OUT &H40, HB&

OUT &H61, INP(&H61) OR &H82: OUT &H20, &H20
CLEAR 'need to have this if reprograming the timer
END 'I think this ends the program. I'm not quite sure.. :)
