'Screen Text Segment = &HB800
'Screen Video segment =&HA000
'
DIM p(8269)
' For screen 1 ;4 bits per pixel
' A Char is 8 bits 0 - 255
DIM Array(16004)

DIM filename AS STRING: filename = "C:\Code\bas\DVBAS\SRC\RES\BG\BOOKJ.pic"
DIM pal(3)

'--carr.pic
pal(1) = 2
pal(2) = 11
pal(3) = 6

'--burn.pic
pal(1) = 14
pal(2) = 12
pal(3) = 4



SCREEN 1
PALETTE 1, pal(1)
PALETTE 2, pal(2)
PALETTE 3, pal(3)
img = _LOADIMAGE(filename)

_PUTIMAGE (0, 0), img
