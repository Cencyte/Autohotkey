#SingleInstance

^+k::clearLine()
clearLine() {
    SendInput("{Home}+{End}")
    SendInput("{Delete}")
    return
}