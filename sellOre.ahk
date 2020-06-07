#Include drawBox.ahk
#include .\lib\Vis2.ahk

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 30,50

topX := 1184
topY := 62
botX := 1395
botY := 401

$*Numpad5:: 
{
    PixelSearch, Px, Py, 1184,62, 1395,143, 0x4F88B8, 1, Fast ; GOLD
    if ErrorLevel{ ; IF not found
        PixelSearch, Px, Py, 1184,62, 1395,143, 0x555455, 0, Fast ; IRON
        if ErrorLevel{ ; IF not found
            PixelSearch, Px, Py, 1184,62, 1395,143, 0xB5D3E7, 0, Fast ; COPPER
            if ErrorLevel{ ; IF not found
                PixelSearch, Px, Py, 1184,62, 1395,143, 0xB5B2B5, 0, Fast ; SILVER
                if ErrorLevel{ ; IF not found
                    MouseMove, 622, 281, 1
                }else{
                    MouseMove, Px, Py, 1
                    Sleep, 50
                    MouseClick, Left
                    Sleep, 100
                }
            }else{
                MouseMove, Px, Py, 1
                Sleep, 50
                MouseClick, Left
                Sleep, 100        
            }
        }else{
            MouseMove, Px, Py, 1
            Sleep, 50
            MouseClick, Left
            Sleep, 100         
        }
    }else{
        MouseMove, Px, Py, 1
        Sleep, 50
        MouseClick, Left
        Sleep, 100          
    }
    MouseMove, 622, 281, 1
    Sleep, 50
    MouseClick, Left , 622, 281
    Sleep, 100   
}
Return

f5::
    tradeOverGoldAndGems()
return


;XButton2::msgbox You pressed Mouse5

m::
    Send, 000000
return

k::
    Send, 00000

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


randomSleep(){
    Random, x, 150, 300
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}

getInventoryGold(){
    return StrReplace(OCR([1271, 418, 82, 20]),",","")
}