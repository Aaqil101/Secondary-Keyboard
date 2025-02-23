#Requires AutoHotkey v2.0

SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
#SingleInstance Force
Persistent ; (Interception hotkeys do not stop AHK from exiting, so use this)

; These lines include the necessary libraries for the script to work.
; AutoHotInterception(https://github.com/evilC/AutoHotInterception) is a library that allows us to intercept and
; modify keyboard and mouse input. InterceptionTapHold(https://github.com/evilC/TapHoldManager) is a library
; that allows us to tap and hold keys.
#include lib\AutoHotInterception.ahk
#include lib\InterceptionTapHold.ahk
#include lib\TapHoldManager.ahk

; Custon function libraries
#Include lib\wifi_connection_func.ahk
#Include lib\ahk_help_selection_func.ahk

; Alt key is !
; Windows key is #
; Shift key is +
; Control key is ^

SetDefaultMouseSpeed 0

;_-_-_VariablesLists_-_-_-

masterIcon := A_ScriptDir "\lib\ico\Keyboard.ico"
MyDownloads := "C:\Users\Aaqil\Downloads"
TimeStamp := "YYYYMMDDHH24MISS"

;_-_-_-_-_-_-_-_-_-_-_-_-

; Set the icon for the tray menu
A_IconTip := "Secondary Keyboard"

; Load the icon from the ICO file
TraySetIcon(masterIcon)

; Create an instance of the AutoHotInterception class, which allows us to
; intercept and block keyboard and mouse input.
AHI := AutoHotInterception()

; Get the device id of the keyboard with the specified handle
keyboard1Id := AHI.GetDeviceIdFromHandle(false, "HID\VID_C0F4&PID_05F5&REV_0110&MI_00")

; Create an instance of InterceptionTapHold class which will manage the keyboard with the given id
ITH1 := InterceptionTapHold(AHI, keyboard1Id)

ITH1.Add("A", Func_a)
ITH1.Add("B", Func_b)
ITH1.Add("C", Func_c)
ITH1.Add("D", Func_d)
ITH1.Add("E", Func_e)
; ITH1.Add("F", Func_f)
ITH1.Add("G", Func_g)
; ITH1.Add("H", Func_h)
ITH1.Add("I", Func_i)
; ITH1.Add("J", Func_j)
ITH1.Add("K", Func_k)
; ITH1.Add("L", Func_l)
ITH1.Add("M", Func_m)
ITH1.Add("N", Func_n)
ITH1.Add("O", Func_o)
; ITH1.Add("P", Func_p)
; ITH1.Add("Q", Func_q)
; ITH1.Add("R", Func_r)
ITH1.Add("S", Func_s)
ITH1.Add("T", Func_t)
; ITH1.Add("U", Func_u)
ITH1.Add("V", Func_v)
ITH1.Add("W", Func_w)
ITH1.Add("X", Func_x)
; ITH1.Add("Y", Func_y)
ITH1.Add("Z", Func_z)
ITH1.Add("Alt", Func_alt)
ITH1.Add("Space", Func_sp)
ITH1.Add("Ctrl", Func_ctrl)
ITH1.Add("1", Func_1)
ITH1.Add("2", Func_2)
ITH1.Add("Shift", Func_shift)
ITH1.Add("CapsLock", Func_CapsLock)
return

;================================
;========FunctionLists===========
;================================

Func_a(isHold, taps, state) { ; AutoHotkey
    if (isHold = 1) & (taps = 1) & (state) ; Ahk2Exe
    {
        if (!WinExist("ahk_exe Ahk2Exe.exe")) {
            Run(A_ProgramFiles "\AutoHotkey\Compiler\Ahk2Exe.exe")
        }
        else {
            if WinExist("ahk_exe Ahk2Exe.exe") {
                WinActivate("ahk_exe Ahk2Exe.exe")
            }
            else {
                MsgBox("Ahk2Exe was not found!", "Ahk2Exe Automation", "0 T1")
            }
        }
    }

    if (isHold = 0) & (taps = 2) & (state) ; WindowSpy
    {
        if (!WinExist("Window Spy for AHKv2")) {
            Run(A_ProgramFiles "\AutoHotkey\WindowSpy.ahk")
        }
        else {
            if WinExist("Window Spy for AHKv2") {
                WinActivate("Window Spy for AHKv2")
            }
            else {
                MsgBox("WindowSpy was not found!", "WindowSpy Automation", "0 T1")
            }
        }
    }

    if (isHold = 0) & (taps = 1) & (state)
    {
        AHK_HELP(
            A_ScriptDir "\lib\ico\Help.ico",
            "Select a Help File`nVersion",
            A_ScriptDir "\lib\pic\HelpSelection_Left.png",
            A_ScriptDir "\lib\pic\HelpSelection_Right.png"
        )
        TraySetIcon(masterIcon)
        return
    }

    if (isHold = 0) & (taps = 3) & (state) ; ui-dash
    {
        if (!WinExist("AutoHotkey Dash")) {
            Run(A_ProgramFiles "\AutoHotkey\UX\ui-dash.ahk")
        }
        else {
            if WinExist("AutoHotkey Dash") {
                WinActivate("AutoHotkey Dash")
            }
            else {
                MsgBox("Ui-Dash was not found!", "Ui-Dash Automation", "0 T1")
            }
        }
    }
}

Func_b(isHold, taps, state) { ; Blender
    if (isHold = 0) & (taps = 1) & (state)
    {
        ; Blender latest Version
        If !WinExist("ahk_exe blender.exe") {
            Run("blender-launcher.exe")
            WinWait("ahk_exe blender.exe") ; Wait for Blender to open
        }
        else {
            if WinExist("ahk_exe blender.exe") {
                WinActivate("ahk_exe blender.exe")
            }
        }
    }
}

Func_c(isHold, taps, state) { ; Chrome
    if (isHold = 0) & (taps = 1) & (state)
    {
        if (!WinExist("ahk_exe chrome.exe")) {
            Run("Chrome")
            WinWait("ahk_exe chrome.exe") ; Wait for Chrome to open
        }

        if (WinActive("ahk_exe chrome.exe")) {
            Send("^+{Tab}")
        }
        else {
            if WinExist("ahk_exe chrome.exe") {
                WinActivate("ahk_exe chrome.exe")
            } else {
                MsgBox("Chrome was not found!", "Chrome Automation", "0 T1")
            }
        }
    }

    if (isHold = 0) & (taps = 2) & (state)
    {
        if (!WinExist("ahk_exe chrome.exe")) {
            Run("Chrome")
            WinWait("ahk_exe chrome.exe") ; Wait for Chrome to open
        }

        if (WinActive("ahk_exe chrome.exe")) {
            Send("^{t}")
        }
        else {
            if WinExist("ahk_exe chrome.exe") {
                WinActivate("ahk_exe chrome.exe")
            } else {
                MsgBox("Chrome was not found!", "Chrome Automation", "0 T1")
            }
        }
    }
}

Func_d(isHold, taps, state) { ; Directory Opus
    if (isHold = 0) & (taps = 1) & (state)
    {
        if (!WinExist("ahk_class dopus.lister")) {
            Run("dopus.exe")
            WinWait("ahk_class dopus.lister") ; Wait for Directory Opus to open
        }

        if (WinActive("ahk_exe dopus.exe")) {
            SendInput("^{PgDn}")
        }
        else {
            if WinExist("ahk_exe dopus.exe") {
                WinActivate("ahk_exe dopus.exe")
            } else {
                MsgBox("Directory Opus was not found!", "Directory Opus Automation", "0 T1")
            }
        }
    }

    if (isHold = 0) & (taps = 2) & (state)
    {
        Run(A_ScriptDir "\lib\dcf\Layout 'Default'.dcf")
    }

    if (isHold = 1) & (taps = 1) & (state)
    {
        if !WinExist("ahk_exe dopus.exe") {
            Run("dopus.exe")
            WinWait("ahk_exe dopus.exe") ; Wait for Directory Opus to open
        }

        if (WinActive("ahk_exe dopus.exe")) {
            SendInput("{Tab}")
        }
        else {
            if WinExist("ahk_exe dopus.exe") {
                WinActivate("ahk_exe dopus.exe")
            } else {
                MsgBox("Directory Opus was not found!", "Directory Opus Automation", "0 T1")
            }
        }
    }
}

Func_e(isHold, taps, state) { ; Explorer
    if (isHold = 0) & (taps = 1) & (state)
    {
        if (!WinExist("ahk_class CabinetWClass")) {
            Run("explorer " MyDownloads)
            WinWait("ahk_class CabinetWClass") ; Wait for Explorer to open
        }

        if (WinActive("ahk_class CabinetWClass")) {
            Send("^{tab}")
        }
        else {
            if WinExist("ahk_class CabinetWClass") {
                WinActivateBottom ("ahk_class CabinetWClass") ;you have to use WinActivateBottom if you didn't create a window group.
            }
            else {
                MsgBox("Explorer was not found!")
            }
        }
    }

    if (ishold = 0) & (taps = 2) & (state)
    {
        MouseMove(1044, 228, 1)
    }

    if (isHold = 1) & (taps = 1) & (state)
    {
        MouseMove(2372, 435, 1)
    }
}

Func_i(isHold, taps, state) { ; DO_Image Viewer
    if (isHold = 0) & (taps = 1) & (state)
    {
        Run(A_ScriptDir "\lib\dcf\Layout 'Image Viewer'.dcf")
    }
}

Func_k(isHold, taps, state) { ; K-Cycles
    MsgBox("K-Cycles Automation is under development!", "K-Cycles Automation", "0x30 T1")
}

Func_m(isHold, taps, state) { ; Uppercase, Lowercase, Capitalized
    if (isHold = 0) & (taps = 1) & (state) ; Uppercase
    {
        OldClipboard := A_Clipboard
        A_Clipboard := ""
        Send("^c") ;copies selected text
        Errorlevel := !ClipWait()
        Uppercase := StrUpper(A_Clipboard)
        Send(Uppercase)
        Sleep(1000)
        OldClipboard := A_Clipboard
        return
    }

    if (isHold = 0) & (taps = 2) & (state) ; Lowercase
    {
        OldClipboard := A_Clipboard
        A_Clipboard := ""
        Send("^c") ;copies selected text
        Errorlevel := !ClipWait()
        Lowercase := StrLower(A_Clipboard)
        Send(Lowercase)
        Sleep(1000)
        OldClipboard := A_Clipboard
        return
    }

    if (isHold = 1) & (taps = 1) & (state) ; Titlecase
    {
        OldClipboard := A_Clipboard
        A_Clipboard := ""
        Send("^c") ;copies selected text
        Errorlevel := !ClipWait()
        A_Clipboard := StrTitle(A_Clipboard)
        Send(A_Clipboard)
        Sleep(1000)
        OldClipboard := A_Clipboard
        return
    }
}

Func_n(isHold, taps, state) { ; Notion
    if (isHold = 0) & (taps = 1) & (state)
    {
        MsgBox("Notion Automation is under development!", "Notion Automation", "0x30 T1")
    }
}

Func_o(isHold, taps, state) { ; Ditto (Important Clip)
    if (isHold = 0) & (taps = 1) & (state)
    {
        ; Ctrl & Shift & Alt & Win & F8
        Send ("^+!#{F8}")
    }
}

Func_g(isHold, taps, state) { ; Graphic Tablet
    if (isHold = 0) & (taps = 1) & (state)
    {
        MsgBox("Graphic Tablet Automation is under development!", "Graphic Tablet Automation", "0x30 T1")
    }
}

Func_s(isHold, taps, state) { ; Services
    {
        Run(A_ScriptDir "\lib\exe\services.lnk")
    }
}

Func_t(isHold, taps, state) { ; TrafficMonitor
    MsgBox("TrafficMonitor Automation is under development!", "TrafficMonitor Automation", "0x30 T1")
}

Func_v(isHold, taps, state) { ; VLC Media Player
    if (isHold = 0) & (taps = 1) & (state)
    {
        if !WinExist("ahk_exe vlc.exe") {
            Run("vlc.exe")
            WinWait("ahk_exe vlc.exe") ; Wait for Vlc to open
        }
        else {
            if WinExist("ahk_exe vlc.exe") {
                WinActivate("ahk_exe vlc.exe")
            } else {
                MsgBox("Vlc was not found!", "Vlc Automation", "0 T1")
            }
        }
    }

    if (isHold = 0) & (taps = 2) & (state)
    {
        if (WinActive("ahk_exe vlc.exe")) {
            Send("#+{Left}") ; Move Position
        }
        else {
            if WinExist("ahk_exe vlc.exe") {
                WinActivate("ahk_exe vlc.exe")
            } else {
                MsgBox("Vlc was not found!", "Vlc Automation", "0 T1")
            }
        }
    }
}

Func_w(isHold, taps, state) { ; Wifi
    if (isHold = 0) & (taps = 1) & (state)
    {
        WIFI(
            A_ScriptDir "\lib\ico\Wifi.ico",
            A_ScriptDir "\lib\ico\WifiOn&off.ico",
            A_ScriptDir "\lib\exe\Wifi_Connecting.exe",
            A_ScriptDir "\lib\exe\Wifi_Connexion.exe",
            A_ScriptDir "\lib\exe\Wifi_Disconnect.exe",
            A_ScriptDir "\lib\exe\ms-availablenetworks.url"
        )
        TraySetIcon(masterIcon)
        return
    }
}

Func_x(isHold, taps, state) { ; KMPlayer 64X
    MsgBox("KMPlayer 64X Automation is under development!", "KMPlayer 64X Automation", "0x30 T1")
}

Func_z(isHold, taps, state) { ; Copy File or Folder Path
    MsgBox("Copy File or Folder Path Automation is under development!", "Copy File or Folder Path Automation", "0x30 T1")
}

Func_alt(isHold, taps, state) { ; Obsidian
    if (isHold = 0) & (taps = 1) & (state)
    {
        if (!WinExist("ahk_exe Obsidian.exe")) {
            Run("C:\Users\User\AppData\Local\Programs\obsidian\Obsidian.exe")
            WinWait("ahk_exe Obsidian.exe") ; Wait for Obsidian to open
        }

        if (WinActive("ahk_exe Obsidian.exe")) {
            Send("^{p}") ; Open Command Palette
        }
        else {
            if WinExist("ahk_exe Obsidian.exe") {
                WinActivate("ahk_exe Obsidian.exe")
            } else {
                MsgBox("Obsidian was not found!")
            }
        }
    }

    if (isHold = 0) & (taps = 2) & (state)
    {
        if (!WinExist("ahk_exe Obsidian.exe")) {
            Run("C:\Users\User\AppData\Local\Programs\obsidian\Obsidian.exe")
            WinWait("ahk_exe Obsidian.exe") ; Wait for Obsidian to open
        }

        if (WinActive("ahk_exe Obsidian.exe")) {
            Send("^{,}") ; Open Settings
        } else {
            if WinExist("ahk_exe Obsidian.exe") {
                WinActivate("ahk_exe Obsidian.exe")
            } else {
                MsgBox("Obsidian was not found!")
            }
        }
    }
}

Func_sp(isHold, taps, state) { ; Flow-Launcher
    if (isHold = 0) & (taps = 1) & (state)
    {
        Send("!{Space}")
    }

    if (isHold = 0) & (taps = 2) & (state)
    {
        If WinActive("ahk_class CabinetWClass")
        {
            ToolTip("Select a File/Folder")
            KeyWait("LButton", "D")
            ToolTip()
            Sleep(500)
            Send("{Del}")
        }

        if WinActive("ahk_class dopus.lister")
        {
            ToolTip("Select a File/Folder")
            KeyWait("LButton", "D")
            ToolTip()
            Send("{Del}")
            Sleep(500)
            Send("{Enter}")
        }
    }
}

Func_ctrl(isHold, taps, state) { ; Disable & Enable Windows Update Services && Windows Update Services Running or Not
    if (isHold = 0) & (taps = 1) & (state)
    {
        Run(A_ScriptDir "\lib\exe\Windows Update Services Running or Not.exe")
    }

    if (isHold = 0) & (taps = 2) & (state)
    {
        Run(A_ScriptDir "\lib\exe\Enable Windows Update Services.exe")
    }

    if (isHold = 1) & (taps = 1) & (state)
    {
        Run(A_ScriptDir "\lib\exe\Disable Windows Update Services.exe")
    }
}

Func_shift(isHold, taps, state) { ; Blender_Shortcuts
    if (isHold = 0) & (taps = 1) & (state)
        ; Local View
    {
        if !WinExist("ahk_exe blender.exe") {
            MsgBox("You are not currently working in Blender.", "Blender Automation", "0 T1")
        }
        if WinActive("ahk_exe blender.exe") {
            ;Backslash
            SendInput("{/}")
        }
    }
}

Func_1(isHold, taps, state) { ; Blender_Shortcuts
    if (isHold = 0) & (taps = 1) & (state)
        ; Automatically Pack Resources
    {
        if !WinExist("ahk_exe blender.exe") {
            MsgBox("You are not currently working in Blender.", "Blender Automation", "0 T1")
        } if WinActive("ahk_exe blender.exe") {
            ;Shift & Ctrl & Alt & Numpad -
            SendInput("+^!{NumpadSub}")
        }
    }

    if (isHold = 0) & (taps = 2) & (state)
        ; Unpack Resources
    {
        if !WinExist("ahk_exe blender.exe") {
            MsgBox("You are not currently working in Blender.", "Blender Automation", "0 T1")
        } if WinActive("ahk_exe blender.exe") {
            ; Shift & Ctrl & Alt & Numpad +
            SendInput("+^!{NumpadAdd}")
        }
    }

    if (isHold = 1) & (taps = 1) & (state)
        ; Emulate 3 Button Mouse
    {
        if !WinExist("ahk_exe blender.exe") {
            MsgBox("You are not currently working in Blender.", "Blender Automation", "0 T1")
        } if WinActive("ahk_exe blender.exe") {
            ; Shift & Ctrl & Alt & Numpad x
            SendInput("+^!{NumpadMult}")
        }
    }

    if (isHold = 0) & (taps = 3) & (state)
        ; Recursive Unused Data-Blocks
    {
        if !WinExist("ahk_exe blender.exe") {
            MsgBox("You are not currently working in Blender.", "Blender Automation", "0 T1")
        } if WinActive("ahk_exe blender.exe") {
            ; Shift & Ctrl & Alt & F12
            SendInput("+^!{F12}")
        }
    }
}

Func_2(isHold, taps, state) { ; Blender_Shortcuts
    if (isHold = 0) & (taps = 1) & (state)
        ; Batch Renamer
    {
        if !WinExist("ahk_exe blender.exe") {
            MsgBox("You are not currently working in Blender.", "Blender Automation", "0 T1")
        } if WinActive("ahk_exe blender.exe") {
            ;Shift & Ctrl & Alt & F14
            SendInput("+^!{F14}")
        }
    }
}

Func_CapsLock(isHold, taps, state) { ; Date Convertor
    if (isHold = 0) & (taps = 1) & (state)
    {
        Run("cmd.exe /c python c:\Users\User\Documents\GitHub\Secondary-Keyboard\lib\py\Date_Convertor.py")
    }
}
