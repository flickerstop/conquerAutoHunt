#Include drawBox.ahk


CoordMode, Mouse, Screen
CoordMode, Pixel, Screen


space::test()


test(){

    createBox2("FFFFFF")
    box2(769, 151, 1394-769, 402-151, 1, "out")
    loop{
        Sleep, randomSleep()
        PixelSearch, Px, Py, 769, 151, 1394, 402, 0x4F88B8, 1, Fast
        if ErrorLevel{ ; IF not found
            break
        }else{ ; if found
            MouseMove, Px, Py
            Sleep, randomSleep()
            MouseClick, Left
            Sleep, randomSleep()
            MouseMove, 217, 252
            Sleep, randomSleep()
            MouseClick, Left
            Sleep, randomSleep()
        }
    }
    MsgBox, DONE
}



randomSleep(){
    Random, x, 100, 400
    return x
}

randomSleepRange(min,max){
    Random, x, min, max
    return x
}