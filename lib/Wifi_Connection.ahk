﻿#Requires AutoHotkey v2.0

SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
#SingleInstance force
Persistent

SetDefaultMouseSpeed 0

;========VariablesLists===========

Wis := "Wifi Selection"
S_Wifi := "Select a Wifi Connection"
W_width := "w400"
W_hight := "h145"

; Get the directory path of the script without the last part (\ahk)
; A_ScriptDirWolp := RegExReplace(A_ScriptDir, "\\[^\\]+$")


; Wifi button image path
; This image is used to toggle the Wifi on and off
Wifi := A_ScriptDir "\pic\WifiOn&off.png"

;=================================

;========GuiLayout==============

{
	wcGui := Gui()
	wcGui.Opt("+AlwaysOnTop")
	wcGui.SetFont("Bold", "JetBrains Mono NL")
	wcGui.SetFont("s14")		 ; Preferred size.
	wcGui.SetFont("cFFFFFF")	 ; Preferred color.
	wcGui.Add("Text", "+Center " . W_width . " x1 y15", S_Wifi)
	wcGui.Add("Picture", "x15 y9 w50 h50", Wifi)
	wcGui.Add("Picture", "x335 y9 w50 h50", Wifi)
	wcGui.SetFont("s10")
	wcGui.Add("Button", "x17 y65 w120 h30 +Center", "Connecting...").OnEvent("Click", Wifi_Connection_v1.Bind("Normal"))
	wcGui.Add("Button", "x262 y65 w120 h30 +Center", "Connexion").OnEvent("Click", Wifi_Connection_v2.Bind("Normal"))
	wcGui.Add("Button", "x145 y65 w110 h30 +Center", "Discinnect").OnEvent("Click", Wifi_Dis.Bind("Normal"))
	wcGui.Add("Button", "x138 y105 w120 h30 +Center", "Other").OnEvent("Click", Other_Wifi_Connection.Bind("Normal"))
	wcGui.OnEvent('Close', (*) => ExitApp())
	wcGui.BackColor := "123452"
	wcGui.Title := Wis
	wcGui.Show(W_width . " " . W_hight)
	WinSetTransparent(200, Wis)
	Sleep(150)
	MouseMove(186, 46)
	return
}

;===============================

;==========Labels===============

Wifi_Connection_v1(*)
{
	Run(A_ScriptDir "\exe\Wifi_Connecting.exe")
	wcGui.Destroy()
	return
}

Wifi_Connection_v2(*)
{
	Run(A_ScriptDir "\exe\Wifi_Connexion.exe")
	wcGui.Destroy()
	return
}

Wifi_Dis(*)
{
	Run(A_ScriptDir "\exe\Wifi_Disconnect.exe")
	wcGui.Destroy()
	return
}

Other_Wifi_Connection(*)
{
	; Old way
	/* Send("#b")
	Sleep(100)
	Send("{Left} 4")
	Sleep(150)
	MouseMove(177, 233)
	Sleep(250)
	Click() */

	; New way
	Run(A_ScriptDir "\exe\ms-availablenetworks.url")
	wcGui.Destroy()
	return
}
return