DECLARE FUNCTION getImageSize! (x1!, y1!, x2!, y2!, bits!, planes!)

imgSize = getImageSize(0, 0, 319, 199, 2, 1)
SLEEP
DIM image(1 TO 8000)

GOSUB init
PRINT "foo"
SLEEP
PUT (0, 0), image, PSET

END
init:
  SCREEN 1
  'GET (0, 0)-(319, 199), image
  OPEN "carr.pic" FOR INPUT AS #1
  i = 1
  DO
    INPUT #1, image(i)
    LOCATE 1, 1: PRINT i
    i = i + 1
  LOOP WHILE NOT EOF(1)
  CLOSE
  SLEEP
RETURN

FUNCTION getImageSize (x1, y1, x2, y2, bits, planes)
  IMG_H = x2 - x1 + 1
  IMG_W = y2 - y1 + 1
  getImageSize = 4 + INT((IMG_H * bits + 7) / 8) * planes * IMG_W
END FUNCTION

SUB InitilizeGame ()
  SCREEN 1
  ' PRINT CHR$(0) + CHR$(1)
  ' SLEEP
  'DIM esc AS STRING: ecs = CHR$(0) + CHR$(1)
  ' RANDOMIZE 0#

  GOTO keyboard
keyboard:
  KEY 16, CHR$(0) + CHR$(1)
  'ON KEY(16) GOSUB foo
  KEY(16) ON
 
  'PALETTE 3, 6
  'PALETTE 1, 2
  'PALETTE 2, 11
  'KEY OFF

END SUB

