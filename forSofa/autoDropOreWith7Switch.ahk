#Include drawBox.ahk



CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 300,500


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Walk Area
;Get the top Left corner
MsgBox, "Hover over the TOP LEFT of your inventory area and click enter"
MouseGetPos, topX, topY 

; Get the Bottom right corner
MsgBox, "Hover over the BOTTOM RIGHT of your inventory area and click enter"
MouseGetPos, botX, botY 

; Draw the box
createBox3("00FF00")
box3(topX, topY, botX-topX, botY-topY, 1, "out")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MsgBox, "This is where the mouse will drop the ore (anywhere on the screen works)"
MouseGetPos, dropX, dropY 

createBox2("FFFFFF")
box2(dropx-10, dropy-10, 20, 20, 1, "out")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

accountX := []
accountY := []


loop, 7{
    MsgBox, Hover Over Account %a_index% in the task bar
    MouseGetPos, x, y 

    accountX.push(x)
    accountY.push(y)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
randomSleepRange(2000,3000)

account := 1

Loop{

    ; Search for IRON ore
    PixelSearch, Px, Py, topX, topY, botX, botY, 0x555455, 0, Fast
    if ErrorLevel{ ; IF not found
        ; Search for COPPER ore
        PixelSearch, Px, Py, topX, topY, botX, botY, 0xB5D3E7, 0, Fast
        if ErrorLevel{ ; IF not found
            ; Search for SILVER ore
            PixelSearch, Px, Py, topX, topY, botX, botY, 0xB5B2B5, 0, Fast
            if ErrorLevel{ ; IF not found
                ;MsgBox, Nothing Found
                MouseMove, dropX, dropY
                randomSleep()
                MouseClick, Right
                switchAccounts()
            }else{ ; if found
                MouseMove, Px, Py
                ;MsgBox, Silver Found x%Px% y%Py%
                randomSleep()
                MouseClick, Left
                MouseMove, dropX, dropY
                randomSleep()
                MouseClick, Left
                randomSleep()
            }
        }else{ ; if found
            MouseMove, Px, Py
            ;MsgBox, Copper Found x%Px% y%Py%
            randomSleep()
            MouseClick, Left
            MouseMove, dropX, dropY
            randomSleep()
            MouseClick, Left
            randomSleep()
        }
    }else{ ; if found
        MouseMove, Px, Py
        ;MsgBox, Iron Found x%Px% y%Py%
        randomSleep()
        MouseClick, Left
        MouseMove, dropX, dropY
        randomSleep()
        MouseClick, Left
        randomSleep()
    }

    randomSleep()
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

randomSleep(){
    Random, x, 300, 600
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}

switchAccounts(){
    global account
    global accountX
    global accountY

    randomSleep()
    MouseMove, accountX[account], accountY[account], 2
    randomSleep()
    MouseClick, Left
    randomSleepRange(2000,3000)
    account++

    if (account = 8){
        account := 1
    }
}