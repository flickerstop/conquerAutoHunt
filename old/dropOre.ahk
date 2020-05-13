CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

$*Numpad0:: 
{

    MouseGetPos, CurrentX, CurrentY
    MouseClick, Left , CurrentX, CurrentY
    Sleep, 20
    MouseMove, CurrentX-300, CurrentY, 1
    Sleep, 20
    MouseClick, Left , CurrentX-300, CurrentY
    Sleep, 20
    MouseMove, CurrentX, CurrentY, 1
}