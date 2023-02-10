#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

Menu,Tray,Icon,icons\Icon.ico
SetCapsLockState, Off

global spotify_volume := .5, spotify_mute := 1, chrome_volume := 1, chrome_mute := 1, master_volume := .5, audio_out := 0, spotify_green := "1DB954"
global num := 45, base_color := "121212", accent_color := "0f99e3", bar_background := "707070", white_block :="ffffff", default_volume :=1, ahk_volume:=1,
global YT_X := 555, YT_Y := 1550, YT_W := 516, YT_H := 325
Gui, Add, Text,cWhite w20 h20 Center vSpotVol
volume_set(spotify_volume, "spotify.exe") ;;set init
volume_set(chrome_volume, "chrome.exe")
master_volume(master_volume, 0)
;;get primary monitor for scaling
Sysget, primMon, MonitorPrimary

if (primMon == 2){
  global gui_bar_back := "X96 y100 W11", gui_block := "w11 h11 X96", gui_back := "X62 Y75 W65 H140", gui_text := "X77 Y201 W35 H30", gui_accent := "X96 Y100 W11 H79"
  global max_block:=100, min_block:=185, dif_block:=85, dif_bar:=74,
}
else{
  global gui_bar_back := "X77 y80 W11", gui_block := "w11 h11 X77", gui_back := "X50 Y60 W65 H140", gui_text := "X62 Y161 W35 H30", gui_accent := "X77 Y80 W11 H79"
  global max_block:=100, min_block:=148, dif_block:=68, dif_bar:=74
}


;;for making shortcuts for programming
Coding(){
  Code = C:\Users\jesse.both\AppData\Local\Programs\Microsoft VS Code\Code.exe
  if WinActive("ahk_exe " Code ){
    return True
  }
  else{
    return False
  }
}

#t:: Winset, Alwaysontop, , A
Return

#i::
WinGetTitle, Title, A
Clipboard := Title
MsgBox, %Title%
return


; https://chrome.google.com/webstore/detail/windowed-floating-youtube/gibipneadnbflmkebnmcbgjdkngkbklb
; https://chrome.google.com/webstore/detail/youtube-windowed-fullscre/gkkmiofalnjagdcjheckamobghglpdpm

;; YouTube keybinding
^PrintScreen::
    SetTitleMatchMode, 1
    DetectHiddenWindows, on

    TITLE = YouTube
    if WinExist("Picture in picture"){
      TITLE = Picture in picture
    }
    if else WinExist("Netflix"){
      TITLE = Netflix
    }
    else if WinExist("HBO Max"){
        TITLE = HBO Max
    }
    else if WinExist("HBOMax"){
      TITLE = HBOMax
    }
    else if WinExist("Live - YouTube TV"){
      TITLE = Live - YouTube TV
    }
    else if WinExist("Home - YouTube TV"){
      TITLE = Home - YouTube TV
    }
    else if WinExist("Plex"){
      TITLE = Plex
    }

    SHORTCUT = "C:\Users\jesse.both\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Chrome Apps\Youtube"
    if not WinExist(TITLE){
      run %SHORTCUT%
      While(not WinExist(TITLE)){
        sleep 10
      }
      sleep 100
      Winset, Alwaysontop, On, %TITLE%
      WinMove, %TITLE%,, YT_X, YT_Y-500, YT_W, YT_H+500
    }
    else if(WinActive(TITLE)){
      WinGetPos, TMP_X, TMP_Y, TMP_W, TMP_H
      if(TMP_X == YT_X and TMP_Y == YT_Y and TMP_W == YT_W and TMP_H == YT_H){
        WinMove, %TITLE%,, YT_X, YT_Y-500, YT_W, YT_H+500
        SendInput, {Esc}
      }
      else{
        WinMove, %TITLE%,, YT_X, YT_Y, YT_W, YT_H
        SendInput, {=}
      }
    }
    else{
      prev:=WinActive("A")
      WinShow, %TITLE%
      WinActivate, %TITLE%
      Winset, Alwaysontop, On, %TITLE%
    }
         return

