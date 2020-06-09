#Include drawBox.ahk
#Include CConsole.ahk
#include .\lib\Vis2.ahk
#Include textOnScreen.ahk

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

;global Console := new CConsole
;Console.show()  ; must use parentheses



topX := 1184
topY := 62
botX := 1395
botY := 401

account := 2
gold := [0,0," 5  ",1,0,0,10,0,0,0,0]

f8::
    ;first level
    jumpNum := 1
    Loop{
        textGui("Mine lvl 1\nHopping to Ladder\nJump #" . jumpNum)
        ; TODO uncomment
        ; if (isDeadNow()){
        ;     resetIfDead()
        ;     return
        ; }

        MouseClick, right

        ; TODO uncomment
        ;checkIfDCMidAction()
        Send, {CTRL DOWN}

        ; TODO uncomment
        ; if (A_TickCount > StartTime+180000){
        ;     Goto, endMineRun
        ; }

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

            waitForMomentStop()
            ;check to make sure we went through
            
            PixelSearch, Px, Py, 1089-1, 169-1, 1089+1, 169+1, 0x29384A, 0, Fast
            if ErrorLevel{
                continue
            }else{
                MsgBox, Down?
            }
            break
        }

        ; 2 jumps down
        if (jumpNum = 1 || jumpNum = 2){
            Random, x, 870-30, 870+30
            Random, y, 614-30, 614+30

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
        randomSleepRange(300,400)
    }

return

f7::
    ;second level
    jumpNum := 1
    Loop{
        textGui("" . Ceil((StartTime+180000-A_TickCount)/1000) . " seconds Left\nMine lvl 2\nHopping to Ladder\nJump #" . jumpNum)
        ; TODO uncomment
        ; if (isDeadNow()){
        ;     resetIfDead()
        ;     return
        ; }

        ; TODO uncomment
        ;checkIfDCMidAction()
        Send, {CTRL DOWN}

        ; TODO uncomment
        ; if (A_TickCount > StartTime+180000){
        ;     Goto, endMineRun
        ; }

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
            }else{
                MsgBox, Down?
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
        randomSleepRange(300,400)
    }
return

r::
    Reload
return

esc::
    exitapp
return

space::
    Pause,Toggle
return


waitForMomentStop(){
    randomSleepRange(100,200)
    loop{
        PixelGetColor, spot1start, 1012, 152
        PixelGetColor, spot2start, 931, 459
        randomSleepRange(100,200)
        PixelGetColor, spot1stop, 1012, 152
        PixelGetColor, spot2stop, 931, 459

        if (spot1start = spot1stop && spot2start = spot2stop){
            if (A_Index = 1){
                ; no movement on first check, try to walk
                randomSleep()
                MouseClick, Left
                continue
            }
            ; no movement detected
            return
        }
    }
}



randomSleep(){
    Random, x, 300, 500
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}
