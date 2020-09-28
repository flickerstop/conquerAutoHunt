CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 30,50









f1::
    MouseClick, left
    MouseMove, 923,404
    MouseClick, left

    MouseMove, 996,541
    MouseClick, left

    Send, 50000

    MouseMove, 1028,568
    MouseClick, left

    Send, 10

    MouseMove, 1005,594
    MouseClick, left

return

f2::
    MouseClick, left
    MouseMove, 1591,727
    MouseClick, left

    sleep, 2000

    MouseMove, 1263,551
    MouseClick, left

    Send, 2

    MouseMove, 1273,577
    MouseClick, left

    Send, 2000

    MouseMove, 1302,551
    MouseClick, left
return


f5::
    Reload
return