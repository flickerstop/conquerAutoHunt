

Pause,Toggle

loop{
    
    Send, {f5}
    randomSleep()
    loop, 5{
        MouseClick, right
        randomSleep()
    }

    Send, {f1}
    randomSleep()
    randomSleepRange(8000,12000)
}

esc::
    exitapp
return

space::
    Pause,Toggle
return

randomSleep(){
    Random, x, 400, 1000
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}