CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

randomSleepRange(3000,3000)

toTheMine(){
    randomSleep()
    MouseMove, 1330, 262, 2
    randomSleep()
    MouseClick, right
    randomSleep()

    Send, {CTRL DOWN}
    loop{
        PixelSearch, Px, Py, 405, 39, 1417, 709, 0x2252AE, 0, Fast ; Search for mine guy
        if ErrorLevel{ ; IF not found
            ; Hop Again
            Random, x, 1250, 1350
            Random, y, 250, 350

            MouseMove, x, y, 2
            randomSleep()
            MouseClick, left
            randomSleepRange(300,500)

        }else{
            Send, {CTRL UP}
            ; Left click mine guy
            randomSleepRange(300,500)

            ; ; Search again
            ; PixelSearch, Px, Py, 405, 39, 1417, 709, 0x2252AE, 0, Fast ; Search for mine guy
            ; if ErrorLevel{
            ;     continue
            ; }

            MouseMove, Px, Py, 2
            randomSleep()
            MouseClick, left
            randomSleep()

            ; enter mine
            MouseMove, 726,147, 2
            randomSleep()
            MouseClick, left

            break
        }
    }

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
}


randomSleep(){
    Random, x, 50, 200
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}

Esc:: ExitApp
