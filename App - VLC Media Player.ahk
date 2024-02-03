#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance
CoordMode "Tooltip", "Screen"
!F4::main()
main() {
    MouseGetPos(, , &ID)
    title := WinGetTitle(ID)
    local class := WinGetClass(title)
    if (class == "SkinWindowClass" && WinActive("ahk_exe vlc.exe")) {
        SendInput("^q")
        return
    } else {
        SendInput("{Blind}{Alt}{F4}")
        return
    }
}