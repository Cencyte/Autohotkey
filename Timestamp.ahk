;#Requires AutoHotkey v2.0
#SingleInstance
~LAlt & F5::Timestamp()
Timestamp() {
;Replacement character for ':' - '∕'  U+2215
;Replacement character for '\' - '：' U+FF1A
format := "M∕d∕yy h：mm tt"
local variable := FormatTime(A_Now, format)
SendText(variable)
}
