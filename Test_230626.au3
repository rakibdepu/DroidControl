#NoTrayIcon
;==>"Made with️ ❤ in Bangladesh"

Opt("GUIOnEventMode", 1)
Opt("GUICoordMode", 1)
Opt("GUICloseOnESC", 1)
Opt("MustDeclareVars", 1)

#include <Array.au3>
#include <ButtonConstants.au3>
#include <Clipboard.au3>
#include <ColorConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <File.au3>
#include <FontConstants.au3>
#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <GUIListView.au3>
#include <GuiStatusBar.au3>
#include <GuiTab.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_array_Devices, $g_btn_Back, $g_btn_Connect, $g_btn_GetIP, $g_btn_Home, $g_btn_Menu, $g_btn_NotificationOff, $g_btn_NotificationOn, $g_btn_ScrcpyOn, $g_btn_Power, $g_btn_Refresh, $g_btn_Reset, $g_btn_ScreenOff, $g_btn_ScreenOn, $g_btn_Switch, $g_btn_VolumeDown, $g_btn_VolumeUP, $g_chk_AlwaysOnTop, $g_chk_Borderless, $g_chk_FullScreen, $g_chk_NoScreenSaver, $g_chk_PowerOffOnExit, $g_chk_ShowTouch, $g_chk_StayAwake, $g_chk_TurnOffTheScreen, $g_chk_ViewOnlyMode, $g_cmd_DeviceAccount, $g_cmd_DeviceBattery, $g_cmd_DeviceIP, $g_cmd_DeviceListGet, $g_cmd_DeviceModel, $g_cmd_DeviceSerial, $g_cmd_DeviceUser, $g_cmd_DeviceUptime, $g_cmd_DeviceWifi, $g_cmd_GetIP, $g_cmdout_DeviceAccount, $g_cmdout_DeviceBattery, $g_cmdout_DeviceListGet, $g_cmdout_DeviceUser, $g_cmdout_DeviceUptime, $g_cmdout_DeviceWifi, $g_cmdout_GetIP, $g_data_Account, $g_data_AlwaysOnTop, $g_data_Battery, $g_data_Borderless, $g_data_Connection, $g_data_DeviceAccount, $g_data_DeviceBattery
Global $g_data_DeviceBatteryAC, $g_data_DeviceBatteryUSB, $g_data_DeviceConnection, $g_data_DeviceIP, $g_data_DeviceListGet, $g_data_DeviceModel, $g_data_DeviceSerial, $g_data_DeviceUser, $g_data_DeviceUptime, $g_data_DeviceWifi, $g_data_FullScreen, $g_data_IP, $g_data_Model, $g_data_NoScreenSaver, $g_data_PowerOffOnExit, $g_data_Resolution, $g_data_Serial_1, $g_data_Serial_2, $g_data_Shortcut, $g_data_ShowTouch, $g_data_StayAwake, $g_data_Title, $g_data_User, $g_data_TurnOffTheScreen, $g_data_Uptime, $g_data_ViewOnlyMode, $g_data_Wifi, $g_extfile_IP, $g_graphic_Line, $g_group_Details, $g_group_DeviceList, $g_group_Options, $g_group_Parameter, $g_group_Resolution, $g_group_SelectedDevice, $g_group_Shortcut, $g_group_Touch, $g_group_Wireless, $g_gui_Child, $g_gui_Main, $g_ini_AlwaysOnTop, $g_ini_Borderless, $g_ini_Devices, $g_ini_FullScreen, $g_ini_NoScreenSaver, $g_ini_PowerOffOnExit, $g_ini_ScrcpyCommand, $g_ini_ShowTouch, $g_ini_StayAwake, $g_ini_TurnOffTheScreen, $g_ini_ViewOnlyMode
Global $g_ini_WiFiAddress, $g_input_IPAddress, $g_key_Shortcut, $g_lbl_Account_1, $g_lbl_Account_2, $g_lbl_Battery_1, $g_lbl_Battery_2, $g_lbl_Connection_1, $g_lbl_Connection_2, $g_lbl_IP_1, $g_lbl_IP_2, $g_lbl_Model_1, $g_lbl_Model_2, $g_lbl_Parameter, $g_lbl_SelectedDevice_1, $g_lbl_SelectedDevice_2, $g_lbl_Serial_1, $g_lbl_Serial_2, $g_lbl_User_1, $g_lbl_User_2, $g_lbl_Uptime_1, $g_lbl_Uptime_2, $g_lbl_Wifi_1, $g_lbl_Wifi_2, $g_lvw_DeviceList, $g_rad_ResolutionAuto, $g_rad_ResolutionMax, $g_rad_ShortcutAlt, $g_rad_ShortcutCtrl, $g_regex_DeviceAccount, $g_regex_DeviceBattery, $g_regex_DeviceBatteryAC, $g_regex_DeviceBatteryUSB, $g_regex_DeviceUser, $g_regex_DeviceWifi, $g_Slogan, $g_Status, $g_txt_IP_1, $g_txt_IP_2, $g_txt_IP_3, $g_txt_IP_4, $g_lbl_Title_1, $g_lbl_Title_2, $g_input_Title, $g_btn_DeviceShutdown, $g_btn_DeviceReboot, $g_btn_DisplayPowerOnOff, $g_btn_DeviceUnlock, $g_data_ScrcpyTitle
Global $g_ini_Config = @ScriptDir & "\Core\Config.ini"
Global $g_font_Name = "Baloo Da 2"
Global $g_font_Size = 9.5
Global $g_font_Bold = 700

_f_sub_MainProgram()

Func _f_sub_MainProgram()
	_f_sub_StartupCheck()
	_f_sub_StatusBar("Installing required components")
	_f_sub_GUIMain()
	_f_sub_StatusBar("Reading settings")
	_f_sub_ReadIni()
	_f_sub_StatusBar("Starting ADB Server")
	_f_sub_AdbStart()
	_f_sub_StatusBar("Searching for device")
	_f_sub_DeviceListGet()
	_f_sub_StatusBar("Making a device list")
	_f_sub_DeviceListSet()
	_f_sub_StatusBar("Select a device from list")
	While 1
		Sleep(100)
	WEnd
