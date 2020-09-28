CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 300,500

sleepMultiplyer := 1
i := 0

pause, Toggle

loop{
    MouseClick, right
    randomSleepRange(180000,185000)

    Send, {f5}
    randomSleep()
}






esc::
    exitapp
return

space::
    Pause,Toggle
return

r::
    Reload
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