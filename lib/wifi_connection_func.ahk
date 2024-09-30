; Only works in ahk v2 and above...
#Requires Autohotkey v2

; Set the default mouse speed to 0
; This will make the mouse move instantly to its destination
; without any acceleration or deceleration
SetDefaultMouseSpeed 0

; Define the function Wifi
WIFI(ww_icon, on_off_png, ww_transparent, window_width, window_height, wifi_connecting, wifi_connexion, wifi_disconnect, ms_availablenetworks) {
    ; Variables for the GUI window
    x := 752
    y := 451
    Width := 416
    Height := 184

    ; Set the icon of the tray to the specified icon file
    ; ww_Icon is a variable that contains the path to the icon file
    ; This is used to set the icon of the tray to a custom icon
    TraySetIcon(ww_icon)
    
    ; Create a new GUI window for the Wifi connection tool
    wcGui := Gui()

    ; Set the GUI window to always on top
    wcGui.Opt("+AlwaysOnTop")
    
    ; Set the font, font size and font color for the GUI window
    wcGui.SetFont("Bold", "JetBrains Mono NL")
    wcGui.SetFont("s14")		 ; Preferred size.
    wcGui.SetFont("cFFFFFF")	 ; Preferred color.
    
    ; Add a text control to the window with the specified text and
    ; options. The text is centered and placed at position (65, 15).
    wcGui.Add("Text", "x80 y15 Center", "Select a WifConnection")

    ; Add two picture controls to the window with the specified image
    ; and options. The first picture is placed at position (15, 9) and
    ; the second at position (335, 9).
    wcGui.Add("Picture", "x16 y9 w50 h50", on_off_png) ; Left Picture
    wcGui.Add("Picture", "x335 y9 w50 h50", on_off_png) ; Right Picture

    ; Set the font size of the buttons to 10.
    wcGui.SetFont("s10")

    ; Add buttons to the GUI window
    wcGui.Add("Button", "x17 y65 w120 h30 Center", "Connecting...").OnEvent("Click", Wifi_Connection_v1.Bind("Normal"))
    wcGui.Add("Button", "x262 y65 w120 h30 Center", "Connexion").OnEvent("Click", Wifi_Connection_v2.Bind("Normal"))
    wcGui.Add("Button", "x145 y65 w110 h30 Center", "Discinnect").OnEvent("Click", Wifi_Dis.Bind("Normal"))

    ; Set the font size of the buttons to 10.
    wcGui.SetFont("s15")

    wcGui.Add("Button", "x17.5 y105 w365 h35 Center", "Wifi Center").OnEvent("Click", Open_Wifi_Center.Bind("Normal"))

    ; Add a close button to the GUI window
    wcGui.OnEvent('Close', (*) => WinClose())

    ; Set the background color of the GUI window
    wcGui.BackColor := "123452"

    ; Set the title of the GUI window
    wcGui.Title := "Wifi Selection"
    
    ; Show the GUI
    wcGui.Show("w400 y145 Center")
    
    ; Set the GUI Transparent to a parameter
    WinSetTransparent(ww_transparent, "Wifi Selection")
    
    ; This code block waits for the wcGui window to appear
    WinWait("Wifi Selection")

    ; Get the position and size of the wcGui window
    /* wcGui.GetPos(&X, &Y, &Width, &Height)
    MsgBox("X = " X "`n" "Y = " Y "`n" "Width = " Width "`n" "Height = " Height) */

	; Calculate the "center" position
    ; Move the mouse to the "center" of the wcGui window
    MouseMove(
		window_width / 2,
		window_height / 2 - 30
	)

    ; IDC constants for LoadCursor (WinAPI)
    ; These constants can be used to load the following cursors:
    IDC_APPSTARTING :=  32650   ; IDC_APPSTARTING - App Starting
    IDC_ARROW := 32512          ; IDC_ARROW - Arrow
    IDC_CROSS := 32515          ; IDC_CROSS - Cross
    IDC_HAND := 32649           ; IDC_HAND - Hand
    IDC_HELP := 32651           ; IDC_HELP - Help
    IDC_IBEAM := 32513          ; IDC_IBEAM - I Beam
    IDC_NO := 32648             ; IDC_NO - Slashed Circle
    IDC_SIZEALL := 32646        ; IDC_SIZEALL - Four-pointed star (resize in all directions)
    IDC_SIZENESW := 32643       ; IDC_SIZENESW - Double arrow pointing NE and SW
    IDC_SIZENS := 32645         ; IDC_SIZENS - Double arrow pointing N and S
    IDC_SIZENWSE := 32642       ; IDC_SIZENWSE - Double arrow pointing NW and SE
    IDC_SIZEWE := 32644         ; IDC_SIZEWE - Double arrow pointing W and E
    IDC_UPARROW := 32516        ; IDC_UPARROW - Up arrow
    IDC_WAIT := 32514           ; IDC_WAIT - Hourglass

    ; Load the "hand" cursor from the system resources
    ; This cursor is used to indicate that a button is clickable
    ; The first parameter is NULL, which tells the function to load the cursor
    ; from the system resources. The second parameter is the ID of the cursor
    ; to load, which is IDC_HAND. The third parameter is ignored.
    BCursor := DllCall(
        "LoadCursor", "UInt", NULL := 0, "Int", IDC_HAND, "UInt"
    )
    
    ; Load the "hand" cursor from the system resources
    ; This cursor is used to indicate that a link is clickable
    ; The first parameter is NULL, which tells the function to load the cursor
    ; from the system resources. The second parameter is the ID of the cursor
    ; to load, which is IDC_HAND. The third parameter is ignored.
    LVCursor:=DllCall(
        "LoadCursor", "UInt", NULL := 0, "Int", IDC_HAND, "UInt"
    )

    ; Set the cursor when hovering over certain buttons
    OnMessage(0x200, WM_MOUSEMOVE)
    WM_MOUSEMOVE(wParam, lParam, msg, hwnd) {
    MouseGetPos(, , , &ctrl)

    ; Set the cursor to 'BCursor' when hovering over Button1, Button2, Button3 and Button4
    if (ctrl == "Button1")
        DllCall("SetCursor", "UInt", BCursor)
    if (ctrl == "Button2")
        DllCall("SetCursor", "UInt", BCursor)
    if (ctrl == "Button3")
        DllCall("SetCursor", "UInt", BCursor)
    if (ctrl == "Button4")
        DllCall("SetCursor", "UInt", BCursor)
    }

    ; Runs the Wifi_Connecting executable and closes the GUI.
    Wifi_Connection_v1(*) {
        Run(wifi_connecting)
        wcGui.Destroy()
    }

    ; Launch the Wifi_Connexion executable and close the GUI.
    Wifi_Connection_v2(*) {
        Run(wifi_connexion)
        wcGui.Destroy()
    }

    ; Disconnect the Wifi.
    ; Run the Wifi_Disconnect executable
    ; Destroy the current Gui.
    Wifi_Dis(*) {
        Run(wifi_disconnect)
        wcGui.Destroy()
    }

    ; Open the wifi application center and destroy the GUI.
    Open_Wifi_Center(*) {
        Run(ms_availablenetworks)
        wcGui.Destroy()
    }

    return wcGui ; Return the wcGui window
}