#Include drawBox.ahk



CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 300,500


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Walk Area
;Get the top Left corner
MsgBox, "Inventory Top Left"
MouseGetPos, topX, topY 

; Get the Bottom right corner
MsgBox, "Inventory Bottom Right"
MouseGetPos, botX, botY 

; Draw the box
createBox3("00FF00")
box3(topX, topY, botX-topX, botY-topY, 1, "out")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MsgBox, "Drop Spot"
MouseGetPos, dropX, dropY 

createBox2("FFFFFF")
box2(dropx-10, dropy-10, 20, 20, 1, "out")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MsgBox, "Shadow for autoLog"
MouseGetPos, shadowX, shadowY 

createBox("FF0000")
box(shadowX-10, shadowY-10, 20, 20, 1, "out")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
randomSleepRange(2000,3000)

attempts := 0
account := 1

Loop{
    if (attempts > 5){
        randomSleepRange(200,300)
        switchAccount()
        randomSleepRange(6000,9000)
        attempts := 0
    }
    ; Check for logged out
    PixelSearch, Px, Py, shadowX-10, shadowY-10, shadowX+10, shadowY+10, 0xFFFFFF, 0, Fast
    if ErrorLevel{ ; IF not found

    }else{
        ; Click OK on disconnect
        randomSleep()
        MouseMove, 1091, 473, 2
        randomSleep()
        MouseClick, Left
        ; Wait for login screen to start
        randomSleepRange(3000,4000)
        ; Click on password Field
        MouseMove, 898, 717, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        ; Put in password
        Send, password
        randomSleep()
        ; Click on login
        MouseMove, 1114, 759, 2
        randomSleep()
        MouseClick, Left
        ; Wait for logging in to finish
        randomSleepRange(12000,15000)
        ; Open inventory
        MouseMove, 980, 765, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
    }

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
                randomSleepRange(2000,3000)
                switchAccount()
                randomSleepRange(2000,3000)
                attempts := 0
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
    attempts++

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

switchAccount(){
    global account

    if (account = 1){
        MouseMove, 573, 855, 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(2000,3000)
        account++
    }else if (account = 2){
        MouseMove, 737, 855, 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(2000,3000)
        account++
    }else if (account = 3){
        MouseMove, 892, 855, 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(2000,3000)
        account++
    }else if (account = 4){
        MouseMove, 1060, 855, 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(2000,3000)
        account++
    }else if (account = 5){
        MouseMove, 1213, 855, 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(2000,3000)
        account := 1
    }
}