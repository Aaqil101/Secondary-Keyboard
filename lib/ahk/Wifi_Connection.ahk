#Requires AutoHotkey v2.0

#SingleInstance force
Persistent

SetDefaultMouseSpeed 0

;========VariablesLists===========

Wis := "Wifi Selection"
S_Wifi := "Select a Wifi Connection"
W_width := "w400"
W_hight := "h145"
Wifi := "C:\Users\User\Documents\AHK - Scripting\Secondary Keyboard Into A Macroboard\AHK Codes\lib\pic\WifiOn&off.png"

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
	Run "C:\Users\User\Documents\AHK - Scripting\Secondary Keyboard Into A Macroboard\AHK Codes\lib\exe\Wifi_Connecting.exe"
	wcGui.Destroy()
	return
}

Wifi_Connection_v2(*)
{
	Run "C:\Users\User\Documents\AHK - Scripting\Secondary Keyboard Into A Macroboard\AHK Codes\lib\exe\Wifi_Connexion.exe"
	wcGui.Destroy()
	return
}

Wifi_Dis(*)
{
	Run "C:\Users\User\Documents\AHK - Scripting\Secondary Keyboard Into A Macroboard\AHK Codes\lib\exe\Wifi_Disconnect.exe"
	wcGui.Destroy()
	return
}

Other_Wifi_Connection(*)
{
	/* Send("#b")
	Sleep(100)
	Send("{Left} 4")
	Sleep(150)
	MouseMove(177, 233)
	Sleep(250)
	Click() */
	Run("C:\Users\User\Documents\AHK - Scripting\Secondary Keyboard Into A Macroboard\AHK Codes\lib\exe\ms-availablenetworks.url")
	wcGui.Destroy()
	return
}
return