
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

loop{
MouseGetPos, CurrentX, CurrentY
PixelGetColor, pc, %CurrentX%, %CurrentY%
MsgBox, Color is %pc%
}

return    ;-maybe missing return here
esc::exitapp
