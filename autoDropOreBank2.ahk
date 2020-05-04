#Include drawBox.ahk



CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 300,500

topX := 1184
topY := 62
botX := 1395
botY := 401

dropX := 1292
dropY := 544

shadowX := 848
shadowY := 416

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Walk Area
;Get the top Left corner
; MsgBox, "Inventory Top Left"
; MouseGetPos, topX, topY 

; ; Get the Bottom right corner
; MsgBox, "Inventory Bottom Right"
; MouseGetPos, botX, botY 

; Draw the box
createBox3("00FF00")
box3(topX, topY, botX-topX, botY-topY, 1, "out")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; MsgBox, "Drop Spot"
; MouseGetPos, dropX, dropY 

createBox2("FFFFFF")
box2(dropx-10, dropy-10, 20, 20, 1, "out")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; MsgBox, "Shadow for autoLog"
; MouseGetPos, shadowX, shadowY 

createBox("FF0000")
box(shadowX-10, shadowY-10, 20, 20, 1, "out")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
randomSleepRange(2000,3000)



attempts := 0
account := 1
isPause := false

Loop{
    if (isPause = true){
        randomSleepRange(1000,2000)
        continue
    }

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

esc::
    exitapp
return

space::
    Pause,Toggle
return

^space::
    Pause,Toggle
return

b::
    global isPause
    global account
    isPause := true
    account := 1
    loop, 7{
        switchAccount()
        randomSleepRange(1000,2000)
        bank()
        randomSleepRange(1000,2000)
    }
    MsgBox, Banking done! Click OK when all Miners back
    isPause := false
return

n::
    global isPause
    global account
    isPause := true
    account := 1
    loop, 7{
        switchAccount()
        randomSleepRange(1000,2000)
        bank2()
        randomSleepRange(1000,2000)
    }
    MsgBox, Banking done! Click OK when all Miners back
    isPause := false
return

randomSleep(){
    Random, x, 50, 200
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
        account++
    }else if (account = 6){
        MouseMove, 1403, 855, 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(2000,3000)
        account++
    }else if (account = 7){
        MouseMove, 1517, 855, 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(2000,3000)
        account := 1
    }
    
}

bank(){
    global topX 
    global topY 
    global botX 
    global botY 

    randomSleepRange(500,1000)


    ; ape scroll
    MouseMove, 1206,82, 2
    randomSleep()

    ;right click to teleport
    MouseClick, right
    randomSleepRange(3000,4000)

    ;Hold ctrl down
    Send, {CTRL DOWN}
    MouseMove, 1203, 153, 2
    randomSleep()
    ;left click
    MouseClick, left
    randomSleepRange(1000,2000)

    ; ctrl up
    Send, {CTRL UP}

    ;pharm
    MouseMove, 783, 90, 2
    randomSleep()
    ;left click
    MouseClick, left
    randomSleepRange(2000,3000)

    ;;;;;;;;;;;;;;;
    ; Check to see if pharm is opened
    PixelSearch, , , 613-5, 283-5, 613+5, 283+5, 0x5A4929, 1, Fast
    if ErrorLevel{ ; IF not found
        MsgBox, Pharm not opened! Manual banking needed!
        return
    }

    ; sell loop
    loop{
        Sleep, randomSleep()
        PixelSearch, Px, Py, topX, topY, botX, botY, 0x4F88B8, 1, Fast ; GOLD
        if ErrorLevel{ ; IF not found
            PixelSearch, Px, Py, topX, topY, botX, botY, 0x555455, 0, Fast ; IRON
            if ErrorLevel{ ; IF not found
                PixelSearch, Px, Py, topX, topY, botX, botY, 0xB5D3E7, 0, Fast ; COPPER
                if ErrorLevel{ ; IF not found
                    PixelSearch, Px, Py, topX, topY, botX, botY, 0xB5B2B5, 0, Fast ; SILVER
                    if ErrorLevel{ ; IF not found
                        break
                    }else{ ; if found
                        MouseMove, Px, Py
                        Sleep, randomSleep()
                        MouseClick, Left
                        MouseMove, 625, 284
                        Sleep, randomSleep()
                        MouseClick, Left
                    }
                }else{ ; if found
                    MouseMove, Px, Py
                    Sleep, randomSleep()
                    MouseClick, Left
                    MouseMove, 625, 284
                    Sleep, randomSleep()
                    MouseClick, Left
                }
            }else{ ; if found
                MouseMove, Px, Py
                Sleep, randomSleep()
                MouseClick, Left
                MouseMove, 625, 284
                Sleep, randomSleep()
                MouseClick, Left
            }
        }else{ ; if found
            MouseMove, Px, Py
            Sleep, randomSleep()
            MouseClick, Left
            MouseMove, 625, 284
            Sleep, randomSleep()
            MouseClick, Left
        }
        randomSleepRange(300,500)
    }
    randomSleepRange(1000,2000)

    ; buy scroll
    MouseMove, 442, 242, 2
    randomSleep()
    MouseClick, right
    randomSleep()
    
    ; jump to bank
    MouseMove, 1355, 554, 2
    Send, {CTRL DOWN}
    randomSleep()
    ;left click
    MouseClick, left
    randomSleepRange(1000,2000)

    ; ctrl up
    Send, {CTRL UP}

    ; close pharm
    MouseMove, 629, 333, 2
    randomSleep()

    ; left
    MouseClick, left
    randomSleep()

    ; open wh
    MouseMove, 1165, 365, 2
    randomSleep()
    ;left
    MouseClick, left
    randomSleep()

    ; walk out of way
    
    MouseMove, 1087, 266, 2
    randomSleep()
    MouseClick, left
    randomSleep()
}

