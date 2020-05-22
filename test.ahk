#Include drawBox.ahk
#Include CConsole.ahk
#include .\lib\Vis2.ahk

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

global Console := new CConsole
Console.show()  ; must use parentheses

t::
    runToMineEntrance2()
return


r::
Reload
return


runToMineEntrance2(){
    Send, {CTRL DOWN}

    clickAttempts := 0
    ; Hop to mine dude
    loop{
        ; Check coords are close to the miner
        coords := getXY()
        Console.log(coords)
        if (coords[2] < 14 and coords[2] > 0){
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
}

drawAllBoxes(){
    createBox("FF0000")
    box(100, 100, 100, 100, 1, "out")
    createBox2("00FF00")
    box2(200, 100, 100, 100, 1, "out")
    createBox3("0000FF")
    box3(300, 100, 100, 100, 1, "out")
    createBox4("FFFFFF")
    box4(400, 100, 100, 100, 1, "out")
    createBox5("000000")
    box5(500, 100, 100, 100, 1, "out")
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

        createBox("FFFFFF")
        box(x1, y1, x2-x1, y2-y1, 1, "out")

        ; Search for male miners
        PixelSearch, pX, pY, x1, y1, x2, y2, 0x8A7461, 3, Fast
        if ErrorLevel{ ; IF not found
            ; Search for female miners
            PixelSearch, pX, pY, x1, y1, x2, y2, 0xEFBA6D, 3, Fast
            if ErrorLevel{ ; IF not found
                ; Search for female miners
                PixelSearch, pX, pY, x1, y1, x2, y2, 0xE2E6D2, 3, Fast
                if ErrorLevel{ ; IF not found
                    ; MsgBox, Nothing found
                }else{
                    createBox2("FF0000")
                    box2(pX-5, pY-5, 10, 10, 1, "out")
                    moveAway := true
                }
            }else{
                createBox2("FF0000")
                box2(pX-5, pY-5, 10, 10, 1, "out")
                moveAway := true
            }
        }else{
            createBox2("FF0000")
            box2(pX-5, pY-5, 10, 10, 1, "out")
            moveAway := true
        }

        ; randomSleepRange(1000,2000)
        ; if (moveAway){
        ;     MsgBox % x1 . "," . y1 . "         " . x2 . "," . y2
        ;     moveAway := false
        ; }
        RemoveBox()
        
    }

    if (moveAway){
        Random, x, 482, 1339
        Random, y, 102, 629

        MouseMove, x, y, 2
        randomSleep()
        MouseClick, Left
        randomSleepRange(1000,1200)
        Send, {f1}
        randomSleep()
        RemoveBox2()
        moveAwayFromMiners()
    }else{
        MouseMove, 917,348,2
        randomSleep()
        MouseClick, Right
        randomSleep()
    }


}

pharmToWH(){
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

    ; PUT SELL LOOP HERE
    ;
    ;


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
    ;left click
    MouseClick, left
    randomSleepRange(6000,7000)

    ; Open WH
    MouseMove, 1308, 585, 2
    randomSleep()
    MouseClick, left
    randomSleepRange(1000,1200)
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