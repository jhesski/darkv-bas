DEFINT A-Z
DIM artFolder AS STRING
artFolder = ".\art\"
DIM joe(760)

SCREEN 13

PALETTE 0, 63

PALETTE 255, 0

DEF SEG = VARSEG(joe(0))
  BLOAD artFolder + "joe01m.pct"
DEF SEG

