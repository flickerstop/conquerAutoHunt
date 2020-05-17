#Include drawBox.ahk
#include .\lib\Vis2.ahk

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

    if (attempts > 9){
        randomSleepRange(200,300)
        switchAccount()
        randomSleep()
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
                randomSleep()
                switchAccount()
                randomSleep()
                attempts := 0
            }else{ ; if found
                MouseMove, Px, Py
                ;MsgBox, Silver Found x%Px% y%Py%
                randomSleep()
                MouseClick, Left
                randomSleep()
                MouseMove, dropX, dropY
                randomSleep()
                if (checkHoldingOre(0xB5B2B5) = false){
                    attempts++
                    continue
                }
                MouseClick, Left
                randomSleep()
            }
        }else{ ; if found
            MouseMove, Px, Py
            ;MsgBox, Copper Found x%Px% y%Py%
            randomSleep()
            MouseClick, Left
            randomSleep()
            MouseMove, dropX, dropY
            randomSleep()
            if (checkHoldingOre(0xB5D3E7) = false){
                attempts++
                continue
            }
            MouseClick, Left
            randomSleep()
        }
    }else{ ; if found
        MouseMove, Px, Py
        ;MsgBox, Iron Found x%Px% y%Py%
        randomSleep()
        MouseClick, Left
        randomSleep()
        MouseMove, dropX, dropY
        randomSleep()
        if (checkHoldingOre(0x555455) = false){
            attempts++
            continue
        }
        MouseClick, Left
        randomSleep()
    }
    attempts++

    randomSleepRange(200,400)
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

; Sell, bank then hop back
b::
    randomSleepRange(5000,6000)
    global isPause
    global account
    isPause := true
    account := 1
    loop, 11{
        switchAccount()
        randomSleepRange(1000,2000)
        bank()
        randomSleepRange(1000,2000)
        wharehouse()
        randomSleepRange(1000,2000)
        toTheMine()
        randomSleepRange(1000,2000)
    }
    isPause := false
return

n::
    randomSleepRange(5000,6000)
    global isPause
    global account
    isPause := true
    account := 1
    loop, 11{
        switchAccount()
        randomSleepRange(1000,2000)
        bank2()
        randomSleepRange(1000,2000)
        wharehouse()
        randomSleepRange(1000,2000)
        toTheMine()
        randomSleepRange(1000,2000)
    }
    isPause := false
return


; Just sell and sit at the bank
g::
    randomSleepRange(5000,6000)
    global isPause
    global account
    isPause := true
    account := 1
    loop, 11{
        switchAccount()
        randomSleepRange(1000,2000)
        bank()
        randomSleepRange(1000,2000)
    }
    MsgBox, All selling done. Click M when all inventorys open and ready to hop back
return

h::
    randomSleepRange(5000,6000)
    global isPause
    global account
    isPause := true
    account := 1
    loop, 11{
        switchAccount()
        randomSleepRange(1000,2000)
        bank2()
        randomSleepRange(1000,2000)
    }
    MsgBox, All selling done. Click M when all inventorys open and ready to hop back
return

; Hop back to the mine
m::
    global isPause
    global account
    isPause := true
    account := 1
    loop, 11{
        switchAccount()
        randomSleepRange(1000,2000)
         ; Teleport scroll
        MouseMove, 1205, 83, 2
        randomSleep()
        MouseClick, right
        randomSleepRange(2000,3000)

        ; Blue marker thing
        MouseMove, 976, 344, 2
        randomSleep()
        MouseClick, left
        randomSleepRange(1000,1200)

        ;Confirm buy
        MouseMove, 683, 148, 2
        randomSleep()
        MouseClick, left
        randomSleepRange(1000,2000)

        ;close 
        MouseClick, left
        randomSleep()

        ; Set DH
        Send, {F10}
        randomSleep()

        MouseMove, 983, 764, 2
        randomSleep()
        MouseClick, left
        randomSleepRange(1000,1200)
        MouseClick, left
        randomSleepRange(1000,2000)
        toTheMine()
        randomSleepRange(1000,2000)
    }
    MsgBox, Banking done! Click OK when all Miners back
    isPause := false
return

t::
    ;prepareMiners()
return

i::
    ;scatterMiners()
return

randomSleep(){
    Random, x, 300, 500
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}

