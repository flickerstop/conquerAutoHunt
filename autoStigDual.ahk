
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 300,500

MsgBox, "Hover over person 1 icon and click enter"
MouseGetPos, x1, y1 

; Get the Bottom right corner
MsgBox, "Hover over person 2 icon and click enter"
MouseGetPos, x2, y2 

Pause,Toggle

loop{
    
    Send, {f5}
    randomSleep()
    loop, 5{
        MouseMove, x1, y1, 2
        MouseClick, right
        randomSleep()
    }

    loop, 5{
        MouseMove, x2, y2, 2
        MouseClick, right
        randomSleep()
    }


    Send, {f1}
    randomSleep()
    randomSleepRange(400,800)
}

esc::
    exitapp
return

space::
    Pause,Toggle
return

randomSleep(){
    Random, x, 400, 600
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}