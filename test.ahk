#Include drawBox.ahk
#Include CConsole.ahk
#include .\lib\Vis2.ahk

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

;global Console := new CConsole
;Console.show()  ; must use parentheses

f8::
    DCbankFromScroll()
return


r::
    Reload
return


DCbankFromScroll(){
    ; Walk to tree
    Mousemove, 1421,304,2
    randomSleep()
    MouseClick, left
    randomSleep()

    randomSleepRange(5000,6000)

    ; walk beside pond
    Mousemove, 1343, 247,2
    randomSleep()
    MouseClick, left
    randomSleep()

    randomSleepRange(5000,6000)

    ; open pharm
    Mousemove, 1130, 563,2
    randomSleep()
    MouseClick, left
    randomSleep()

    randomSleepRange(1000,2000)
    
    ; SELL NOW
    randomSleepRange(1000,2000)


    ; Walk to to stairs
    Mousemove, 406,46,2
    randomSleep()
    MouseClick, left
    randomSleep()

    randomSleepRange(8000,10000)

    ; open wh
    Mousemove, 515,321,2
    randomSleep()
    MouseClick, left
    randomSleep()


}

randomSleep(){
    Random, x, 300, 500
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}

getXY(){
    coords := StrSplit(StrReplace(StrReplace(StrReplace(OCR([517, 36, 65, 18]),"(",""),"{",""),")",""),",")
    ; x := coords[1]
    ; y := coords[1]
    
    

    return coords
}