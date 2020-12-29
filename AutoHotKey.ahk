#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

Menu,Tray,Icon,icons\Icon.ico

global spotify_volume := .5, spotify_mute := 1, chrome_volume := 1, chrome_mute := 1, master_volume := .3, audio_out := 0, spotify_green := "1DB954"
global num := 45, base_color := "0f0f0f", pos := "X62 Y75 W65 H140", accent_color := "0f99e3", bar_background := "707070", bar_pos := "X96 Y100 W11 H80", num_pos:="X79 Y204 W35 H20", white_block :="ffffff"

volume_set(spotify_volume, "spotify.exe") ;;set init
volume_set(chrome_volume, "chrome.exe")
master_volume(master_volume)

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
		volume_set(spotify_volume, "Volume\spotify_") ;;set init
		
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
	run %SHORTCUT%
	While(not WinExist("ahk_exe " PATH)){
		sleep 10
	}
	volume_set(spotify_volume, "Volume\spotify_") ;;set init
	Send {Media_Play_Pause}
	Sleep, 100
	WinClose, ahk_exe %PATH%
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


^+t::
	if(not Coding()){
		run shell.ahk

	}
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

; ^!i::
; 	Send {up}
; 	return

; ^!j::
; 	Send {Left}
; Send {End}
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

; ^+u::
; 	Send +{Home}
; 	return

; ^+o::
; 	Send +{End}
; 	return


;spotify_spotify_volume-------------------------------------------------------------------------------
spotify_up(){
	if(spotify_volume < 1){
		spotify_volume += .05
		volume_set(spotify_volume, "spotify.exe")
	}
	createGui(spotify_volume*100, spotify_green)
}


spotify_down(){
	if((spotify_volume > 0)){
		spotify_volume -= .05
		volume_set(spotify_volume, "spotify.exe")
	}
	createGui(spotify_volume*100, spotify_green)
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
	}
	else{
		spotify_mute = 1
		volume_set(spotify_volume, "spotify.exe")
	}
	Return
;chrome_volume ---------------------------------------------------------------------
chrome_up(){
	if(chrome_volume < 1){
		chrome_volume += .05
		volume_set(chrome_volume, "chrome.exe")
	}
}

chrome_down(){
	if(chrome_volume > 0){
		chrome_volume -= .05
		volume_set(chrome_volume, "chrome.exe")
	}
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
	}
	else{
		chrome_mute = 1
		volume_set(chrome_volume, "chrome.exe")
	}
	Return

volume_set(vol, app){
	value := Round(vol, 2)
	set := "nircmd.exe setappvolume " app " " value
	run %set%
}

master_volume(vol){
	max = 65535
	value := (vol * max)
	value := Round(value, 0)
	set := "nircmd.exe setvolume 0 " value " " value
	run %set%
}

select_audio_out(){
	if(audio_out == 0){
		set := "nircmd setdefaultsounddevice Headphones"
		audio_out +=1
	}
	else{
		if(audio_out = 1){
			set := "nircmd setdefaultsounddevice Headset"
			audio_out +=1
		}
		else{

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
	vSpotVol = ""
		; Removes the Border and Task bar icon
	Gui back:+ToolWindow +LastFound -Caption 
	Gui back:Color, %base_color%, volume_back
	hGuiBack := WinExist()


	Gui bar_back: +ToolWindow +LastFound -Caption
	Gui bar_back:Color,  %bar_background%, volume_bar
	hGuiBarBack := WinExist()

	Gui, +ToolWindow +LastFound -Caption
	Gui, Color, %base_color%,volume_num
	; hGuitext := WinExist()
	; Value := Floor(num)
	; place = %Value%
	; Gui, Add, Text,cWhite, %place%
	; Gui, Font, s10 cWhite, Marlet


	Gui white_block: +ToolWindow +LastFound -Caption
	Gui white_block:Color,  %color%, volume_block
	hGuibox := WinExist()

	Gui accent_bar: +ToolWindow +LastFound -Caption
	Gui accent_bar: Color, %accent_color%, volume_accent
	hGuiacc := WinExist()


	/*
	Show
	*/
	Gui back: Show, %pos%, volume_back
	WinSet, Transcolor, 0e0e0e 240, volume_back
	WinSet, AlwaysOnTop,, volume_back
	Gui,  Show, %num_pos%, volume_num
	WinSet, AlwaysOnTop,, volume_num
	Gui bar_back:Show, %bar_pos%, volume_bar
	WinSet, AlwaysOnTop,, volume_bar
	GuiControl, Font, SpotVol

	max_block:=100
	min_block:=185
	dif_block:=85
	block_place:=min_block-num/100*dif_block

	max_bar := 80
	max_bot := 110

	bar_height := num/100*max_bar
	bar_y := 200-num
	;;max 100
	;;min 185
	Gui accent_bar: Show, X96 y%bar_y% W11 h%bar_height%, volume_accent
	WinSet, AlwaysOnTop,, volume_accent

	Gui white_block:  Show, w11 h11 X96 y%block_place%, volume_block
	WinSet, AlwaysOnTop,, volume_block
	
	Return
}


~LButton::
    MouseGetPos,,, hWinUM
    if (hWinUM == hGuiBack or hWinUM == hGuiBarBack or hWinUM == hGuitext or hWinUM == hGuibox or hWinUM == hGuiacc){
        hide(false)
    }
    return


hide(check){
	if(check){
		sleep (15*1000)
	}
    Gui back:Hide
    Gui, Hide
    Gui bar_back: Hide
    Gui accent_bar: Hide
    Gui white_block: Hide
}