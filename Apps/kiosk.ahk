#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Run, chrome.exe -k http://www.google.com/ --new-window --kiosk
sleep 500
WinMove,Google - Google Chrome,,100,100,400,300