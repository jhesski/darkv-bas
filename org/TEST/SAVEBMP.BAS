DEFINT A-Z
DECLARE SUB SAVE4BIT (FileName$, MinX, MinY, MaxX, MaxY)
TYPE BMPHeader
   ValidID AS STRING * 2
   SizeOfFile AS LONG
   Reserved AS LONG
   OffsetOfBitMap AS LONG
END TYPE
TYPE WindowsBMPInfoHeader
    SizeOfHeader AS LONG
    Widthz AS LONG
    Heightz AS LONG
    Planes AS INTEGER
    BitsPerPixel AS INTEGER
    CompressMethod AS LONG
    ImageSizeInBytes AS LONG
    HorizontalResol AS LONG
    VerticalResol AS LONG
    ColorsUsed AS LONG
    ImportantColors AS LONG
END TYPE
SAVE4BIT "4bit.bmp", 0, 0, 639, 479

SUB SAVE4BIT (FileName$, MinX, MinY, MaxX, MaxY)
  OPEN FileName$ FOR BINARY AS #255
  IF LOF(255) <> 0 THEN
     CLOSE
     KILL FileName$
     OPEN FileName$ FOR BINARY AS #255
  END IF
  ImageWidth = (MaxX - MinX) + 1: ImageHeight = (MaxY - MinY) + 1
  DIM BMPHeader AS BMPHeader
  DIM WindowsBMPInfoHeader AS WindowsBMPInfoHeader
  WindowsBMPInfoHeader.SizeOfHeader = 40
  WindowsBMPInfoHeader.Widthz = ImageWidth
  WindowsBMPInfoHeader.Heightz = ImageHeight
  WindowsBMPInfoHeader.Planes = 1
  WindowsBMPInfoHeader.BitsPerPixel = 4
  WindowsBMPInfoHeader.CompressMethod = 0
  WindowsBMPInfoHeader.ColorsUsed = 16
  WindowsBMPInfoHeader.ImportantColors = 16
  PUT #255, 15, WindowsBMPInfoHeader
  Empty$ = SPACE$(1)
  SCREEN 12
  FOR Colors = 0 TO 15
     OUT &H3C6, &HFF
     OUT &H3C7, Colors
     Red$ = CHR$(INP(&H3C9) * 4): Green$ = CHR$(INP(&H3C9) * 4)
     Blue$ = CHR$(INP(&H3C9) * 4): AllColorz$ = Blue$ + Green$ + Red$ + Empty$
     PUT #255, , AllColorz$
  NEXT Colors
  Padding$ = SPACE$(0)
  IF (4 - ((BMPInfoHeader.Widthz MOD 8) / 2)) <> 4 THEN
     Padding$ = SPACE$((4 - ((BMPInfoHeader.Widthz MOD 8) / 2)))
  END IF
  FOR Loops = MaxY TO MinY STEP -1
     FOR Lips = MinX TO MaxX STEP 2
        Byte = POINT(Lips, Loops) * 16
        IF Lips + 1 <= MaxX THEN
           Byte = (Byte OR POINT(Lips + 1, Loops))
        END IF
        Bytez$ = Bytez$ + CHR$(Byte)
        Byte = 0
     NEXT Lips
     LINE (MinX, Loops)-(MaxX, Loops), 0
     PUT #255, , Bytez$
     PUT #255, , Padding$
     Bytez$ = ""
  NEXT Loops
  BMPHeader.ValidID = "BM"
  BMPHeader.SizeOfFile = LOF(255)
  BMPHeader.OffsetOfBitMap = 118
  PUT #255, 1, BMPHeader
  CLOSE
END SUB

