#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
Menu,Tray,Icon,icons\icon_shell.ico

	PATH = %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
	SHORTCUT = C:\Users\jesse.both\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell
	if not WinExist("Windows PowerShell"){
		run %SHORTCUT%
	}
	else if not WinActive("Windows PowerShell"){
			WinActivate, ahk_exe %PATH%
	}
	else{
		run %SHORTCUT%
	}