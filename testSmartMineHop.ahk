CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 300,500

randomSleepRange(3000,3000)

Send, {CTRL DOWN}
;first level
jumpNum := 1
Loop{

    ; look for ladder
    PixelSearch, Px, Py, 647, 223, 1153, 578, 0x587D91, 0, Fast
    if ErrorLevel{ ; IF not found

    }else{
        randomSleepRange(1000,1300)
        PixelSearch, Px, Py, 647, 223, 1153, 578, 0x587D91, 0, Fast
        if ErrorLevel{
            continue
        }
        MouseMove, Px, Py, 2
        randomSleep()
        MouseClick, Left

        randomSleepRange(1500,2000)
        ;check to make sure we went through
        PixelSearch, Px, Py, 647, 223, 1153, 578, 0x587D91, 0, Fast
        if ErrorLevel{
            
        }else{
            MouseMove, 520, 146, 2
            randomSleep()
            MouseClick, Left
            randomSleep()
            MouseClick, Left
            randomSleep()
            continue
        }
        break
    }

    ; 2 jumps right
    if (jumpNum = 1 || jumpNum = 2){
        Random, x, 1109-30, 1109+30
        Random, y, 651-30, 651+30

        MouseMove, x, y, 2
        randomSleepRange(50,100)
        MouseClick, Left
        jumpNum++
    }else{ ; 1 jump left
        Random, x, 771-30, 771+30
        Random, y, 643-30, 643+30

        MouseMove, x, y, 2
        randomSleepRange(50,100)
        MouseClick, Left
        jumpNum := 1
    }
    
    randomSleepRange(200,300)
}
randomSleepRange(1000,1200)

Loop{

    ; look for ladder
    PixelSearch, Px, Py, 647, 223, 1153, 578, 0x587D91, 0, Fast
    if ErrorLevel{ ; IF not found

    }else{
        randomSleepRange(1000,1300)
        PixelSearch, Px, Py, 647, 223, 1153, 578, 0x587D91, 0, Fast
        if ErrorLevel{
            continue
        }
        MouseMove, Px, Py, 2
        randomSleep()
        MouseClick, Left

        randomSleepRange(1000,2000)
        break
    }
    if (jumpNum = 1){
        Random, x, 1245-30, 1245+30
        Random, y, 435-30, 435+30

        ; Check if jump is useless due to wall
        PixelSearch, , , x-10, y-10, x+10, y+10, 0x000000, 1, Fast
        if ErrorLevel{
            
        }else{
            jumpNum++
            continue
        }

        MouseMove, x, y, 2
        randomSleepRange(50,100)
        MouseClick, Left
        jumpNum++
    }else if (jumpNum = 2){
        Random, x, 1282-30, 1282+30
        Random, y, 634-30, 634+30

        MouseMove, x, y, 2
        randomSleepRange(50,100)
        MouseClick, Left
        jumpNum++
    }else{ ; 1 jump left
        Random, x, 948-30, 948+30
        Random, y, 712-30, 712+30

        MouseMove, x, y, 2
        randomSleepRange(50,100)
        MouseClick, Left
        jumpNum := 1
    }

    randomSleepRange(200,300)
}

Loop, 20{

    ; look for ladder
    PixelSearch, Px, Py, 647, 223, 1153, 578, 0x587D91, 0, Fast
    if ErrorLevel{ ; IF not found

    }else{
        randomSleepRange(1000,1300)
        PixelSearch, Px, Py, 647, 223, 1153, 578, 0x587D91, 0, Fast
        if ErrorLevel{
            continue
        }
        MouseMove, Px, Py, 2
        randomSleep()
        MouseClick, Left

        randomSleepRange(1000,2000)
        break
    }

    ; 2 jumps up
    if (jumpNum = 1 || jumpNum = 2){
        Random, x, 1203-30, 1203+30
        Random, y, 296-30, 296+30

        MouseMove, x, y, 2
        randomSleepRange(50,100)
        MouseClick, Left
        jumpNum++
    }else{ ; 1 jump right
        Random, x, 1215-30, 1215+30
        Random, y, 620-30, 620+30

        MouseMove, x, y, 2
        randomSleepRange(50,100)
        MouseClick, Left
        jumpNum := 1
    }
    
    randomSleepRange(200,300)
}
Send, {CTRL UP}

r::
Reload
return

esc::exitapp
return

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
