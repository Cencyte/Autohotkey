#Requires AutoHotkey v2.0
#SingleInstance, Force
paused := true

;TrayTip, Title, This is a tray tip message.
;Displays a popup @ the system tray.

;Gui, Add, Text,, This is a custom dialog box.
;Gui, Show

SetTimer TooltipLoop, 50
return
TooltipLoop() {
if (pwsh_IsRunning)
return
local charPos
local ControlWidth
local ControlHeight
local MouseX
local MouseY
local ControlX
local ControlY
local pwsh_IsRunning := false
;local Text_Fields_ClassXX = {Notepad: "Edit1", Word: "_WwG1", Wordpad: "RICHEDIT50W1"}
MouseGetPos(&MouseX, &MouseY, &ID, &control)
title := WinGetTitle(ID) 
if title != "" and control {
ControlGetPos(&ControlX, &ControlY, &ControlWidth, &ControlHeight, control, ID)
 if WinActive("ahk_class Notepad") and RegexMatch(title, " - Notepad$", &Match) != 0 and title and control {
    if control == "Edit1" or control == "_WwG1" or control == "RICHEDIT50W1" { ;Notepad, Word, Wordpad
        Text := EditGetSelectedText(control, title)
        }
    else {
        return
    }
    ; Calculate the character position 
    CoordMode "Mouse", "Screen"
    CoordMode "ToolTip", "Screen"
    ControlGetPos(&ControlX, &ControlY, &ControlWidth, &ControlHeight, control, title)
    ;MouseX is screen size, ControlX is window for application that is being controlled size. (Wherever the mouse cursor is, if it happens to equal "Edit1", "_WwG1" or "RICHEDIT50W1")
    PixelX := (MouseX - ControlX) / ControlWidth ;Ranges are 0 to 1 for both x, and y. Consider a fullscreen control window. Not much different from the origtinal size of the screen represented in coordinates from MouseX and MouseY.
    PixelY := (MouseY - ControlY) / ControlHeight
    CharacterPos := Round(PixelX * StrLen(text))
    tooltip("CharacterPos is: " . CharacterPos)
    ; Get the character code at the calculated position 
    if (CharacterPos >= 0 && CharacterPos < StrLen(text)) {
        charPos := CharacterPos
        CharCode := Ord(SubStr(text, CharacterPos + 1, 1))
        SelectedChar = SubStr(text, CharacterPos + 1, 1)
        ToolTip(
            ;"PixelX:" . PixelX .
            ;"PixelY:" . PixelY .
            "Character Code:" . CharCode
            "SelectedChar:" . SelectedChar
            "CharPos:" . charPos
            )
            Thread "NoTimers"
            RunWait A_ComSpec " /c PowerShell.exe -File 'C:\Users\FireSongz\Documents\PowerShell\PS Scripts\Test-Rest.ps1' -InputValue" . CharCode . "," . AnotherValue, , output
            outputArray := StrSplit(output, ",") ; All Four BigNames are returned from Tes-Rest.ps1 via Write-Output through the "output" variable.
            site_Info := { Character: A_Args[0],  UTF Code: A_Args[1], Name: A_Args[2],Family: A_Args[3] }

            ; Build a string from the site_Info array
            site_InfoStr := ""
            for key, value in site_Info
                site_InfoStr .= key . ": " . value . "`n"

            ; Build a string from the outputArray
            outputArrayStr := ""
            for index, value in outputArray
                outputArrayStr .= "Index " . index . ": " . value . "`n"

            ; Display the strings in a MsgBox
            MsgBox "site_Info:`n" . site_InfoStr . "`noutputArray:`n" . outputArrayStr

            if CharacterPos != charPos {
            SetTimer, TimerAction, 1000
            Thread "NoTimers", false
            return
            }
        } else {
            ToolTip
        }
        return 
        } else {
            return
        }
        }
;Remember to also output the selected character to the Powershell script.