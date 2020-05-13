CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetKeyDelay 30,50


MsgBox, "This is where the the ore will be sold to the store"
MouseGetPos, storeX, storeY 

createBox2("0000FF")
box2(storeX-10, storeY-10, 20, 20, 1, "out")

MsgBox, "Hover over the TOP LEFT of your inventory area and click enter"
MouseGetPos, topX, topY 

; Get the Bottom right corner
MsgBox, "Hover over the BOTTOM RIGHT of your inventory area and click enter"
MouseGetPos, botX, botY 

$*Numpad5:: 
{
    PixelSearch, Px, Py, topX,topY, botX,botY, 0x4F88B8, 1, Fast ; GOLD
    if ErrorLevel{ ; IF not found
        PixelSearch, Px, Py, topX,topY, botX,botY, 0x555455, 0, Fast ; IRON
        if ErrorLevel{ ; IF not found
            PixelSearch, Px, Py, topX,topY, botX,botY, 0xB5D3E7, 0, Fast ; COPPER
            if ErrorLevel{ ; IF not found
                PixelSearch, Px, Py, topX,topY, botX,botY, 0xB5B2B5, 0, Fast ; SILVER
                if ErrorLevel{ ; IF not found
                    ;MouseMove, 622, 281, 1
                }else{
                    MouseMove, Px, Py, 1
                    Sleep, 50
                    MouseClick, Left
                    Sleep, 100
                }
            }else{
                MouseMove, Px, Py, 1
                Sleep, 50
                MouseClick, Left
                Sleep, 100        
            }
        }else{
            MouseMove, Px, Py, 1
            Sleep, 50
            MouseClick, Left
            Sleep, 100         
        }
    }else{
        MouseMove, Px, Py, 1
        Sleep, 50
        MouseClick, Left
        Sleep, 100          
    }
    MouseMove, storeX, storeY, 1
    Sleep, 50
    MouseClick, Left , storeX, storeY
    Sleep, 100   
}
Return


;XButton2::msgbox You pressed Mouse5

m::
    Send, 000000
return

k::
    Send, 00000
return

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
