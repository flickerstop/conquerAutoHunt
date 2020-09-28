#Include drawBox.ahk
#include .\lib\Vis2.ahk
#Include textOnScreen.ahk

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
rotationStartTime := 0

sleepMultiplyer := 2

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

; TODO
;TODO
;TODO
;Refine the banking more
; miner once jumped past the pharm
; tighten up the randomness
; create a test script that hops to the pharm over and over to test it

attempts := 0
account := 1
isPause := false
rotationStartTime := A_TickCount
Random, rotationInterval, 9, 10

nextResetGui("" . Ceil((rotationStartTime+(1000*60*rotationInterval)-A_TickCount)/1000/60) . " minutes Left")
textGui("Switching to first account")
switchAccount()
Loop{

    
    ; Checking if player has rev'd from being dead
    PixelSearch, , , 596-1, 153-1, 596+1, 153+1, 0x4A9673, 0, Fast
    if ErrorLevel{ ; IF not found
    }else{
        DCbankFromScroll(true)
    }

    textGui("Looking for Ore\nAttempt:" . attempts . "/9")
    nextResetGui("" . Ceil((rotationStartTime+(1000*60*rotationInterval)-A_TickCount)/1000/60) . " minutes Left")
    if (A_TickCount > rotationStartTime+(1000*60*rotationInterval)){
        rotationStartTime := A_TickCount
        isPause := true
        account := 1
        loop, 1{

            switchAccount()
            randomSleepRange(1000,2000)
            DCbankFromScroll()
        }
        isPause := false
    }
    
    if (isPause = true){
        randomSleepRange(1000,2000)
        continue
    }

    if (attempts > 9){
        textGui("9 Attempts done, switching")
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
                ; switchAccount()
                ; randomSleep()
                ; attempts := 0
                textGui("Sleeping for 30 seconds\nInstead of switching accounts")

                randomSleepRange(30000,32000)
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
    loop, 1{
        switchAccount()
        randomSleepRange(1000,2000)
        DCbankFromScroll()
    }
    isPause := false
return


; Just sell and sit at the bank
g::
    prepareTrading()
return


; Hop back to the mine
m::
    global isPause
    global account
    isPause := true
    account := 1
    loop, 1{
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

randomSleep(){
    global sleepMultiplyer
    Random, x, 300*sleepMultiplyer, 500*sleepMultiplyer
    Sleep, x
}

randomSleepRange(min,max){
    global sleepMultiplyer
    Random, x, min*sleepMultiplyer, max*sleepMultiplyer
    Sleep, x
}

switchAccount(){
    global account

    accountX := [538,538,538,538,538,538,538,538,538,538,538]

    loop{
        textGui("Looking for DC window")
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

    randomSleepRange(500,1000)
    textGui("Switching Windows")
    
    MouseMove, accountX[account], 855, 2
    randomSleep()
    MouseClick, Left
    randomSleep()
    textGui("Checking if DC'd")
    checkIfDCWhileMining()
    textGui("Checking if Popup Open")
    checkIfPopupOpen()
    textGui("Checking if Settings Wrong")
    checkIfSettingsWrong()
    textGui("Checking if Inventory NOT opened")
    checkIfInventoryNotOpen()

    textGui("Checking if Dead")
    ; If it's dead now, try to revive all the other ones!
    if (isDeadNow()){
        loop, 1{
            MouseMove, accountX[A_Index], 855, 2
            MouseClick, Left
            if (isDeadNow()){
                ; Revive
                Mousemove, 1348,656,2
                randomSleep()
                MouseClick, left
                randomSleep()
            }
        }
        ; Go back to the current account
        MouseMove, accountX[account], 855, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
    }
    resetIfDead()

    account++

    if (account = 12){
        account := 1
    }
    
}

getInventoryGold(){
    return StrReplace(OCR([1271, 418, 82, 20]),",","")
}

getBankGold(){
    return StrReplace(StrReplace(OCR([529,220, 609-529, 234-220]),",","")," ","")
}

updateGoldGui(){
    totalCoins := 0

    totalMoneyGui("" . CommaAdd(totalCoins) . " coins")
}

; Formats a number nicely
CommaAdd(num) {
    VarSetCapacity(fNum,32)
    DllCall("GetNumberFormat",UInt,0x0409,UInt,0,Str,Num,UInt,0,Str,fNum,Int,32)
    return SubStr(fNum,1,StrLen(fNum) - 3)
}

wharehouse(){
    global

    textGui("WH Open")

    textGui("WH Open\nEmptying Gold")
    ;Select text area
    MouseMove, 543, 194, 2
    randomSleep()
    MouseClick, left
    randomSleep()
    MouseClick, left
    ; Write in amount of gold
    Send % getInventoryGold() - 5000
    randomSleep()

    ;Deposit
    MouseMove, 569, 161, 2
    randomSleep()
    MouseClick, left
    randomSleep()


    ; Bank Gem Loop
    loop{
        textGui("WH Open\nEmptying Gems")
        if (checkIfDCMidAction()){
            break
        }
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

    
    ; Check account's Gold
    ; MsgBox % account
    ; MsgBox % gold[account]
    ; currentGold := getBankGold()
    ; gold[account] := currentGold
    ; MsgBox % gold[(account)]

    ; Can't get f***ing arrays to work
    

    ; updateGoldGui()
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MINE STUFF

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

toTheMine(){
    textGui("To the Mine\nStarting DH")


    MouseClick, right
    Send, {f10}
    MouseClick, right

    randomSleep()
    MouseMove, 1372, 421, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(1000,1200)
    MouseClick, right
    randomSleep()

    Send, {CTRL DOWN}
    SetKeyDelay 10,20
    loop,25{
        Send, {f10}
        MouseClick, right

        textGui("To the Mine\nHopping without checks")
        Send, {CTRL DOWN}
        ; Hop Again
        Random, x, 1250, 1350
        Random, y, 250, 350

        MouseMove, x, y, 2
        randomSleepRange(50,100)
        MouseClick, left
        Send, {CTRL UP}
        MouseClick, left
        Send, {CTRL DOWN}
        randomSleepRange(50,100)
    }

    checkIfDCMidAction()

    jumps := 0
    clickAttempts := 0
    ; Hop to mine dude
    loop{
        textGui("To the Mine\nLooking for Mine Guy")
        jumps++
        if (jump > 10){
            checkIfDCMidAction()
            jumps := 0

            if (isDeadNow()){
                ; Revive
                Mousemove, 1348,656,2
                randomSleep()
                MouseClick, left
                randomSleep()

                randomSleepRange(4000,6000)
                DCbankFromScroll()
                return
            }
        }
        ; Check coords are close to the miner
        ;coords := getXY()
        ;Console.log(coords)
        
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
            Send, {CTRL UP}
            MouseClick, left
            Send, {CTRL DOWN}
            randomSleepRange(50,100)
        }else{
            MouseMove, Px, Py-30, 2
            randomSleepRange(50,100)
            MouseClick, left
            randomSleepRange(300,500)
            clickAttempts++
        }

        ;if unable to open the miner box
        if (clickAttempts > 6){
            loop,4{
                textGui("To the Mine\nBacking away from mine")
                MouseMove, 515,343, 2
                randomSleepRange(300,500)
                MouseClick, left
            }
            clickAttempts := 0
        }

        
        ; Check to see if popup is open
        PixelSearch, , , 711,70, 712, 71, 0x000000, 0, Fast
        if ErrorLevel{ ; IF not found

        }else{
            textGui("To the Mine\nEntering Mine")
            MouseMove, 726,147, 2
            randomSleep()
            MouseClick, left

            randomSleepRange(800,1000)

            break
        }
    }
    
    Send, {Ctrl Up}
    MouseMove, 1382, 664, 2
    ; Scan for the "end DH" thing
    Send, {F1}
    Loop,40{
        Send, {F1}
        textGui("Mine lvl 1\nScanning for DH End\n" . A_Index . "/40")
        checkIfDCMidAction()

        PixelSearch, , , 1372,654, 1392,674, 0x4D3921, 0, Fast
        if ErrorLevel{ ; IF not found
            randomSleepRange(500,1000)
        }else{
            ; Stop DH
            MouseMove, 1382, 664, 2
            randomSleep()
            MouseClick, left
            randomSleep()
            break
        }

        ; Look to see if we're gaining stam
        PixelSearch, , , 448-1,785-1, 448+1,785+1, 0x978728, 0, Fast
        if ErrorLevel{ ; IF not found
        }else{
            break
        }

    }
    ; Sit
    Send, {F1}
    Send, {F1}
    Send, {F1}
    Send, {F1}
    textGui("Mine lvl 1\nSitting for Stam")
    randomSleepRange(17000,19000) ;Wait for stam

    if (isDeadNow()){
        resetIfDead()
        return
    }

    StartTime := A_TickCount

    startRun:
    Random, isGoingLeft, 0, 1
    if (isGoingLeft == 1){
        textGui("Mine lvl 1\nHopping to Ladder")
        MouseMove, 884, 684, 1
        MouseClick, left
        randomSleep()
        MouseClick, right
        randomSleep()
        MouseClick, left

        Send, {CTRL DOWN}
        ;first level
        jumpNum := 1
        ladderClicks := 0
        Loop{
            textGui("Mine lvl 1\nHopping to Ladder\nJump #" . jumpNum)
            if (isDeadNow()){
                resetIfDead()
                return
            }

            MouseClick, right

            checkIfDCMidAction()
            Send, {CTRL DOWN}

            if (A_TickCount > StartTime+180000){
                Goto, endMineRun
            }

            ; look for ladder
            PixelSearch, Px, Py, 423, 90, 1417, 722, 0x587D91, 0, Fast
            if ErrorLevel{ ; IF not found

            }else{
                textGui("Mine lvl 1\nLadder Found!")
                randomSleepRange(1000,1300)
                PixelSearch, Px, Py, 423, 90, 1417, 722, 0x587D91, 0, Fast
                if ErrorLevel{
                    continue
                }
                Send, {Ctrl Up}
                MouseMove, Px, Py, 2
                MouseClick, Left
                Send, {CTRL DOWN}
                ladderClicks++

                waitForMomentStop()


                if (ladderClicks > 5){
                    MouseMove, Px+200, Py-200, 2
                    Send, {Ctrl Up}
                    MouseMove, Px, Py, 2
                    randomSleep()
                    MouseClick, Left
                    Send, {CTRL DOWN}
                    randomSleepRange(600,1000)
                    ladderClicks:=0
                }

                ;check to make sure we went through
                PixelSearch, Px, Py, 1089-1, 169-1, 1089+1, 169+1, 0x29384A, 0, Fast
                if ErrorLevel{
                    continue
                }else{
                    
                }
                break
            }

            ; Check if we went down the ladder by accient 
            PixelSearch, Px, Py, 1089-1, 169-1, 1089+1, 169+1, 0x29384A, 0, Fast
            if ErrorLevel{
                
            }else{
                break
            }

            ; 2 jumps down
            if (jumpNum = 1 || jumpNum = 2){
                Random, x, 771-30, 771+30
                Random, y, 680-30, 680+30

                MouseMove, x, y, 2
                MouseClick, Left
                jumpNum++
            }else{ ; 1 jump left
                Random, x, 541-30, 541+30
                Random, y, 399-30, 399+30

                MouseMove, x, y, 2
                MouseClick, Left
                jumpNum := 1
            }

            
            Send,{ctrl up}
            waitForMomentStop()
            Send,{ctrl down}

            
        }

        textGui("Mine lvl 2\nLadder")
        randomSleepRange(500,700)

        ; Hop to allow the crystal check
        Send, {Ctrl Up}
        MouseMove, 817, 427, 2
        MouseClick, right
        randomSleepRange(50,100)
        MouseClick, Left
        randomSleepRange(500,700)
        MouseClick, Left
        Send, {CTRL DOWN}

        ;second level
        jumpNum := 1
        Loop{
            textGui("" . Ceil((StartTime+180000-A_TickCount)/1000) . " seconds Left\nMine lvl 2\nHopping to Ladder\nJump #" . jumpNum)
            if (isDeadNow()){
                resetIfDead()
                return
            }

            checkIfDCMidAction()
            Send, {CTRL DOWN}

            if (A_TickCount > StartTime+180000){
                Goto, endMineRun
            }

            ; look for ladder
            PixelSearch, Px, Py, 423, 90, 1417, 722, 0x587D91, 0, Fast
            if ErrorLevel{ ; IF not found

            }else{
                textGui("Mine lvl 2\nLadder Found!")
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

                waitForMomentStop()

                ;check to make sure we went through
                PixelSearch, Px, Py, 578-1, 222-1, 578+1, 222+1, 0x182839, 0, Fast
                if ErrorLevel{
                    continue
                }
                break
            }

            ; 2 jumps right
            if (jumpNum = 1 || jumpNum = 2){
                Random, x, 1096-30, 1096+30
                Random, y, 684-30, 684+30

                MouseMove, x, y, 2
                MouseClick, Left
                jumpNum++
            }else{ ; 1 jump left
                Random, x, 745-30, 745+30
                Random, y, 621-30, 621+30

                MouseMove, x, y, 2
                MouseClick, Left
                jumpNum := 1
            }

            Send,{ctrl up}
            MouseClick, left
            randomSleepRange(50,100)
            MouseClick, left
            randomSleepRange(100,200)
            Send,{ctrl down}

            ; check to see if we went down a ladder by accident
            PixelSearch, , , 578-1, 222-1, 578+1, 222+1, 0x182839, 0, Fast
            if ErrorLevel{
            }else{
                break
            }

            ; look for crystals
            PixelSearch, , , 857-1, 446-1, 857+1, 446+1, 0x212439, 0, Fast
            if ErrorLevel{
            }else{
                break
            }
        }

        textGui("Mine lvl 3\nMoving from Crystals")
        ; Hop to allow the crystal check
        Send, {Ctrl Up}
        MouseMove, 1024, 579, 2
        MouseClick, right
        randomSleepRange(50,100)
        MouseClick, Left
        randomSleepRange(500,700)
        MouseClick, Left
        Send, {CTRL DOWN}

        ;3nd level
        Loop{
            textGui("" . Ceil((StartTime+180000-A_TickCount)/1000) . " seconds Left\nMine lvl 3\nHopping to Ladder\nJump #" . jumpNum)
            if (isDeadNow()){
                resetIfDead()
                return
            }

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
                textGui("" . Ceil((StartTime+180000-A_TickCount)/1000) . " seconds Left\nMine lvl 3\nLadder Found")
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
                ; checkIfMinerTooLow()
                ; if (checkIfMinerTooLow() = false){
                    Random, x, 948-30, 948+30
                    Random, y, 672-30, 672+30

                    MouseMove, x, y, 2
                    randomSleepRange(50,100)
                    MouseClick, Left
                    
                ;}
                jumpNum := 1
            }

            randomSleepRange(300,400)
        }



    }else{
        textGui("Mine lvl 1\nHopping to Ladder")
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
            textGui("Mine lvl 1\nHopping to Ladder\nJump #" . jumpNum)
            if (isDeadNow()){
                resetIfDead()
                return
            }

            MouseClick, right

            checkIfDCMidAction()
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
                textGui("Mine lvl 1\nLadder Found!")
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

        textGui("Mine lvl 2\nMoving from Crystals")
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
            textGui("" . Ceil((StartTime+180000-A_TickCount)/1000) . " seconds Left\nMine lvl 2\nHopping to Ladder\nJump #" . jumpNum)
            if (isDeadNow()){
                resetIfDead()
                return
            }

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
                textGui("" . Ceil((StartTime+180000-A_TickCount)/1000) . " seconds Left\nMine lvl 2\nLadder Found")
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

        textGui("Mine lvl 3\nMoving from Crystals")
        ; Hop to allow the crystal check
        Send, {Ctrl Up}
        MouseMove, 1024, 579, 2
        MouseClick, right
        randomSleepRange(50,100)
        MouseClick, Left
        randomSleepRange(500,700)
        MouseClick, Left
        Send, {CTRL DOWN}

        ;3nd level
        Loop{
            textGui("" . Ceil((StartTime+180000-A_TickCount)/1000) . " seconds Left\nMine lvl 3\nHopping to Ladder\nJump #" . jumpNum)
            if (isDeadNow()){
                resetIfDead()
                return
            }

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
                textGui("" . Ceil((StartTime+180000-A_TickCount)/1000) . " seconds Left\nMine lvl 3\nLadder Found")
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
                ; checkIfMinerTooLow()
                ; if (checkIfMinerTooLow() = false){
                    Random, x, 948-30, 948+30
                    Random, y, 672-30, 672+30

                    MouseMove, x, y, 2
                    randomSleepRange(50,100)
                    MouseClick, Left
                    
                ;}
                jumpNum := 1
            }

            randomSleepRange(300,400)
        }

    }
    

    endMineRun:

    global dropX
    global dropY
    Send, {CTRL UP}

    textGui("Mine lvl 4\nScattering Miner")
    scatterMiner()
    textGui("Mine lvl 4\nMoving away from other miners")
    moveAwayFromMiners()
    textGui("Mine lvl 4\nPreparing Miner")
    prepareMiner()
    
    textGui("Mine lvl 4\nRight Clicking to mine")
    randomSleep()
    MouseMove, dropX, dropY
    randomSleep()
    MouseClick, Right
    randomSleep()
    SetKeyDelay 300,500
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

checkIfDCWhileMining(){
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
        checkIfDCWhileMining()
    }

    checkIfPopupOpen()
    checkIfInventoryNotOpen()
    checkIfSettingsWrong()
    
    ; Start mining
    MouseMove, 1289, 626, 2
    randomSleep()
    MouseClick, right
    randomSleep()

    randomSleepRange(2000,3000)
}

getXY(){

    coords := StrSplit(StrReplace(StrReplace(StrReplace(OCR([517, 36, 65, 18]),"(",""),"{",""),")",""),",")
    ; x := coords[1]
    ; y := coords[1]
    
    

    return coords
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

checkIfDCMidAction(){
    if (WinExist("Tip")){
        randomSleep()
        WinActivate, Tip
        randomSleep()
        MouseMove, 1058,465
        randomSleep()
        MouseClick, Left
        randomSleepRange(10000,12000)
    }

    ; Check if login screen
    PixelSearch, , , 856-1,145-1, 856+1,145+1, 0x3CBCCA, 0, Fast
    if ErrorLevel{ ; IF not found
        return false
    }

    

    attemptToLogin:
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
        checkIfPopupOpen()
        checkIfSettingsWrong()
    }else{
        randomSleep()
        MouseMove, 898,463, 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(3000,4000)

        Goto, attemptToLogin
    }

    return true
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

resetIfDead(){
    if (isDeadNow()){
        textGui("IS DEAD!","FF0000")
        ; Make sure we can rev
        randomSleepRange(23000,25000)
        if (!isDeadNow()){
            ; someone rev'd me
            return
        }
        ; Revive
        Mousemove, 1348,656,2
        randomSleep()
        MouseClick, left
        randomSleep()
        textGui("Reviving")
        randomSleepRange(1000,2000)
        DCbankFromScroll(true)
    }
}

isDeadNow(){
    PixelSearch, , , 434-1, 777-1, 434+1, 777+1, 0x887F74, 0, Fast
    if ErrorLevel{ ; IF not found
        return false
    }else{
        PixelSearch, , , 1340-1, 654-1, 1340+1, 654+1, 0x94BED6, 0, Fast
        if ErrorLevel{ ; IF not found
            return false
        }else{
            return true
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

DCbankFromScroll(isFromDead:=false){
    global topX
    global topY
    global botX
    global botY

    textGui("Checking if in DC already")
    ; Check to see if in DC already
    PixelSearch, , , 608-1, 483-1, 608+1, 483+1, 0x60B28F, 1, Fast
    if ErrorLevel{ ; IF not found
        if (not isFromDead){
            textGui("Using scroll")
            if (useScroll() = "error"){
                return
            }
        }
    }else{
        textGui("Closing Inventory")
        ; Close Inventory
        MouseMove, 970, 762, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        randomSleepRange(1000,2000)
    }   

    restartSell:

    ; Make sure inventory is closed
    PixelSearch, , , 1255-1, 429-1, 1255+1, 429+1, 0x635131, 0, Fast
    if ErrorLevel{ ; IF not found
        
    }else{
        ; close Inventory
        MouseMove, 970, 762, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        randomSleepRange(1000,2000)
    }

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Hop to the Pharm
    textGui("Hopping to Pharm")
    SetKeyDelay 10,20
    loop,30{

        if (isDeadNow()){
            resetIfDead()
            return
        }
        textGui("Hopping to Pharm\nLooking for Pharm")
        ; Find the pharm
        PixelSearch, px, py, 405, 37, 1424, 724, 0x0000CE, 0, Fast
        if ErrorLevel{ ; IF not found

        }else{
            textGui("Hopping to Pharm\nPharm Found")
            Mousemove, px-100,py,2
            randomSleep()
            MouseClick, Left
            randomSleepRange(2000,3000)

            textGui("Hopping to Pharm\nChecking Pharm is Open")
            ; Check to see if pharm is opened
            PixelSearch, , , 613-5, 283-5, 613+5, 283+5, 0x5A4929, 1, Fast
            if ErrorLevel{ ; IF not found
                continue
            }else{
                break
            }
        }
        textGui("Hopping to Pharm\nMoving to Pharm")

        Random, x, 1130, 1220
        Random, y, 320, 415

        Mousemove, x,y,2
        Send, {Ctrl Down}
        MouseClick, Left
        Send, {Ctrl Up}
        waitForMomentStop()
        

    }

    textGui("Double checking pharm is open")
    ;;;;;;;;;;;;;;;
    ; Check to see if pharm is opened
    PixelSearch, , , 613-5, 283-5, 613+5, 283+5, 0x5A4929, 1, Fast
    if ErrorLevel{ ; IF not found
        textGui("unable to find pharm!", "FF0000")
        randomSleepRange(10000,13000)
        return
    }
    
    ; sell loop
    loop{
        textGui("Selling Ore\nOre #" . A_Index)
        if (isDeadNow()){
            resetIfDead()
            return
        }

        if (A_Index > 60){
            break
        }

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


    ; Check if hp is low

    ; if low, buy a pot
    PixelSearch, , , 432-1, 759-1, 432+1, 759+1, 0x86795E, 0, Fast
    if ErrorLevel{ ; IF not found
    }else{
        Mousemove, 618,195
        randomSleep()
        MouseClick, right
        randomSleepRange(700,1000)

        ; find then use the pot
        PixelSearch, px, py, topX, topY, botX, botY, 0x37984D, 0, Fast
        if ErrorLevel{ ; IF not found
        }else{
            Mousemove, px, py
            randomSleep()
            MouseClick, right
            randomSleepRange(700,1000)
        }
    }



    ; Only buy a scroll if there are no other scrolls in inventory
    PixelSearch, , , topX, topY, botX, botY, 0x3CBEEF, 0, Fast
    if ErrorLevel{ ; IF not found
        ; buy scroll
        MouseMove, 442, 242, 2
        randomSleep()
        MouseClick, right
        randomSleep()
    }

    textGui("Closing Pharm")
    ; Close inventory/Store
    MouseMove, 634, 331, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(1000,1200)

    randomSleepRange(1000,2000)
    findWHCount := 0
    loop{
        textGui("Looking for WH\nAttempts:" . findWHCount . "/15")
        if (isDeadNow()){
            resetIfDead()
            return
        }

        ; if unable to find the WH guy, restart
        if (findWHCount > 15){
            if (useScroll() = "error"){
                return
            }
            Goto, restartSell
        }

        ;check if any npc clicked by accident
        PixelSearch, , , 1180-1, 54-1, 1180+1, 54+1, 0x84C7D6, 0, Fast
        if ErrorLevel{ ; IF not found
            ; nothing
        }else{
            Mousemove, 1160,51,2
            randomSleep()
            MouseClick, Left
        }


        ; Hop towards the WH
        PixelSearch, Px, Py, 405, 37, 1424, 724, 0x392010, 0, Fast
        if ErrorLevel{ ; IF not found

        }else{
            textGui("Opening WH")
            Mousemove, px,py,2
            randomSleep()
            MouseClick, Left
            randomSleepRange(7000,8000)

            ;Check to see if WH is opened
            PixelSearch, , , 1255-1, 429-1, 1255+1, 429+1, 0x635131, 0, Fast
            if ErrorLevel{ ; IF not found
                continue
            }else{
                break
            }
        }
        textGui("Looking for WH\nAttempts:" . findWHCount . "/15\nMoving Closer")
        Random, x, 483, 540
        Random, y, 198, 250

        Mousemove, x,y,2
        Send, {Ctrl Down}
        MouseClick, Left
        Send, {Ctrl Up}
        waitForMomentStop()

        findWHCount++
    }

    randomSleepRange(1000,1200)
    textGui("WH Open")
    SetKeyDelay 300,500
    ; DO WH STUFF
    wharehouse()
    SetKeyDelay 10,20
    randomSleepRange(1000,1200)

    
    textGui("Closing WH")
    ; Close WH
    Mousemove, 587,459,2
    randomSleep()
    MouseClick, left
    randomSleepRange(1000,1200)

    searchAttempts := 0
    loop{
        textGui("Looking for Conductress\nAttempt:" . searchAttempts . "/30")
        if (isDeadNow()){
            resetIfDead()
            return
        }

        ;check if any npc clicked by accident
        PixelSearch, , , 1180-1, 54-1, 1180+1, 54+1, 0x84C7D6, 0, Fast
        if ErrorLevel{ ; IF not found
            ; nothing
        }else{
            Mousemove, 1160,51,2
            randomSleep()
            MouseClick, Left
        }

        ; Talk to conductress
        PixelSearch, Px, Py, 405, 37, 1424, 724, 0x6F8EFF, 1, Fast
        if ErrorLevel{ ; IF not found
            if (searchAttempts > 30){
                ; Hop towards the WH
                PixelSearch, Px, Py, 405, 37, 1424, 724, 0x392010, 0, Fast
                if ErrorLevel{ ; IF not found
                    if (useScroll() = "error"){
                        return
                    }
                    Goto, restartSell
                }else{
                    Mousemove, Px, Py+200,2
                    randomSleep()
                    MouseClick, Left
                    randomSleepRange(1000,2000)
                }

                randomSleepRange(3000,5000)
            }
        }else{
            Mousemove, Px, Py,2
            randomSleep()
            MouseClick, Left
            randomSleepRange(1000,2000)

            ; Check if open
            PixelSearch, , , 709, 93, 711, 95, 0xE7BAE7, 0, Fast
            if ErrorLevel{ ; IF not found
                
            }else{
                break
            }
        }
        searchAttempts++
    }

    randomSleepRange(1000,1200)
    textGui("Teleporting to MC")
    ; teleport to MC
    Mousemove, 958,140, 2
    randomSleep()
    MouseClick, left
    randomSleep()

    randomSleepRange(1000,1200)

    SetKeyDelay 300,500
    toTheMine()

}

waitForMomentStop(){
    loop{
        PixelGetColor, spot1start, 1012, 152
        PixelGetColor, spot2start, 931, 459
        randomSleepRange(50,100)
        PixelGetColor, spot1stop, 1012, 152
        PixelGetColor, spot2stop, 931, 459

        if (spot1start = spot1stop && spot2start = spot2stop){
            if (A_Index = 1){
                ; no movement on first check, try to walk
                MouseClick, Left
                randomSleep()
                continue
            }
            ; no movement detected
            return
        }
    }
}

useScroll(){
    global topX
    global topY
    global botX
    global botY

    ; check if inventory is open
    PixelSearch, , , 1255-1, 429-1, 1255+1, 429+1, 0x635131, 0, Fast
    if ErrorLevel{ ; IF not found
        ; Open Inventory
        MouseMove, 970, 762, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        randomSleepRange(1000,2000)
    }

    ; find the scroll
    PixelSearch, px, py, topX, topY, botX, botY, 0x3CBEEF, 0, Fast
    if ErrorLevel{ ; IF not found
        ; Check to see if in DC already
        PixelSearch, , , 608-1, 483-1, 608+1, 483+1, 0x60B28F, 1, Fast
        if ErrorLevel{ ; IF not found
            return "error"
        }
    }else{
        MouseMove, px, py, 2
        randomSleep()
        MouseClick, right
        randomSleep()
        randomSleepRange(3000,4000)
    }
}

prepareTrading(){
    ; Teleport to DC
    ; Sell all the items
    ; Grab everything from the bank
    ; teleport to the market
    ; Hop south west
    ; wait for trade window
    ; check who's trading
    ; trade over items
    ; teleport to dc
    global topX
    global topY
    global botX
    global botY
    global account
    account := 1
    loop, 1{
        switchAccount()
        ; Teleport to DC
        attemptSellingAgain:
        if (useScroll() == "error"){
            MsgBox, No scroll to teleport
        }

        ; Make sure inventory is closed
        PixelSearch, , , 1255-1, 429-1, 1255+1, 429+1, 0x635131, 0, Fast
        if ErrorLevel{ ; IF not found
            
        }else{
            ; close Inventory
            MouseMove, 970, 762, 2
            randomSleep()
            MouseClick, Left
            randomSleep()
            randomSleepRange(1000,2000)
        }

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;; Hop to the Pharm
        textGui("Hopping to Pharm")
        SetKeyDelay 10,20
        loop,30{

            if (isDeadNow()){
                resetIfDead()
                return
            }
            textGui("Hopping to Pharm\nLooking for Pharm")
            ; Find the pharm
            PixelSearch, px, py, 405, 37, 1424, 724, 0x0000CE, 0, Fast
            if ErrorLevel{ ; IF not found

            }else{
                textGui("Hopping to Pharm\nPharm Found")
                Mousemove, px-100,py,2
                randomSleep()
                MouseClick, Left
                randomSleepRange(6000,7000)

                textGui("Hopping to Pharm\nChecking Pharm is Open")
                ; Check to see if pharm is opened
                PixelSearch, , , 613-5, 283-5, 613+5, 283+5, 0x5A4929, 1, Fast
                if ErrorLevel{ ; IF not found
                    continue
                }else{
                    break
                }
            }
            textGui("Hopping to Pharm\nMoving to Pharm")

            Random, x, 1150, 1200
            Random, y, 350, 415

            Mousemove, x,y,2
            Send, {Ctrl Down}
            MouseClick, Left
            Send, {Ctrl Up}
            MouseClick, Left
            MouseClick, Left
            waitForMomentStop()
            

        }

        textGui("Double checking pharm is open")
        ;;;;;;;;;;;;;;;
        ; Check to see if pharm is opened
        PixelSearch, , , 613-5, 283-5, 613+5, 283+5, 0x5A4929, 1, Fast
        if ErrorLevel{ ; IF not found
            textGui("unable to find pharm!", "FF0000")
            randomSleepRange(10000,13000)
            return
        }
        
        ; sell loop
        loop{
            textGui("Selling Ore\nOre #" . A_Index)
            if (isDeadNow()){
                resetIfDead()
                return
            }

            if (A_Index > 60){
                break
            }

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


        ; Check if hp is low
        ; if low, buy a pot
        PixelSearch, , , 432-1, 759-1, 432+1, 759+1, 0x86795E, 0, Fast
        if ErrorLevel{ ; IF not found
        }else{
            Mousemove, 618,195
            randomSleep()
            MouseClick, right
            randomSleepRange(700,1000)

            ; find then use the pot
            PixelSearch, px, py, topX, topY, botX, botY, 0x37984D, 0, Fast
            if ErrorLevel{ ; IF not found
            }else{
                Mousemove, px, py
                randomSleep()
                MouseClick, right
                randomSleepRange(700,1000)
            }
        }



        ; Only buy a scroll if there are no other scrolls in inventory
        PixelSearch, , , topX, topY, botX, botY, 0x3CBEEF, 0, Fast
        if ErrorLevel{ ; IF not found
            ; buy scroll
            MouseMove, 442, 242, 2
            randomSleep()
            MouseClick, right
            randomSleep()
        }

        textGui("Closing Pharm")
        ; Close inventory/Store
        MouseMove, 634, 331, 2
        randomSleep()
        MouseClick, left
        randomSleepRange(1000,1200)

        randomSleepRange(1000,2000)
        findWHCount := 0
        loop{
            textGui("Looking for WH\nAttempts:" . findWHCount . "/15")
            if (isDeadNow()){
                resetIfDead()
                return
            }

            ; if unable to find the WH guy, restart
            if (findWHCount > 15){
                if (useScroll() = "error"){
                    return
                }
                Goto, attemptSellingAgain
            }

            ;check if any npc clicked by accident
            PixelSearch, , , 1180-1, 54-1, 1180+1, 54+1, 0x84C7D6, 0, Fast
            if ErrorLevel{ ; IF not found
                ; nothing
            }else{
                Mousemove, 1160,51,2
                randomSleep()
                MouseClick, Left
            }


            ; Hop towards the WH
            PixelSearch, Px, Py, 405, 37, 1424, 724, 0x392010, 0, Fast
            if ErrorLevel{ ; IF not found

            }else{
                textGui("Opening WH")
                Mousemove, px,py,2
                randomSleep()
                MouseClick, Left
                randomSleepRange(7000,8000)

                ;Check to see if WH is opened
                PixelSearch, , , 1255-1, 429-1, 1255+1, 429+1, 0x635131, 0, Fast
                if ErrorLevel{ ; IF not found
                    continue
                }else{
                    break
                }
            }
            textGui("Looking for WH\nAttempts:" . findWHCount . "/15\nMoving Closer")
            Random, x, 483, 540
            Random, y, 198, 250

            Mousemove, x,y,2
            Send, {Ctrl Down}
            MouseClick, Left
            Send, {Ctrl Up}
            waitForMomentStop()

            findWHCount++
        }

        randomSleepRange(1000,1200)
        textGui("WH Open")
        SetKeyDelay 300,500
        
        ; Withdraw bank
        withdrawBank()


        ; unBank Gem Loop
        loop{
            textGui("WH Open\nEmptying Gems")
            if (checkIfDCMidAction()){
                break
            }
            randomSleep()
            PixelSearch, Px, Py, 422, 266, 634, 434, 0xFF7FEC, 1, Fast ; VIOLET GEM
            if ErrorLevel{ ; IF not found
                PixelSearch, Px, Py, 422, 266, 634, 434, 0xEF511B, 0, Fast ; MOON GEM
                if ErrorLevel{ ; IF not found
                    randomSleepRange(2000,3000)
                    break
                }else{ ; if found
                    MouseMove, Px, Py
                    randomSleep()
                    MouseClick, Left
                }
            }else{ ; if found
                MouseMove, Px, Py
                randomSleep()
                MouseClick, Left
            }
            randomSleepRange(300,500)
        }


        SetKeyDelay 10,20
        randomSleepRange(1000,1200)

        
        textGui("Closing WH")
        ; Close WH
        Mousemove, 587,459,2
        randomSleep()
        MouseClick, left
        randomSleepRange(1000,1200)

        searchAttempts := 0
        loop{
            textGui("Looking for Conductress\nAttempt:" . searchAttempts . "/30")
            if (isDeadNow()){
                resetIfDead()
                return
            }

            ;check if any npc clicked by accident
            PixelSearch, , , 1180-1, 54-1, 1180+1, 54+1, 0x84C7D6, 0, Fast
            if ErrorLevel{ ; IF not found
                ; nothing
            }else{
                Mousemove, 1160,51,2
                randomSleep()
                MouseClick, Left
            }

            ; Talk to conductress
            PixelSearch, Px, Py, 405, 37, 1424, 724, 0x6F8EFF, 1, Fast
            if ErrorLevel{ ; IF not found
                if (searchAttempts > 30){
                    ; Hop towards the WH
                    PixelSearch, Px, Py, 405, 37, 1424, 724, 0x392010, 0, Fast
                    if ErrorLevel{ ; IF not found
                        if (useScroll() = "error"){
                            return
                        }
                        Goto, attemptSellingAgain
                    }else{
                        Mousemove, Px, Py+200,2
                        randomSleep()
                        MouseClick, Left
                        randomSleepRange(1000,2000)
                    }

                    randomSleepRange(3000,5000)
                }
            }else{
                Mousemove, Px, Py,2
                randomSleep()
                MouseClick, Left
                randomSleepRange(1000,2000)

                ; Check if open
                PixelSearch, , , 709, 93, 711, 95, 0xE7BAE7, 0, Fast
                if ErrorLevel{ ; IF not found
                    
                }else{
                    break
                }
            }
            searchAttempts++
        }

        ; Go to the market
        MouseMove, 696, 167, 2
        randomSleep()
        MouseClick, Left
        randomSleep()

        randomSleepRange(5000,6000)

        ; Move away from teleport spot
        Random, x, 684-50, 684+50
        Random, y, 530-50, 530+50

        Send, {Ctrl down}
        MouseMove, x, y, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        Send, {Ctrl up}

        ; wait for trade loop
        loop{
             PixelSearch, , , 935-1,410-1, 935+1,410+1, 0x6E919A, 0, Fast
            if ErrorLevel{ ; IF not found
                
            }else{
                name := StrReplace(StrReplace(OCR([777, 336, 847-777, 355-336]),":","")," ","")
                if (name = "Cookie" or name = "Cupcakes"){
                    MouseMove, 925, 411, 2
                    randomSleep()
                    MouseClick, Left
                    randomSleep()
                    break
                }
            }
        }
        randomSleepRange(2000,4000)
        tradeOverGoldAndGems()
        randomSleepRange(2000,4000)
        useScroll()


        ; check who's trading
        ; trade over items
        ; teleport to dc
        



    }

    loop, 1{
        switchAccount()
        randomSleepRange(1000,2000)
        DCbankFromScroll()
    }
}

;070B0F Mine DUDE
;405, 39 CLIENT TOP LEFT
;1417, 709 CLIENT BOTTOM RIGHT

;1330, 262 CLick Area