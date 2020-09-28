#include .\lib\Vis2.ahk

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 30,50

pages := []
i := 0
$*Numpad5:: 
    pages.push(OCR([506, 337, 620-506, 482-337]))
    i++
return

$*Numpad6:: 
    temp := ""
    loop % i{
        temp := temp . pages[a_index]
    }
    MsgBox % temp
    FileAppend, %temp%, guildMembers.txt
return