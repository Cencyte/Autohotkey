#SingleInstance
SetNumLockState "On"
global NumLockState := GetKeyState("NumLock", "T")
global Code := ""
global table := {}

null(ThisHotKey){   
    return
}

; OUTPUT THE ALT CODE
OutputAltCode() {
global Code
if RegExMatch(Code, "\d{1,4}") {
AltCode := "{ASC " Code "}"
SendInput(AltCode)
}
Code := ""
Loop 10 {
        i := (A_Index == 10) ? 0 : A_Index
        num := "Numpad" . i
        Hotkey num, "Off"
    }
return
}

~LAlt & LWin::InputAltCode()
InputAltCode() {
global Code := ""
    Loop 10 {
        i := (A_Index == 10) ? 0 : A_Index
        num := "Numpad" . i
        table.%num% := i
        Hotkey num, (ThisHotKey) => null(ThisHotKey)
        Hotkey num, "On"
    }

    while (AltState := GetKeyState("LAlt", "P")) {
    for k, v in table.OwnProps() {
        if GetKeyState(k, "P") {
            key := k
            Code .= String(v)
            KeyWait k
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