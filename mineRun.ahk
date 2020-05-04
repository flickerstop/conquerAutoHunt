CoordMode, Mouse, Screen
CoordMode, Pixel, Screen


r::
    randomSleepRange(2000,3000)
    Send, {CTRL DOWN}
    MouseMove, 884, 684, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 746, 646, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 909, 670, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1055, 683, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1055, 683, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1055, 683, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1078, 649, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 951, 358, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1093, 455, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1228, 672, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1228, 672, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1228, 672, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1228, 672, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 1228, 672, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 652, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 652, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 652, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 652, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 652, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 918, 659, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 843, 550, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 627, 502, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 502, 566, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 479, 480, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 481, 404, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 494, 478, 1
    MouseClick, Left
    randomSleepRange(500,600)
    MouseMove, 509, 586, 1
    MouseClick, Left
    randomSleepRange(500,600)

    Send, {CTRL UP}
return

randomSleep(){
    Random, x, 50, 200
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}