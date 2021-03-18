#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

Menu,Tray,Icon,icons\Icon.ico

global spotify_volume := .5, spotify_mute := 1, chrome_volume := 1, chrome_mute := 1, master_volume := .3, audio_out := 0, spotify_green := "1DB954"
global num := 45, base_color := "121212", accent_color := "0f99e3", bar_background := "707070", white_block :="ffffff", default_volume :=1, ahk_volume:=1,
Gui, Add, Text,cWhite w20 h20 Center vSpotVol
volume_set(spotify_volume, "spotify.exe") ;;set init
volume_set(chrome_volume, "chrome.exe")
master_volume(master_volume, 0)
;;get primary monitor for scaling
Sysget, primMon, MonitorPrimary
if (primMon == 1){
	global gui_bar_back := "X96 y100 W11", gui_block := "w11 h11 X96", gui_back := "X62 Y75 W65 H140", gui_text := "X77 Y201 W35 H30", gui_accent := "X96 Y100 W11 H79"
	global max_block:=100, min_block:=185, dif_block:=85, dif_bar:=74,
}
else{
	global gui_bar_back := "X77 y80 W11", gui_block := "w11 h11 X77", gui_back := "X50 Y60 W65 H140", gui_text := "X62 Y161 W35 H30", gui_accent := "X77 Y80 W11 H79"
	global max_block:=100, min_block:=148, dif_block:=68, dif_bar:=74
}

;;for making shortcuts for programming
Coding(){
	Code = C:\Users\jesse\AppData\Local\Programs\Microsoft VS Code\Code.exe
	if WinActive("ahk_exe " Code ){
		return True
	}
	else{
		return False
	}
}

^TAB:: Winset, Alwaysontop, , A
Return

#Media_Play_Pause::
F4::
	PATH = C:\Users\jesse\AppData\Roaming\Spotify\Spotify.exe
	SHORTCUT = Apps\shortcuts\Spotify.lnk
	if not WinExist("ahk_exe " PATH){
		run %SHORTCUT%
		While(not WinExist("ahk_exe " PATH)){
			sleep 10
		}
		sleep 100
		volume_set(spotify_volume, "spotify.exe")
		
/*
	Do something here?
*/
	}
	else{
		if(WinActive("ahk_exe " PATH)){
			WinClose, ahk_exe %PATH%
		}
		else{
			WinActivate, ahk_exe %PATH%
		}
	}
	return

^Media_Play_Pause::
	PATH = C:\Users\jesse\AppData\Roaming\Spotify\Spotify.exe
	SHORTCUT = Apps\shortcuts\Spotify.lnk
	hwnd:=WinActive("A") ; get current active window
	run %SHORTCUT%
	While(not WinExist("ahk_exe " PATH)){
		sleep 10
	}
	sleep 100 
	volume_set(spotify_volume, "spotify.exe")
	Send {Space}
	Sleep, 100
	WinClose, ahk_exe %PATH%
	WinActivate ahk_id %hwnd%
	return
	
#`:: ; [Win]+[`]
    WinGet, window, ID, A
    WinMove, ahk_id %window%, , , , 1125, 900
    return	

^F4:: ; [Win]+[Home]
	PATH = C:\Users\jesse\Downloads\installers\Wabbitemu.exe
	SHORTCUT = C:\Users\jesse\Downloads\installers\Calculator.lnk
	if not WinExist("ahk_exe " PATH){
		run %SHORTCUT%
		While(not WinExist("ahk_exe " PATH)){
			sleep 10
		}
		WinGet, window, ID, A
	    	WinMove, ahk_exe C:\Users\jesse\Downloads\installers\Wabbitemu.exe, , , , 450, 900

	}
	else{
		WinActivate, ahk_exe %PATH%
	}
	return 
	

!z:: ; [alt]+[z]
	Send {Volume_Up}  ;show current song
	Send {Volume_Down} 
	return 

^+bs::
	Send {HOME}+{END}+{bs}{END}
	return

^+c::
	Send {HOME}+{END}^c{END}
	return

