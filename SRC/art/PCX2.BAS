'Qbasic PCX loader. By Jon Kreuzer

'I have used some tricks here to make the loader about 5 times
'faster than a straightforward Qbasic version. Still, unless you use
'Quick Basic to compile it, it will probably run too slow for use in
'a game or a project. At the end of this program is optional code to save it
'for instant access.
DEFINT A-Q, S-Z
CONST mask = &H3C5
CONST reg = &H3C8
CONST dat = &H3C9
DIM buffer AS STRING * 12000
DIM char AS INTEGER, red AS STRING * 1, char2 AS STRING * 1
DIM back, rtim, green AS STRING * 1, blue AS STRING * 1
DIM bytepos AS LONG, buffercount AS LONG, bufferadd AS LONG, ende AS LONG
SCREEN 13

'LOAD PALLETE
OPEN "JOE02M.pcx" FOR BINARY AS #1
ende = LOF(1)
SEEK #1, ende - 767
FOR i = 0 TO 255
GET #1, , red
GET #1, , green
GET #1, , blue
red = CHR$(ASC(red) \ 4)
green = CHR$(ASC(green) \ 4)
blue = CHR$(ASC(blue) \ 4)
OUT dat, ASC(red)
OUT dat, ASC(green)
OUT dat, ASC(blue)
NEXT i

'LOAD PICTURE
SEEK #1, 129
rtim = TIMER

again:
  GET #1, , buffer
  back = VARSEG(buffer)
  DEF SEG = VARSEG(buffer)
  bufferadd = VARPTR(buffer)
                  'seek
  buffercount = bufferadd
  WHILE buffercount < 12000 + bufferadd
  char = PEEK((buffercount))
  buffercount = buffercount + 1
  IF bytepos >= 64000 THEN GOTO done
          IF char > 192 THEN
                  loopfor = char - 192
                  char = PEEK((buffercount))
                  IF 12000 + bufferadd = buffercount THEN GET #1, , char2: char = ASC(char2) 'Hits boundary
                  buffercount = buffercount + 1
                  FOR i = 1 TO loopfor
                  DEF SEG = &HA000: POKE bytepos, char: DEF SEG = back
                  bytepos = bytepos + 1
                  NEXT i

          ELSE
                  DEF SEG = &HA000: POKE bytepos, char: DEF SEG = back
                  bytepos = bytepos + 1
          END IF
  WEND
  IF bytepos < 64000 THEN GOTO again
done: DEF SEG
  CLOSE

  SLEEP

  DIM car(342)
  PALETTE 0, 0
  PALETTE 255, CLNG(63 + (63 * 256) + (63 * (256 ^ 2)))

  FOR y = 78 TO 120
    FOR x = 111 TO 208
      col = 255
      IF POINT(x, y) = 255 THEN col = 0
      PSET (x, y), col
    NEXT x
  NEXT y
  CLOSE

  GET (149, 84)-(170, 114), car(0)
  CLS
  PUT (149, 84), car(0)



  'This code will write the video buffer onto the disk as test.pct

  DEF SEG = VARSEG(car(0))
  BSAVE "joe02M.pct", 0, 4216
  DEF SEG

  WHILE INKEY$ = "": WEND

