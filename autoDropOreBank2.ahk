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

    if (attempts > 8){
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
                randomSleep()
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
            randomSleep()
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
        randomSleep()
        MouseMove, dropX, dropY
        randomSleep()
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
    MsgBox, Banking done! Click OK when all Miners back
    isPause := false
return

n::
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
    MsgBox, Banking done! Click OK when all Miners back
    isPause := false
return


; Just sell and sit at the bank
g::
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
    MsgBox, All selling done. Click R when all inventorys open and ready to hop back
return

h::
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
    MsgBox, All selling done. Click R when all inventorys open and ready to hop back
return

; Hop back to the mine
r::
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
    switchAccount()
return

randomSleep(){
    Random, x, 150, 300
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}

switchAccount(){
    global account

    accountX := [531,643,744,846,961,1068,1162,1269,1371,1471,1574]

    
    MouseMove, accountX[account], 855, 2
    randomSleep()
    MouseClick, Left
    randomSleepRange(2000,3000)
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
    Send, 5000
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

    ; Teleport scroll
    MouseMove, 1205, 83, 2
    randomSleep()
    MouseClick, right
    randomSleepRange(3000,4000)

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
            ; Hop Again
            Random, x, 1250, 1350
            Random, y, 250, 350

            MouseMove, x, y, 2
            randomSleep()
            MouseClick, left
            randomSleepRange(100,300)

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

                break
            }
        }
    }

    randomSleepRange(2000,3000)

    Send, {CTRL DOWN}
    MouseMove, 884, 684, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 746, 646, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 909, 670, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1055, 683, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1055, 683, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1055, 683, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1078, 649, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 951, 358, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1093, 455, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1228, 672, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1228, 672, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1228, 672, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1228, 672, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1228, 672, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 652, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 652, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 652, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 652, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 652, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 918, 659, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 843, 550, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 502, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 502, 566, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 479, 480, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 481, 404, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 494, 478, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 509, 586, 1
    MouseClick, Left
    randomSleepRange(500,600)
    Send, {CTRL UP}
}

;070B0F Mine DUDE
;405, 39 CLIENT TOP LEFT
;1417, 709 CLIENT BOTTOM RIGHT

;1330, 262 CLick Area