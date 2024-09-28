#Requires AutoHotkey v2.0

#SingleInstance force
Persistent ; (Interception hotkeys do not stop AHK from exiting, so use this)

SetDefaultMouseSpeed 0

;========VariablesLists===========

Del := "Shift Delete"
D_Sure := "Are you sure...?"
D_width := "w400"
D_hight := "h110"
Delete := "C:\Users\User\Documents\AHK - Scripting\Secondary Keyboard Into A Macroboard\AHK Codes\lib\pic\Warning.png"

;=================================

;========GuiLayout==============

{
	sdGui := Gui()
	sdGui.Opt("+AlwaysOnTop")
	sdGui.SetFont("Bold", "JetBrains Mono NL")
	sdGui.SetFont("s20")		 ; Preferred size.
	sdGui.SetFont("cFFFFFF")	 ; Preferred color.
	sdGui.Add("Text", "+Center " . D_width . " x1 y10", D_Sure)
	sdGui.Add("Picture", "x15 y7 w50 h50", Delete)
	sdGui.Add("Picture", "x335 y7 w50 h50", Delete)
	sdGui.SetFont("s25")		 ; Button Preferred size.
	sdGui.Add("Button", "x52 y65 w120 h35 +Center", "No").OnEvent("Click", No.Bind("Normal"))
	sdGui.Add("Button", "x222 y65 w120 h35 +Center", "Yes").OnEvent("Click", Yes.Bind("Normal"))
	sdGui.OnEvent('Close', (*) => ExitApp())
	sdGui.BackColor := "123452"
	sdGui.Title := Del
	sdGui.Show(D_width . " " . D_hight)
	WinSetTransparent(200, Del)
	Sleep(150)
	MouseMove(194, 80)
	return
}

;===============================

;========Labels==================

No(*)
{
	sdGui.Destroy()
	return
}

Yes(*)
{
	sdGui.Destroy()
	Sleep(150)
	Send("+{Del}")
	Sleep(250)
	Send("{Enter}")
	return
}
return