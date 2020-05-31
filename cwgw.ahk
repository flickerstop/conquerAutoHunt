#Include drawBox.ahk
#include .\lib\Vis2.ahk

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 300,500

manaCount := 4
hpCount := 4
hpPotTimes := 0

; createBox2("FFFFFF")
; createBox3("FFFFFF")

; box2(831, 933, 6, 1, 1, "out")

; box3(801, 919, 6, 1, 1, "out")

loop{
    ; Search for mana under 1k
    PixelSearch, , , 831-1,933-1, 831+1,933+1, 0x8F856C, 0, fast
    if ErrorLevel{ ; IF not found
        
    }else{
        Send, {f6}
        Send,{CTRL DOWN}
        manaCount--
    }
    randomSleep()
    ; if (manaCount = 1){
    ;     Send, {f7}
    ;     manaCount := 4
    ; }

    ; Search for hp
    ; randomSleep()
    ; PixelSearch, , , 801-1,919-1, 801+1,919+1, 0x776E5D, 0, fast
    ; if ErrorLevel{ ; IF not found
        
    ; }else{
    ;     Send, {f2}
    ;     Send,{CTRL DOWN}
    ;     hpCount--
    ;     hpPotTimes := 3
    ; }
    ; randomSleep()
    ; if (hpCount = 1){
    ;     Send, {f3}
    ;     hpCount := 4
    ; }
    ; randomSleep()
    ; if (hpPotTimes > 0){
    ;     hpPotTimes--
    ;     hpCount--
    ;     Send, {f2}
    ; }

    randomSleep()

}



randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}

randomSleep(){
    Random, x, 50, 100
    Sleep, x
}

esc::
    exitapp
return

\::
    Pause,Toggle
return
