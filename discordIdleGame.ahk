CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

SetKeyDelay 300,500


randomSleepRange(2000,3000)

Loop{
    MouseMove, 513,787
    randomSleep()
    MouseClick, left
    randomSleep()
    
    Send, {+}q
    Send, {Enter}
    randomSleepRange(27*60*1000,29*60*1000)
    
}

randomSleep(){
    Random, x, 50, 200
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}