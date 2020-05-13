#include .\lib\Vis2.ahk
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen


;main 1926, 587
;Vm   1271, 418

getInventoryGold(){
    return StrReplace(OCR([1271, 418, 82, 20]),",","")
}