'POINTER1.BAS
'Prototype ver 3.7 of Voices Of Libertys

'The following are SUB programs that WEREN'T written by Acidus Software
'They simply load the mouse and check it x/y coordinates

DECLARE SUB MouseDriver (ax%, bx%, cx%, dx%)
DECLARE FUNCTION Initialize% ()
DECLARE SUB CursorOff ()
DECLARE SUB cursoron ()
DECLARE SUB GetMouse (lb%, rb%, xMouse%, yMouse%)
DECLARE SUB LocateCursor (x%, y%)



'The following are SUB used to make your own cursor
DECLARE SUB LoadPointer (load$)
DECLARE SUB MovePointer (xM%, yM%)

DIM SHARED PointerX
DIM SHARED PointerY
DIM SHARED DimX         'how many pixels wide the cusor is 
DIM SHARED DimY         'how many pixels tall the cusur is
DIM SHARED pointer(100)         'The cursors image
DIM SHARED UnderPointer(100)    'image of what is under the cursor


'The following allows for mouse use in Qbasic. It is NOT written by Acidus
'Software
DIM SHARED Mouse$
Mouse$ = SPACE$(57)
FOR i% = 1 TO 57
  READ a$
  H$ = CHR$(VAL("&H" + a$))
  MID$(Mouse$, i%, 1) = H$
NEXT i%
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00        
CLS
ms% = Initialize%
IF NOT ms% THEN
PRINT "Mouse not found"
END
END IF

'GOTO bypass            'UN comment this line after you run the program once
'the following lines of code make a cursor
'I make all my mointers 10x10

SCREEN 1
CLS
FOR y = 1 TO 10
FOR x = 1 TO 10
READ r
PSET (x, y), r
NEXT
NEXT
GET (1, 1)-(10, 10), pointer

DEF SEG = VARSEG(pointer(0))
BSAVE "cursor1.cpf", 0, 100

DATA 3,0,0,0,0,0,0,0,0,3
DATA 0,3,0,0,0,0,0,0,3,0
DATA 0,0,3,0,0,0,0,3,0,0
DATA 0,0,0,3,0,0,3,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,3,0,0,3,0,0,0
DATA 0,0,3,0,0,0,0,3,0,0
DATA 0,3,0,0,0,0,0,0,3,0
DATA 3,0,0,0,0,0,0,0,0,3


ByPass:
SCREEN 1
'This creates a random background for you to move your cursor over:

CLS
RANDOMIZE TIMER
FOR a = 1 TO 100
xx = INT(RND * 300) + 1
yy = INT(RND * 180) + 1
cc = INT(RND * 2) + 1
LINE (xx, yy)-(xx + 20, yy + 20), cc, BF
NEXT
'To call a custom cusur (which I call pointers) you must first load
'it. Be sure to put the correct wide and tall Dim's, because your cursor is
'centered on the tip of the default arrow head.
'You must also always turn off the cursor before loading a custom pointer

DimX = 10               '10 pixels wide
DimY = 10               '10 pixels tall
LoadPointer "Cursor1.cpf"


pointerloop:
DO
x = xMouse%
y = yMouse%
CALL GetMouse(lb%, rb%, xMouse%, yMouse%)
IF x <> xMouse% OR y <> yMouse% THEN MovePointer xMouse%, yMouse%
LOOP UNTIL INKEY$=CHR$(27)
STOP

SUB CursorOff
 'Turns off the mouse cursor
 ax% = 2
 MouseDriver ax%, 0, 0, 0
END SUB

SUB cursoron
  'Turn on the mouse cursor
  ax% = 1
  MouseDriver ax%, 0, 0, 0
END SUB

SUB GetMouse (lb%, rb%, xMouse%, yMouse%)
  ax% = 3
  MouseDriver ax%, bx%, cx%, dx%
  lb% = ((bx% AND 1) <> 0)
  rb% = ((bx% AND 2) <> 0)
  xMouse% = cx%
  yMouse% = dx%
END SUB

FUNCTION Initialize%
  ax% = 0
  MouseDriver ax%, 0, 0, 0
  Initialize% = ax%
END FUNCTION


SUB LoadPointer (load$)
'Load the image of your custom pointer
DEF SEG = VARSEG(pointer(0))
BLOAD load$, 0
DEF SEG

'Find out the current x,y coordinates of the mouse
CALL GetMouse(lb%, rb%, xMouse%, yMouse%)

'The next statements make it so the center of your pointer is the x,y 
'coordinates of the mouse by dividing the width and heigth by 2
'the xMouse%/2 is used to get the x coordinate into Screen 1 dimensons
'PointerX and PointerY are the top left coordinates of the pointers image.
'They are the top left cornor becuase that is where the image must be PUT
'so that the center of the pointer is the returned x,y Mouse coordinates

PointerX = (xMouse% / 2) - INT(DimX / 2)
PointerY = yMouse% - INT(DimY / 2)

LOCATE 1: PRINT PointerX, PointerY      

'The foloowing make sure you stay inside the bounds of the screen
'in screen mode 1, the dimensions are 320x200, so change the following
'numbers if you have different dimensions (like 640x200)

IF PointerX < 1 THEN PointerX = 1 
IF PointerX > 319 - (DimX) THEN PointerX = 319 - (DimX)
IF PointerY < 1 THEN PointerY = 1
IF PointerY > 199 - DimY THEN PointerY = 199 - DimY

'The next statement saves the image of what will be under your pointer

GET (PointerX, PointerY)-(PointerX + DimX, PointerY + DimY), UnderPointer
'The next statement places your pointer at that location

PUT (PointerX, PointerY), pointer, OR

END SUB

SUB LocateCursor (x%, y%)
  'This moves your ax% = 4
  cx% = x%
  dx% = y%
  MouseDriver ax%, 0, cx%, dx%
END SUB

SUB MouseDriver (ax%, bx%, cx%, dx%)
  DEF SEG = VARSEG(Mouse$)
  Mouse% = SADD(Mouse$)
  CALL Absolute(ax%, bx%, cx%, dx%, Mouse%)
END SUB

SUB MovePointer (xM%, yM%)
'This sub is called when the mouse is moved to a new postion

'1st replace the background
PUT (PointerX, PointerY), UnderPointer, PSET

'calculate the new location of the top right cornor of your pointer
'the xM%/2 is to get the right Dimensions for screen 1

PointerX = (xM% / 2) - INT(DimX / 2)
PointerY = yM% - INT(DimY / 2)

'Make sure PointerX and PointerY are within Screen Dimensions

IF PointerX < 1 THEN PointerX = 1
IF PointerX > 319 - (DimX) THEN PointerX = 319 - (DimX)
IF PointerY < 1 THEN PointerY = 1
IF PointerY > 199 - DimY THEN PointerY = 199 - DimY

'Save the image under the pointer
GET (PointerX, PointerY)-(PointerX + DimX, PointerY + DimY), UnderPointer

'place the pointer

PUT (PointerX, PointerY), pointer, OR
END SUB

'-------------------------