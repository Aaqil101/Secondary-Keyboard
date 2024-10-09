#Requires AutoHotkey v2.0

; Set the default mouse speed to 0, which is the fastest speed.
; This is useful for scripts that need to move the mouse quickly.
SetDefaultMouseSpeed 0

/*
* Include the GuiEnhancerKit library, which provides a set of functions to enhance the look and feel of AutoHotkey GUIs.
* For more information, see https://github.com/nperovic/GuiEnhancerKit

* Include the ColorButton library, which allows you to create custom buttons.
* For more information, see https://github.com/nperovic/ColorButton.ahk
*/

#Include GuiEnhancerKit.ahk
#Include ColorButton.ahk

/**
 * Creates a GUI window with a specified icon, header text, left and right images, colors and ect...
 * * The color palette can be found in here - https://in.pinterest.com/pin/563018696837652/ & https://in.pinterest.com/pin/985231163680747/
 * @param {String} ah_icon - Icon for the GUI window
 * @param {String} ah_header - Header text
 * @param {String} ah_left_image - Left image
 * @param {String} ah_right_image - Right image
 * @param {String} [header_col="cFBFADA"] - Color of the header text
 * @param {String} [background_col="161b2e"] - Background color of the GUI window
 * @param {String} [b1_bgcol="541b2e"] - Background color of the first button
 * @param {Float} [b1_showBorder=0] - Show border of the first button
 * * The color of button is a string but by default it's 0 because (0 := Disable)
 * @param {String} [b1_borderCol=0] - Border color of the first button
 * @param {Float} [b1_roundedCorner=9] - Rounded corner of the first button
 * @param {String} [b2_bgcol="b2192b"] - Background color of the second button
 * @param {Float} [b2_showBorder=0] - Show border of the second button
 * * The color of button is a string but by default it's 0 because (0 := Disable)
 * @param {String} [b2_borderCol=0] - Border color of the second button
 * @param {Float} [b2_roundedCorner=9] - Rounded corner of the second button
 * @param {String} [b_text_col="FBFADA"] - Colors of the buttons text
 * @param {Float} [ah_transparent=250] - Level of transparency for the GUI window (0-255)
 * @param {Float} [window_width=400] - Width of the GUI window
 * @param {Float} [window_height=150] - Height of the GUI window
 */
