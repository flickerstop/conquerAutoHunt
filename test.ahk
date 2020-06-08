#Include drawBox.ahk
#Include CConsole.ahk
#include .\lib\Vis2.ahk

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

;global Console := new CConsole
;Console.show()  ; must use parentheses



topX := 1184
topY := 62
botX := 1395
botY := 401

f8::

    xLow := 1228
    xHigh := 1300

    yLow := 350
    yHigh := 415

    Random, x, 1228, 1300
    Random, y, 350, 415

    createBox3("FFFFFF")
    box3(xLow,yLow,xHigh-xLow,yHigh-yLow,1,"out")

    createBox2("00FF00")
    box2(483,198,540-483,250-198,1,"out")
return

f7::
    restartSell:

    SetKeyDelay 10,20
    loop,10{
        ; Find the pharm
        PixelSearch, px, py, 405, 37, 1424, 724, 0x0000CE, 0, Fast
        if ErrorLevel{ ; IF not found

        }else{
            Mousemove, px-100,py,2
            randomSleep()
            MouseClick, Left
            randomSleepRange(6000,7000)

            ; Check to see if pharm is opened
            PixelSearch, , , 613-5, 283-5, 613+5, 283+5, 0x5A4929, 1, Fast
            if ErrorLevel{ ; IF not found
                continue
            }else{
                break
            }
        }


        Random, x, 1150, 1200
        Random, y, 350, 415

        Mousemove, x,y,2
        Send, {Ctrl Down}
        MouseClick, Left
        Send, {Ctrl Up}
        waitForMomentStop()
        

    }

    ;;;;;;;;;;;;;;;
    ; Check to see if pharm is opened
    PixelSearch, , , 613-5, 283-5, 613+5, 283+5, 0x5A4929, 1, Fast
    if ErrorLevel{ ; IF not found
        MsgBox, Pharm not opened! Walk to the spot and open the pharm!
    }


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; SELL LOOP HERE

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

    randomSleepRange(1000,2000)
    findWHCount := 0
    loop{
        ; if unable to find the WH guy, restart
        if (findWHCount > 15){
            useScroll()
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

    SetKeyDelay 300,500
    ; DO WH STUFF
    ;FIXME uncomment wharehouse()
    SetKeyDelay 10,20
    randomSleepRange(1000,1200)

    ; Close WH
    Mousemove, 587,459,2
    randomSleep()
    MouseClick, left
    randomSleepRange(1000,1200)

    searchAttempts := 0
    loop{
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
                    useScroll()
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

    ; teleport to MC
    Mousemove, 958,140, 2
    randomSleep()
    MouseClick, left
    randomSleep()

    ;;;;;;;;;;;;;;;;;

    useScroll()
    Goto, restartSell

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
        MsgBox, No scroll found!
    }else{
        MouseMove, px, py, 2
        randomSleep()
        MouseClick, right
        randomSleep()
        randomSleepRange(3000,4000)
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

getXY(){
    coords := StrSplit(StrReplace(StrReplace(StrReplace(OCR([517, 36, 65, 18]),"(",""),"{",""),")",""),",")
    ; x := coords[1]
    ; y := coords[1]
    
    

    return coords
}

