#Persistent
; SetTimer, CheckTeamsStatus, 1000 ; Check every second
Return

CheckTeamsStatus:
{
    ; Define coordinates for the Teams taskbar icon
    CoordMode, Pixel, Screen
    x := 2128  ; Update with the X coordinate of the Teams status icon in the taskbar
    y := 1476 ; Update with the Y coordinate for your display setup

    ; Show a tooltip marker at the specified location
    ToolTip, ★, %x%, %y%
    Sleep, 2000  ; Display for 2 seconds
    ToolTip  ; Turn off tooltip

    ; Get the pixel color at the specified coordinates
    PixelGetColor, color, x, y

    MsgBox, %color%

    ; Check if the color is "Available" (green or your specific color code)
    if (color = 0x0b9f10) ; Example color code for green (Available), update as needed
    {
        ; Status is "Available" - do nothing
    }
    else
    {
        ; Status has changed from "Available" - play a tone
        SoundBeep, 750, 300
    }
}
Return


f7::
    goto CheckTeamsStatus ; Run the function once to start monitoring
    return

^!p:: ; Press Ctrl+Alt+P to get the coordinates
    MouseGetPos, x, y
    PixelGetColor, color, x, y
    MsgBox, The mouse is at (X%x%, Y%y%, Color: %color%)