#Requires AutoHotkey v2.0
#SingleInstance
TraySetIcon("No (Blue).ico", , true)
iconsize := 128
hIcon := LoadPicture("No (Blue).ico", "Icon GDI+ w" . iconsize . " h" . iconsize, &imgType)
~!Down::moveLineDown()
moveLineDown() {
    blocklist := {code: "ahk_exe Code.exe", ISE: "ahk_exe powershell_ise.exe"}
    local HWND := (WinActive("ahk_exe Code.exe") or WinActive("ahk_exe powershell_ise.exe"))
    if (!HWND) {
    SendInput("{Home}+{End}^x{Delete}{End}+{Enter}^v")
    }
}
~!Up::moveLineUp()
moveLineUp() {
    blocklist := {code: "ahk_exe Code.exe", ISE: "ahk_exe powershell_ise.exe"}
    local HWND := (WinActive("ahk_exe Code.exe") or WinActive("ahk_exe powershell_ise.exe"))
    if (!HWND) {
    SendInput("{Home}+{End}^x{Backspace}{Home}+{Enter}{Up}^v")
    }
}