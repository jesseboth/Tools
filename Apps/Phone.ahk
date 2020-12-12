; #SingleInstance, Force
; SendMode Input
; SetWorkingDir, %A_ScriptDir%
Menu,Tray,Icon,icons\icon_phon.ico

	PATH = C:\Users\jesse\.ahk_Paths\Phone
	if not WinExist("ahk_exe " PATH){
		run %PATH%
/*
	Do something here?
*/
	}
	else{
		WinActivate, ahk_exe %PATH%
	}
	return