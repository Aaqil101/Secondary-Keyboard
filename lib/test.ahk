#Requires AutoHotkey v2.0

SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
#SingleInstance force
Persistent

/* test := RegExReplace(A_ScriptDir, "\\[^\\]+$")
test := test "\lib\pic\WifiOn&off.png"
MsgBox(test) */


A_ScriptDirWolp := RegExReplace(A_ScriptDir, "\\[^\\]+$")
Wifi := A_ScriptDirWolp "\lib\pic\WifiOn&off.png"
MsgBox(Wifi)

/* Wifi := A_ScriptDir "\pic\WifiOn&off.png"
MsgBox(Wifi) */


return