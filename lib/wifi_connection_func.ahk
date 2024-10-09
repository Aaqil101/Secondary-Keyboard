; Only works in ahk v2 and above...
#Requires Autohotkey v2

; Set the default mouse speed to 0
; This will make the mouse move instantly to its destination
; without any acceleration or deceleration
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
 * * The color palette can be found in here - https://in.pinterest.com/pin/1196337403011413/ & https://in.pinterest.com/pin/985231163680747/
 * @param {String} ww_icon - Icon for the GUI window
 * @param {String} on_off_png - Images for the left and right
 * @param {String} wifi_connecting - Add the pathway for wifi_connecting.exe
 * @param {String} wifi_connexion - Add the pathway for wifi_connexion.exe
 * @param {String} wifi_disconnect - Add the pathway for wifi_disconnect.exe
 * @param {String} ms_availablenetworks - Add the pathway for ms_availablenetworks.url
 * @param {String} [header_col="cfff5cc"] - Color of the header text
 * @param {String} [background_col="5d576b"] - Background color of the GUI window
 * @param {String} [b1_bgcol="9bc1bc"] - Background color of the first button
 * @param {Float} [b1_showBorder=0] - Show border of the first button
 * * The color of button is a string but by default it's 0 because (0 := Disable)
 * @param {String} [b1_borderCol=0] - Border color of the first button
 * @param {Float} [b1_roundedCorner=9] - Rounded corner of the first button
 * @param {String} [b2_bgcol="ed6a5a"] - Background color of the second button
 * @param {Float} [b2_showBorder=0] - Show border of the second button
 * * The color of button is a string but by default it's 0 because (0 := Disable)
 * @param {String} [b2_borderCol=0] - Border color of the second button
 * @param {Float} [b2_roundedCorner=9] - Rounded corner of the second button
 * @param {String} [b_text_col="fff5cc"] - Colors of the buttons text
 * @param {Float} [ww_transparent=250] - Level of transparency for the GUI window (0-255)
 * @param {Float} [window_width=400] - Width of the GUI window
 * @param {Float} [window_height=150] - Height of the GUI window
 */
