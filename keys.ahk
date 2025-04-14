#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

Menu,Tray,Icon,icons\Icon.ico
SetCapsLockState, Off

Terminal(){
  T = WindowsTerminal.exe
  if WinActive("ahk_exe " T){
    return True
  }
  else{
    return False
  }
}

#IfWinExist ahk_exe Code.exe  ; This checks if VS Code is running
!`::  ; Alt + ` to activate VS Code if it's running
    WinActivate ahk_exe Code.exe
    return


#IfWinActive ahk_exe Code.exe  ; This ensures the script only runs when VS Code is active
^!Enter::  ; Ctrl + Alt + Enter to trigger GitHub Copilot and then send a backspace
    Send, ^{Enter}
    Sleep, 100  ; Wait for 100 milliseconds
    Send, {Backspace}
    Send, {/}
    return
#IfWinActive  ; Ends the VS Code specific bindings

#IfWinNotActive ahk_exe Code.exe  ; This only triggers when VS Code is not active
^+bs::  ; Ctrl + Shift + Backspace to get the active program and perform actions
    SendInput, {Ctrl Up}{Shift Up}{Ctrl Up}{Ctrl Up}
    Send {HOME}+{END}+{bs}
    ; SendInput, {Ctrl Down}{Shift Down}
    return

^+c::  ; Ctrl + Shift + C to copy everything on the line
    SendInput, {Ctrl Up}{Shift Up}{Ctrl Up}{Ctrl Up}
    Send {HOME}+{END}^c{END}
    return

^+x::  ; Ctrl + Shift + X to cut everything on the line
    SendInput, {Ctrl Up}{Shift Up}{Ctrl Up}{Ctrl Up}
    Send {HOME}+{Shift Down}+{END}+{Shift Up}^x{END}
    return

~^!t::  ; Ctrl + Alt + T to run a specific script
    Run, Apps\shell.ahk
    return
#IfWinNotActive  ; Ends the non-VS Code condition

#t:: Winset, Alwaysontop, , A
Return

; #i::
; WinGetTitle, Title, A
; Clipboard := Title
; MsgBox, %Title%
; return


; Doorbell -----------------------------------------
isPlaying := false
F17::
    if (!isPlaying)
    {
        isPlaying := true
        SoundPlay, C:\Users\jesse.both\Tools\Lib\doorbell.mp3

        ; Retrieve the number of monitors
        SysGet, MonitorCount, MonitorCount

        Loop, %MonitorCount%
        {
            ; Get each monitor's work area dimensions
            SysGet, Monitor, MonitorWorkArea, %A_Index%

            BoxSize := 50  ; Size of the green square
            BoxX := MonitorLeft + (MonitorRight - MonitorLeft) / 2 - BoxSize / 2
            BoxY := MonitorTop + 0  ; Position the square at the top center

            ; Create a GUI window for each monitor
            Gui, % "Monitor" . A_Index ":New", +AlwaysOnTop +ToolWindow -Caption +Owner
            Gui, % "Monitor" . A_Index ":Color", Green
            Gui, % "Monitor" . A_Index ":Show", NoActivate x%BoxX% y%BoxY% w%BoxSize% h%BoxSize%

            ; Set a timer to automatically close the GUI after 3 seconds
            SetTimer, CloseGreenBox%A_Index%, -3000
        }

        ; Set a timer to reset the playing flag after 3 seconds
        SetTimer, ResetPlayingFlag, -3000
    }
return

ResetPlayingFlag:
    ; Reset the flag after the sound is finished playing
    isPlaying := false
return

CloseGreenBox1:
CloseGreenBox2:
CloseGreenBox3:
CloseGreenBox4:
CloseGreenBox5:
CloseGreenBox6:
    ; Destroy the GUI using the associated monitor index
    Loop, %MonitorCount%
    {
        Gui, % "Monitor" . A_Index ":Destroy"
    }
return
; Doorbell -----------------------------------------


#`:: ; [Win]+[`]
    WinGet, window, ID, A
    WinMove, ahk_id %window%, , , , 1000, 800
    return

*CapsLock Up:: SendInput, {Ctrl Up}{Shift Up}{Ctrl Up}{Ctrl Up}
*CapsLock:: SendInput, {Ctrl Down}{Shift Down}

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

; >^1::
;   Send,  {F1}
;   Return
; >^2::
;   Send,  {F2}
;   Return
; >^3::
;   Send,  {F3}
;   Return
; >^4::
;   Send,  {F4}
;   Return
; >^5::
;   Send,  {F5}
;   Return
; >^6::
;   Send, {F6}
;   Return
; >^7::
;   Send,  {F7}
;   Return
; >^8::
;   Send,  {F8}
;   Return
; >^9::
;   Send,  {F9}
;   Return

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
    Process, Close, Spotify.exe
    Sleep, 300                                          ; delay to prevent unintentional action stop
    SendMessage, 0x112, 0xF140, 0,, Program Manager     ; 0x112 is WM_SYSCOMMAND -- 0xF140 is SC_SCREENSAVE
Return

!Ins::Send, ^{Up}
^!Ins::Send, ^{Up}
