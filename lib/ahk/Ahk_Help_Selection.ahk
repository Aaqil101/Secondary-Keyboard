#Requires AutoHotkey v2.0

SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
#SingleInstance force
Persistent ; (Interception hotkeys do not stop AHK from exiting, so use this)

SetDefaultMouseSpeed 0

;========VariablesLists===========

; Get the directory path of the script without the last part (\ahk)
A_ScriptDirWolp := RegExReplace(A_ScriptDir, "\\[^\\]+$")

A_Help := A_ScriptDirWolp "\ico\Help.ico"
Sel := "Ahk Help Selection"
H_Select := "Select a Help File`nVersion"
H_width := "w400"
H_hight := "h110"
AHS_Left := A_ScriptDirWolp "\pic\HelpSelection_Left.png"
AHS_Right := A_ScriptDirWolp "\pic\HelpSelection_Right.png"

;=================================

;========GuiLayout==============

{
	ahGui := Gui()
	;TraySetIcon(A_Help)
	ahGui.Opt("+AlwaysOnTop")
	ahGui.SetFont("Bold", "JetBrains Mono NL")
	ahGui.SetFont("s15") ; Title Preferred size.
	ahGui.SetFont("cFFFFFF") ; Title Preferred color.
	ahGui.Add("Text", "+Center " . H_width . " x1 y5", H_Select)
	ahGui.Add("Picture", "x15 y7 w60 h60", AHS_Left)
	ahGui.Add("Picture", "x335 y7 w60 h60", AHS_Right)
	ahGui.SetFont("s12") ; Button Preferred size.
	ahGui.Add("Button", "x52 y65 w120 h30 + Center", "v1.1.37.02").OnEvent("Click", Ahk_V1_Help_File.Bind("Normal"))
	ahGui.Add("Button", "x222 y65 w120 h30 + Center", "v2").OnEvent("Click", Ahk_V2_Help_File.Bind("Normal"))
	ahGui.OnEvent('Close', (*) => ExitApp())
	ahGui.BackColor := "123452"
	ahGui.Title := Sel
	ahGui.Show(H_width . " " . H_hight)
	WinSetTransparent(200, Sel)
	Sleep 150
	MouseMove(194, 73)
	return
}

;===============================

;========Labels==================

Ahk_V1_Help_File(*)
{
	if !WinExist("ahk_exe hh.exe") {
		Run(A_ProgramFiles "\AutoHotkey\v1.1.37.02\AutoHotkeyU64.exe")
	} else {
		WinActivate("ahk_exe hh.exe")
	}
	ahGui.Destroy()
	return
}

Ahk_V2_Help_File(*)
{
	if !WinExist("AutoHotkey v2 - Google Chrome") {
		Run("https://www.autohotkey.com/docs/v2/index.htm")
	}
	else {
		WinActivate("AutoHotkey v2 - Google Chrome")
	}
	ahGui.Destroy()
	return
}
return