bank2(){
    global topX 
    global topY 
    global botX 
    global botY 

    randomSleepRange(500,1000)


    ; ape scroll
    MouseMove, 1206,82, 2
    randomSleep()

    ;right click to teleport
    MouseClick, right
    randomSleepRange(3000,4000)

    ;Hold ctrl down
    Send, {CTRL DOWN}
    MouseMove, 1296, 151, 2
    randomSleep()
    ;left click
    MouseClick, left
    randomSleepRange(1000,2000)

    ; ctrl up
    Send, {CTRL UP}

    ;pharm
    MouseMove, 690, 69, 2
    randomSleep()
    ;left click
    MouseClick, left
    randomSleepRange(2000,3000)

    ;;;;;;;;;;;;;;;
    ; Check to see if pharm is opened
    PixelSearch, , , 613-5, 283-5, 613+5, 283+5, 0x5A4929, 1, Fast
    if ErrorLevel{ ; IF not found
        MsgBox, Pharm not opened! Manual banking needed!
        return
    }

    ; sell loop
    loop{
        Sleep, randomSleep()
        PixelSearch, Px, Py, topX, topY, botX, botY, 0x4F88B8, 1, Fast ; GOLD
        if ErrorLevel{ ; IF not found
            PixelSearch, Px, Py, topX, topY, botX, botY, 0x555455, 0, Fast ; IRON
            if ErrorLevel{ ; IF not found
                PixelSearch, Px, Py, topX, topY, botX, botY, 0xB5D3E7, 0, Fast ; COPPER
                if ErrorLevel{ ; IF not found
                    PixelSearch, Px, Py, topX, topY, botX, botY, 0xB5B2B5, 0, Fast ; SILVER
                    if ErrorLevel{ ; IF not found
                        break
                    }else{ ; if found
                        MouseMove, Px, Py
                        Sleep, randomSleep()
                        MouseClick, Left
                        MouseMove, 625, 284
                        Sleep, randomSleep()
                        MouseClick, Left
                    }
                }else{ ; if found
                    MouseMove, Px, Py
                    Sleep, randomSleep()
                    MouseClick, Left
                    MouseMove, 625, 284
                    Sleep, randomSleep()
                    MouseClick, Left
                }
            }else{ ; if found
                MouseMove, Px, Py
                Sleep, randomSleep()
                MouseClick, Left
                MouseMove, 625, 284
                Sleep, randomSleep()
                MouseClick, Left
            }
        }else{ ; if found
            MouseMove, Px, Py
            Sleep, randomSleep()
            MouseClick, Left
            MouseMove, 625, 284
            Sleep, randomSleep()
            MouseClick, Left
        }
        randomSleepRange(300,500)
    }
    randomSleepRange(1000,2000)

    ; buy scroll
    MouseMove, 442, 242, 2
    randomSleep()
    MouseClick, right
    randomSleep()
    
    ; jump to bank
    MouseMove, 1341, 566, 2
    Send, {CTRL DOWN}
    randomSleep()
    ;left click
    MouseClick, left
    randomSleepRange(1000,2000)

    ; ctrl up
    Send, {CTRL UP}

    ; close pharm
    MouseMove, 629, 333, 2
    randomSleep()

    ; left
    MouseClick, left
    randomSleep()

    ; open wh
    MouseMove, 1103, 327, 2
    randomSleep()
    ;left
    MouseClick, left
    randomSleep()

    ; walk out of way
    
    MouseMove, 1011, 136, 2
    randomSleep()
    MouseClick, left
    randomSleep()
}