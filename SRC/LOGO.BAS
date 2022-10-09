''
'' putbmp.bas -- loads a BMP file directly to screen
''

DEFINT A-Z
'$INCLUDE: 'ugl.bi'

CONST xRes = 640
CONST yRes = 400
CONST cFmt = UGL.8BIT

DECLARE SUB ExitError (msg AS STRING)

'':::
		DIM video AS LONG
		DIM flname AS STRING
		
				flname = "10PLGO2X2.bmp"
		
		'' initialize
		IF (NOT uglInit) THEN ExitError "Init"
		
		'' change video-mode
		video = uglSetVideoDC(cFmt, xRes, yRes, 1)
		IF (video = 0) THEN ExitError "SetVideoDC"

		'' show it
		IF (NOT uglPutBMPEx(video, 0, 0, flname, BMPOPT.NO332)) THEN ExitError "put"
		SLEEP

		uglRestore
		uglEnd
		END

'':::
SUB ExitError (msg AS STRING)
		uglRestore
		uglEnd
		PRINT "ERROR! "; msg
		END
END SUB

