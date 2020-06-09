
textGui(Text="No Text...",textColor="FFFFFF",xPos="405",yPos="10"){

    Text := StrReplace(Text, "\n","`r")
    ; Destory the gui
    Gui, 79:Destroy

    ; set variables
    Font := Tahoma
    TS := 20
    TimeOut := 0

    ; create the gui
	Gui, 79:Font, S%TS% c%textColor%, %Font%
	Gui, 79:Add, Text, x10 y10 BackgroundTrans, %Text%

	Gui, 79:Color, EEAA99
	Gui, 79:+LastFound -Caption +AlwaysOnTop +ToolWindow
	WinSet, TransColor, EEAA99
	Gui, 79:Show, x%xPos% y%yPos% AutoSize, TransSplashTextWindow
}

nextResetGui(Text="No Text...",textColor="FFFFFF",xPos="1182",yPos="10"){

    Text := StrReplace(Text, "\n","`r")
    ; Destory the gui
    Gui, 80:Destroy

    ; set variables
    Font := Tahoma
    TS := 20
    TimeOut := 0

    ; create the gui
	Gui, 80:Font, S%TS% c%textColor%, %Font%
	Gui, 80:Add, Text, x10 y10 BackgroundTrans, %Text%

	Gui, 80:Color, EEAA99
	Gui, 80:+LastFound -Caption +AlwaysOnTop +ToolWindow
	WinSet, TransColor, EEAA99
	Gui, 80:Show, x%xPos% y%yPos% AutoSize, TransSplashTextWindow
}

totalMoneyGui(Text="#### coins",textColor="FFFFFF",xPos="1200",yPos="760"){

    Text := StrReplace(Text, "\n","`r")
    ; Destory the gui
    Gui, 78:Destroy

    ; set variables
    Font := Tahoma
    TS := 20
    TimeOut := 0

    ; create the gui
	Gui, 78:Font, S%TS% c%textColor%, %Font%
	Gui, 78:Add, Text, x10 y10 BackgroundTrans, %Text%

	Gui, 78:Color, EEAA99
	Gui, 78:+LastFound -Caption +AlwaysOnTop +ToolWindow
	WinSet, TransColor, EEAA99
	Gui, 78:Show, x%xPos% y%yPos% AutoSize, TransSplashTextWindow
}