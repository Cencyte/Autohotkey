/*
    --@ Author: Cencyte
    --@ Date Released: 2∕2∕24
    --@ Description: Select a character from a text field, and then have the character's unicode info displayed in a tooltip.
    --@ Version: 0.0
    --@ License: MIT
    --@ Limitations:
        • Doesn't work with notepad
        • You need to manually set the path to the Powershell script that accesses the API.
        • Windows only
        • Released "As-Is"
*/

#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn All, Off
FileEncoding "UTF-8"
Original_Clipboard := ""
global prev_Text := ""
global switched := ""
global output := ""
last_Char := ""
outputArray := ""
pwsh_IsRunning := false
tempFile := A_Temp . "\" . A_ScriptName . ".tmp"
MatchesFile := A_Temp . "\" . "Test-Rest-Matches.tmp"

;♠
;Specify the path for the Powershell script in the psScript variable
psScript := "C:\Users\[Your Username]\Documents\...\Get Character Code\Test-Rest.ps1"
;

paused := true
TrayTip "ToolTips Active: Text Selection" , A_ScriptName, "Mute" 
TraySetIcon("No (Blue).ico", , true)
MyGui := Gui("+Border +Caption +DPIScale +MaximizeBox +OwnDialogs +Resize", "Get Character Code")
iconsize := 128
hIcon := LoadPicture("No (Blue).ico", "Icon GDI+ w" . iconsize . " h" . iconsize, &imgType)
SendMessage(0x0080, 1, hIcon, MyGui)
SetTimer TooltipLoop, 50
return
TooltipLoop() {
    global
    if (pwsh_IsRunning) {
    return
}
    local MouseX
    local MouseY
    local ControlX
    local ControlY
    local ControlWidth
    local ControlHeight
    local ID
    CoordMode "Mouse", "Screen"
    CoordMode "ToolTip", "Screen"
    MouseGetPos(&MouseX, &MouseY, &ID, &control)
    title := WinGetTitle(ID) 
    if title != "" and control {
        if GetKeyState("LBUTTON") {
            ControlGetPos(&ControlX, &ControlY, &ControlWidth, &ControlHeight, control, ID)
            PixelX := (MouseX - ControlX) / ControlWidth
            PixelY := (MouseY - ControlY) / ControlHeight
            if !(switched) {
                switched := true
                SelectedChar := ""
                outputArrayStr := ""
                MouseGetPos(&otherX, &otherY)
                Original_Clipboard := A_Clipboard
                }
            delx := Abs(MouseX - otherX)
            if (delx >= 4 && delx <= 20) {
                SendInput "^c"
                CharCode := Format("{:X}", Ord(SubStr(A_Clipboard, 1, 1)))
                SelectedChar := SubStr(A_Clipboard, 1, 1)
                if (FileExist(psScript)) {
                    outputArray := ""
                    if (SelectedChar != SubStr(Original_Clipboard, 1, 1)) && (last_Char != SelectedChar) {
                    pwsh_IsRunning := true
                    RunWait A_ComSpec " /c PowerShell.exe -File `"" . psScript . "`" -CharCode " . CharCode . " -SelectedChar " . SelectedChar . " > `"" . tempFile . "`"", , "Hide" 
                    pwsh_IsRunning := false
                    output := RegExReplace(FileRead(tempFile, "UTF-8"), "�", "") ;https://en.wikipedia.org/wiki/Non-breaking_space
                    FileDelete tempFile
                    FileAppend output, tempFile, "UTF-8"
                    }
                } else {
                    MsgBox "The file does not exist at the specified path:" . psScript
                    MsgBox "SelectedChar:" . SelectedChar
                }
                outputArray := StrSplit(output, "`n", , 4) 
                len := outputArray.Length
                if len == 4 {
                    outputArrayStr := ""
                    for index, value in outputArray {
                        if index == len {
                            outputArrayStr .= value    
                            } else {
                            outputArrayStr .= value . "`n"
                        }
                    }
                } 
            ToolTip outputArrayStr
            return
            }
        }
        else if switched && !(GetKeyState("LBUTTON")) {
            outputArrayStr := ""
            output := ""
            outputArray := ""
            switched := false
            last_Char := SelectedChar
            otherX := 0
            A_Clipboard := Original_Clipboard
            ToolTip
        } 
    }
}