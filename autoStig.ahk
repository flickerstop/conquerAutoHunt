

Pause,Toggle

loop{
    
    Send, {f5}
    randomSleep()

    MouseClick, right
    randomSleep()


    Send, {f1}
    randomSleep()
    randomSleepRange(400,800)
}

esc::
    exitapp
return

space::
    Pause,Toggle
return

randomSleep(){
    Random, x, 400, 600
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}