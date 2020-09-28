#Include drawBox.ahk

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 300,500


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Get the top Left corner
MsgBox, "Hover over the TOP LEFT click enter"
MouseGetPos, topX, topY 

; Get the Bottom right corner
MsgBox, "Hover over the BOTTOM RIGHT click enter"
MouseGetPos, botX, botY 

Pause,Toggle

createBox("00FF00")
box(topX, topY, botX-topX, botY-topY, 1, "out")

loop{
    
    ; Use med
    Send, {f5}
    randomSleep()
    
    loop, 5{
        ;PixelSearch, pX, pY, topX, topY, botX, botY, 0x5040FE, 3,fast
        ;if ErrorLevel{ ; IF not found
            PixelSearch, pX, pY, topX, topY, botX, botY, 0xDECB8D, 3,fast
            if ErrorLevel{ ; IF not found
                continue
            }else{
                RemoveBox2()
                createBox2("000000")
                box2(pX-5, pY-5, 10, 10, 1, "out")
                MouseMove, pX, pY, 2
                MouseClick, right
            }
        ;}else{
        ;    RemoveBox2()
        ;    createBox2("000000")
        ;    box2(pX-5, pY-5, 10, 10, 1, "out")
        ;    MouseMove, pX, pY, 2
        ;    MouseClick, right
        ;}
        randomSleep()
    }
    RemoveBox2()

    Send, {f1}
    randomSleep()
    randomSleepRange(400,600)
}

esc::
    exitapp
return

space::
    Pause,Toggle
return

randomSleep(){
    Random, x, 400, 500
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}