^+x::
	Send {home}{shift down}{down}{shift up}^x
	return
	
!Media_Prev::
	Send !{F4}
F13::
	DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0)
	Return

;;CAPSLOCK = [Ctrl][Capslock];
CapsLock::		; CapsLock;
+CapsLock::	; Shift+CapsLock
!CapsLock::	; Alt+CapsLock
#CapsLock::		; Win+CapsLock
^!CapsLock::	; Ctrl+Alt+CapsLock
^!#CapsLock::	; Ctrl+Alt+Win+CapsLock
;............	; You can add whatever you want to block
return			; Do nothing, return

PgUp:: 
	Send {Left}
	return
PgDn:: 
	Send {Right}
	return 


~^!t::
	if(not Coding()){
		run Apps\shell.ahk

	}
	return

#+v::
	send #v
	sleep 200
	send {Down}
	sleep 200
	send {Enter}
	sleep 300
	send ^z
	sleep 200
	send #v
	sleep 200
	send {Enter}
	return

/*
for VS Code ----------------------------------------------
*/
^5:: ;;gives 2 percents symbols for ahk %I%
	if (Coding()){
		Send +{5}+{5} 
		Send {Left}
	}
	return

>^1::
	Send,  {F1}
	Return
>^2::
	Send,  {F2}
	Return
>^3::
	Send,  {F3}
	Return
>^4::
	Send,  {F4}
	Return
>^5::
	Send,  {F5}
	Return
>^6::
	Send, {F6}
	Return
>^7::
	Send,  {F7}
	Return
>^8::
	Send,  {F8}
	Return
>^9::
	Send,  {F9}
	Return

/*
arrow keys--------------------------------------------------
*/

; ^i::
; 	Send {up}
; 	return

; ^j::
; 	Send {left}
; 	return

; ^l::
; 	Send {right}
; 	return

; ^k::
; 	Send {down}
; 	return

; ^+i::
; 	Send +{up}
; 	return

; ^+j::
; 	Send +{Left}
; 	return

; ^+k::
; 	Send +{Down}
; 	return

; ^+l::
; 	Send +{Right}
; 	return

;spotify_spotify_volume-------------------------------------------------------------------------------
spotify_up(){
	if(spotify_volume < 1){
		spotify_volume += .05
		volume_set(spotify_volume, "spotify.exe")
	}
	createGui(spotify_volume*100, spotify_green)
	return
}


spotify_down(){
	if((spotify_volume > .04)){
		spotify_volume -= .05
		volume_set(spotify_volume, "spotify.exe")
	}
	createGui(spotify_volume*100, spotify_green)
	return
}

^Volume_Up::
	spotify_up()
	Return
^Volume_Down::
	spotify_down()
	return
^Volume_Mute::
	if(spotify_mute == 1){
		spotify_mute = 0
		volume_set(0, "spotify.exe")
		createGui(0, spotify_green)

	}
	else{
		spotify_mute = 1
		volume_set(spotify_volume, "spotify.exe")
		createGui(spotify_volume*100, spotify_green)

	}
	Return
;chrome_volume ---------------------------------------------------------------------
chrome_up(){
	if(chrome_volume < 1){
		chrome_volume += .05
		volume_set(chrome_volume, "chrome.exe")
	}
	createGui(chrome_volume*100, "FF0000")
	return
}

chrome_down(){
	if(chrome_volume > .04){
		chrome_volume -= .05
		volume_set(chrome_volume, "chrome.exe")
	}
	createGui(chrome_volume*100, "FF0000")
	return
}

!Volume_Up::
	chrome_up()
	Return
!Volume_Down::
	chrome_down()
	return
!Volume_Mute::
	if(chrome_mute == 1){
		chrome_mute = 0
		volume_set(0, "chrome.exe")
		createGui(0, "FF0000")

	}
	else{
		chrome_mute = 1
		volume_set(chrome_volume, "chrome.exe")
		createGui(chrome_volume*100, "FF0000")
	}
	Return

