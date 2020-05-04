CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 30,50

$*Numpad5:: 
{
    PixelSearch, Px, Py, 1184,62, 1395,143, 0x4F88B8, 1, Fast ; GOLD
    if ErrorLevel{ ; IF not found
        PixelSearch, Px, Py, 1184,62, 1395,143, 0x555455, 0, Fast ; IRON
        if ErrorLevel{ ; IF not found
            PixelSearch, Px, Py, 1184,62, 1395,143, 0xB5D3E7, 0, Fast ; COPPER
            if ErrorLevel{ ; IF not found
                PixelSearch, Px, Py, 1184,62, 1395,143, 0xB5B2B5, 0, Fast ; SILVER
                if ErrorLevel{ ; IF not found
                    MouseMove, 622, 281, 1
                }else{
                    MouseMove, Px, Py, 1
                    Sleep, 50
                    MouseClick, Left
                    Sleep, 50
                }
            }else{
                MouseMove, Px, Py, 1
                Sleep, 50
                MouseClick, Left
                Sleep, 50        
            }
        }else{
            MouseMove, Px, Py, 1
            Sleep, 50
            MouseClick, Left
            Sleep, 50         
        }
    }else{
        MouseMove, Px, Py, 1
        Sleep, 50
        MouseClick, Left
        Sleep, 50          
    }
    MouseMove, 622, 281, 1
    Sleep, 50
    MouseClick, Left , 622, 281
}
Return


;XButton2::msgbox You pressed Mouse5

m::
    Send, 000000
return

k::
    Send, 00000

$*Numpad7:: 
{

    MouseGetPos, storeX, storeY
}
return

$*Numpad9:: 
{

    MouseGetPos, invenX, invenY
}
return
