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

dcAttempts := 0

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
switchAccount()
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
        withdrawBank()
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
        randomSleepRange(5000,6000)

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
    isPause := false
return


f5::
    tradeOverGoldAndGems()
return

f8::
    resetFromDead()
    Pause,Toggle
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

    loop{
        if (WinExist("Tip")){
            randomSleep()
            WinActivate, Tip
            randomSleep()
            MouseMove, 1058,465
            randomSleep()
            MouseClick, Left
            randomSleep()
        }else{
            break
        }
    }

    randomSleepRange(5000,6000)
    
    MouseMove, accountX[account], 855, 2
    randomSleep()
    MouseClick, Left
    randomSleep()
    account++

    if (account = 12){
        account := 1
    }
    
    checkIfDC()
    checkIfPopupOpen()
    checkIfSettingsWrong()
    checkIfInventoryNotOpen()
    checkIfDead()
}

bank(){
    global topX 
    global topY 
    global botX 
    global botY 

    randomSleepRange(500,1000)


    ; check to see if the player is not already at ape
    PixelSearch, , , 887-1, 680-1, 887+1, 680+1, 0x947DB0, 1, Fast
    if ErrorLevel{ ; IF not found
        ; ape scroll
        MouseMove, 1206,82, 2
        randomSleep()

        ;right click to teleport
        MouseClick, right
        randomSleepRange(3000,4000)
    }else{
        ; Close Inventory
        MouseMove, 970, 762, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        randomSleepRange(1000,2000)
    }

    


    ; Walk to pharm
    MouseMove, 967, 88, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(8000,10000)

    ; Open pharm
    MouseMove, 981, 74, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(1000,2000)

    ;;;;;;;;;;;;;;;
    ; Check to see if pharm is opened
    PixelSearch, , , 613-5, 283-5, 613+5, 283+5, 0x5A4929, 1, Fast
    if ErrorLevel{ ; IF not found
        MsgBox, Pharm not opened! Walk to the spot and open the pharm!
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

    ; Close inventory/Store
    MouseMove, 634, 331, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(1000,1200)

    ; Walk to WH
    MouseMove, 1392, 296, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(6000,7000)

    ; Open WH
    MouseMove, 1308, 585, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(1000,1200)
}

getInventoryGold(){
    return StrReplace(OCR([1271, 418, 82, 20]),",","")
}

getBankGold(){
    return StrReplace(OCR([529,220, 609-529, 234-220]),",","")
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
    randomSleepRange(5000,6000)

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

    ;; TODO
    ; Add if it takes more than 3 minutes, just start mining

    randomSleep()
    MouseMove, 1330, 262, 2
    randomSleep()
    MouseClick, right
    randomSleep()

    Send, {CTRL DOWN}

    clickAttempts := 0
    ; Hop to mine dude
    loop{
        ; Check coords are close to the miner
        ;coords := getXY()
        ;Console.log(coords)
        if (false) { ;(coords[2] < 14 and coords[2] > 0){
            OutputDebug % coords[2]
            Random, x, 1176, 1212
            Random, y, 139, 237

            MouseMove, x, y, 2
            randomSleepRange(50,100)
            MouseClick, left
            clickAttempts++

        }else{
            ; Hop towards the mine entrance
            PixelSearch, Px, Py, 1153, 37, 1422, 248, 0x392010, 0, Fast ; Search for mine guy
            if ErrorLevel{ ; IF not found
                Send, {CTRL DOWN}
                ; Hop Again
                Random, x, 1250, 1350
                Random, y, 250, 350

                MouseMove, x, y, 2
                randomSleepRange(50,100)
                MouseClick, left
                randomSleepRange(50,100)
            }else{
                MouseMove, Px, Py-30, 2
                randomSleepRange(50,100)
                MouseClick, left
                randomSleepRange(300,500)
                clickAttempts++
            }
        }

        ;if unable to open the miner box
        if (clickAttempts > 6){
            loop,4{
                MouseMove, 515,343, 2
                randomSleepRange(300,500)
                MouseClick, left
            }
            clickAttempts := 0
        }

        
        randomSleepRange(100,200)
        ; Check to see if popup is open
        PixelSearch, , , 711,70, 712, 71, 0x000000, 0, Fast
        if ErrorLevel{ ; IF not found

        }else{
            MouseMove, 726,147, 2
            randomSleep()
            MouseClick, left

            randomSleepRange(800,1000)
            
            ;FIXME Removed this to stop a bug, might cause bugs
            ; ; Scan for being in the mine
            ; PixelSearch, , , 980, 235, 982, 237, 0x425563, 0, Fast
            ; if ErrorLevel{ ; IF not found
            ;     continue
            ; }
            break
        }
    }

    Send, {Ctrl Up}

    MouseMove, 1382, 664, 2
    ; Scan for the "end DH" thing
    Loop{
        PixelSearch, , , 1372,654, 1392,674, 0x4D3921, 0, Fast
        if ErrorLevel{ ; IF not found
            randomSleepRange(500,1000)
        }else{
            break
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

    StartTime := A_TickCount

    startRun:

    MouseMove, 884, 684, 1
    MouseClick, left
    randomSleep()
    MouseClick, right
    randomSleep()
    MouseClick, left

    Send, {CTRL DOWN}
    ;first level
    jumpNum := 1
    Loop{
        Send, {CTRL DOWN}

        if (A_TickCount > StartTime+180000){
            Goto, endMineRun
        }

        randomSleepRange(200,300)
        
        ; Check to make sure we didn't go down a ladder by accient
        PixelSearch, , , 840, 460, 850, 470, 0x5D6276, 0, Fast
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
    
    }
    randomSleepRange(500,700)

    ; Hop to allow the crystal check
    Send, {Ctrl Up}
    MouseMove, 1024, 579, 2
    MouseClick, right
    randomSleepRange(50,100)
    MouseClick, Left
    randomSleepRange(500,700)
    MouseClick, Left
    Send, {CTRL DOWN}

    ;2nd level
    Loop{
        Send, {CTRL DOWN}

        if (A_TickCount > StartTime+180000){
            Goto, endMineRun
        }

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
            Send, {Ctrl Up}
            MouseClick, Left
            Send, {CTRL DOWN}
            jumpNum++
        }else if (jumpNum = 2){
            Random, x, 1202-30, 1202+30
            Random, y, 634-30, 634+30

            MouseMove, x, y, 2
            randomSleepRange(50,100)
            MouseClick, Left
            Send, {Ctrl Up}
            MouseClick, Left
            Send, {CTRL DOWN}
            jumpNum++
        }else{ ; 1 jump left
            ; checkIfMinerTooLow()
            ; if (checkIfMinerTooLow() = false){
            Random, x, 948-30, 948+30
            Random, y, 672-30, 672+30

            MouseMove, x, y, 2
            randomSleepRange(50,100)
            MouseClick, Left
            Send, {Ctrl Up}
            MouseClick, Left
            Send, {CTRL DOWN}
                
            ; }
            jumpNum := 1
        }

        randomSleepRange(300,400)
    }

    ; Hop to allow the crystal check
    Send, {Ctrl Up}
    MouseMove, 1024, 579, 2
    MouseClick, right
    randomSleepRange(50,100)
    MouseClick, Left
    randomSleepRange(500,700)
    MouseClick, Left
    Send, {CTRL DOWN}

    ;NOTE trying to go down to 4th level now
    ;3nd level
    Loop{
        Send, {CTRL DOWN}
        if (A_TickCount > StartTime+180000){
            Goto, endMineRun
        }

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
            checkIfMinerTooLow()
            if (checkIfMinerTooLow() = false){
                Random, x, 948-30, 948+30
                Random, y, 672-30, 672+30

                MouseMove, x, y, 2
                randomSleepRange(50,100)
                MouseClick, Left
                
            }
            jumpNum := 1
        }

        randomSleepRange(300,400)
    }

    endMineRun:

    global dropX
    global dropY
    Send, {CTRL UP}

    scatterMiner()
    moveAwayFromMiners()
    prepareMiner()
    

    randomSleep()
    MouseMove, dropX, dropY
    randomSleep()
    MouseClick, Right
    randomSleep()
}

scatterMiner(){
    randomSleepRange(2000,3000)

    MouseMove, 648,558,2
    randomSleep()
    MouseClick, right
    randomSleep()


    
    ; Hop to center of room
    Random, amountOfJumps, 8, 24
    Loop % amountOfJumps{
        Random, x, 1024-20, 1024+20
        Random, y, 579-20, 579+20

        MouseMove, x, y, 2
        randomSleepRange(50,100)
        Send, {Ctrl Down}
        MouseClick, Left
        Send, {Ctrl Up}
        randomSleepRange(50,100)
        MouseClick, Left
        randomSleepRange(500,700)
    }

}

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

moveAwayFromMiners(){


    boxX := [[749,1033],[749,1033],[749,843],[959,1033]]
    boxY := [[236,304],[446,525],[304,446],[304,446]]
    

    moveAway := false

    Loop, 4{
        x1 := boxX[A_Index][1]
        x2 := boxX[A_Index][2]

        y1 := boxY[A_Index][1]
        y2 := boxY[A_Index][2]

        createBox5("f1c40f")
        box5(x1, y1, x2-x1, y2-y1, 1, "out")

        ; Search for male miners
        PixelSearch, pX, pY, x1, y1, x2, y2, 0x8A7461, 3, Fast
        if ErrorLevel{ ; IF not found
            ; Search for female miners
            PixelSearch, pX, pY, x1, y1, x2, y2, 0xEFBA6D, 3, Fast
            if ErrorLevel{ ; IF not found
                ; Search for female miners
                PixelSearch, pX, pY, x1, y1, x2, y2, 0xE2E6D2, 3, Fast
                if ErrorLevel{ ; IF not found
                    PixelSearch, pX, pY, x1, y1, x2, y2, 0xFFFFFF, 3, Fast
                    if ErrorLevel{ ; IF not found
                        ; MsgBox, Nothing found
                    }else{
                        createBox4("e74c3c")
                        box4(pX-5, pY-5, 10, 10, 1, "out")
                        moveAway := true
                    }
                }else{
                    createBox4("e74c3c")
                    box4(pX-5, pY-5, 10, 10, 1, "out")
                    moveAway := true
                }
            }else{
                createBox4("e74c3c")
                box4(pX-5, pY-5, 10, 10, 1, "out")
                moveAway := true
            }
        }else{
            createBox4("FF0000")
            box4(pX-5, pY-5, 10, 10, 1, "out")
            moveAway := true
        }

        ; randomSleepRange(1000,2000)
        ; if (moveAway){
        ;     MsgBox % x1 . "," . y1 . "         " . x2 . "," . y2
        ;     moveAway := false
        ; }
        RemoveBox5()
        
    }

    if (moveAway){
        Random, x, 482, 1339
        Random, y, 102, 629

        MouseMove, x, y, 2
        randomSleep()
        Send, {CTRL DOWN}
        MouseClick, Left
        Send, {CTRL UP}
        MouseClick, Left
        randomSleepRange(1000,1200)
        Send, {f1}
        randomSleep()
        RemoveBox4()
        moveAwayFromMiners()
    }else{
        Send, {f1}
        randomSleep()
    }


}


getXY(){

    coords := StrSplit(StrReplace(StrReplace(StrReplace(OCR([517, 36, 65, 18]),"(",""),"{",""),")",""),",")
    ; x := coords[1]
    ; y := coords[1]
    
    

    return coords
}

checkIfMinerTooLow(){
    coords := getXY()
    x := coords[1]
    y := coords[2]

    if (y > 120){
        MouseMove, 1233,407
        randomSleep()
        MouseClick, left
        randomSleepRange(400,600)
        return true
    }
    return false

}

withdrawBank(){
    MouseMove,552,196,2
    randomSleep()
    MouseClick, left
    randomSleep()
    Send % getBankGold()
    randomSleep()
    MouseMove, 477, 163, 2
    randomSleep()
    MouseClick, left
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

checkIfDC(){
    global dcAttempts
    PixelSearch, , , 856-1,145-1, 856+1,145+1, 0x3CBCCA, 0, Fast
    if ErrorLevel{ ; IF not found
        return
    }

    randomSleepRange(1000,2000)

    ;select password
    MouseMove, 902,720, 2
    MouseClick, Left
    randomSleep()
    MouseClick, Left
    randomSleep()
    Send, {BackSpace}{BackSpace}{BackSpace}{BackSpace}{BackSpace}{BackSpace}{BackSpace}{BackSpace}
    Send, password

    randomSleep()
    MouseMove, 1113, 755, 2
    randomSleep()
    MouseClick, Left
    randomSleep()

    randomSleepRange(30000,40000)

    PixelSearch, , , 856-1,145-1, 856+1,145+1, 0x3CBCCA, 0, Fast
    if ErrorLevel{ ; IF not found
        
    }else{
        randomSleep()
        MouseMove, 898,463, 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(3000,4000)
        dcAttempts++

        if (dcAttempts > 4){
            dcAttempts := 0
            return
        }
        checkIfDC()
    }

    ; Close "vote"
    MouseMove, 1103, 337, 2
    randomSleep()
    MouseClick, Left
    randomSleep()
    randomSleepRange(1000,2000)

    ; Check to see if patch notes up
    PixelSearch, OutputVarX, , 1245, 483, 1247, 485, 0x568CAC, 0,fast
    if ErrorLevel{ ; IF not found

    }else{
        MouseMove, 1171, 253, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        randomSleepRange(1000,2000)
    }


    ; Open Inventory
    MouseMove, 970, 762, 2
    randomSleep()
    MouseClick, Left
    randomSleep()
    randomSleepRange(1000,2000)

    ; Open Settings
    MouseMove, 1229, 740, 2
    randomSleep()
    MouseClick, Left
    randomSleep()
    randomSleepRange(4000,5000)

    ; Click the 5 buttons
    buttonY := [527,465,406,349,287]
    Loop, 5{
        MouseMove, 1004, buttonY[A_Index], 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(2000,3000)
    }
    ; Close settings
    MouseMove, 1060, 247, 2
    randomSleep()
    MouseClick, Left
    randomSleep()
    
    ; Start mining
    MouseMove, 1289, 626, 2
    randomSleep()
    MouseClick, right
    randomSleep()

    randomSleepRange(2000,3000)
}

checkIfPopupOpen(){
    ; Check if hourly thing open

    ; Check to see if patch notes up
    PixelSearch, OutputVarX, , 1245, 483, 1247, 485, 0x568CAC, 0,fast
    if ErrorLevel{ ; IF not found

    }else{
        MouseMove, 1171, 253, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        randomSleepRange(1000,2000)
    }

    ; Check if vote is showing
    PixelSearch, , , 1022-1,478-1, 1022+1,478+1, 0x00F584, 0, Fast
    if ErrorLevel{ ; IF not found
        return
    }
    randomSleep()
    MouseMove, 1103,335,2
    randomSleep()
    MouseClick, left
    randomSleep()
}

checkIfSettingsWrong(){
    ; Check to see if arena button is up
    PixelSearch, , , 975-1,708-1, 975+1, 708+1, 0x4AB2EF, 0, Fast
    if ErrorLevel{ ; IF not found
        return
    }

    ; Open Settings
    MouseMove, 1229, 740, 2
    randomSleep()
    MouseClick, Left
    randomSleep()
    randomSleepRange(4000,5000)

    ; Click the 5 buttons
    buttonY := [527,465,406,349,287]
    Loop, 5{
        MouseMove, 1004, buttonY[A_Index], 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(2000,3000)
    }
    ; Close settings
    MouseMove, 1060, 247, 2
    randomSleep()
    MouseClick, Left
    randomSleep()

}

checkIfInventoryNotOpen(){
    PixelSearch, , , 1255-1, 429-1, 1255+1, 429+1, 0x635131, 0, Fast
    if ErrorLevel{ ; IF not found
        ; Open Inventory
        MouseMove, 970, 762, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        randomSleepRange(1000,2000)
    }
}

checkIfDead(){
    ; Check HP
    PixelSearch, , , 434-1, 777-1, 434+1, 777+1, 0x887F74, 0, Fast
    if ErrorLevel{ ; IF not found
        return
    }else{
        PixelSearch, , , 1340-1, 654-1, 1340+1, 654+1, 0x94BED6, 0, Fast
        if ErrorLevel{ ; IF not found
            return
        }else{
            ; Start the DC train

            account := 1
            accountX := [538,641,752,861,960,1065,1166,1274,1373,1479,1588]

            loop{
                ; Close the DC tip
                loop{
                    if (WinExist("Tip")){
                        randomSleep()
                        WinActivate, Tip
                        randomSleep()
                        MouseMove, 1058,465
                        randomSleep()
                        MouseClick, Left
                        randomSleep()
                    }else{
                        break
                    }
                }
                randomSleepRange(1000,2000)
                
                MouseMove, accountX[account], 855, 2
                randomSleep()
                MouseClick, Left
                randomSleep()

                ; Check if account is logged out already
                PixelSearch, , , 856-1,145-1, 856+1,145+1, 0x3CBCCA, 0, Fast
                if ErrorLevel{ ; IF not found
                    
                }else{
                    account++
                    if (account = 12){
                        MsgBox, One miner was detected dead. All logged out!
                    }
                    continue
                }
                ; Type DC
                MouseMove, 758,741,2
                randomSleep()
                MouseClick, Left
                randomSleep()
                Send, /dc
                Send, {enter}



                account++
                if (account = 12){
                    MsgBox, One miner was detected dead. All logged out!
                }
            }
        }
    }
}

resetFromDead(){
    account := 1
    accountX := [538,641,752,861,960,1065,1166,1274,1373,1479,1588]
    loop{
        randomSleepRange(1000,2000)
        
        MouseMove, accountX[account], 855, 2
        randomSleep()
        MouseClick, Left
        randomSleep()

        ; Check for REV button
        PixelSearch, , , 1340-1, 654-1, 1340+1, 654+1, 0x94BED6, 0, Fast
        if ErrorLevel{ ; IF not found
            account++
            if (account = 12){
                MsgBox, All Miners rev'd
            }
            continue
        }

        ; Click rev button
        MouseMove, 1357,657, 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(3000,5000)

        ; open inventory
        MouseMove, 970, 762, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        randomSleepRange(1000,2000)

        ; Check if player has both teleport scrolls
        PixelSearch, , , 1213-1, 91-1, 1213+1, 91+1, 0x63AEDE, 0, Fast
        if ErrorLevel{ ; IF not found
            
        }else{
            PixelSearch, , , 1253-1, 91-1, 1253+1, 91+1, 0x29AED6, 0, Fast
            if ErrorLevel{ ; IF not found
                
            }else{
                ; Both Scrolls Found teleport to AC
                MouseMove, 1213, 91, 2
                randomSleep()
                MouseClick, Right
                randomSleep()
            }
        }



        account++
        if (account = 12){
            MsgBox, All Miners rev'd
        }
    }

}

tradeOverGoldAndGems(){

    global topX 
    global topY 
    global botX 
    global botY 

    MouseMove, 631, 295, 2
    randomSleep()
    MouseClick, left
    randomSleep()
    ; Write in amount of gold
    Send % (getInventoryGold() - 30000)
    randomSleep()

    gemCount := 0
    ; Trade Gem Loop
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
                MouseMove, 530,331
                randomSleep()
                MouseClick, Left
                gemCount++
            }
        }else{ ; if found
            MouseMove, Px, Py
            randomSleep()
            MouseClick, Left
            MouseMove, 530,331
            randomSleep()
            MouseClick, Left
            gemCount++
        }
        if (gemCount = 6){
            gemCount := 0
            MouseMove, 568,339,2
            randomSleep()
            MouseClick, left
            randomSleep()
        }
        randomSleepRange(300,500)
    }
    MouseMove, 614,348,2
    randomSleep()
    MouseClick, left
    randomSleep()

    MouseMove, 538,369,2
    randomSleep()
    MouseClick, left
    randomSleep()


}

;070B0F Mine DUDE
;405, 39 CLIENT TOP LEFT
;1417, 709 CLIENT BOTTOM RIGHT

;1330, 262 CLick Area