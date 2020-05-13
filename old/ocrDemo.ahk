#include .\lib\Vis2.ahk

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

; MsgBox % text := StrReplace(OCR([1271, 418, 82, 20]),",","")

b::
;main 1926, 587
;Vm   1271, 418
Send % StrReplace(OCR([1926, 587, 82, 20]),",","")
return

Esc:: ExitApp


; 1271, 418, 82, 20
