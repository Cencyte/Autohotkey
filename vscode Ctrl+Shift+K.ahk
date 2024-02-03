#SingleInstance
TraySetIcon("No (Blue).ico", , true)
iconsize := 128
hIcon := LoadPicture("No (Blue).ico", "Icon GDI+ w" . iconsize . " h" . iconsize, &imgType)
^+k::clearLine()
clearLine() {
    SendInput("{Home}+{End}")
    SendInput("{Delete}")
    return
}