;; YouTube keybinding
PrintScreen::
  DetectHiddenWindows, on
  SetTitleMatchMode, 1
  ; ▶
  TITLE = YouTube
  if WinExist("Picture in picture"){
      TITLE = Picture in picture
  }
  else if WinExist("Netflix"){
    TITLE = Netflix
  }
  else if WinExist("HBO Max"){
      TITLE = HBO Max
  }
  else if WinExist("HBOMax"){
      TITLE = HBOMax
  }
  else if WinExist("Live - YouTube TV"){
      TITLE = Live - YouTube TV
  }
  else if WinExist("Home - YouTube TV"){
      TITLE = Home - YouTube TV
  }
  else if WinExist("Plex"){
      TITLE = Plex
  }


  SHORTCUT = "C:\Users\jesse.both\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Chrome Apps\Youtube"
  if not WinExist(TITLE){
    run %SHORTCUT%
    While(not WinExist(TITLE)){
      sleep 10
    }
    sleep 100
    Winset, Alwaysontop, On, %TITLE%
    ; WinMove, %TITLE%,, YT_X, YT_Y, YT_W, YT_H
    WinMove, %TITLE%,, YT_X, YT_Y-500, YT_W, YT_H+500
  }
  else{
    WinGet, STATE, MinMax, %TITLE%
    if ((STATE == -1)){
      prev:=WinActive("A")
      WinShow, %TITLE%
      WinActivate, %TITLE%
      Winset, Alwaysontop, On, %TITLE%
       if prev
        WinActivate, ahk_id %prev%
    }
    else if(WinActive(TITLE)){
      ; WinMove, %TITLE%,, YT_X, YT_Y, YT_W, YT_H
      WinMinimize, %TITLE%
      WinHide, %TITLE%
    }
    else{
      ; WinMove, %TITLE%,, YT_X, YT_Y, YT_W, YT_H
      WinMinimize, %TITLE%
      WinHide, %TITLE%
    }
  }
  return
  
#Media_Play_Pause::
F4::
#c::
  DetectHiddenWindows, On
  PATH = C:\Users\jesse.both\AppData\Roaming\Spotify\Spotify.exe
  SHORTCUT = Apps\shortcuts\Spotify.lnk
  WinGetTitle, title, ahk_exe %PATH%
  if not WinExist(title){
    run %SHORTCUT%
    While(not WinExist("ahk_exe " PATH)){
      sleep 10
    }
    sleep 100
    volume_set(spotify_volume, "spotify.exe")
    WinMove, ,,,,1, 1	; min size
  }
  else{
    if(WinActive(title)){
      WinMinimize, %title%
      WinHide, %title%
    }
    else{
      WinShow, ahk_exe %PATH%
      WinActivate, ahk_exe %PATH%
    }
  }
  return

^Media_Play_Pause::
  ; DetectHiddenWindows, On
  ; prev:=WinActive("A")

  ; PATH = C:\Users\jesse.both\AppData\Roaming\Spotify\Spotify.exe
  ; SHORTCUT = Apps\shortcuts\Spotify.lnk
  ; WinGetTitle, title, ahk_exe %PATH%
  ; if not WinExist(title){
  ;   run %SHORTCUT%
  ;   While(not WinExist("ahk_exe " PATH)){
  ;     sleep 10
  ;   }
  ;   sleep 100
  ;   WinMove, ,,,,1, 1	; min size
  ; }


  ; WinHide, %title%
  ; WinActivate, %title%
  ; send {Space}

  ; if prev
  ;   WinActivate, ahk_id %prev%
return

#`:: ; [Win]+[`]
    WinGet, window, ID, A
    WinMove, ahk_id %window%, , , , 1000, 800

    return	

^F4:: ; [Win]+[Home]
  PATH = C:\Users\jesse.both\Downloads\installers\Wabbitemu.exe
  SHORTCUT = C:\Users\jesse.both\Downloads\installers\Calculator.lnk
  if not WinExist("ahk_exe " PATH){
    run %SHORTCUT%
    While(not WinExist("ahk_exe " PATH)){
      sleep 10
    }
    WinGet, window, ID, A
        WinMove, ahk_exe C:\Users\jesse.both\Downloads\installers\Wabbitemu.exe, , , , 450, 900

  }
  else{
    WinActivate, ahk_exe %PATH%
  }
  return 


#/:: ; [alt]+[z]
  Send {Volume_Up}  ;show current song
  Send {Volume_Down} 
  return 

*CapsLock Up:: SendInput, {Ctrl Up}{Shift Up}
*CapsLock:: SendInput, {Ctrl Down}{Shift Down}

^+bs::
  SendInput, {Ctrl Up}{Shift Up}
  Send {HOME}+{END}+{bs}
  SendInput, {Ctrl Down}{Shift Down}
  return

