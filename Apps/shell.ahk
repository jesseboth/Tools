#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
Menu,Tray,Icon,icons\icon_shell.ico

	PATH = %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
	SHORTCUT = C:\Users\jesse\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell
	if not WinExist("ahk_exe " PATH){
		run %SHORTCUT%
		While(not WinExist("ahk_exe " PATH)){
			sleep 10
		}

	}
	else{
	 	WinActivate, ahk_exe %PATH%
	}