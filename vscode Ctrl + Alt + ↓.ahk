#Requires AutoHotkey v2.0
#SingleInstance
TraySetIcon("No (Blue).ico", , true)
iconsize := 128
hIcon := LoadPicture("No (Blue).ico", "Icon GDI+ w" . iconsize . " h" . iconsize, &imgType)
~+!Down::copyLineDown()
copyLineDown() {
    blocklist := {code: "ahk_exe Code.exe", ISE: "ahk_exe powershell_ise.exe"}
    local HWND := (WinActive("ahk_exe Code.exe") or WinActive("ahk_exe powershell_ise.exe"))
    if (!HWND) {
    SendInput("{Home}+{End}^c{End}+{Enter}^v")
    Sleep 100
    }
}