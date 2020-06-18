DECLARE FUNCTION pxl2hex (pc1%, pc2%) AS STRING
DEFINT A-Z
SCREEN 1
CLS
DIM s(16004)

DEF SEG = &HB800
  BLOAD ".\org\carr.pic"
DEF SEG

'PSET (0, 0), 3
'PSET (1, 0), 3
'PSET (2, 0), 3
'PSET (3, 0), 3
'PSET (4, 0), 3
'PSET (5, 0), 3
'PSET (6, 0), 3
'PSET (7, 0), 3
'
PSET (0, 1), 3
'PSET (1, 1), 3
'PSET (2, 1), 3
'PSET (3, 1), 3
'PSET (4, 1), 3
'PSET (5, 1), 3
'PSET (6, 1), 3
'PSET (7, 1), 3

SLEEP
GET (0, 0)-(319, 199), s(0)

CLS
'SCREEN 12



PRINT s(0)
s(2) = VAL("&H00C0")
's(42) = VAL("&H003C")
's(82) = VAL("&HFFFF")
's(122) = VAL("&H003C")
's(162) = VAL("&H000C")

DIM OT AS STRING
DIM TF AS STRING
DIM FS AS STRING
DIM SE AS STRING

PUT (0, 0), s(0), PSET

'--- Line 1
OT = pxl2hex(3, 0): TF = "0": FS = "0": SE = "0"
GOSUB putSprite

'--- Line 2
OT = pxl2hex(0, 2): TF = "0": FS = "0": SE = "0"
GOSUB putSprite

'--- Line 3
OT = "0": TF = pxl2hex(1, 0): FS = "0": SE = "0"
GOSUB putSprite

'--- Line 4
OT = "0": TF = pxl2hex(0, 3): FS = "0": SE = "0"
GOSUB putSprite

'--- Line 5
OT = "0": TF = "0": FS = pxl2hex(2, 0): SE = "0"
GOSUB putSprite

'--- Line 6
OT = "0": TF = "0": FS = pxl2hex(0, 1): SE = "0"
GOSUB putSprite

'--- Line 7
OT = "0": TF = "0": FS = "0": SE = pxl2hex(2, 0)
GOSUB putSprite

'--- Line 8
OT = "0": TF = "0": FS = "0": SE = pxl2hex(0, 1)
GOSUB putSprite

'--- Line 9
OT = "0": TF = "0": FS = "0": SE = pxl2hex(0, 2)
GOSUB putSprite

'--- Line 10
OT = "0": TF = "0": FS = "0": SE = pxl2hex(0, 3)
GOSUB putSprite


END

putSprite:
  s(2) = VAL("&H" + FS + SE + OT + TF)
  PUT (0, 0), s(0), PSET
RETURN

FUNCTION pxl2hex (pc1, pc2) AS STRING
  DIM colors(3) AS STRING * 2
  colors(0) = "00"
  colors(1) = "01"
  colors(2) = "10"
  colors(3) = "11"
  hexen$ = colors(pc1) + colors(pc2)
  SELECT CASE hexen$
    CASE "0000"
      pxl2hex = "0"
    CASE "0001"
      pxl2hex = "1"
    CASE "0010"
      pxl2hex = "2"
    CASE "0011"
      pxl2hex = "3"
    CASE "0100"
      pxl2hex = "4"
    CASE "0101"
      pxl2hex = "5"
    CASE "0110"
      pxl2hex = "6"
    CASE "0111"
      pxl2hex = "7"
    CASE "1000"
      pxl2hex = "8"
    CASE "1001"
      pxl2hex = "9"
    CASE "1010"
      pxl2hex = "A"
    CASE "1011"
      pxl2hex = "B"
    CASE "1100"
      pxl2hex = "C"
    CASE "1101"
      pxl2hex = "D"
    CASE "1110"
      pxl2hex = "E"
    CASE "1111"
      pxl2hex = "F"
  END SELECT
END FUNCTION

