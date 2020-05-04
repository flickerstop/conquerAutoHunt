#Include drawBox.ahk



CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 30,50


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

attempts := 0

Loop{
    Random, sleepTime, 100, 400
    Random, sleepTime2, 100, 400
    Random, sleepTime3, 1000, 2000

    if (attempts > 5){
        randomSleepRange(2000,3000)
        Send, {ALT DOWN}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{ALT UP}
        randomSleepRange(2000,3000)
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
                Sleep, sleepTime
                MouseClick, Right
                randomSleepRange(2000,3000)
                Send, {ALT DOWN}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{ALT UP}
                Sleep, sleepTime3
                attempts := 0
            }else{ ; if found
                MouseMove, Px, Py
                ;MsgBox, Silver Found x%Px% y%Py%
                Sleep, sleepTime
                MouseClick, Left
                MouseMove, dropX, dropY
                Sleep, sleepTime2
                MouseClick, Left
                Sleep, sleepTime2
            }
        }else{ ; if found
            MouseMove, Px, Py
            ;MsgBox, Copper Found x%Px% y%Py%
            Sleep, sleepTime
            MouseClick, Left
            MouseMove, dropX, dropY
            Sleep, sleepTime2
            MouseClick, Left
            Sleep, sleepTime2
        }
    }else{ ; if found
        MouseMove, Px, Py
        ;MsgBox, Iron Found x%Px% y%Py%
        Sleep, sleepTime
        MouseClick, Left
        MouseMove, dropX, dropY
        Sleep, sleepTime2
        MouseClick, Left
        Sleep, sleepTime2
    }
    attempts++
    Send {Shift Up}
    Sleep, sleepTime
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

; GOLD ORE 0x80C6EE
; SCROLL 0x313871

s::
Loop, 8{ ; change for more than 6 accounts
    global topX 
    global topY 
    global botX 
    global botY 
    ; Search for the Scroll
    PixelSearch, Px, Py, topX, topY, botX, botY, 0x29AED6, 0, Fast
    if ErrorLevel{ ; IF not found
        MsgBox, Scroll not Found! %topX%, %topY%, %botX%, %botY%
        Pause,Toggle
    }else{ ; if found
        MouseMove, Px, Py
        Sleep, randomSleep()
        MouseClick, Right
        Sleep, randomSleepRange(1000,2000)

        ;1st step closer
        MouseMove, 1340, 203
        Sleep, randomSleep()
        MouseClick, Left
        Sleep, randomSleepRange(3000,5000)

        MouseMove, 1397, 576
        Sleep, randomSleep()
        MouseClick, Left
        Sleep, randomSleepRange(3000,5000)

        ; Search for pharm
        PixelSearch, Px, Py, 0, 0, 2000, 2000, 0x2D5896, 1, Fast
        if ErrorLevel{ ; IF not found
            MsgBox, Pham not found!
            Pause,Toggle
        }else{ ; if found
            MouseMove, Px, Py
            Sleep, randomSleep()
            MouseClick, Left
            Sleep, randomSleepRange(3000,5000)
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
            }
            
        }
    }
    randomSleepRange(2000,3000)
    Send, {ALT DOWN}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{ALT UP}
    randomSleepRange(2000,3000)
}
return

t::

return

randomSleep(){
    Random, x, 100, 400
    return x
}

randomSleepRange(min,max){
    Random, x, min, max
    return x
}