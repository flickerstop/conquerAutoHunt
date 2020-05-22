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
        randomSleepRange(1000,2000)
        ;check to see if still there (not someone jumping by)
        PixelSearch, Px, Py, shadowX-10, shadowY-10, shadowX+10, shadowY+10, 0xFFFFFF, 0, Fast
        if ErrorLevel{ ; IF not found
            continue
        }
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
    tradeOverGoldAndGems()
return

i::
    coords := getXY()
    x := coords[1]
    y := coords[2]
    MsgBox % x . "," . y
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


    ; Walk to pharm
    MouseMove, 967, 88, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(6000,7000)

    ; Open pharm
    MouseMove, 981, 74, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(1000,2000)

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
                randomSleepRange(50,100)
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

        
        randomSleepRange(300,500)
        ; Check to see if popup is open
        PixelSearch, , , 711,70, 712, 71, 0x000000, 0, Fast
        if ErrorLevel{ ; IF not found

        }else{
            MouseMove, 726,147, 2
            randomSleep()
            MouseClick, left

            randomSleepRange(800,1000)
            
            ; Scan for being in the mine
            PixelSearch, , , 980, 235, 982, 237, 0x425563, 0, Fast
            if ErrorLevel{ ; IF not found
                continue
            }
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

    StartTime := A_TickCount

    startRun:

    MouseMove, 884, 684, 1
    randomSleep()
    MouseClick, right
    randomSleep()

    Send, {CTRL DOWN}
    ;first level
    jumpNum := 1
    Loop{

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
    MouseMove, 1024, 579, 2
    randomSleepRange(50,100)
    MouseClick, Left
    randomSleepRange(500,700)

    ;2nd level
    Loop{

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


    
    ; Random, jumpDir,1,4

    ; if (jumpDir = 1){
    ;     Send, {Ctrl down}
    ;     loop % amountOfJumps{
    ;         Random, x, 423, 920
    ;         Random, y, 90, 406
            
    ;         MouseMove, x,y,2
    ;         randomSleep()
    ;         MouseClick, left
    ;         randomSleepRange(300,500)
    ;     }
    ;     Send, {Ctrl Up}
    ; }else if (jumpDir = 2){
    ;     Send, {Ctrl down}
    ;     loop % amountOfJumps{
    ;         Random, x, 920, 1417
    ;         Random, y, 90, 406
            
    ;         MouseMove, x,y,2
    ;         randomSleep()
    ;         MouseClick, left
    ;         randomSleepRange(300,500)
    ;     }
    ;     Send, {Ctrl Up}
    ; }else if (jumpDir = 3){
    ;     Send, {Ctrl down}
    ;     loop % amountOfJumps{
    ;         Random, x, 423, 920
    ;         Random, y, 406, 720
            
    ;         MouseMove, x,y,2
    ;         randomSleep()
    ;         MouseClick, left
    ;         randomSleepRange(300,500)
    ;     }
    ;     Send, {Ctrl Up}
    ; }else{
    ;     Send, {Ctrl down}
    ;     loop % amountOfJumps{
    ;         Random, x, 920, 1417
    ;         Random, y, 406, 720
            
    ;         MouseMove, x,y,2
    ;         randomSleep()
    ;         MouseClick, left
    ;         randomSleepRange(300,500)
    ;     }
    ;     Send, {Ctrl Up}
    ; }
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

tradeOverGoldAndGems(){

    MouseMove, 631, 295, 2
    randomSleep()
    MouseClick, left
    randomSleep()
    ; Write in amount of gold
    Send % getInventoryGold()
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
        if (gemCount > 6){
            MsgBox, Too many gems! Manually trade them over!
            break
        }
        randomSleepRange(300,500)
    }
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