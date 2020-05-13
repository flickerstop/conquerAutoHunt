#Include drawBox.ahk



CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

isPause := false

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
setOuter()

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
setInner()

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
setScatter()



;0x0303B8
;0x1713B5

Loop{
    Random, sleepTime, 200, 600
    Random, xDiff, 0, 30
    Random, sleepTimeLong, 800, 1200
    if (isPause = false){
        ; Search the inside box first
        PixelSearch, Px, Py, xpos3, ypos3, xpos4, ypos4, 0x0303B8, 10, Fast
        if ErrorLevel{ ; IF not found
            ; Search the outside Box
            PixelSearch, Px, Py, xpos1, ypos1, xpos2, ypos2, 0x0303B8, 10, Fast
            if ErrorLevel{ ; IF not found
                ; Search the outside Box
                PixelSearch, Px, Py, xpos5, ypos5, xpos6, ypos6, 0x0303B8, 10, Fast
                if ErrorLevel{ ; IF not found
                    ;MsgBox, That color was not found in the specified region.
                }else{ ; if found
                    Send {Shift Down}
                    MouseMove, Px+xDiff, Py+30
                    Sleep, 50
                    MouseClick, Right
                }
            }else{ ; if found
                Send {Shift Down}
                MouseMove, Px+xDiff, Py+30
                Sleep, 50
                MouseClick, Left
            }
        }else{ ; if found
            Send {Shift Down}
            MouseMove, Px+xDiff, Py+30
            Sleep, 50
            MouseClick, Left
        }
        Send {Shift Up}
    }
    Sleep, sleepTime
}

return    ;-maybe missing return here

esc::exitapp
return

space::
Pause,Toggle
return

^space::
Pause,Toggle
return

1::
isPause := true
setScatter()
isPause := false
return

2::
isPause := true
setOuter()
isPause := false
return

3::
isPause := true
setInner()
isPause := false
return

setScatter(){
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Walk Area
    ;Get the top Left corner
    MsgBox, "Walk Area Top Left"
    MouseGetPos, xpos5, ypos5 

    ; Get the Bottom right corner
    MsgBox, "Walk Area Bottom Right"
    MouseGetPos, xpos6, ypos6 

    ; Draw the box
    createBox3("00FF00")
    box3(xpos5, ypos5, xpos6-xpos5, ypos6-ypos5, 1, "out")

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
}

setOuter(){
    ; Outside Hunt Area
    ; Get the top Left corner
    MsgBox, "Outer Area Top Left"
    MouseGetPos, xpos1, ypos1 

    ; Get the Bottom right corner
    MsgBox, "Outer Area Bottom Right"
    MouseGetPos, xpos2, ypos2 

    ; Draw the box
    createBox("FF0000")
    box(xpos1, ypos1, xpos2-xpos1, ypos2-ypos1, 1, "out")
}

setInner(){
    ; Inside Hunt Area
    ;Get the top Left corner
    MsgBox, "Inner Area Top Left"
    MouseGetPos, xpos3, ypos3 

    ; Get the Bottom right corner
    MsgBox, "Inner Area Bottom Right"
    MouseGetPos, xpos4, ypos4 

    ; Draw the box
    createBox2("0000FF")
    box2(xpos3, ypos3, xpos4-xpos3, ypos4-ypos3, 1, "out")
}