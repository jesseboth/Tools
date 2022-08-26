Menu,Tray,Icon,icons\icon_calc.ico
	PATH = C:\Users\jesse.both\Downloads\installers\Wabbitemu.exe
	SHORTCUT = C:\Users\jesse.both\Downloads\installers\Calculator.lnk
	if not WinExist("ahk_exe " PATH){
		run %SHORTCUT%
		While(not WinExist("ahk_exe " PATH)){
			sleep 10
		}
		Sysget, primMon, MonitorPrimary
		if (primMon == 1){
			WinMove, ahk_exe %PATH%, , , , 450, 900
		}
		else{
			WinMove, ahk_exe %PATH%, , , , 376, 753
		}
		
	}
	else{
	 	WinActivate, ahk_exe %PATH%
	}