Menu,Tray,Icon,icons\icon_calc.ico
	PATH = C:\Users\jesse\Downloads\installers\Wabbitemu.exe
	SHORTCUT = C:\Users\jesse\Downloads\installers\Calculator.lnk
	if not WinExist("ahk_exe " PATH){
		run %SHORTCUT%
		While(not WinExist("ahk_exe " PATH)){
			sleep 10
		}

		SysGet, Mon2, Monitor, 2
		SysGet, Mon3, Monitor, 3

		; MsgBox, %Mon2Bottom%,
		if (Mon2Left = -1920 && Mon2Top = 0 && Mon2Right = -384 && Mon2Bottom = 864){
	    		WinMove, ahk_exe %PATH%, , , , 376, 753 
		}
		else if(Mon3Left = -1920 && Mon3Top = 0 && Mon3Right = -384 && Mon3Bottom = 864){
	    		WinMove, ahk_exe %PATH%, , , , 376, 753
		}
		else if(Mon2Left = 1920 && Mon2Top = -387 && Mon2Right = 2640 && Mon2Bottom = 893){
	    		WinMove, ahk_exe %PATH%, , , , 376, 753
		}
		else{
		    	WinMove, ahk_exe %PATH%, , , , 450, 900
		}
		
	}
	else{
	 	WinActivate, ahk_exe %PATH%
	}