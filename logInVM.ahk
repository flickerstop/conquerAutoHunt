CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 400,500

account := 1

f1::
    run(1)
return

f2::
    run(12)
return

f3::
    run(23)
return

run(accountID){
    ; Type in user + password
    Loop, 11{
        switchAccount()
        randomSleepRange(1000,2000)

        ;select login box
        MouseMove, 879,688, 2
        MouseClick, Left
        randomSleep()
        Send, shitwater
        Send % accountID

        ;select password
        MouseMove, 990,721, 2
        MouseClick, Left
        randomSleep()
        Send, password

        ; Login
        ; MouseMove, 1113, 755, 2
        ; randomSleep()
        ; MouseClick, Left
        ; randomSleep()
        ; randomSleepRange(1000,2000)

        accountID++
    }

    ; Login
    Loop, 11{
        switchAccount()
        randomSleepRange(1000,2000)

        MouseMove, 1113, 755, 2
        randomSleep()
        MouseClick, Left
        randomSleep()

        randomSleepRange(15000,20000)
    }

    ; open inventory + settings
    Loop, 11{
        switchAccount()
        randomSleepRange(1000,2000)

        ; Close "vote"
        MouseMove, 1103, 337, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        randomSleepRange(1000,2000)

        ; Check to see if patch notes up
        PixelSearch, OutputVarX, , 1245, 483, 1247, 485, 0x568CAC, 0,fast
        if ErrorLevel{ ; IF not found

        }else{
            MouseMove, 1171, 253, 2
            randomSleep()
            MouseClick, Left
            randomSleep()
            randomSleepRange(1000,2000)
        }


        ; Open Inventory
        MouseMove, 970, 762, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        randomSleepRange(1000,2000)

        ; Open Settings
        MouseMove, 1229, 740, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        randomSleepRange(4000,5000)

        ; Click the 5 buttons
        buttonY := [527,465,406,349,287]
        Loop, 5{
            MouseMove, 1004, buttonY[A_Index], 2
            randomSleep()
            MouseClick, Left
            randomSleepRange(2000,3000)
        }
        ; Close settings
        MouseMove, 1060, 247, 2
        randomSleep()
        MouseClick, Left
        randomSleep()
        
        ; Start mining
        MouseMove, 1289, 626, 2
        randomSleep()
        MouseClick, right
        randomSleep()

        randomSleepRange(2000,3000)
    }
}

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