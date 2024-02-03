#SingleInstance
;KeyHistory 500

TraySetIcon("No (Blue).ico", , true)
iconsize := 128
hIcon := LoadPicture("No (Blue).ico", "Icon GDI+ w" . iconsize . " h" . iconsize, &imgType)
;MyGui := Gui("+Border +Caption +DPIScale +MaximizeBox +OwnDialogs +Resize", "Testing Grounds 12∕16∕23 3：57 AM")
;SendMessage(0x0080, 1, hIcon, MyGui) ;The 1 allows for large icon.

SetNumLockState "On"
InstallKeybdHook
InstallMouseHook
;ListLines
;ListHotkeys
;ListVars
global NumLockState := GetKeyState("NumLock", "T")
global Code := ""
global table := {}

null(ThisHotKey){   
    return
}

; OUTPUT THE ALT CODE
OutputAltCode() {
global Code
ToolTip "Is anybody out there?"
ToolTip() ;Reset ToolTip
if RegExMatch(Code, "\d{1,4}") {
AltCode := "{ASC " Code "}"
SendInput(AltCode)
}
Code := ""
Loop 10 {
        i := (A_Index == 10) ? 0 : A_Index
        num := i
        Hotkey i, "Off"
    }
return
}

~LAlt::InputAltCode()
InputAltCode() {
    ;MsgBox KeyHistory()
global Code := ""
;ToolTip "Okay, the input occurred"
    Loop 10 {
        i := (A_Index == 10) ? 0 : A_Index
        num := i
        table.%num% := i
        Hotkey i, (ThisHotKey) => null(ThisHotKey)
        Hotkey i, "On"
    }

    while (AltState := GetKeyState("LAlt", "P")) {
    ;ToolTip "Can You See Me Temporarily?"
    for i, v in table.OwnProps() {
        if GetKeyState(i, "P") {
            key := i
            Code .= String(v)
            KeyWait i
        }
        }
        
    if StrLen(Code) == 4 {
    OutputAltCode()
    return
    }
    Sleep 10
}
OutputAltCode()
}

Exit:
    SetNumLockState (numLockState ? "On" : "Off")