EndFunc   ;==>_f_sub_MainProgram

Func _f_btn_Refresh()
	_f_sub_StatusBar("Searching for device")
	_f_sub_DeviceListGet()
	_f_sub_StatusBar("Making a device list")
	_f_sub_DeviceListSet()
	_f_sub_StatusBar("Select a device from list")
EndFunc   ;==>_f_btn_Refresh

Func _f_btn_Reset()
	_f_sub_StatusBar("Restarting ADB Server")
	_f_sub_AdbStop()
	_f_sub_AdbStart()
	_f_sub_StatusBar("Searching for device")
	_f_sub_DeviceListGet()
	_f_sub_StatusBar("Making a device list")
	_f_sub_DeviceListSet()
	_f_sub_StatusBar("Select a device from list")
EndFunc   ;==>_f_btn_Reset

Func _f_btn_GetIP()
	_f_sub_StatusBar("Geting IP Address from selected device")
	_f_sub_GetIP()
	_f_sub_ReadIni()
EndFunc   ;==>_f_btn_GetIP

Func _f_btn_Connect()
	_f_sub_StatusBar("Try connecting to given IP")
	_f_sub_Connect()
	_f_sub_StatusBar("Searching for device")
	_f_sub_DeviceListGet()
	_f_sub_StatusBar("Making a device list")
	_f_sub_DeviceListSet()
	_f_sub_StatusBar("Select a device from list")
EndFunc   ;==>_f_btn_Connect

Func _f_btn_Parameter()
	_f_sub_StatusBar("Adding select parameter in the scrcpy command line")
	_f_sub_ParameterUpdate()
	_f_sub_ScrcpyCommand()
EndFunc   ;==>_f_btn_Parameter

Func _f_btn_ScrcpyOn()
	_f_sub_StatusBar("Starting scrcpy command")
	_f_btn_Parameter()
	_f_sub_ScrcpyOn()
	_f_sub_GUIChild()
	_f_sub_ScrcpyRun()
EndFunc   ;==>_f_btn_ScrcpyOn

Func _f_btn_DeviceShutdown()

EndFunc   ;==>_f_btn_DeviceShutdown

Func _f_btn_DeviceReboot()

EndFunc   ;==>_f_btn_DeviceReboot

Func _f_btn_DevicePowerOnOff()

EndFunc   ;==>_f_btn_DevicePowerOnOff

Func _f_btn_DeviceUnlock()

EndFunc   ;==>_f_btn_DeviceUnlock

Func _f_sub_StartupCheck()
	$g_extfile_IP = @ScriptDir & "\Core\ip.bat"
	$g_txt_IP_1 = "FOR /F ""tokens=2"" %%G IN ('adb -s shell ip addr show wlan0 ^|find ""inet ""') DO set ipfull=%%G"
	$g_txt_IP_2 = "FOR /F ""tokens=1 delims=/"" %%G in (""%ipfull%"") DO set ip=%%G"
	$g_txt_IP_3 = "echo %ip%|clip"
	If Not FileExists($g_extfile_IP) Then
		_FileCreate($g_extfile_IP)
		_FileWriteToLine($g_extfile_IP, 1, $g_txt_IP_1, True, True)
		_FileWriteToLine($g_extfile_IP, 2, $g_txt_IP_2, True, True)
		_FileWriteToLine($g_extfile_IP, 3, $g_txt_IP_3, True, True)
	EndIf
EndFunc   ;==>_f_sub_StartupCheck

