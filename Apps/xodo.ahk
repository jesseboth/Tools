#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Menu,Tray,Icon,icons\pdf_2_0qa_icon.ico

	PATH = C:\Users\jesse.both\.ahk_Paths\PDF
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