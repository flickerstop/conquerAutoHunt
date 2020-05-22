CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 100,200


accountNum := 23
account := 1

l::
    Loop, 11{
        switchAccount()
        randomSleepRange(1000,2000)

        global accountNum

        ;select login box
        MouseMove, 879,688, 2
        MouseClick, Left
        randomSleep()
        Send, shitwater
        Send % accountNum

        ;select password
        MouseMove, 990,721, 2
        MouseClick, Left
        randomSleep()
        Send, password


        accountNum++
    }
    
return

randomSleep(){
    Random, x, 150, 300
    Sleep, x
}

randomSleepRange(min,max){
    Random, x, min, max
    Sleep, x
}

switchAccount(){
    global account

    accountX := [531,643,744,846,961,1068,1162,1269,1371,1471,1574]

    
    MouseMove, accountX[account], 855, 2
    randomSleep()
    MouseClick, Left
    randomSleep()
    account++

    if (account = 12){
        account := 1
    }
    
}

esc::
    exitapp
return