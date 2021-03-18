#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
Menu,Tray,Icon,icons\icon_shell.ico

	PATH = %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
	SHORTCUT = C:\Users\jesse\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell
	if not WinExist("Windows PowerShell"){
		run %SHORTCUT%
	}
	else{
	 	WinActivate, ahk_exe %PATH%
	}