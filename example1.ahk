#Include drawLine.ahk

CreateBox("FF0000")
Loop {
	Box(10, 10, 100, 100, 2, "in")
	Sleep 100
}
RemoveBox()