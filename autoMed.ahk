


randomSleepRange(2000,3000)
Loop{
    Send, {f5}
    randomSleep()
}

space::
Pause,Toggle
return

randomSleep(){
    Random, x, 300, 500
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}