^+c::
  SendInput, {Ctrl Up}{Shift Up}
  Send {HOME}+{END}^c{END}
  SendInput, {Ctrl Down}{Shift Down}
  return

^+x::
  SendInput, {Ctrl Up}{Shift Up}
  ; Send {home}{shift down}{down}{shift up}^x
  Send {HOME}+{Shift down}+{END}+{shift up}^x{END}
  SendInput, {Ctrl Down}{Shift Down}
  return
  
!Media_Prev::
  Send !{F4}
F13::
  DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0)
  Return

;;CAPSLOCK = [Ctrl][Capslock];
;CapsLock::		; CapsLock;
;+CapsLock::	; Shift+CapsLock
;!CapsLock::	; Alt+CapsLock
;#CapsLock::		; Win+CapsLock
;^!CapsLock::	; Ctrl+Alt+CapsLock
;^!#CapsLock::	; Ctrl+Alt+Win+CapsLock
;............	; You can add whatever you want to block
return			; Do nothing, return

; PgUp:: 
; 	Send {Left}
; 	return
; PgDn:: 
; 	Send {Right}
; 	return 


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

+#k::                                                                ; convert to capitalized case
 Convert_Cap()
RETURN
Convert_Cap()
{
 Clip_Save:= ClipboardAll                                                 ; save original contents of clipboard
 Clipboard:= ""                                                           ; empty clipboard
 Send ^c{delete}                                                          ; copy highlighted text to clipboard
 StringLower Clipboard, Clipboard                                         ; convert clipboard to desired case
 Send %Clipboard%                                                         ; send desired text
 Len:= Strlen(Clipboard)
 Send +{left %Len%}                                                       ; highlight text
 Clipboard:= Clip_Save                                                    ; restore clipboard
}

                                                            
                                                              


/*
arrow keys--------------------------------------------------
*/

; *^k::
; 	Send {up}
; 	return

; *^j::
; 	Send {down}
; 	return

; *^l::
; 	Send {right}
; 	return

; *^h::
; 	Send {left}
; 	return

; *^+k::
; 	Send +{up}
; 	return

; *^+j::
; 	Send +{down}
; 	return

; *^+l::
; 	Send +{right}
; 	return

; *^+h::
; 	Send +{left}
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
F23::
^Volume_Up::
  spotify_up()
  Return
F24::
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
  Send, #k
  sleep 1500
  Send, {tab}{down}{down}{enter}{esc}
return
}

#h::
  select_audio_out()
  return

; #t::
; 	createGui(spotify_volume*100, green)
; 	return
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


;move window
; move active right
#+right::
  wingetpos x, y,,, A  
  x += 50			      
  winmove, A,,%x%, %y%  
  return				  

; move active left
#+left::
  wingetpos x, y,,, A
  x -= 50
  winmove, A,,%x%, %y%
  return

; move active up
#+Up::
  wingetpos x, y,,, A
  y -= 50
  winmove, A,,%x%, %y%
  return

; move active down
#+Down::
  wingetpos x, y,,, A
  y += 50
  winmove, A,,%x%, %y%
  return



#^+right::
  wingetpos x, y,w,h, A  
  w += 50			      
  winmove, A,,%x%, %y%, %w%, %h%
  return				  

; move active left
#^+left::
  wingetpos x, y,w,h, A  
  w -= 50
  winmove, A,,%x%, %y%, %w%, %h%
  return

; move active up
#^+Up::
  wingetpos x, y,w,h, A  
  h -= 50
  winmove, A,,%x%, %y%, %w%, %h%
  return

; move active down
#^+Down::
  wingetpos x, y,w,h, A  
  h += 50
  winmove, A,,%x%, %y%, %w%, %h%
  return

#z::
  hide_default()
  show_default()
  return

; PgUp::
; 	Click WheelUp
; 	Click WheelUp
; 	Click WheelUp
; 	Click WheelUp
; 	return

; PgDn::
; 	Click WheelDown
; 	Click WheelDown
; 	Click WheelDown
; 	Click WheelDown
; 	return

#l::                                                 ; the pause/brake key on keyboard (change sc045 to #L for Win+L)
    Sleep, 300                                          ; delay to prevent unintentional action stop
    SendMessage, 0x112, 0xF140, 0,, Program Manager     ; 0x112 is WM_SYSCOMMAND -- 0xF140 is SC_SCREENSAVE
Return