#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
Menu,Tray,Icon,icons\icon_tv.ico

title = TV - Google Chrome

SysGet, Mon2, Monitor, 2
if (Mon2Left = -1769 && Mon2Top = -1080 && Mon2Right = 151 && Mon2Bottom = 0){
            Run, Chrome.exe "file:///C:/Users/jesse.both/IdeaProjects/Personal-Projects/New_Tab/src/main/tab/misc/tv.html" " --new-window ",, Min
            WinWaitActive, %title%,,,
            WinMove, %title%,, -1769, -1080
            Send #{Up}
}