WIFI(
    ww_icon,
    ww_header,
    on_off_png,
    wifi_connecting,
    wifi_connexion,
    wifi_disconnect,
    ms_availablenetworks,
    header_col := "cFBFADA",
    background_col := "221830",
    b1_bgcol := "c5757c",
    b1_showBorder := 0,
    b1_borderCol := 0,
    b1_roundedCorner := 9,
    b2_bgcol := "c5757c",
    b2_showBorder := 0,
    b2_borderCol := 0,
    b2_roundedCorner := 9,
    b3_bgcol := "c5757c",
    b3_showBorder := 0,
    b3_borderCol := 0,
    b3_roundedCorner := 9,
    b4_bgcol := "462037",
    b4_showBorder := 0,
    b4_borderCol := 0,
    b4_roundedCorner := 9,
    b_text_col := "FBFADA",
    ww_transparent := 250,
    window_width := 400,
    window_height := 145
) {
    ; Set the icon of the tray to the specified icon file
    ; ww_icon is a variable that contains the path to the icon file
    ; This is used to set the icon of the tray to a custom icon
    TraySetIcon(ww_icon)
    
    ; Create a new GUI window for wifi connection
    ; Set the GUI window to always on top
    wcGui := GuiExt("+AlwaysOnTop")

    ; Set the title bar of the GUI window to a dark theme
    wcGui.SetDarkTitle()
    
    ; Set the menu of the GUI window to a dark theme
    ; This will make the menu background and text color dark
    wcGui.SetDarkMenu()
    
    ; Set the font, font size and font color for the GUI window
    wcGui.SetFont("Bold", "JetBrains Mono NL")
    wcGui.SetFont("s13")		 ; Preferred size.
    wcGui.SetFont(header_col)	 ; Preferred color.
    
    ; Add a text control to the window with the specified text and
    ; options. The text is centered and placed at position (65, 15).
    wcGui.AddText("x80 y15 Center", ww_header)

    ; Add two picture controls to the window with the specified image
    ; and options. The first picture is placed at position (15, 9) and
    ; the second at position (335, 9).
    wcGui.AddPicture("x16 y9 w50 h50", on_off_png) ; Left Picture
    wcGui.AddPicture("x335 y9 w50 h50", on_off_png) ; Right Picture

    ; Set the font size of the buttons to 10.
    wcGui.SetFont("s10")

    ; Set the background color of the GUI window
    wcGui.BackColor := background_col

    ; Add a button to the GUI window with the text "Connecting..."
    ; The button is centered and placed at position (17, 65)
    ; The button is 120 pixels wide and 30 pixels high
    ; When the button is clicked, the Wifi_Connection_v1 function is called with the argument "Normal".
    button1 := wcGui.AddButton("x17 y65 w120 h30 Center", "Connecting...")
    button1.SetColor(b1_bgcol, b_text_col, b1_showBorder, b1_borderCol, b1_roundedCorner)
    button1.OnEvent("Click", Wifi_Connection_v1.Bind("Normal"))

    ; Add a button to the GUI window with the text "Connexion"
    ; The button is centered and placed at position (262, 65)
    ; The button is 120 pixels wide and 30 pixels high
    ; When the button is clicked, the Wifi_Connection_v2 function is called
    ; with the argument "Normal"
    button2 := wcGui.AddButton("x262 y65 w120 h30 Center", "Connexion")
    button2.SetColor(b2_bgcol, b_text_col, b2_showBorder, b2_borderCol, b2_roundedCorner)
    button2.OnEvent("Click", Wifi_Connection_v2.Bind("Normal"))

    ; Add a button to disconnect the Wifi.
    ; The button is centered and placed at position (145, 65).
    ; The button is 110 pixels wide and 30 pixels high.
    ; When the button is clicked, the Wifi_Dis function is called with the argument "Normal".
    button3 := wcGui.AddButton("x145 y65 w110 h30 Center", "Discinnect")
    button3.SetColor(b3_bgcol, b_text_col, b3_showBorder, b3_borderCol, b3_roundedCorner)
    button3.OnEvent("Click", Wifi_Dis.Bind("Normal"))

    ; Set the font size of the Wifi Center button to 15.
    wcGui.SetFont("s15")

    ; Add a button to open Wifi Center
    ; The button is centered and placed at position (17.5, 105)
    ; The button is 365 pixels wide and 35 pixels high
    ; When the button is clicked, the Open_Wifi_Center function is called
    ; with the argument "Normal"
    button4 := wcGui.AddButton("x17.5 y105 w365 h35 Center", "Wifi Center")
    button4.SetColor(b4_bgcol, b_text_col, b4_showBorder, b4_borderCol, b4_roundedCorner)
    button4.OnEvent("Click", Open_Wifi_Center.Bind("Normal"))

    ; Add a close button to the GUI window
    wcGui.OnEvent('Close', (*) => WinClose())

    ; Set the title of the GUI window
    wcGui.Title := "Wifi Selection"
    
    ; Show the GUI
    wcGui.Show("w400 y145 Center")
    
    ; Set the GUI Transparent to a parameter
    WinSetTransparent(ww_transparent, "Wifi Selection")
    
    ; This code block waits for the wcGui window to appear
    WinWait("Wifi Selection")

	; Calculate the "center" position
    ; Move the mouse to the "center" of the wcGui window
    MouseMove(
		window_width / 2,
		window_height / 2 - 30
	)

    /*
    * The following code block is from a youtube video (https://www.youtube.com/watch?v=jn83VAU3tBw) but the code in tha video is for autohotkey v1 and I am using v2 in here so, I used AHK-v2-script-converter (https://github.com/mmikeww/AHK-v2-script-converter) by mmikeww and changed some of codes myself now it works :) 👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼👇🏼
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

    /*
    👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼👆🏼
    */

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