switchAccount(){
    global account

    accountX := [538,641,752,861,960,1065,1166,1274,1373,1479,1588]

    
    MouseMove, accountX[account], 855, 2
    randomSleep()
    MouseClick, Left
    randomSleep()
    account++

    if (account = 12){
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
        randomSleep()
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
                        randomSleep()
                        MouseClick, Left
                        MouseMove, 625, 284
                        randomSleep()
                        MouseClick, Left
                    }
                }else{ ; if found
                    MouseMove, Px, Py
                    randomSleep()
                    MouseClick, Left
                    MouseMove, 625, 284
                    randomSleep()
                    MouseClick, Left
                }
            }else{ ; if found
                MouseMove, Px, Py
                randomSleep()
                MouseClick, Left
                MouseMove, 625, 284
                randomSleep()
                MouseClick, Left
            }
        }else{ ; if found
            MouseMove, Px, Py
            randomSleep()
            MouseClick, Left
            MouseMove, 625, 284
            randomSleep()
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
        randomSleep()
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
                        randomSleep()
                        MouseClick, Left
                        MouseMove, 625, 284
                        randomSleep()
                        MouseClick, Left
                    }
                }else{ ; if found
                    MouseMove, Px, Py
                    randomSleep()
                    MouseClick, Left
                    MouseMove, 625, 284
                    randomSleep()
                    MouseClick, Left
                }
            }else{ ; if found
                MouseMove, Px, Py
                randomSleep()
                MouseClick, Left
                MouseMove, 625, 284
                randomSleep()
                MouseClick, Left
            }
        }else{ ; if found
            MouseMove, Px, Py
            randomSleep()
            MouseClick, Left
            MouseMove, 625, 284
            randomSleep()
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

getInventoryGold(){
    return StrReplace(OCR([1271, 418, 82, 20]),",","")
}
; FF7FEC VIOLET GEM
; EF511B MOON GEM

wharehouse(){
    global topX 
    global topY 
    global botX 
    global botY 

    ;Select text area
    MouseMove, 543, 194, 2
    randomSleep()
    MouseClick, left

    ; Write in amount of gold
    Send % getInventoryGold()
    randomSleep()

    ;Deposit
    MouseMove, 569, 161, 2
    randomSleep()
    MouseClick, left
    randomSleep()

    ;Select text area
    MouseMove, 550, 197, 2
    randomSleep()
    MouseClick, left
    randomSleep()

    ; Take out 5000
    Send, {BackSpace}{BackSpace}{BackSpace}{BackSpace}{BackSpace}{BackSpace}
    Send, 12000
    randomSleep()

    ;Withdraw
    MouseMove, 480, 163, 2
    randomSleep()
    MouseClick, left
    randomSleep()

    ; Bank Gem Loop
    loop{
        randomSleep()
        PixelSearch, Px, Py, topX, topY, botX, botY, 0xFF7FEC, 1, Fast ; VIOLET GEM
        if ErrorLevel{ ; IF not found
            PixelSearch, Px, Py, topX, topY, botX, botY, 0xEF511B, 0, Fast ; MOON GEM
            if ErrorLevel{ ; IF not found
                randomSleepRange(2000,3000)
                break
            }else{ ; if found
                MouseMove, Px, Py
                randomSleep()
                MouseClick, Left
                MouseMove, 607,419
                randomSleep()
                MouseClick, Left
            }
        }else{ ; if found
            MouseMove, Px, Py
            randomSleep()
            MouseClick, Left
            MouseMove, 607,419
            randomSleep()
            MouseClick, Left
        }
        randomSleepRange(300,500)
    }

    teleportAttempts := 0
    teleportToDesert:

    ; Teleport scroll
    MouseMove, 1205, 83, 2
    randomSleep()
    MouseClick, right
    randomSleepRange(3000,4000)

    PixelSearch, , , 484, 201, 486, 203, 0x52717B, 0, Fast
    if ErrorLevel{ ; IF not found
        if (teleportAttempts = 3){
            MsgBox, Unable to teleport to desert!
        }
        teleportAttempts++
        Goto, teleportToDesert
    }

    ; Blue marker thing
    MouseMove, 976, 344, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(1500,2200)

    ;Confirm buy
    MouseMove, 683, 148, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(1500,2000)

    ;close 
    MouseClick, left
    randomSleep()

    ; Set DH
    Send, {F10}
    randomSleep()

    MouseMove, 983, 764, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(1000,1200)
    MouseClick, left
    randomSleepRange(1000,1200)
}

toTheMine(){
    randomSleep()
    MouseMove, 1330, 262, 2
    randomSleep()
    MouseClick, right
    randomSleep()

    Send, {CTRL DOWN}
    loop{
        PixelSearch, Px, Py, 405, 39, 1417, 709, 0x2252AE, 0, Fast ; Search for mine guy
        if ErrorLevel{ ; IF not found
            Send, {CTRL DOWN}
            ; Hop Again
            Random, x, 1250, 1350
            Random, y, 250, 350

            MouseMove, x, y, 2
            randomSleepRange(50,100)
            MouseClick, left
            randomSleepRange(50,100)

            ;TODO Check to see if the character is in the top right of the map
            ; do something like if x<### && y< ### then click on the fixed spot

        }else{
            Send, {CTRL UP}
            ; Left click mine guy
            randomSleepRange(300,500)
            MouseMove, Px, Py, 2
            randomSleep()
            MouseClick, left
            randomSleep()

            PixelSearch, , , 651,63, 716,127, 0x526D7B, 0, Fast ; Search for mine guy ICON
            if ErrorLevel{ ; IF not found

            }else{
                

                ; ; Search again
                ; PixelSearch, Px, Py, 405, 39, 1417, 709, 0x2252AE, 0, Fast ; Search for mine guy
                ; if ErrorLevel{
                ;     continue
                ; }


                ; enter mine
                MouseMove, 726,147, 2
                randomSleep()
                MouseClick, left

                randomSleepRange(800,1000)
                
                PixelSearch, , , 980, 235, 982, 237, 0x425563, 0, Fast
                if ErrorLevel{ ; IF not found
                    continue
                }

                break
            }
        }
    }

    MouseMove, 1382, 664, 2
    ; Scan for the "end DH" thing
    Loop{
        PixelSearch, , , 1372,654, 1392,674, 0x4D3921, 0, Fast
        if ErrorLevel{ ; IF not found
            randomSleepRange(500,1000)
        }else{
            break
        }

        ;and stam is full
        PixelSearch, , , 447,720, 451,724, 0x927E02, 0, Fast
        if ErrorLevel{ ; IF not found
            Send, {F1}
        }else{
            Goto, startRun
        }
    }

    ; Stop DH
    MouseMove, 1382, 664, 2
    randomSleep()
    MouseClick, left
    randomSleep()

    ; Sit
    Send, {F1}
    randomSleepRange(12000,13000) ;Wait for stam

    startRun:

    MouseMove, 884, 684, 1
    randomSleep()
    MouseClick, right
    randomSleep()

    Send, {CTRL DOWN}
    ;first level
    jumpNum := 1
    Loop{

        ; Check to make sure we didn't go down a ladder by accient
        PixelSearch, , , 842, 463, 844, 465, 0x5D6276, 0, Fast
        if ErrorLevel{ ; IF not found
        }else{
            randomSleepRange(1000,1300)
            break
        }

        ; look for ladder
        PixelSearch, Px, Py, 423, 90, 1417, 722, 0x587D91, 0, Fast
        if ErrorLevel{ ; IF not found

        }else{
            randomSleepRange(1000,1300)
            PixelSearch, Px, Py, 423, 90, 1417, 722, 0x587D91, 0, Fast
            if ErrorLevel{
                continue
            }
            Send, {Ctrl Up}
            MouseMove, Px, Py, 2
            randomSleep()
            MouseClick, Left
            Send, {CTRL DOWN}

            randomSleepRange(3000,4000)
            ;check to make sure we went through
            PixelSearch, Px, Py, 423, 90, 1417, 722, 0x587D91, 0, Fast
            if ErrorLevel{
                continue
            }else{
                MouseMove, 520, 146, 2
                randomSleep()
                MouseClick, Left
                randomSleep()
                MouseClick, Left
                randomSleep()
            }
            break
        }

        ; 2 jumps right
        if (jumpNum = 1 || jumpNum = 2){
            Random, x, 1109-30, 1109+30
            Random, y, 651-30, 651+30

            MouseMove, x, y, 2
            randomSleepRange(50,100)
            MouseClick, Left
            jumpNum++
        }else{ ; 1 jump left
            Random, x, 771-30, 771+30
            Random, y, 643-30, 643+30

            MouseMove, x, y, 2
            randomSleepRange(50,100)
            MouseClick, Left
            jumpNum := 1
        }
        
        randomSleepRange(200,300)
    }
    randomSleepRange(500,700)

    ; Hop to allow the crystal check
    MouseMove, 1024, 579, 2
    randomSleepRange(50,100)
    MouseClick, Left
    randomSleepRange(500,700)

    ;2nd level
    Loop{

        ; Check to make sure we didn't go down a ladder by accient
        PixelSearch, , , 842, 463, 844, 465, 0x5D6276, 0, Fast
        if ErrorLevel{ ; IF not found
        }else{
            randomSleepRange(1000,1300)
            break
        }

        ; look for ladder
        PixelSearch, Px, Py, 423, 90, 1417, 722, 0x587D91, 0, Fast
        if ErrorLevel{ ; IF not found

        }else{
            randomSleepRange(1000,1300)
            PixelSearch, Px, Py, 423, 90, 1417, 722, 0x587D91, 0, Fast
            if ErrorLevel{
                continue
            }
            Send, {Ctrl Up}
            MouseMove, Px, Py, 2
            randomSleep()
            MouseClick, Left
            Send, {CTRL DOWN}

            randomSleepRange(3000,4000)
            break
        }
        if (jumpNum = 1){
            Random, x, 1245-30, 1245+30
            Random, y, 435-30, 435+30

            ; Check if jump is useless due to wall
            PixelSearch, , , x-1, y-1, x+1, y+1, 0x000000, 1, Fast
            if ErrorLevel{
                
            }else{
                jumpNum++
                continue
            }

            MouseMove, x, y, 2
            randomSleepRange(50,100)
            MouseClick, Left
            jumpNum++
        }else if (jumpNum = 2){
            Random, x, 1202-30, 1202+30
            Random, y, 634-30, 634+30

            MouseMove, x, y, 2
            randomSleepRange(50,100)
            MouseClick, Left
            jumpNum++
        }else{ ; 1 jump left
            Random, x, 948-30, 948+30
            Random, y, 672-30, 672+30

            MouseMove, x, y, 2
            randomSleepRange(50,100)
            MouseClick, Left
            jumpNum := 1
        }

        randomSleepRange(300,400)
    }

    ; Hop to allow the crystal check
    Random, amountOfJumps, 3, 10
    Loop % amountOfJumps{
        MouseMove, 1024, 579, 2
        randomSleepRange(50,100)
        MouseClick, Left
        randomSleepRange(500,700)
    }

    ; 3rd level
    Random, amountOfJumps, 1, 10
    Loop % amountOfJumps{

        ; look for ladder
        PixelSearch, Px, Py, 647, 223, 1312, 578, 0x587D91, 0, Fast
        if ErrorLevel{ ; IF not found

        }else{
            randomSleepRange(1000,1300)
            PixelSearch, Px, Py, 647, 223, 1153, 578, 0x587D91, 0, Fast
            if ErrorLevel{
                continue
            }
            MouseMove, Px, Py, 2
            randomSleep()
            MouseClick, Left

            randomSleepRange(1000,2000)
            break
        }

        ; 2 jumps up
        if (jumpNum = 1 || jumpNum = 2){
            Random, x, 1203-30, 1203+30
            Random, y, 296-30, 296+30

            MouseMove, x, y, 2
            randomSleepRange(50,100)
            MouseClick, Left
            jumpNum++
        }else{ ; 1 jump right
            Random, x, 1215-30, 1215+30
            Random, y, 620-30, 620+30

            MouseMove, x, y, 2
            randomSleepRange(50,100)
            MouseClick, Left
            jumpNum := 1
        }
        
        randomSleepRange(200,300)
    }

    global dropX
    global dropY
    Send, {CTRL UP}

    scatterMiner()
    prepareMiner()

    randomSleep()
    MouseMove, dropX, dropY
    randomSleep()
    MouseClick, Right
    randomSleep()
}

; scatterMiners(){
;     randomSleepRange(2000,3000)
;     global isPause
;     global account
;     isPause := true
;     account := 1
    
;     loop, 11{
;         switchAccount()
;         randomSleepRange(1000,2000)
;         ; do DH

;         MouseMove, 648,558,2
;         randomSleep()
;         MouseClick, right
;         randomSleep()

;         ; jump to the center
        

;         Random, amountOfJumps, 1, 7
;         Send, {Ctrl down}
;         loop % amountOfJumps{
;             Random, x, 648-50, 648+50
;             Random, y, 558-50, 558+50
            
;             MouseMove, x,y,2
;             randomSleep()
;             MouseClick, left
;             randomSleepRange(300,500)
;         }
;         Send, {Ctrl Up}
;         Random, jumpDir,1,4

;         if (jumpDir = 1){
;             Send, {Ctrl down}
;             loop % amountOfJumps{
;                 Random, x, 423, 920
;                 Random, y, 90, 406
                
;                 MouseMove, x,y,2
;                 randomSleep()
;                 MouseClick, left
;                 randomSleepRange(300,500)
;             }
;             Send, {Ctrl Up}
;         }else if (jumpDir = 2){
;             Send, {Ctrl down}
;             loop % amountOfJumps{
;                 Random, x, 920, 1417
;                 Random, y, 90, 406
                
;                 MouseMove, x,y,2
;                 randomSleep()
;                 MouseClick, left
;                 randomSleepRange(300,500)
;             }
;             Send, {Ctrl Up}
;         }else if (jumpDir = 3){
;             Send, {Ctrl down}
;             loop % amountOfJumps{
;                 Random, x, 423, 920
;                 Random, y, 406, 720
                
;                 MouseMove, x,y,2
;                 randomSleep()
;                 MouseClick, left
;                 randomSleepRange(300,500)
;             }
;             Send, {Ctrl Up}
;         }else{
;             Send, {Ctrl down}
;             loop % amountOfJumps{
;                 Random, x, 20, 1417
;                 Random, y, 406, 720
                
;                 MouseMove, x,y,2
;                 randomSleep()
;                 MouseClick, left
;                 randomSleepRange(300,500)
;             }
;             Send, {Ctrl Up}
;         }

        
;     }
    
; }

scatterMiner(){
    randomSleepRange(2000,3000)

    MouseMove, 648,558,2
    randomSleep()
    MouseClick, right
    randomSleep()

    ; jump to the center
    

    Random, amountOfJumps, 1, 7
    Send, {Ctrl down}
    loop % amountOfJumps{
        Random, x, 648-50, 648+50
        Random, y, 558-50, 558+50
        
        MouseMove, x,y,2
        randomSleep()
        MouseClick, left
        randomSleepRange(300,500)
    }
    Send, {Ctrl Up}
    Random, jumpDir,1,4

    if (jumpDir = 1){
        Send, {Ctrl down}
        loop % amountOfJumps{
            Random, x, 423, 920
            Random, y, 90, 406
            
            MouseMove, x,y,2
            randomSleep()
            MouseClick, left
            randomSleepRange(300,500)
        }
        Send, {Ctrl Up}
    }else if (jumpDir = 2){
        Send, {Ctrl down}
        loop % amountOfJumps{
            Random, x, 920, 1417
            Random, y, 90, 406
            
            MouseMove, x,y,2
            randomSleep()
            MouseClick, left
            randomSleepRange(300,500)
        }
        Send, {Ctrl Up}
    }else if (jumpDir = 3){
        Send, {Ctrl down}
        loop % amountOfJumps{
            Random, x, 423, 920
            Random, y, 406, 720
            
            MouseMove, x,y,2
            randomSleep()
            MouseClick, left
            randomSleepRange(300,500)
        }
        Send, {Ctrl Up}
    }else{
        Send, {Ctrl down}
        loop % amountOfJumps{
            Random, x, 20, 1417
            Random, y, 406, 720
            
            MouseMove, x,y,2
            randomSleep()
            MouseClick, left
            randomSleepRange(300,500)
        }
        Send, {Ctrl Up}
    }
}

; prepareMiners(){
;     randomSleepRange(2000,3000)
;     global isPause
;     global account
;     isPause := true
;     account := 1
    
;     loop, 11{
;         switchAccount()
;         randomSleepRange(1000,2000)

;         ; Grab DH
;         MouseMove, 1174,785, 2
;         randomSleep()
;         click, down
;         randomSleep()
;         MouseMove, 1162,665, 2
;         randomSleep()
;         ; drop DH
;         click, up
;         randomSleep()

;         ; open inventory
;         MouseMove, 983, 764, 2
;         randomSleep()
;         MouseClick, left
;         randomSleepRange(1000,1200)
;     }
; }

prepareMiner(){
    ; Grab DH
    MouseMove, 1174,785, 2
    randomSleep()
    click, down
    randomSleep()
    MouseMove, 1162,665, 2
    randomSleep()
    ; drop DH
    click, up
    randomSleep()

    ; open inventory
    MouseMove, 983, 764, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(1000,1200)
}



; Make sure the mouse is holding the current ore
checkHoldingOre(oreColour){
    MouseGetPos, x, y 

    PixelSearch, , , x-10, y-10, x+10, y+10, oreColour, 0, Fast
    if ErrorLevel{ ; IF not found
        return false
    }else{
        return true
    }
}

;070B0F Mine DUDE
;405, 39 CLIENT TOP LEFT
;1417, 709 CLIENT BOTTOM RIGHT

;1330, 262 CLick Area