AHK_HELP(
    ah_icon,
    ah_header,
    ah_left_image,
    ah_right_image,
    header_col := "cFBFADA",
    background_col := "161b2e",
    b1_bgcol := "541b2e",
    b1_showBorder := 0,
    b1_borderCol := 0,
    b1_roundedCorner := 9,
    b2_bgcol := "b2192b",
    b2_showBorder := 0,
    b2_borderCol := 0,
    b2_roundedCorner := 9,
    b_text_col := "FBFADA",
    ah_transparent := 250,
    window_width := 400,
    window_height := 150
) {
	; Set the icon of the tray to the specified icon file
	; ah_icon is a variable that contains the path to the icon file
	; This is used to set the window icon to a custom icon
	TraySetIcon(ah_icon)

	; Create a new GUI window for AHK_HELP
    ; Set the GUI window to always on top
	ahGui := GuiExt("+AlwaysOnTop")

    ; Set the title bar of the GUI window to a dark theme
    ahGui.SetDarkTitle()
    ahGui.SetWindowAttribute(33, 2)
    
    ; Set the menu of the GUI window to a dark theme
    ; This will make the menu background and text color dark
    ahGui.SetDarkMenu()

	; Set the font, font size and font color for the GUI window
	ahGui.SetFont("Bold", "JetBrains Mono NL")  
	ahGui.SetFont("s15") ; Header Preferred size.
	ahGui.SetFont(header_col) ; Header Preferred color.

	; Add a text control to the window with the specified text and
    ; options. The text is centered and placed at position (1, 5).
	ahGui.AddText("Center " . "w400" . " x1 y5", ah_header)

	; Add two picture controls to the window with the specified image
    ; and options. The first picture is placed at position (15, 7) and
    ; the second at position (335, 7).
	ahGui.AddPicture("x15 y7 w60 h60", ah_left_image)
	ahGui.AddPicture("x330 y7 w60 h60", ah_right_image)

	; Set the font size of the buttons to 12.
	ahGui.SetFont("s12") ; Button Preferred size.

    ; Set window to dark mode
    ; See https://learn.microsoft.com/en-us/windows/win32/api/dwmapi/nf-dwmapi-dwmsetwindowattribute
    ; DWMWA_USE_IMMERSIVE_DARK_MODE = 20
    DllCall("Dwmapi\DwmSetWindowAttribute", "Ptr", ahGui.hwnd, "UInt", 20, "Ptr*", 1, "UInt", 4)

    ; Set the background color of the GUI window
	ahGui.BackColor := background_col

    ; Add a button to open AutoHotkey v1 help file
    button1 := ahGui.AddButton("x50 y104 w303 h30 Center", "v&1.1.37.02")
    button1.SetColor(b1_bgcol, b_text_col, b1_showBorder, b1_borderCol, b1_roundedCorner)

    ; Bind the button to the function that opens the help file
    button1.OnEvent("Click", Ahk_V1_Help_File.Bind("Normal"))

    ; Add a button to open AutoHotkey v2 help file
    button2 :=ahGui.AddButton("x50 y64 w303 h30 Center", "v&2...")
    button2.SetColor(b2_bgcol, b_text_col, b2_showBorder, b2_borderCol, b2_roundedCorner)

    ; Bind the button to the function that opens the help file
    button2.OnEvent("Click", Ahk_V2_Help_File.Bind("Normal"))

    ; Add a close button to the GUI window
	ahGui.OnEvent('Close', (*) => WinClose())
    

    ; SetWindowAttribute(33, 2) sets the WS_EX_LAYERED window style,
    ; which allows the window to have a transparent background.
    ; See https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setwindowlonga
    ; for more information.
    ahGui.SetWindowAttribute(33, 2) ; WS_EX_LAYERED

    ; Set the title of the GUI window
	ahGui.Title := "Ahk Help Selection"

    ; Show the GUI
	ahGui.Show("w400 h150 Center")
	
    ; Set the GUI Transparent to a parameter
	WinSetTransparent(ah_transparent, "Ahk Help Selection")

	; This code block waits for the ahGui window to appear
    WinWait("Ahk Help Selection")

    ; Move the mouse to the center of the ahGui window
    MouseMove(
        window_width / 2,
        window_height / 2
    )
    
    /*
    * The following code block is from a youtube video (https://www.youtube.com/watch?v=jn83VAU3tBw)
    * but the code in tha video is for autohotkey v1 and I am using v2 in here.
    * So, I used AHK-v2-script-converter (https://github.com/mmikeww/AHK-v2-script-converter) by mmikeww and changed some of codes myself now it works :) 👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼
    */

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

    ; Set the cursor to 'BCursor' when hovering over Button1, Button2
    if (ctrl == "Button1")
        DllCall("SetCursor", "UInt", BCursor)
    if (ctrl == "Button2")
        DllCall("SetCursor", "UInt", BCursor)
    }

    /*
    👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼
    */

	Ahk_V1_Help_File(*) {
		; Check if the Help file is already open
		if !WinExist("ahk_exe hh.exe") { ; If not, open it with the appropriate version of AutoHotkey
			Run(A_ProgramFiles "\AutoHotkey\v1.1.37.02\AutoHotkeyU64.exe")
		} else { ; If it is, just activate the window
			WinActivate("ahk_exe hh.exe")
		}

		ahGui.Destroy() ; Destroy the GUI, as it is no longer needed
	}

	Ahk_V2_Help_File(*) {
		; Check if the Help file is already open
		if !WinExist("AutoHotkey v2 - Google Chrome") { ; Open the AutoHotkey v2 documentation in Google Chrome
			Run("https://www.autohotkey.com/docs/v2/index.htm") 
		} else { ; If it is, just activate the window
			WinActivate("AutoHotkey v2 - Google Chrome")
		}
		
		ahGui.Destroy() ; Destroy the GUI, as it is no longer needed
	}
	return ahGui ; Return the ahGui window
}