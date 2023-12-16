#Requires AutoHotkey v2.0
#SingleInstance

~+!Down::copyLineDown()
copyLineDown() {
    blocklist := {code: "ahk_exe Code.exe", ISE: "ahk_exe powershell_ise.exe"}
    local HWND := (WinActive("ahk_exe Code.exe") or WinActive("ahk_exe powershell_ise.exe"))
    if (!HWND) {
    SendInput("{Home}+{End}^c{End}+{Enter}^v")
    ;ToolTip "This is a test, and ideally shouldn't be here."
    }
}










