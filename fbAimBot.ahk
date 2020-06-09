#Include drawBox.ahk
#Include CConsole.ahk
#include .\lib\Vis2.ahk

;00ff36

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
createBox3("000000")

searchDistance := 100
SetDefaultMouseSpeed, 0
^f3::
    fbAimBot()
return

f3::
    fbAimBot()
return


fbAimBot(){
    global searchDistance
    MouseGetPos, x, y

    box3(x-(searchDistance/2),y-(searchDistance/2),searchDistance,searchDistance,1,"out")

    PixelSearch, px,py, x-searchDistance, y-searchDistance, x+searchDistance, y+searchDistance, 0x60E735, 40, Fast
    if ErrorLevel{ ; IF not found
        
    }else{
        MouseMove, px+2, py+2,0
        MouseClick, right
        MouseClick, right
        MouseMove, x,y,0
    }
}

f5::
    Reload
return

esc::
    exitapp
return

\::
    Pause,Toggle
return