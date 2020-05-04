CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

x := []
y := []
i := 0

space::
    global x
    global y

    MouseGetPos, mx, my

    x.Push(mx)
    y.Push(my)
    i++

return

^space::
    global x
    global y

    MouseGetPos, mx, my

    x.Push(mx)
    y.Push(my)
    i++

return

b::

    loop % i{
        str := x[a_index] . ", " . y[a_index]
        Clipboard := str
        MsgBox, %str%
    }

    ; Strx := ""
    ; For Index, Value In x
    ;     Strx .= Value . "|"
    ; Strx := RTrim(Strx, "|")

    ; Stry := ""
    ; For Index, Value In y
    ;     Stry .= Value . "|"
    ; Stry := RTrim(Stry, "|")
	    

    ; MsgBox, %Strx% `n %Stry%
return