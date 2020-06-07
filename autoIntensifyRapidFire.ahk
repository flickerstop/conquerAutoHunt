


Pause,Toggle
loop{
    Loop,1500{
        MouseClick, Right
        randomSleep()
    }
    Send, {f7}
    randomSleep()
    MouseClick, Right
    randomSleep()
    Send, {f8}
    randomSleep()
    Send, {f1}
    randomSleep()
}

space::
    Pause,Toggle
return


randomSleep(){
    Random, x, 30, 60
    Sleep, x
}