volume_set(vol, app){
	value := Round(vol, 2)
	set := "nircmd.exe setappvolume " app " " value
	run %set%
	return
}

master_up(){
	if(master_volume < 1){
		master_volume += .02
		master_volume(master_volume, 1)
	}
	return
}
master_down(){
	if(master_volume > .01){
		master_volume -= .02
		master_volume(master_volume, 1)
	}
	return
}

master_volume(vol, Check){
	max = 65535
	value := (vol * max)
	value := Round(value, 0)
	set := "nircmd.exe setvolume 0 " value " " value
	run %set%
	gui_vol := (vol*100)
	if(Check){
		show_default()
	}
	return
}

select_audio_out(){
	if(audio_out == 0){
		set := "nircmd setdefaultsounddevice Headphones"
		master_volume := .3
		volume_set(master_volume, 0)
		audio_out +=1
	}
	else{
		if(audio_out = 1){
			set := "nircmd setdefaultsounddevice Headset"
			master_volume := .15
			volume_set(master_volume, 0)
			audio_out = 0
		}
	}

	run %set%
	return
}

#h::
	select_audio_out()
	return

#t::
	createGui(spotify_volume*100, green)
	return
; Removes the Border and Task bar icon

/*
Show
*/
global hGuiBack := 0, hGuiBarBack := 0, hGuitext:= 0, hGuibox := 0,  hGuiacc := 0
	
createGui(num, color){

	if(ahk_volume){
		hide_default()
	}
		; Removes the Border and Task bar icon
	Gui back:+ToolWindow +LastFound +AlwaysOnTop -Caption +Disabled
	Gui back:Color, %base_color%, volume_back
    
    Gui accent_bar: +ToolWindow +LastFound -Caption +Ownerback
	Gui accent_bar: Color, %accent_color%, volume_accent


	Gui bar_back: +ToolWindow +LastFound -Caption +Ownerback
	Gui bar_back:Color,  %bar_background%, volume_bar

	Gui, +ToolWindow +LastFound -Caption +Alwaysontop +Ownerback
	Gui, Color, %base_color%,volume_num

	Gui white_block: +ToolWindow +LastFound -Caption +Ownerback
	Gui white_block:Color,  %color%, volume_block

	if(ahk_volume){
		ahk_volume = 0
	}
	

	/*
	Show
	*/
	Value := Round(num)
	place = %Value%

	Gui back: Show, %gui_back% NoActivate, volume_back
	Gui,  Show, %gui_text% NoActivate, volume_num

	GuiControl, Font, SpotVol
	WinSet, Transparent, 243, volume_back
	WinSet, TransColor, %base_color% 243, volume_num

	if(%place% == 0){
		Gui, Font, s12 cWhite w700 Bold, Marlett
		GuiControl,,SpotVol,r
		GuiControl, Font, SpotVol
	}
	else{
		Gui, Font, s10 cWhite w500, Segoe UI Semibold
		GuiControl,,SpotVol,%place%
		GuiControl, Font, SpotVol
	}

	block_place:=min_block-num/100*dif_block
    bar_height := dif_bar - num/100*dif_bar
	
	Gui bar_back: Show, %gui_bar_back% h%bar_height% NoActivate, volume_bar
	Gui accent_bar:Show, %gui_accent% NoActivate, volume_bar
	Gui white_block:  Show, %gui_block% y%block_place% NoActivate, volume_block	

	;hide after x seconds
	SetTimer, hide, 2500
	Return
}

~Volume_Down::
	master_down()
	hide()
	return

~Volume_Up::
	master_up()
	hide()
	return

show_default(){
	if(default_volume){
		run "Apps\HideVolumeOSD (Show)"
		default_volume = 0
	}
	return
}
hide_default(){
	if(not default_volume){
		run "Apps\HideVolumeOSD (Hide)"
		default_volume = 1
	}
	return
}
hide(){
	ahk_volume := 1
	Gui back:Hide
	Gui, Hide
	Gui bar_back: Hide
	Gui accent_bar: Hide
	Gui white_block: Hide
	return
}

hide:
	hide()
	return
