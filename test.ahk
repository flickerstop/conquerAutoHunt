#Include drawBox.ahk
#Include CConsole.ahk
#include .\lib\Vis2.ahk
#Include textOnScreen.ahk

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

;global Console := new CConsole
;Console.show()  ; must use parentheses



topX := 1184
topY := 62
botX := 1395
botY := 401

account := 2
gold := [0,0," 5  ",1,0,0,10,0,0,0,0]

f8::
    

return

f7::
    name := StrReplace(StrReplace(OCR([777, 336, 847-777, 355-336]),":","")," ","")
    MsgBox % name
return

r::
    Reload
return

esc::
    exitapp
return

space::
    Pause,Toggle
return


waitForMomentStop(){
    randomSleepRange(100,200)
    loop{
        PixelGetColor, spot1start, 1012, 152
        PixelGetColor, spot2start, 931, 459
        randomSleepRange(100,200)
        PixelGetColor, spot1stop, 1012, 152
        PixelGetColor, spot2stop, 931, 459

        if (spot1start = spot1stop && spot2start = spot2stop){
            if (A_Index = 1){
                ; no movement on first check, try to walk
                randomSleep()
                MouseClick, Left
                continue
            }
            ; no movement detected
            return
        }
    }
}



randomSleep(){
    Random, x, 300, 500
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}
