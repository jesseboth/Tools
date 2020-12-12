;#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

monitor := MWAGetMonitorMouseIsIn()

SysGet, Mon, Monitor, %monitor%

;get center of screen
workHor :=  (MonRight + MonLeft)/2 - 562 ;;size/2
WorkVert := (MonBottom + MonTop)/2 - 450 ;;size/2

;;open chrome and shift it to monitor
title = New Tab - Google Chrome ;;this might not be the same for you,
;open chrome and hover over the icon in task bar and look at its title.
if(not WinExist(title)){
	Run, Chrome
	While, not WinExist(title){
		sleep 10
	}	
}
WinActivate, %title%
WinMove, %title%,,,,1125,900
WinMove, %title%,, %workHor%, %workVert%


Send #{Left}
sleep 100
Send {Esc}


MWAGetMonitorMouseIsIn() ; we didn't actually need the "Monitor = 0"
{
	; get the mouse coordinates first
	Coordmode, Mouse, Screen	; use Screen, so we can compare the coords with the sysget information`
	MouseGetPos, Mx, My

    SysGet, MonitorCount, 10
	
	Loop, %MonitorCount%
	{
		SysGet, mon%A_Index%, Monitor, %A_Index%	; "Monitor" will get the total desktop space of the monitor, including taskbars

		if ( Mx >= mon%A_Index%left ) && ( Mx < mon%A_Index%right ) && ( My >= mon%A_Index%top ) && ( My < mon%A_Index%bottom )
		{
			ActiveMon := A_Index
			break
		}
	}
	return ActiveMon
}