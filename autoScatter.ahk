
isCtrlDown := false

Pause,Toggle
Loop{
    Random, sleepTime, 50, 100
    MouseClick, Right
    Sleep, sleepTime
}

esc::exitapp
return

\::
    Pause,Toggle
    if (isCtrlDown){
        Send, {CTRL UP}
        isCtrlDown := false
    }else{
        Send, {CTRL DOWN}
        isCtrlDown := true
    }
return

^\::
    Pause,Toggle
    if (isCtrlDown){
        Send, {CTRL UP}
        isCtrlDown := false
    }else{
        Send, {CTRL DOWN}
        isCtrlDown := true
    }
return
