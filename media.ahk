#NoEnv
#UseHook

SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force

Menu,Tray,Icon,icons\media.ico

global spotify_volume := -1, spotify_mute := 1, chrome_volume := -1, chrome_mute := 1, master_volume := .5, audio_out := 0, spotify_green := "1DB954"
global num := 45, base_color := "121212", accent_color := "0f99e3", bar_background := "707070", white_block :="ffffff", default_volume :=1, ahk_volume:=1,

global BIAMP_LAPTOP = "BSI-US-9XJ43J3"
global BIAMP_DESKTOP = "BSI-US-3XXLWP3"
global ComputerName = GetComputerNameEx(1)
SysGet, NumMonitors, MonitorCount
if (ComputerName == BIAMP_DESKTOP){
  global YT_X := 555, YT_Y := 1550, YT_W := 516, YT_H := 325
  ; global YT_X := 400, YT_Y := 1550, YT_W := 500, YT_H := 325
}
else if (ComputerName == BIAMP_LAPTOP) && NumMonitors == 2 {
  global YT_X := 1950, YT_Y := -504, YT_W := 740, YT_H := 499
}
else if (ComputerName == BIAMP_LAPTOP) && NumMonitors == 1 {
  ; global YT_X := 2162, YT_Y := -350, YT_W := 516, YT_H := 325
}

Gui, Add, Text,cWhite w20 h20 Center vSpotVol
; volume_set(spotify_volume, "spotify.exe") ;;set init
; volume_set(chrome_volume, "chrome.exe")
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

; SetTimer, StopSpotify, 60000 ; Check every minute
; Return

StopSpotify(){
    if (!CheckAudioDevices()){
      Process, Close, Spotify.exe ; Close Spotify
    }
  }


CheckAudioDevices() {
    SoundGet, deviceName, ,
    if (deviceName = "") {
        return False
    }
    return True
}

mediaButton(ctrl) {
  SetTitleMatchMode, 2
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
  else if WinExist("YouTube TV"){
    TITLE = YouTube TV
  }
  else if WinExist("Plex"){
    TITLE = Plex
  }

  SHORTCUT = "C:\Users\jesse.both\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Chrome Apps\Youtube"
  if not ctrl {

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
  }
  else {
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
    if !GetKeyState("Ctrl", "P") ; Check if Ctrl is not being held
      SendInput, {Ctrl Up}
    return
  }
}

; https://chrome.google.com/webstore/detail/windowed-floating-youtube/gibipneadnbflmkebnmcbgjdkngkbklb
; https://chrome.google.com/webstore/detail/youtube-windowed-fullscre/gkkmiofalnjagdcjheckamobghglpdpm
;; YouTube keybinding
^PrintScreen::
    SetTitleMatchMode, 2
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
    else if WinExist("YouTube TV"){
      TITLE = YouTube TV
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
      if(TMP_X == YT_X and TMP_Y == YT_Y and TMP_H == YT_H){
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
      WinActivate, %TITLE%
      WinMove, %TITLE%,, YT_X, YT_Y, YT_W, YT_H
      WinShow, %TITLE%
      Winset, Alwaysontop, On, %TITLE%
    }
    if !GetKeyState("Ctrl", "P") ; Check if Ctrl is not being held
      SendInput, {Ctrl Up}
    return

;; YouTube keybinding
PrintScreen::
  DetectHiddenWindows, on
  SetTitleMatchMode, 2
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
  else if WinExist("YouTube TV"){
      TITLE = YouTube TV
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
      WinActivate, %TITLE%
      WinMove, %TITLE%,, YT_X, YT_Y, YT_W, YT_H
      WinShow, %TITLE%
      WinRestore, %TITLE%
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

^+PrintScreen::  ; Ctrl+PrintScreen hotkey
  ; Simulate pressing Ctrl+PrintScreen
  Send, {Ctrl down}{PrintScreen}{Ctrl up}
  ; Sleep, 1000  ; Wait for 1000 milliseconds
  ; Send, {Space}  ; Simulate pressing Space
  ; Send, {PrintScreen}  ; Simulate pressing PrintScreen
return 

#Media_Play_Pause::
F4::
#c::
  if(!CheckAudioDevices()){
    MsgBox, No audio device connected
    StopSpotify()
    return
  }

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
    WinMove, ,,,,1, 1   ; min size
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

!Media_Prev::
  Send !{F4}

#/:: ; [alt]+[z]
  Send {Volume_Up}  ;show current song
  Send {Volume_Down}
  return

#z::
  hide_default()
  show_default()
  return

;spotify_spotify_volume-------------------------------------------------------------------------------
spotify_up(){
    if (spotify_volume == -1){
        spotify_volume := volume_get("spotify.exe")
    }

    if(spotify_volume < 100){
        spotify_volume += 5
        volume_set(spotify_volume, "spotify.exe")
    }
    createGui(spotify_volume, spotify_green)
    return
}


spotify_down(){
    if (spotify_volume == -1){
        spotify_volume := volume_get("spotify.exe")
    }

    if((spotify_volume > 4)){
        spotify_volume -= 5
        volume_set(spotify_volume, "spotify.exe")
    }
    createGui(spotify_volume, spotify_green)
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
        createGui(spotify_volume, spotify_green)

    }
    Return
;chrome_volume ---------------------------------------------------------------------
chrome_up(){
    if (chrome_volume == -1){
        chrome_volume := volume_get("chrome.exe")
    }

    if(chrome_volume < 100){
        chrome_volume += 5
        volume_set(chrome_volume, "chrome.exe")
    }
    createGui(chrome_volume, "FF0000")
    return
}

chrome_down(){
    if (chrome_volume == -1){
        chrome_volume := volume_get("chrome.exe")
    }

    if(chrome_volume > 4){
        chrome_volume -= 5
        volume_set(chrome_volume, "chrome.exe")
    }
    createGui(chrome_volume, "FF0000")
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
    createGui(chrome_volume, "FF0000")
    }
    Return

volume_set(vol, app){
    value := Round(vol, 2)
    set := "Lib/svcl.exe /SetVolume " app " " value
    run %set%,,hide
    return
}

volume_get(app){

    set := ".\Lib\svcl.exe /Stdout /GetPercent " app

    RunWait %comspec% /c %set%  > volume.txt,, hide
    FileRead, volume, volume.txt
    FileDelete, volume.txt

    val := Round(volume)
    return val
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
;     createGui(spotify_volume*100, green)
;     return
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

GetComputerNameEx(COMPUTER_NAME_FORMAT := 0)                                      ; http://msdn.com/library/ms724301(vs.85,en-us)
{
    DllCall("GetComputerNameEx", "UInt", COMPUTER_NAME_FORMAT, "Ptr", 0, "UInt*", size)
    VarSetCapacity(buf, size * (A_IsUnicode ? 2 : 1), 0)
    if !(DllCall("GetComputerNameEx", "UInt", COMPUTER_NAME_FORMAT, "Ptr", &buf, "UInt*", size))
        return "*" A_LastError
    return StrGet(&buf, size, "UTF-16")
}


; Define the time for the daily trigger
TargetHour := 18  ; 6 PM in 24-hour format
TargetMinute := 0 ; 0 minutes
SetTimer, DailyTrigger, 60000 ; Check every 60,000 ms (1 minute)

DailyTrigger:
    ; Get the current hour and minute
    CurrentHour := A_Hour
    CurrentMinute := A_Min

    ; Check if the current time matches the target time
    if (CurrentHour = TargetHour and CurrentMinute = TargetMinute) {
        ; Send the Win+L keybinding to lock the screen
        Send, #l
    }
Return
