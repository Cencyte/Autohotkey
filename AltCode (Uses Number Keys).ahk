#SingleInstance
;KeyHistory 500
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