Func _f_sub_GUIMain()
	$g_gui_Main = GUICreate("Droid Control", 400, 595, -1, -1, BitOR($WS_POPUP, $WS_CAPTION))
	GUISetOnEvent($GUI_EVENT_CLOSE, "_f_sub_GUIMainClose")
	GUISetBkColor($CLR_WHITE)
	$g_group_DeviceList = GUICtrlCreateGroup("Device List", 5, 5, 390, 120, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_lvw_DeviceList = _GUICtrlListView_Create($g_gui_Main, "#|Device|Connection", 10, 20, 305, 100)
	_GUICtrlListView_SetExtendedListViewStyle($g_lvw_DeviceList, $LVS_EX_FULLROWSELECT)
	_GUICtrlListView_SetColumnWidth($g_lvw_DeviceList, 0, 50)
	_GUICtrlListView_SetColumnWidth($g_lvw_DeviceList, 1, 175)
	_GUICtrlListView_SetColumnWidth($g_lvw_DeviceList, 2, 80)
	_GUICtrlListView_JustifyColumn($g_lvw_DeviceList, 0, 2)
	_GUICtrlListView_JustifyColumn($g_lvw_DeviceList, 1, 2)
	_GUICtrlListView_JustifyColumn($g_lvw_DeviceList, 2, 2)
	$g_btn_Refresh = GUICtrlCreateButton("Refresh", 320, 20, 70, 48)
	GUICtrlSetOnEvent(-1, "_f_btn_Refresh")
	GUICtrlSetTip(-1, "Click to refresh device list.")
	$g_btn_Reset = GUICtrlCreateButton("Reset", 320, 73, 70, 47)
	GUICtrlSetOnEvent(-1, "_f_btn_Reset")
	GUICtrlSetTip(-1, "Click to reset device list.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_group_Wireless = GUICtrlCreateGroup("Wireless", 5, 130, 390, 40, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_btn_GetIP = GUICtrlCreateButton("Get IP", 10, 145, 70, 20)
	GUICtrlSetOnEvent(-1, "_f_btn_GetIP")
	GUICtrlSetTip(-1, "Get IP from usb device.")
	$g_input_IPAddress = _GUICtrlIpAddress_Create($g_gui_Main, 115, 145, 170, 20)
	_GUICtrlIpAddress_Set($g_input_IPAddress, $g_ini_WiFiAddress)
	$g_btn_Connect = GUICtrlCreateButton("Connect", 320, 145, 70, 20)
	GUICtrlSetOnEvent(-1, "_f_btn_Connect")
	GUICtrlSetTip(-1, "Click to connect with IP.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_group_Details = GUICtrlCreateGroup("Details", 5, 175, 390, 140, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_graphic_Line = GUICtrlCreateGraphic(81, 205, 309, 140)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_PENSIZE, 1)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_COLOR, 0xDCDCDC)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_LINE, 309, 0)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_MOVE, 0, 33)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_LINE, 309, 33)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_MOVE, 0, 51)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_LINE, 309, 51)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_MOVE, 0, 69)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_LINE, 117, 69)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_MOVE, 0, 87)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_LINE, 117, 87)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_MOVE, 192, 69)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_LINE, 309, 69)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_MOVE, 192, 87)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_LINE, 309, 87)

	$g_lbl_User_1 = GUICtrlCreateLabel("User", 10, 190, 66, 15)
	$g_lbl_User_2 = GUICtrlCreateLabel(":", 76, 190, 5, 15)
	$g_data_User = GUICtrlCreateLabel("", 81, 190, 309, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Account_1 = GUICtrlCreateLabel("Accounts", 10, 208, 73, 30)
	$g_lbl_Account_2 = GUICtrlCreateLabel(":", 76, 208, 2, 30)
	$g_data_Account = GUICtrlCreateLabel("", 81, 208, 309, 30)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Model_1 = GUICtrlCreateLabel("Device Model", 10, 241, 66, 15)
	$g_lbl_Model_2 = GUICtrlCreateLabel(":", 76, 241, 5, 15)
	$g_data_Model = GUICtrlCreateLabel("", 81, 241, 309, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Serial_1 = GUICtrlCreateLabel("Device Serial", 10, 259, 66, 15)
	$g_lbl_Serial_2 = GUICtrlCreateLabel(":", 76, 259, 5, 15)
	$g_data_Serial_2 = GUICtrlCreateLabel("", 81, 259, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Battery_1 = GUICtrlCreateLabel("Battery Status", 10, 277, 66, 15)
	$g_lbl_Battery_2 = GUICtrlCreateLabel(":", 76, 277, 5, 15)
	$g_data_Battery = GUICtrlCreateLabel("", 81, 277, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Uptime_1 = GUICtrlCreateLabel("Up Time", 10, 295, 66, 15)
	$g_lbl_Uptime_2 = GUICtrlCreateLabel(":", 76, 295, 5, 15)
	$g_data_Uptime = GUICtrlCreateLabel("", 81, 295, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Connection_1 = GUICtrlCreateLabel("Connected by", 202, 259, 66, 15)
	$g_lbl_Connection_2 = GUICtrlCreateLabel(":", 268, 259, 5, 15)
	$g_data_Connection = GUICtrlCreateLabel("", 273, 259, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Wifi_1 = GUICtrlCreateLabel("Wi-Fi SSID", 202, 277, 66, 15)
	$g_lbl_Wifi_2 = GUICtrlCreateLabel(":", 268, 277, 5, 15)
	$g_data_Wifi = GUICtrlCreateLabel("", 273, 277, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_IP_1 = GUICtrlCreateLabel("IP Address", 202, 295, 66, 15)
	$g_lbl_IP_2 = GUICtrlCreateLabel(":", 268, 295, 5, 15)
	$g_data_IP = GUICtrlCreateLabel("", 273, 295, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_group_Options = GUICtrlCreateGroup("Options", 5, 320, 315, 135, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_lbl_Title_1 = GUICtrlCreateLabel("Window Title", 10, 337, 62, 15)
	$g_lbl_Title_2 = GUICtrlCreateLabel(":", 72, 337, 5, 15)
	$g_input_Title = GUICtrlCreateEdit("", 78, 335, 237, 17, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL))
	$g_chk_AlwaysOnTop = GUICtrlCreateCheckbox("Always On Top", 10, 358, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Make scrcpy window always on top (above other windows).")
	$g_chk_Borderless = GUICtrlCreateCheckbox("Borderless", 112, 358, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Disable window decorations (display borderless window).")
	$g_chk_FullScreen = GUICtrlCreateCheckbox("Full Screen", 213, 358, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Start in fullscreen.")
	$g_chk_NoScreenSaver = GUICtrlCreateCheckbox("No ScreenSaver", 10, 389, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Disable screensaver while scrcpy is running.")
	$g_chk_PowerOffOnExit = GUICtrlCreateCheckbox("Power Off On Exit", 112, 389, 96, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Turn the device screen off when closing scrcpy.")
	$g_chk_ShowTouch = GUICtrlCreateCheckbox("Show Touch", 213, 389, 96, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Enable 'show touches' on start, restore the initial value on exit.")
	$g_chk_StayAwake = GUICtrlCreateCheckbox("Stay Awake", 10, 420, 96, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Keep the device on while scrcpy is running.")
	$g_chk_TurnOffTheScreen = GUICtrlCreateCheckbox("Turn Off The Screen", 112, 420, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Turn the device screen off immediately.")
	$g_chk_ViewOnlyMode = GUICtrlCreateCheckbox("View Only Mode", 213, 420, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Disable device control (mirror the device in read-only).")
;~ 	$g_Slogan = GUICtrlCreateLabel("Made with️ ❤ in Bangladesh", 10, 467, 290, 30, $SS_CENTER)
;~ 	GUICtrlSetFont(-1, $g_font_Size, $g_font_Bold, 0, $g_font_Name, 5)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_group_Resolution = GUICtrlCreateGroup("Resolution", 325, 320, 70, 65, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_rad_ResolutionAuto = GUICtrlCreateRadio("Auto", 330, 335, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Set window height automatic.")
	$g_rad_ResolutionMax = GUICtrlCreateRadio("Max", 330, 360, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Set window height maximum.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_group_Shortcut = GUICtrlCreateGroup("ShortCut", 325, 390, 70, 65, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_rad_ShortcutCtrl = GUICtrlCreateRadio("Ctrl", 330, 405, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Set 'Ctrl' as shortcut key.")
	$g_rad_ShortcutAlt = GUICtrlCreateRadio("Alt", 330, 430, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "_f_btn_Parameter")
	GUICtrlSetTip(-1, "Set 'Alt' as shortcut key.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_btn_DeviceShutdown = GUICtrlCreateButton("Device" & @CRLF & "Shutdown", 5, 460, 70, 50, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "_f_btn_DeviceShutdown")
	GUICtrlSetTip(-1, "Shutdown Device")

	$g_btn_DeviceReboot = GUICtrlCreateButton("Device" & @CRLF & "Reboot", 85, 460, 70, 50, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "_f_btn_DeviceReboot")
	GUICtrlSetTip(-1, "Reboot Device")

	$g_btn_DisplayPowerOnOff = GUICtrlCreateButton("Display" & @CRLF & "On / Off", 165, 460, 70, 50, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "_f_btn_DevicePowerOnOff")
	GUICtrlSetTip(-1, "Display On or Off")

	$g_btn_DeviceUnlock = GUICtrlCreateButton("Device" & @CRLF & "Unlock", 245, 460, 70, 50, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "_f_btn_DeviceUnlock")
	GUICtrlSetTip(-1, "Unlock Device")

	$g_btn_ScrcpyOn = GUICtrlCreateButton("Scrcpy" & @CRLF & "On", 325, 460, 70, 50, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "_f_btn_ScrcpyOn")
	GUICtrlSetTip(-1, "Start SCRCPY.")

	$g_group_Parameter = GUICtrlCreateGroup("Parameter", 5, 515, 390, 50, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_lbl_Parameter = GUICtrlCreateLabel($g_ini_ScrcpyCommand, 10, 530, 380, 30, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_Status = _GUICtrlStatusBar_Create($g_gui_Main)
	_GUICtrlStatusBar_SetMinHeight($g_Status, 25)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	GUISetState(@SW_SHOWNORMAL)
EndFunc   ;==>_f_sub_GUIMain

Func _f_sub_ReadIni()
	$g_ini_AlwaysOnTop = IniRead($g_ini_Config, "Main", "AlwaysOnTop", 4)
	GUICtrlSetState($g_chk_AlwaysOnTop, $g_ini_AlwaysOnTop)
	$g_ini_Borderless = IniRead($g_ini_Config, "Main", "Borderless", 4)
	GUICtrlSetState($g_chk_Borderless, $g_ini_Borderless)
	$g_ini_ScrcpyCommand = IniRead($g_ini_Config, "Main", "FinalParameter", "")
	GUICtrlSetData($g_lbl_Parameter, $g_ini_ScrcpyCommand)
	$g_ini_FullScreen = IniRead($g_ini_Config, "Main", "FullScreen", 4)
	GUICtrlSetState($g_chk_FullScreen, $g_ini_FullScreen)
	$g_ini_NoScreenSaver = IniRead($g_ini_Config, "Main", "NoScreenSaver", 4)
	GUICtrlSetState($g_chk_NoScreenSaver, $g_ini_NoScreenSaver)
	$g_ini_PowerOffOnExit = IniRead($g_ini_Config, "Main", "PowerOffOnExit", 1)
	GUICtrlSetState($g_chk_PowerOffOnExit, $g_ini_PowerOffOnExit)
	$g_ini_ShowTouch = IniRead($g_ini_Config, "Main", "ShowTouch", 4)
	GUICtrlSetState($g_chk_ShowTouch, $g_ini_ShowTouch)
	$g_ini_StayAwake = IniRead($g_ini_Config, "Main", "StayAwake", 4)
	GUICtrlSetState($g_chk_StayAwake, $g_ini_StayAwake)
	$g_ini_TurnOffTheScreen = IniRead($g_ini_Config, "Main", "TurnOffTheScreen", 1)
	GUICtrlSetState($g_chk_TurnOffTheScreen, $g_ini_TurnOffTheScreen)
	$g_ini_ViewOnlyMode = IniRead($g_ini_Config, "Main", "ViewOnlyMode", 4)
	GUICtrlSetState($g_chk_ViewOnlyMode, $g_ini_ViewOnlyMode)
	$g_ini_WiFiAddress = IniRead($g_ini_Config, "Main", "WiFiAddress", "192.168.1.2")
	_GUICtrlIpAddress_Set($g_input_IPAddress, $g_ini_WiFiAddress)

	If IniRead($g_ini_Config, "Main", "ResolutionAuto", "") = 1 Then
		GUICtrlSetState($g_rad_ResolutionAuto, $GUI_CHECKED)
	ElseIf IniRead($g_ini_Config, "Main", "ResolutionMax", "") = 1 Then
		GUICtrlSetState($g_rad_ResolutionMax, $GUI_CHECKED)
	EndIf

	If IniRead($g_ini_Config, "Main", "ShortCutCtrl", "") = 1 Then
		GUICtrlSetState($g_rad_ShortcutCtrl, $GUI_CHECKED)
	ElseIf IniRead($g_ini_Config, "Main", "ShortCutAlt", "") = 1 Then
		GUICtrlSetState($g_rad_ShortcutAlt, $GUI_CHECKED)
	EndIf
EndFunc   ;==>_f_sub_ReadIni

Func _f_sub_AdbStart()
	RunWait(@ComSpec & " /c " & "adb start-server", "", @SW_HIDE)
EndFunc   ;==>_f_sub_AdbStart

Func _f_sub_DeviceListGet()
	IniDelete($g_ini_Config, "Devices")
	$g_cmd_DeviceListGet = Run(@ComSpec & " /c adb devices", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_DeviceListGet)
	$g_cmdout_DeviceListGet = StdoutRead($g_cmd_DeviceListGet)
	$g_data_DeviceListGet = StringReplace(StringReplace(StringReplace(StringStripWS(StringTrimLeft($g_cmdout_DeviceListGet, 26), $STR_STRIPTRAILING), @CR, ""), "	device", " USB ="), ":5555 USB =", ":5555 Wireless =")
	If $g_data_DeviceListGet = "" Then
		IniWriteSection($g_ini_Config, "Devices", "NO USB =")
	Else
		IniWriteSection($g_ini_Config, "Devices", $g_data_DeviceListGet)
	EndIf
	_GUICtrlListView_DeleteAllItems($g_lvw_DeviceList)
EndFunc   ;==>_f_sub_DeviceListGet

Func _f_sub_DeviceListSet()
	$g_ini_Devices = IniReadSection($g_ini_Config, "Devices")
	ConsoleWrite(@ScriptLineNumber & ': ' & $g_ini_Devices & @CRLF)
	_GUICtrlListView_BeginUpdate($g_lvw_DeviceList)
	For $i = 1 To $g_ini_Devices[0][0]
		_GUICtrlListView_AddItem($g_lvw_DeviceList, $i)
		$g_array_Devices = StringSplit($g_ini_Devices[$i][0], " ", 1)
		_GUICtrlListView_AddSubItem($g_lvw_DeviceList, $i - 1, $g_array_Devices[1], 1)
		_GUICtrlListView_AddSubItem($g_lvw_DeviceList, $i - 1, $g_array_Devices[2], 2)
	Next
	_GUICtrlListView_EndUpdate($g_lvw_DeviceList)
EndFunc   ;==>_f_sub_DeviceListSet

Func _f_sub_AdbStop()
	RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
EndFunc   ;==>_f_sub_AdbStop

Func _f_sub_GetIP()
	$g_txt_IP_4 = "FOR /F ""tokens=2"" %%G IN ('adb -s " & $g_data_Serial_1 & " shell ip addr show wlan0 ^|find ""inet ""') DO set ipfull=%%G"
	_FileWriteToLine(@ScriptDir & "\Core\ip.bat", 1, $g_txt_IP_4, True, True)
	$g_cmd_GetIP = RunWait(@ComSpec & " /c " & @ScriptDir & "\Core\ip.bat", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_GetIP)
	$g_cmdout_GetIP = StringStripWS(_ClipBoard_GetData(), $STR_STRIPTRAILING)
	_GUICtrlIpAddress_Set($g_input_IPAddress, $g_cmdout_GetIP)
	_SaveIni("WiFiAddress", $g_cmdout_GetIP)
	_ClipBoard_Open($g_gui_Main)
	_ClipBoard_Empty()
	_ClipBoard_Close()
EndFunc   ;==>_f_sub_GetIP

Func _f_sub_Connect()
	If _GUICtrlIpAddress_IsBlank($g_input_IPAddress) Then
		MsgBox($MB_SYSTEMMODAL, "", "Enter IP Address.")
		_GUICtrlIpAddress_SetFocus($g_input_IPAddress, 0)
	Else
		RunWait(@ComSpec & " /c " & "adb connect " & _GUICtrlIpAddress_Get($g_input_IPAddress), "", @SW_HIDE)
	EndIf
EndFunc   ;==>_f_sub_Connect

Func _f_sub_DeviceInfo()
	If $g_data_Serial_1 = "No" Then
		_f_sub_StatusBar("No device found")
	Else
		_f_sub_StatusBar("Selected device: " & $g_data_Serial_1)

		$g_cmd_DeviceUser = Run(@ComSpec & " /c adb -s " & $g_data_Serial_1 & " shell dumpsys user", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmd_DeviceUser)
		$g_cmdout_DeviceUser = StdoutRead($g_cmd_DeviceUser)
		$g_regex_DeviceUser = StringRegExp($g_cmdout_DeviceUser, "{[0-9]+:(.*):[0-9]+}", 3)
		$g_data_DeviceUser = $g_regex_DeviceUser[0]
		GUICtrlSetData($g_data_User, $g_data_DeviceUser)

		$g_cmd_DeviceAccount = Run(@ComSpec & " /c adb -s " & $g_data_Serial_1 & " shell dumpsys account", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmd_DeviceAccount)
		$g_cmdout_DeviceAccount = StdoutRead($g_cmd_DeviceAccount)
		$g_regex_DeviceAccount = StringRegExp($g_cmdout_DeviceAccount, "{name=(.*), type=com.google}", 3)
		For $x = 0 To UBound($g_regex_DeviceAccount) - 1
			$g_regex_DeviceAccount[$x] = $g_regex_DeviceAccount[$x]
		Next
		$g_data_DeviceAccount = _ArrayToString($g_regex_DeviceAccount, ", ")
		GUICtrlSetData($g_data_Account, $g_data_DeviceAccount)

		$g_cmd_DeviceModel = Run(@ComSpec & " /c adb -s " & $g_data_Serial_1 & " shell getprop ro.product.model", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmd_DeviceModel)
		$g_data_DeviceModel = StringStripWS(StdoutRead($g_cmd_DeviceModel), 8)
		GUICtrlSetData($g_data_Model, $g_data_DeviceModel)

		$g_cmd_DeviceSerial = Run(@ComSpec & " /c adb -s " & $g_data_Serial_1 & " shell getprop ro.serialno", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmd_DeviceSerial)
		$g_data_DeviceSerial = StringStripWS(StdoutRead($g_cmd_DeviceSerial), 8)
		GUICtrlSetData($g_data_Serial_2, $g_data_DeviceSerial)

		$g_cmd_DeviceBattery = Run(@ComSpec & " /c adb -s " & $g_data_Serial_1 & " shell dumpsys battery", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmd_DeviceBattery)
		$g_cmdout_DeviceBattery = StdoutRead($g_cmd_DeviceBattery)
		$g_regex_DeviceBattery = StringRegExp($g_cmdout_DeviceBattery, "level: (.*)", 3)
		$g_data_DeviceBattery = $g_regex_DeviceBattery[0]
		$g_regex_DeviceBatteryAC = StringRegExp($g_cmdout_DeviceBattery, "AC powered: (.*)", 3)
		$g_data_DeviceBatteryAC = $g_regex_DeviceBatteryAC[0]
		$g_regex_DeviceBatteryUSB = StringRegExp($g_cmdout_DeviceBattery, "USB powered: (.*)", 3)
		$g_data_DeviceBatteryUSB = $g_regex_DeviceBatteryUSB[0]
		If ($g_data_DeviceBatteryAC = "false" And $g_data_DeviceBatteryUSB = "false") Or ($g_data_DeviceBatteryAC = "true" And $g_data_DeviceBatteryUSB = "true") Then
			GUICtrlSetData($g_data_Battery, $g_data_DeviceBattery & "% (Not Charging)")
		ElseIf ($g_data_DeviceBatteryAC = "true") And ($g_data_DeviceBatteryUSB = "false") Then
			GUICtrlSetData($g_data_Battery, $g_data_DeviceBattery & "% (AC Charging)")
		Else
			GUICtrlSetData($g_data_Battery, $g_data_DeviceBattery & "% (USB Charging)")
		EndIf

		$g_cmd_DeviceUptime = Run(@ComSpec & " /c adb -s " & $g_data_Serial_1 & " shell uptime", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmd_DeviceUptime)
		$g_cmdout_DeviceUptime = StdoutRead($g_cmd_DeviceUptime)
		$g_data_DeviceUptime = StringRegExpReplace($g_cmdout_DeviceUptime, "up time: (.*?), (.*?):(.*?):(.*), idle(.*)", "$1 $2 hrs $3 mins", 0)
		GUICtrlSetData($g_data_Uptime, $g_data_DeviceUptime)

		GUICtrlSetData($g_data_Connection, $g_data_DeviceConnection)

		$g_cmd_DeviceWifi = Run(@ComSpec & " /c adb -s " & $g_data_Serial_1 & " shell dumpsys connectivity", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmd_DeviceWifi)
		$g_cmdout_DeviceWifi = StdoutRead($g_cmd_DeviceWifi)
		$g_regex_DeviceWifi = StringRegExp($g_cmdout_DeviceWifi, 'extra: "(.*)"', 3)
		$g_data_DeviceWifi = $g_regex_DeviceWifi[0]
		GUICtrlSetData($g_data_Wifi, $g_data_DeviceWifi)

		$g_cmd_DeviceIP = Run(@ComSpec & " /c adb -s " & $g_data_Serial_1 & " shell getprop dhcp.wlan0.ipaddress", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmd_DeviceIP)
		$g_data_DeviceIP = StringStripWS(StdoutRead($g_cmd_DeviceIP), 8)
		GUICtrlSetData($g_data_IP, $g_data_DeviceIP)
		GUICtrlSetData($g_input_Title, $g_data_DeviceUser & "'s Phone")
	EndIf
EndFunc   ;==>_f_sub_DeviceInfo

Func _f_sub_ParameterUpdate()
	$g_data_ScrcpyTitle = GUICtrlRead($g_input_Title)
	If $g_data_ScrcpyTitle = "" Then
		$g_data_Title = ""
	Else
		$g_data_Title = " --window-title=" & $g_data_ScrcpyTitle
	EndIf
	If _IsChecked($g_rad_ResolutionAuto) Then
		$g_data_Resolution = ""
		_SaveIni("ResolutionAuto", GUICtrlRead($g_rad_ResolutionAuto))
		_SaveIni("ResolutionMax", GUICtrlRead($g_rad_ResolutionMax))
	ElseIf _IsChecked($g_rad_ResolutionMax) Then
		$g_data_Resolution = " --window-height=" & _GetworkingAreaHeight()
		_SaveIni("ResolutionAuto", GUICtrlRead($g_rad_ResolutionAuto))
		_SaveIni("ResolutionMax", GUICtrlRead($g_rad_ResolutionMax))
	EndIf
	If _IsChecked($g_chk_FullScreen) Then
		$g_data_FullScreen = " -f"
		_SaveIni("FullScreen", GUICtrlRead($g_chk_FullScreen))
	Else
		$g_data_FullScreen = ""
		_SaveIni("FullScreen", GUICtrlRead($g_chk_FullScreen))
	EndIf
	If _IsChecked($g_chk_PowerOffOnExit) Then
		$g_data_PowerOffOnExit = " --power-off-on-close"
		_SaveIni("PowerOffOnExit", GUICtrlRead($g_chk_PowerOffOnExit))
	Else
		$g_data_PowerOffOnExit = ""
		_SaveIni("PowerOffOnExit", GUICtrlRead($g_chk_PowerOffOnExit))
	EndIf
	If _IsChecked($g_chk_AlwaysOnTop) Then
		$g_data_AlwaysOnTop = " --always-on-top"
		_SaveIni("AlwaysOnTop", GUICtrlRead($g_chk_AlwaysOnTop))
	Else
		$g_data_AlwaysOnTop = ""
		_SaveIni("AlwaysOnTop", GUICtrlRead($g_chk_AlwaysOnTop))
	EndIf
	If _IsChecked($g_chk_ViewOnlyMode) Then
		$g_data_ViewOnlyMode = " -n"
		_SaveIni("ViewOnlyMode", GUICtrlRead($g_chk_ViewOnlyMode))
	Else
		$g_data_ViewOnlyMode = ""
		_SaveIni("ViewOnlyMode", GUICtrlRead($g_chk_ViewOnlyMode))
	EndIf
	If _IsChecked($g_chk_ShowTouch) Then
		$g_data_ShowTouch = " -t"
		_SaveIni("ShowTouch", GUICtrlRead($g_chk_ShowTouch))
	Else
		$g_data_ShowTouch = ""
		_SaveIni("ShowTouch", GUICtrlRead($g_chk_ShowTouch))
	EndIf
	If _IsChecked($g_chk_NoScreenSaver) Then
		$g_data_NoScreenSaver = " --disable-screensaver"
		_SaveIni("NoScreenSaver", GUICtrlRead($g_chk_NoScreenSaver))
	Else
		$g_data_NoScreenSaver = ""
		_SaveIni("NoScreenSaver", GUICtrlRead($g_chk_NoScreenSaver))
	EndIf
	If _IsChecked($g_chk_TurnOffTheScreen) Then
		$g_data_TurnOffTheScreen = " -S"
		_SaveIni("TurnOffTheScreen", GUICtrlRead($g_chk_TurnOffTheScreen))
	Else
		$g_data_TurnOffTheScreen = ""
		_SaveIni("TurnOffTheScreen", GUICtrlRead($g_chk_TurnOffTheScreen))
	EndIf
	If _IsChecked($g_chk_StayAwake) Then
		$g_data_StayAwake = " -w"
		_SaveIni("StayAwake", GUICtrlRead($g_chk_StayAwake))
	Else
		$g_data_StayAwake = ""
		_SaveIni("StayAwake", GUICtrlRead($g_chk_StayAwake))
	EndIf
	If _IsChecked($g_chk_Borderless) Then
		$g_data_Borderless = " --window-borderless"
		_SaveIni("Borderless", GUICtrlRead($g_chk_Borderless))
	Else
		$g_data_Borderless = ""
		_SaveIni("Borderless", GUICtrlRead($g_chk_Borderless))
	EndIf
	If _IsChecked($g_rad_ShortcutCtrl) Then
		$g_data_Shortcut = " --shortcut-mod=""lctrl,rctrl"""
		$g_key_Shortcut = "^"
		_SaveIni("ShortCutCtrl", GUICtrlRead($g_rad_ShortcutCtrl))
		_SaveIni("ShortCutAlt", GUICtrlRead($g_rad_ShortcutAlt))
	ElseIf _IsChecked($g_rad_ShortcutAlt) Then
		$g_data_Shortcut = " --shortcut-mod=""lalt,ralt"""
		$g_key_Shortcut = "!"
		_SaveIni("ShortCutCtrl", GUICtrlRead($g_rad_ShortcutCtrl))
		_SaveIni("ShortCutAlt", GUICtrlRead($g_rad_ShortcutAlt))
	EndIf
EndFunc   ;==>_f_sub_ParameterUpdate

Func _f_sub_ScrcpyCommand()
	$g_ini_ScrcpyCommand = " -s " & $g_data_Serial_1 & $g_data_Resolution & $g_data_Shortcut & $g_data_FullScreen & $g_data_PowerOffOnExit & $g_data_AlwaysOnTop & $g_data_ViewOnlyMode & $g_data_ShowTouch & $g_data_NoScreenSaver & $g_data_TurnOffTheScreen & $g_data_StayAwake & $g_data_Borderless & $g_data_Title
	_SaveIni("FinalParameter", $g_ini_ScrcpyCommand)
	GUICtrlSetData($g_lbl_Parameter, $g_ini_ScrcpyCommand)
EndFunc   ;==>_f_sub_ScrcpyCommand

Func _f_sub_ScrcpyOn()
	GUICtrlSetState($g_btn_ScrcpyOn, $GUI_DISABLE)
	GUISetState(@SW_HIDE, $g_gui_Main)
EndFunc   ;==>_f_sub_ScrcpyOn

Func _f_sub_ScrcpyRun()
	Run(@ComSpec & " /c " & "scrcpy" & $g_ini_ScrcpyCommand, "", @SW_HIDE)
EndFunc   ;==>_f_sub_ScrcpyRun

Func _f_sub_GUIChild()
	$g_gui_Child = GUICreate("Scrcpy Control", 255, 285, 1, -1, BitOR($WS_POPUP, $WS_CAPTION))
	GUISetOnEvent($GUI_EVENT_CLOSE, "_f_sub_GUIChildClose")
	GUISetBkColor($COLOR_WHITE)
	$g_group_SelectedDevice = GUICtrlCreateGroup("Selected Device", 5, 5, 245, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_lbl_SelectedDevice_1 = GUICtrlCreateLabel("", 10, 20, 235, 18, $SS_CENTER)
	GUICtrlSetFont(-1, $g_font_Size, $g_font_Bold, 0, $g_font_Name, 5)
	$g_lbl_SelectedDevice_2 = GUICtrlCreateLabel("", 10, 38, 235, 17, $SS_CENTER)
	GUICtrlSetData($g_lbl_SelectedDevice_1, $g_data_DeviceUser & "'s Phone")
	GUICtrlSetData($g_lbl_SelectedDevice_2, "(" & $g_data_Serial_1 & ")")
	GUICtrlSetFont(-1, $g_font_Size, $g_font_Bold, 0, $g_font_Name, 5)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_group_Touch = GUICtrlCreateGroup("Scrcpy Control", 5, 65, 245, 215, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_btn_VolumeUP = GUICtrlCreateButton("Volume +", 50, 80, 75, 35)
	GUICtrlSetOnEvent(-1, "_f_btn_VolumeUP")
	$g_btn_VolumeDown = GUICtrlCreateButton("Volume -", 130, 80, 75, 35)
	GUICtrlSetOnEvent(-1, "_f_btn_VolumeDown")
	$g_btn_ScreenOn = GUICtrlCreateButton("Screen On", 50, 120, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "_f_btn_ScreenOn")
	$g_btn_ScreenOff = GUICtrlCreateButton("Screen Off", 130, 120, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "_f_btn_ScreenOff")
	$g_btn_NotificationOn = GUICtrlCreateButton("Notification On", 50, 160, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "_f_btn_NotificationOn")
	$g_btn_NotificationOff = GUICtrlCreateButton("Notification Off", 130, 160, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "_f_btn_NotificationOff")
	$g_btn_Menu = GUICtrlCreateButton("Menu", 50, 200, 75, 35)
	GUICtrlSetOnEvent(-1, "_f_btn_Menu")
	$g_btn_Power = GUICtrlCreateButton("Power", 130, 200, 75, 35)
	GUICtrlSetOnEvent(-1, "_f_btn_Power")
	$g_btn_Back = GUICtrlCreateButton("<", 10, 240, 75, 35)
	GUICtrlSetOnEvent(-1, "_f_btn_Back")
	$g_btn_Home = GUICtrlCreateButton("?", 90, 240, 75, 35)
	GUICtrlSetOnEvent(-1, "_f_btn_Home")
	$g_btn_Switch = GUICtrlCreateButton("=", 170, 240, 75, 35)
	GUICtrlSetOnEvent(-1, "_f_btn_Switch")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUISetState(@SW_SHOW, $g_gui_Child)
EndFunc   ;==>_f_sub_GUIChild

Func _f_btn_VolumeUP()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "{UP}")
	EndIf
EndFunc   ;==>_f_btn_VolumeUP

Func _f_btn_ScreenOn()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "+o")
	EndIf
EndFunc   ;==>_f_btn_ScreenOn

Func _f_btn_NotificationOn()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "n")
	EndIf
EndFunc   ;==>_f_btn_NotificationOn

Func _f_btn_Menu()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "m")
	EndIf
EndFunc   ;==>_f_btn_Menu

Func _f_btn_VolumeDown()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "{DOWN}")
	EndIf
EndFunc   ;==>_f_btn_VolumeDown

Func _f_btn_ScreenOff()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "o")
	EndIf
EndFunc   ;==>_f_btn_ScreenOff

Func _f_btn_NotificationOff()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "+n")
	EndIf
EndFunc   ;==>_f_btn_NotificationOff

Func _f_btn_Power()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "p")
	EndIf
EndFunc   ;==>_f_btn_Power

Func _f_btn_Back()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "b")
	EndIf
EndFunc   ;==>_f_btn_Back

Func _f_btn_Home()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "h")
	EndIf
EndFunc   ;==>_f_btn_Home

Func _f_btn_Switch()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "s")
	EndIf
EndFunc   ;==>_f_btn_Switch

Func _f_sub_GUIChildClose()
	If WinExists("[CLASS:SDL_app]", "") Then
		WinClose("[CLASS:SDL_app]", "")
		GUIDelete($g_gui_Child)
		GUISetState(@SW_SHOW, $g_gui_Main)
		_f_sub_StatusBar("Selected device: " & $g_data_Serial_1)
		GUICtrlSetState($g_btn_ScrcpyOn, $GUI_ENABLE)
	Else
		GUIDelete($g_gui_Child)
		GUISetState(@SW_SHOW, $g_gui_Main)
		_f_sub_StatusBar("Selected device: " & $g_data_Serial_1)
		GUICtrlSetState($g_btn_ScrcpyOn, $GUI_ENABLE)
	EndIf
EndFunc   ;==>_f_sub_GUIChildClose

Func _f_sub_GUIMainClose()
	_f_sub_AdbStop()
	_SaveIni("Serial", "")
	_SaveIni("FinalParameter", "")
	Exit
EndFunc   ;==>_f_sub_GUIMainClose

;==>Supporting Function<==;

Func _SaveIni($_sKey, $_sValue)
	Local $sSection = "Main"
	Local $sIniRead = IniRead($g_ini_Config, $sSection, $_sKey, "")
	If $sIniRead = $_sValue Then Return
	IniWrite($g_ini_Config, $sSection, $_sKey, $_sValue)
EndFunc   ;==>_SaveIni

Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

Func _f_sub_StatusBar($sMessage = "")
	_GUICtrlStatusBar_SetText($g_Status, $sMessage)
EndFunc   ;==>_f_sub_StatusBar

Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
	Local $hListView, $tNMHDR, $hWndFrom, $iCode
	$hListView = $g_lvw_DeviceList
	If Not IsHWnd($hListView) Then $hListView = GUICtrlGetHandle($g_lvw_DeviceList)
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "HwndFrom"))
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hListView
			Switch $iCode
				Case $NM_CLICK
					Local $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					Local $iItem = DllStructGetData($tInfo, "Item")
					If _GUICtrlListView_GetItemSelected($hListView, $iItem) = True Then
						$g_data_Serial_1 = _GUICtrlListView_GetItemText($g_lvw_DeviceList, $iItem, 1)
						$g_data_DeviceConnection = _GUICtrlListView_GetItemText($g_lvw_DeviceList, $iItem, 2)
						_SaveIni("Serial", $g_data_Serial_1)
						_f_sub_DeviceInfo()
						_f_btn_Parameter()
					EndIf
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _GetworkingAreaHeight()
	Local $aRect[4]
	Local $iWidth = 0
	$aRect = _GetworkingAreaRect()
	If Not @error Then
		$iWidth = $aRect[3] - $aRect[1]
		Return $iWidth
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_GetworkingAreaHeight

Func _GetworkingAreaRect()
	Local $aRect[4]
	Const $SPI_GETWORKAREA = 0x0030
	Local $rect = DllStructCreate("int;int;int;int")
	Local $iResult = 0
	$iResult = _WinAPI_SystemParametersInfo($SPI_GETWORKAREA, 0, DllStructGetPtr($rect))
	If $iResult Then
		$aRect[0] = DllStructGetData($rect, 1)
		$aRect[1] = DllStructGetData($rect, 2)
		$aRect[2] = DllStructGetData($rect, 3)
		$aRect[3] = DllStructGetData($rect, 4)
		Return $aRect
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_GetworkingAreaRect