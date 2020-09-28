
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

sleepMultiplyer := 5

randomSleepRange(3000,4000)

loop{
    MouseMove, 1307,522
    randomSleepRange(3000,4000)
    MouseClick, left
    randomSleepRange(3000,4000)

    MouseMove, 665,646
    randomSleepRange(3000,4000)
    MouseClick, left
    randomSleepRange(3000,4000)

    MouseMove, 478,314
    randomSleepRange(3000,4000)
    MouseClick, left
    randomSleepRange(3000,4000)

    MouseMove, 645,184
    randomSleepRange(3000,4000)
    MouseClick, left
    randomSleepRange(3000,4000)

    MouseMove, 1336,378
    randomSleepRange(3000,4000)
    MouseClick, left
    randomSleepRange(3000,4000)

    MouseMove, 1110,480
    randomSleepRange(3000,4000)
    MouseClick, left
    randomSleepRange(3000,4000)


}


esc::
    exitapp
return

space::
    Pause,Toggle
return

^space::
    Pause,Toggle
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