createLine(Color,lineID)
{
	Gui lineID:color, %Color%
	Gui lineID:+ToolWindow -SysMenu -Caption +AlwaysOnTop
}

line(XCor, YCor, Width, Height, Thickness, lineID)
{
	x := XCor
	y := YCor
	h := Height
	w := Thickness
	Gui lineID :Show, x%x% y%y% w%w% h%h% NA
}

removeLine(lineID)
{
	Gui lineID:destroy
}