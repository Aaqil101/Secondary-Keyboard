#Requires AutoHotkey v2.0

SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
#SingleInstance force
Persistent

test := RegExReplace(A_ScriptDir, "\\[^\\]+$")
test := test "\pic\WifiOn&off.png"
MsgBox(test)

return