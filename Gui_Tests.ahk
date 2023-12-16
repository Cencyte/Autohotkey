
#Requires AutoHotkey v2.0
#SingleInstance
/*
;
;   
   _____ _    _ _____   _______        _       
  / ____| |  | |_   _| |__   __|      | |      
 | |  __| |  | | | |      | | ___  ___| |_ ___ 
 | | |_ | |  | | | |      | |/ _ \/ __| __/ __|
 | |__| | |__| |_| |_     | |  __/\__ \ |_\__ \
  \_____|\____/|_____|    |_|\___||___/\__|___/
;
;Here is what I would like to show in the GUI: A_ScreenDPI
;
;
;
*/

MyGui := Gui("+Border +Caption +DPIScale +MaximizeBox +OwnDialogs +Resize", "☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺")

MyGui.BackColor := "171010"
;WinSetTransColor("171010", MyGui)
;MyGui.Opt("-Caption")

MyGui.SetFont("cBlue s45 w700 q5 italic", "Times New Roman")
MyGui.SetFont("cRed s45 w400 q5", "Antiultra")
MyGui.SetFont("cWhite s45 q5 italic", "Arial") 
MyGui.Add("text",, "Working Directory: " A_WorkingDir)
MyGui.AddEdit("vName")
iconsize := 128
hIcon := LoadPicture("No (Blue).ico", "Icon GDI+ w" . iconsize . " h" . iconsize, &imgType)
TraySetIcon("No (Blue).ico", , true)
;TraySetIcon("Shell32.dll", 174, true)

SendMessage(0x0080, 1, hIcon, MyGui)
;MyGui.Add("Text",, "Coming Soon...:")
;MyGui.Add("Text",, "Coming Soon...:")
;MyGui.Add("Text",, "Coming Soon...:")

;The Greater the ln is for SetFont, the higher the preference for it. 
;q3 means the font quality is not antialiased, so more pixelated. q5 is cleartype quality standard.
;s45 is the font size.
;cBlue is the color to set the text.
;w<n> is weight (boldness), and it ranges from 200-400-700.

MyGui.Show()

/*
MyGui := Gui()
MyGui.Add("Edit", "w600")  ; Add a fairly wide edit control at the top of the window.
MyGui.Add("Text", "Section", "First Name:")  ; Save this control's position and start a new section.
MyGui.Add("Text",, "Last Name:")
MyGui.Add("Edit", "ys")  ; Start a new column within this section.
MyGui.Add("Edit")
MyGui.Show
*/

;MyGui := Gui(Options, "Here is a gooey", EventObj)


; Gui, Add, Text,, This is a custom dialog box.
; Gui, Show

