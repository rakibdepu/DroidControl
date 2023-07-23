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
#include <GuiEdit.au3>
#include <GuiIPAddress.au3>
#include <GUIListView.au3>
#include <GuiStatusBar.au3>
#include <GuiTab.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include "GUIExtender.au3"

Global $g_array_Devices, $g_btn_Back, $g_btn_Connect, $g_btn_DeviceReboot, $g_btn_DeviceShutdown, $g_btn_DeviceUnlock, $g_btn_DisplayPowerOnOff, $g_btn_GetIP, $g_btn_Home, $g_btn_Menu, $g_btn_NotificationOff, $g_btn_NotificationOn, $g_btn_Power, $g_btn_Refresh, $g_btn_Reset, $g_btn_ScrcpyOn, $g_btn_ScreenOff, $g_btn_ScreenOn, $g_btn_Switch, $g_btn_VolumeDown, $g_btn_VolumeUP, $g_chk_AlwaysOnTop, $g_chk_Borderless, $g_chk_FullScreen, $g_chk_NoScreenSaver, $g_chk_PowerOffOnExit, $g_chk_ShowTouch, $g_chk_StayAwake, $g_chk_TurnOffTheScreen, $g_chk_ViewOnlyMode, $g_cmdout_AdbStart, $g_cmdout_AdbStart1, $g_cmdout_AdbStop, $g_cmdout_AdbStop1, $g_cmdout_DeviceAccount, $g_cmdout_DeviceBattery, $g_cmdout_DeviceIP, $g_cmdout_DeviceListGet, $g_cmdout_DeviceModel, $g_cmdout_DeviceSerial, $g_cmdout_DeviceUptime, $g_cmdout_DeviceUser, $g_cmdout_DeviceWifi, $g_cmdout_DeviceWifiC, $g_cmdout_DeviceWifiC2, $g_cmdout_GetIP, $g_cmd_AdbStart, $g_cmd_AdbStop, $g_cmd_Connect, $g_cmd_DeviceAccount, $g_cmd_DeviceBattery, $g_cmd_DeviceIP, $g_cmd_DeviceListGet, $g_cmd_DeviceModel, $g_cmd_DeviceSerial, $g_cmd_DeviceUptime, $g_cmd_DeviceUser
Global $g_cmd_DeviceWifi, $g_cmd_DeviceWifiC, $g_cmd_GetIP, $g_data_Account, $g_data_AlwaysOnTop, $g_data_Battery, $g_data_Borderless, $g_data_Connection, $g_data_DeviceAccount, $g_data_DeviceBattery, $g_data_DeviceBatteryAC, $g_data_DeviceBatteryUSB, $g_data_DeviceConnection, $g_data_DeviceIP, $g_data_DeviceListGet, $g_data_DeviceModel, $g_data_DeviceSelected, $g_data_DeviceSerial, $g_data_DeviceUptime, $g_data_DeviceUser, $g_data_DeviceWifi, $g_data_FullScreen, $g_data_GetIP, $g_data_IP, $g_data_Model, $g_data_NoScreenSaver, $g_data_PowerOffOnExit, $g_data_Resolution, $g_data_ScrcpyTitle, $g_data_SectionState, $g_data_Serial, $g_data_Shortcut, $g_data_ShowTouch, $g_data_StayAwake, $g_data_Title, $g_data_TurnOffTheScreen, $g_data_Uptime, $g_data_User, $g_data_ViewOnlyMode, $g_data_Wifi, $g_font_Bold, $g_font_Name, $g_font_Size, $g_graphic_Line, $g_group_Details, $g_group_DeviceList, $g_group_Options, $g_group_Parameter, $g_group_Resolution, $g_group_SelectedDevice, $g_group_Shortcut, $g_group_Touch, $g_group_Wireless, $g_gui_Child, $g_gui_Main
Global $g_ini_AlwaysOnTop, $g_ini_Borderless, $g_ini_Config, $g_ini_DeviceAccount, $g_ini_DeviceConnection, $g_ini_DeviceModel, $g_ini_Devices, $g_ini_DeviceSerial, $g_ini_DeviceUser, $g_ini_FullScreen, $g_ini_NoScreenSaver, $g_ini_PowerOffOnExit, $g_ini_ScrcpyCommand, $g_ini_ShowTouch, $g_ini_StayAwake, $g_ini_TurnOffTheScreen, $g_ini_ViewOnlyMode, $g_ini_WiFiAddress, $g_input_IPAddress, $g_input_Title, $g_key_Shortcut, $g_lbl_Account_1, $g_lbl_Account_2, $g_lbl_Battery_1, $g_lbl_Battery_2, $g_lbl_Connection_1, $g_lbl_Connection_2, $g_lbl_IP_1, $g_lbl_IP_2, $g_lbl_Model_1, $g_lbl_Model_2, $g_lbl_Parameter, $g_lbl_SelectedDevice_1, $g_lbl_SelectedDevice_2, $g_lbl_Serial_1, $g_lbl_Serial_2, $g_lbl_Title_1, $g_lbl_Title_2, $g_lbl_Uptime_1, $g_lbl_Uptime_2, $g_lbl_User_1, $g_lbl_User_2, $g_lbl_Wifi_1, $g_lbl_Wifi_2, $g_lvw_DeviceList, $g_rad_ResolutionAuto, $g_rad_ResolutionMax, $g_rad_ShortcutAlt, $g_rad_ShortcutCtrl, $g_regex_DeviceAccount, $g_regex_DeviceBattery, $g_regex_DeviceBatteryAC, $g_regex_DeviceBatteryUSB, $g_regex_DeviceUser, $g_regex_DeviceWifi, $g_Status
Global $g_ini_Config = @ScriptDir & "\Config.ini"
Global $g_font_Name = "Baloo Da 2"
Global $g_font_Size = 9.5
Global $g_font_Bold = 700

_f_sub_MainProgram()

Func _f_sub_MainProgram()
	_f_sub_GUIMain()
	_f_sub_StatusBar("Starting ADB server.")
	_f_sub_AdbStart()
	_f_btn_Refresh()
	While 1
		Sleep(100)
	WEnd
EndFunc   ;==>_f_sub_MainProgram

Func _f_btn_Refresh()
	_f_sub_StatusBar("Searching for device.")
	_f_sub_DeviceListGet()
	_f_sub_StatusBar("Making a device list.")
	_f_sub_DeviceListSet()
	_f_sub_StatusBar("Select a device from list.")
EndFunc   ;==>_f_btn_Refresh

Func _f_btn_Reset()
	_f_sub_StatusBar("Restarting ADB server.")
	_f_sub_AdbStop()
	_f_sub_AdbStart()
	_f_btn_Refresh()
EndFunc   ;==>_f_btn_Reset

Func _f_btn_GetIP()
	_f_sub_StatusBar("Getting IP address from selected device.")
	_f_sub_GetIP()
	_f_sub_StatusBar("Click ""Connect"" button to add " & $g_data_GetIP & ".")
EndFunc   ;==>_f_btn_GetIP

Func _f_btn_Connect()
	_f_sub_StatusBar("Connecting . . .")
	_f_sub_Connect()
	_f_sub_StatusBar("Updating device list.")
	_f_btn_Refresh()
EndFunc   ;==>_f_btn_Connect

Func _f_sub_DeviceSelected()
	_f_sub_StatusBar("Handshaking with device.")
	_f_sub_StatusBar("Receiving device info.")
	_f_sub_StatusBar("Updating config files.")
	_f_sub_ReadIni()
	_f_sub_Option()
EndFunc   ;==>_f_sub_DeviceSelected

Func _f_sub_Option()
	_f_sub_StatusBar("Updating all selected options in scrcpy command line.")
	_f_sub_OptionSet()
	_f_sub_ScrcpyCommand()
	_f_sub_StatusBar("Click ""Scrcpy On"" button to start Scrcpy.")
EndFunc   ;==>_f_sub_Option

Func _f_btn_ScrcpyOn()
	_f_sub_StatusBar("Verifing all selected options in scrcpy command line.")
	_f_sub_Option()
	_f_sub_StatusBar("Now closing main window.")
	_f_sub_MainGuiHide()
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

Func _f_sub_GUIMain()
	$g_gui_Main = GUICreate("Droid Control", 800, 360, -1, -1, BitOR($WS_POPUP, $WS_CAPTION))
	GUISetOnEvent($GUI_EVENT_CLOSE, "_f_sub_GUIMainClose")
	GUISetBkColor($CLR_WHITE)
	_GUIExtender_Init($g_gui_Main, 1, 1, True)
	_GUIExtender_Section_Create($g_gui_Main, Default, 400)
	_GUIExtender_Section_Activate($g_gui_Main, 2)
	$g_group_DeviceList = GUICtrlCreateGroup("Device List", 5, 5, 390, 135, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_lvw_DeviceList = _GUICtrlListView_Create($g_gui_Main, "#|Device|Connection", 10, 20, 305, 110)
	_GUICtrlListView_SetExtendedListViewStyle($g_lvw_DeviceList, $LVS_EX_FULLROWSELECT)
	_GUICtrlListView_SetColumnWidth($g_lvw_DeviceList, 0, 50)
	_GUICtrlListView_SetColumnWidth($g_lvw_DeviceList, 1, 175)
	_GUICtrlListView_SetColumnWidth($g_lvw_DeviceList, 2, 80)
	_GUICtrlListView_JustifyColumn($g_lvw_DeviceList, 0, 2)
	_GUICtrlListView_JustifyColumn($g_lvw_DeviceList, 1, 2)
	_GUICtrlListView_JustifyColumn($g_lvw_DeviceList, 2, 2)
	$g_btn_Refresh = GUICtrlCreateButton("Refresh", 320, 20, 70, 53)
	GUICtrlSetOnEvent(-1, "_f_btn_Refresh")
	GUICtrlSetTip(-1, "Click to refresh device list.")
	$g_btn_Reset = GUICtrlCreateButton("Reset", 320, 83, 70, 52)
	GUICtrlSetOnEvent(-1, "_f_btn_Reset")
	GUICtrlSetTip(-1, "Click to reset device list.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_group_Wireless = GUICtrlCreateGroup("Wireless", 5, 145, 390, 40, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_btn_GetIP = GUICtrlCreateButton("Get IP", 10, 160, 70, 20)
	GUICtrlSetOnEvent(-1, "_f_btn_GetIP")
	GUICtrlSetTip(-1, "Get IP from usb device.")
	$g_input_IPAddress = _GUICtrlIpAddress_Create($g_gui_Main, 115, 160, 170, 20)
	$g_btn_Connect = GUICtrlCreateButton("Connect", 320, 160, 70, 20)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_btn_Connect")
	GUICtrlSetTip(-1, "Click to connect with IP.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_group_Details = GUICtrlCreateGroup("Details", 5, 190, 390, 140, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_graphic_Line = GUICtrlCreateGraphic(81, 220, 309, 105)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_PENSIZE, 1)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_COLOR, 0xDCDCDC)
	GUICtrlSetGraphic($g_graphic_Line, $GUI_GR_MOVE, 0, 0)
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

	$g_lbl_User_1 = GUICtrlCreateLabel("User", 10, 205, 66, 15)
	$g_lbl_User_2 = GUICtrlCreateLabel(":", 76, 205, 5, 15)
	$g_data_User = GUICtrlCreateLabel("", 81, 205, 309, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Account_1 = GUICtrlCreateLabel("Accounts", 10, 223, 73, 30)
	$g_lbl_Account_2 = GUICtrlCreateLabel(":", 76, 223, 2, 30)
	$g_data_Account = GUICtrlCreateLabel("", 81, 223, 309, 30)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Model_1 = GUICtrlCreateLabel("Device Model", 10, 256, 66, 15)
	$g_lbl_Model_2 = GUICtrlCreateLabel(":", 76, 256, 5, 15)
	$g_data_Model = GUICtrlCreateLabel("", 81, 256, 309, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Serial_1 = GUICtrlCreateLabel("Device Serial", 10, 274, 66, 15)
	$g_lbl_Serial_2 = GUICtrlCreateLabel(":", 76, 274, 5, 15)
	$g_data_Serial = GUICtrlCreateLabel("", 81, 274, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Battery_1 = GUICtrlCreateLabel("Battery Status", 10, 292, 66, 15)
	$g_lbl_Battery_2 = GUICtrlCreateLabel(":", 76, 292, 5, 15)
	$g_data_Battery = GUICtrlCreateLabel("", 81, 292, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Uptime_1 = GUICtrlCreateLabel("Up Time", 10, 310, 66, 15)
	$g_lbl_Uptime_2 = GUICtrlCreateLabel(":", 76, 310, 5, 15)
	$g_data_Uptime = GUICtrlCreateLabel("", 81, 310, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Connection_1 = GUICtrlCreateLabel("Connected by", 202, 274, 66, 15)
	$g_lbl_Connection_2 = GUICtrlCreateLabel(":", 268, 274, 5, 15)
	$g_data_Connection = GUICtrlCreateLabel("", 273, 274, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_Wifi_1 = GUICtrlCreateLabel("Wi-Fi SSID", 202, 292, 66, 15)
	$g_lbl_Wifi_2 = GUICtrlCreateLabel(":", 268, 292, 5, 15)
	$g_data_Wifi = GUICtrlCreateLabel("", 273, 292, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)

	$g_lbl_IP_1 = GUICtrlCreateLabel("IP Address", 202, 310, 66, 15)
	$g_lbl_IP_2 = GUICtrlCreateLabel(":", 268, 310, 5, 15)
	$g_data_IP = GUICtrlCreateLabel("", 273, 310, 117, 15)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	_GUIExtender_Section_Create($g_gui_Main, Default, Default)

	$g_group_Options = GUICtrlCreateGroup("Options", 405, 5, 315, 135, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_lbl_Title_1 = GUICtrlCreateLabel("Window Title", 410, 22, 62, 15)
	$g_lbl_Title_2 = GUICtrlCreateLabel(":", 472, 22, 5, 15)
	$g_input_Title = GUICtrlCreateEdit("", 478, 20, 237, 17, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)
	$g_chk_AlwaysOnTop = GUICtrlCreateCheckbox("Always On Top", 410, 43, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Make scrcpy window always on top (above other windows).")
	$g_chk_Borderless = GUICtrlCreateCheckbox("Borderless", 512, 43, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Disable window decorations (display borderless window).")
	$g_chk_FullScreen = GUICtrlCreateCheckbox("Full Screen", 613, 43, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Start in fullscreen.")
	$g_chk_NoScreenSaver = GUICtrlCreateCheckbox("No ScreenSaver", 410, 74, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Disable screensaver while scrcpy is running.")
	$g_chk_PowerOffOnExit = GUICtrlCreateCheckbox("Power Off On Exit", 512, 74, 96, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Turn the device screen off when closing scrcpy.")
	$g_chk_ShowTouch = GUICtrlCreateCheckbox("Show Touch", 613, 74, 96, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Enable 'show touches' on start, restore the initial value on exit.")
	$g_chk_StayAwake = GUICtrlCreateCheckbox("Stay Awake", 410, 105, 96, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Keep the device on while scrcpy is running.")
	$g_chk_TurnOffTheScreen = GUICtrlCreateCheckbox("Turn Off The Screen", 512, 105, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Turn the device screen off immediately.")
	$g_chk_ViewOnlyMode = GUICtrlCreateCheckbox("View Only Mode", 613, 105, 97, 25, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE, $BS_RIGHTBUTTON))
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Disable device control (mirror the device in read-only).")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_group_Resolution = GUICtrlCreateGroup("Resolution", 725, 5, 70, 65, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_rad_ResolutionAuto = GUICtrlCreateRadio("Auto", 730, 20, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Set window height automatic.")
	$g_rad_ResolutionMax = GUICtrlCreateRadio("Max", 730, 45, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Set window height maximum.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_group_Shortcut = GUICtrlCreateGroup("ShortCut", 725, 75, 70, 65, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_rad_ShortcutCtrl = GUICtrlCreateRadio("Ctrl", 730, 90, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Set 'Ctrl' as shortcut key.")
	$g_rad_ShortcutAlt = GUICtrlCreateRadio("Alt", 730, 115, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_sub_Option")
	GUICtrlSetTip(-1, "Set 'Alt' as shortcut key.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_group_Parameter = GUICtrlCreateGroup("Parameter", 405, 145, 390, 130, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_lbl_Parameter = GUICtrlCreateEdit($g_ini_ScrcpyCommand, 410, 160, 380, 110, BitOR($ES_READONLY, $ES_AUTOVSCROLL))
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_btn_DeviceShutdown = GUICtrlCreateButton("Device" & @CRLF & "Shutdown", 405, 280, 70, 50, $BS_MULTILINE)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_btn_DeviceShutdown")
	GUICtrlSetTip(-1, "Shutdown Device")

	$g_btn_DeviceReboot = GUICtrlCreateButton("Device" & @CRLF & "Reboot", 485, 280, 70, 50, $BS_MULTILINE)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_btn_DeviceReboot")
	GUICtrlSetTip(-1, "Reboot Device")

	$g_btn_DisplayPowerOnOff = GUICtrlCreateButton("Display" & @CRLF & "On / Off", 565, 280, 70, 50, $BS_MULTILINE)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_btn_DevicePowerOnOff")
	GUICtrlSetTip(-1, "Display On or Off")

	$g_btn_DeviceUnlock = GUICtrlCreateButton("Device" & @CRLF & "Unlock", 645, 280, 70, 50, $BS_MULTILINE)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_btn_DeviceUnlock")
	GUICtrlSetTip(-1, "Unlock Device")

	$g_btn_ScrcpyOn = GUICtrlCreateButton("Scrcpy" & @CRLF & "On", 725, 280, 70, 50, $BS_MULTILINE)
	GUICtrlSetImage(-1, "..\NewSoft\scrcpy-win32\icon.ico", 1, 1)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_f_btn_ScrcpyOn")
	GUICtrlSetTip(-1, "Start SCRCPY.")

	$g_Status = _GUICtrlStatusBar_Create($g_gui_Main)
	_GUICtrlStatusBar_SetMinHeight($g_Status, 25)

	_GUIExtender_Section_Create($g_gui_Main, -99)
	_GUIExtender_Section_Action($g_gui_Main, 2, False) ; hide section 2

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	GUISetState(@SW_SHOWNORMAL)
EndFunc   ;==>_f_sub_GUIMain

Func _f_sub_AdbStart()
	$g_cmd_AdbStart = Run(@ComSpec & " /c " & "adb start-server", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_AdbStart)
	$g_cmdout_AdbStart = StdoutRead($g_cmd_AdbStart)
	Local $g_cmdout_AdbStart1 = StderrRead($g_cmd_AdbStart)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, $g_cmdout_AdbStart)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, $g_cmdout_AdbStart1)
EndFunc   ;==>_f_sub_AdbStart

Func _f_sub_DeviceListGet()
	IniDelete($g_ini_Config, "Devices")
	$g_cmd_DeviceListGet = Run(@ComSpec & " /c adb devices", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_DeviceListGet)
	$g_cmdout_DeviceListGet = StdoutRead($g_cmd_DeviceListGet)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & $g_cmdout_DeviceListGet)
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
	$g_cmd_AdbStop = Run(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_AdbStop)
	$g_cmdout_AdbStop = StdoutRead($g_cmd_AdbStop)
	Local $g_cmdout_AdbStop1 = StderrRead($g_cmd_AdbStop)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, $g_cmdout_AdbStop)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, $g_cmdout_AdbStop1)
EndFunc   ;==>_f_sub_AdbStop

Func _f_sub_GetIP()
	$g_cmd_GetIP = Run(@ComSpec & " /c " & "adb -s " & $g_data_DeviceSelected & " shell getprop dhcp.wlan0.ipaddress", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_GetIP)
	$g_cmdout_GetIP = StdoutRead($g_cmd_GetIP)
	$g_data_GetIP = StringStripWS($g_cmdout_GetIP, 2)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & $g_cmdout_GetIP)
	_GUICtrlIpAddress_Set($g_input_IPAddress, $g_data_GetIP)
	GUICtrlSetState($g_btn_Connect, $GUI_ENABLE)
EndFunc   ;==>_f_sub_GetIP

Func _f_sub_Connect()
	If _GUICtrlIpAddress_IsBlank($g_input_IPAddress) Then
		MsgBox($MB_SYSTEMMODAL, "", "Enter IP Address.")
		_GUICtrlIpAddress_SetFocus($g_input_IPAddress, 0)
	Else
		$g_cmd_Connect = RunWait(@ComSpec & " /c " & "adb tcpip 5555 | adb connect " & _GUICtrlIpAddress_Get($g_input_IPAddress), "", @SW_HIDE)
		ProcessWaitClose($g_cmd_Connect)
	EndIf
EndFunc   ;==>_f_sub_Connect

Func _f_sub_ReadIni()
	If (_ReadIni("" & $g_data_DeviceSelected & "_Connection") = "USB") Or (_ReadIni("" & $g_data_DeviceSelected & "_Connection") = "Wireless") Then
		If ($g_data_User == "") Then
			_f_sub_UpdateWindow()
			_f_sub_GetIni()
		Else
			_f_sub_UpdateWindow()
			_f_sub_DeviceInfoClear()
			_f_sub_GetIni()
		EndIf
	Else
		_f_sub_SetIni()
		_f_sub_GetIni()
	EndIf
EndFunc   ;==>_f_sub_ReadIni

Func _f_sub_GetIni()
	$g_ini_DeviceUser = _ReadIni("" & $g_data_DeviceSelected & "_User", "")
	GUICtrlSetData($g_data_User, $g_ini_DeviceUser)
	Sleep(333)
	$g_ini_DeviceAccount = _ReadIni("" & $g_data_DeviceSelected & "_Account", "")
	GUICtrlSetData($g_data_Account, $g_ini_DeviceAccount)
	Sleep(333)
	$g_ini_DeviceModel = _ReadIni("" & $g_data_DeviceSelected & "_Model", "")
	GUICtrlSetData($g_data_Model, $g_ini_DeviceModel)
	Sleep(333)
	$g_data_SectionState = _GUIExtender_Section_State($g_gui_Main, 2)
	If $g_data_SectionState = 0 Then
		_GUIExtender_Section_Action($g_gui_Main, 2, 9)
		Sleep(333)
	Else
		Sleep(333)
	EndIf
	$g_ini_DeviceSerial = _ReadIni("" & $g_data_DeviceSelected & "_Serial", "")
	GUICtrlSetData($g_data_Serial, $g_ini_DeviceSerial)
	Sleep(333)
	$g_cmd_DeviceBattery = Run(@ComSpec & " /c adb -s " & $g_data_DeviceSelected & " shell dumpsys battery", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_DeviceBattery)
	$g_cmdout_DeviceBattery = StdoutRead($g_cmd_DeviceBattery)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & $g_cmdout_DeviceBattery)
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
	Sleep(333)
	$g_cmd_DeviceUptime = Run(@ComSpec & " /c adb -s " & $g_data_DeviceSelected & " shell uptime", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_DeviceUptime)
	$g_cmdout_DeviceUptime = StdoutRead($g_cmd_DeviceUptime)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & $g_cmdout_DeviceUptime)
	$g_data_DeviceUptime = StringStripWS(StringRegExpReplace($g_cmdout_DeviceUptime, "up time: (.*?), (.*?):(.*?):(.*), idle(.*)", "$1 $2 hrs $3 mins", 0), 2)
	GUICtrlSetData($g_data_Uptime, $g_data_DeviceUptime)
	Sleep(333)
	$g_ini_DeviceConnection = _ReadIni("" & $g_data_DeviceSelected & "_Connection")
	GUICtrlSetData($g_data_Connection, $g_ini_DeviceConnection)
	Sleep(333)
	$g_cmd_DeviceWifiC = Run(@ComSpec & " /c adb -s " & $g_data_DeviceSelected & " shell getprop dhcp.wlan0.result", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_DeviceWifiC)
	$g_cmdout_DeviceWifiC = StdoutRead($g_cmd_DeviceWifiC)
	$g_cmdout_DeviceWifiC2 = StringStripWS($g_cmdout_DeviceWifiC, 8)
	If ($g_cmdout_DeviceWifiC2 == "ok") Then
		$g_cmd_DeviceWifi = Run(@ComSpec & " /c adb -s " & $g_data_DeviceSelected & " shell dumpsys connectivity", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmd_DeviceWifi)
		$g_cmdout_DeviceWifi = StdoutRead($g_cmd_DeviceWifi)
		_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & $g_cmdout_DeviceWifi)
		$g_regex_DeviceWifi = StringRegExp($g_cmdout_DeviceWifi, 'extra: "(.*)"', 3)
		$g_data_DeviceWifi = $g_regex_DeviceWifi[0]
		GUICtrlSetData($g_data_Wifi, $g_data_DeviceWifi)
	Else
		GUICtrlSetData($g_data_Wifi, "Not Connected")
	EndIf
	Sleep(333)
	$g_cmd_DeviceIP = Run(@ComSpec & " /c adb -s " & $g_data_DeviceSelected & " shell getprop dhcp.wlan0.ipaddress", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_DeviceIP)
	$g_cmdout_DeviceIP = StdoutRead($g_cmd_DeviceIP)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & $g_cmdout_DeviceIP)
	$g_data_DeviceIP = StringStripWS($g_cmdout_DeviceIP, 8)
	GUICtrlSetData($g_data_IP, $g_data_DeviceIP)
	Sleep(333)
	GUICtrlSetState($g_input_Title, $GUI_ENABLE)
	GUICtrlSetState($g_chk_AlwaysOnTop, $GUI_ENABLE)
	GUICtrlSetState($g_chk_Borderless, $GUI_ENABLE)
	GUICtrlSetState($g_chk_FullScreen, $GUI_ENABLE)
	GUICtrlSetState($g_chk_NoScreenSaver, $GUI_ENABLE)
	GUICtrlSetState($g_chk_PowerOffOnExit, $GUI_ENABLE)
	GUICtrlSetState($g_chk_ShowTouch, $GUI_ENABLE)
	GUICtrlSetState($g_chk_StayAwake, $GUI_ENABLE)
	GUICtrlSetState($g_chk_TurnOffTheScreen, $GUI_ENABLE)
	GUICtrlSetState($g_chk_ViewOnlyMode, $GUI_ENABLE)
	GUICtrlSetState($g_rad_ResolutionAuto, $GUI_ENABLE)
	GUICtrlSetState($g_rad_ResolutionMax, $GUI_ENABLE)
	GUICtrlSetState($g_rad_ShortcutCtrl, $GUI_ENABLE)
	GUICtrlSetState($g_rad_ShortcutAlt, $GUI_ENABLE)
	GUICtrlSetState($g_btn_DeviceShutdown, $GUI_ENABLE)
	GUICtrlSetState($g_btn_DeviceReboot, $GUI_ENABLE)
	GUICtrlSetState($g_btn_DisplayPowerOnOff, $GUI_ENABLE)
	GUICtrlSetState($g_btn_DeviceUnlock, $GUI_ENABLE)
	GUICtrlSetData($g_input_Title, $g_ini_DeviceUser & "'s Phone")
	$g_ini_AlwaysOnTop = _ReadIni("" & $g_data_DeviceSelected & "_AlwaysOnTop", "")
	GUICtrlSetState($g_chk_AlwaysOnTop, $g_ini_AlwaysOnTop)
	$g_ini_Borderless = _ReadIni("" & $g_data_DeviceSelected & "_Borderless", "")
	GUICtrlSetState($g_chk_Borderless, $g_ini_Borderless)
	$g_ini_FullScreen = _ReadIni("" & $g_data_DeviceSelected & "_FullScreen", "")
	GUICtrlSetState($g_chk_FullScreen, $g_ini_FullScreen)
	$g_ini_NoScreenSaver = _ReadIni("" & $g_data_DeviceSelected & "_NoScreenSaver", "")
	GUICtrlSetState($g_chk_NoScreenSaver, $g_ini_NoScreenSaver)
	$g_ini_PowerOffOnExit = _ReadIni("" & $g_data_DeviceSelected & "_PowerOffOnExit", "")
	GUICtrlSetState($g_chk_PowerOffOnExit, $g_ini_PowerOffOnExit)
	If _ReadIni("" & $g_data_DeviceSelected & "_ResolutionAuto", "") = 1 Then
		GUICtrlSetState($g_rad_ResolutionAuto, $GUI_CHECKED)
	ElseIf _ReadIni("" & $g_data_DeviceSelected & "_ResolutionMax", "") = 1 Then
		GUICtrlSetState($g_rad_ResolutionMax, $GUI_CHECKED)
	EndIf
	If _ReadIni("" & $g_data_DeviceSelected & "_ShortCutCtrl", "") = 1 Then
		GUICtrlSetState($g_rad_ShortcutCtrl, $GUI_CHECKED)
	ElseIf _ReadIni("" & $g_data_DeviceSelected & "_ShortCutAlt", "") = 1 Then
		GUICtrlSetState($g_rad_ShortcutAlt, $GUI_CHECKED)
	EndIf
	$g_ini_ShowTouch = _ReadIni("" & $g_data_DeviceSelected & "_ShowTouch", "")
	GUICtrlSetState($g_chk_ShowTouch, $g_ini_ShowTouch)
	$g_ini_StayAwake = _ReadIni("" & $g_data_DeviceSelected & "_StayAwake", "")
	GUICtrlSetState($g_chk_StayAwake, $g_ini_StayAwake)
	$g_ini_TurnOffTheScreen = _ReadIni("" & $g_data_DeviceSelected & "_TurnOffTheScreen", "")
	GUICtrlSetState($g_chk_TurnOffTheScreen, $g_ini_TurnOffTheScreen)
	$g_ini_ViewOnlyMode = _ReadIni("" & $g_data_DeviceSelected & "_ViewOnlyMode", "")
	GUICtrlSetState($g_chk_ViewOnlyMode, $g_ini_ViewOnlyMode)
EndFunc   ;==>_f_sub_GetIni

Func _f_sub_SetIni()
	$g_cmd_DeviceUser = Run(@ComSpec & " /c adb -s " & $g_data_DeviceSelected & " shell dumpsys user", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_DeviceUser)
	$g_cmdout_DeviceUser = StdoutRead($g_cmd_DeviceUser)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & $g_cmdout_DeviceUser)
	$g_regex_DeviceUser = StringRegExp($g_cmdout_DeviceUser, "{[0-9]+:(.*):[0-9]+}", 3)
	$g_data_DeviceUser = $g_regex_DeviceUser[0]
	_SaveIni($g_data_DeviceSelected & "_User", $g_data_DeviceUser)

	$g_cmd_DeviceAccount = Run(@ComSpec & " /c adb -s " & $g_data_DeviceSelected & " shell dumpsys account", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_DeviceAccount)
	$g_cmdout_DeviceAccount = StdoutRead($g_cmd_DeviceAccount)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & $g_cmdout_DeviceAccount)
	$g_regex_DeviceAccount = StringRegExp($g_cmdout_DeviceAccount, "{name=(.*), type=com.google}", 3)
	For $x = 0 To UBound($g_regex_DeviceAccount) - 1
		$g_regex_DeviceAccount[$x] = $g_regex_DeviceAccount[$x]
	Next
	$g_data_DeviceAccount = _ArrayToString($g_regex_DeviceAccount, ", ")
	_SaveIni($g_data_DeviceSelected & "_Account", $g_data_DeviceAccount)

	$g_cmd_DeviceModel = Run(@ComSpec & " /c adb -s " & $g_data_DeviceSelected & " shell getprop ro.product.model", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_DeviceModel)
	$g_cmdout_DeviceModel = StdoutRead($g_cmd_DeviceModel)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & $g_cmdout_DeviceModel)
	$g_data_DeviceModel = StringStripWS($g_cmdout_DeviceModel, 8)
	_SaveIni($g_data_DeviceSelected & "_Model", $g_data_DeviceModel)

	$g_cmd_DeviceSerial = Run(@ComSpec & " /c adb -s " & $g_data_DeviceSelected & " shell getprop ro.serialno", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_DeviceSerial)
	$g_cmdout_DeviceSerial = StdoutRead($g_cmd_DeviceSerial)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & $g_cmdout_DeviceSerial)
	$g_data_DeviceSerial = StringStripWS($g_cmdout_DeviceSerial, 8)
	_SaveIni($g_data_DeviceSelected & "_Serial", $g_data_DeviceSerial)

	_SaveIni($g_data_DeviceSelected & "_Connection", $g_data_DeviceConnection)
EndFunc   ;==>_f_sub_SetIni

Func _f_sub_UpdateWindow()
	If _GUICtrlIpAddress_IsBlank($g_input_IPAddress) Then
		GUICtrlSetState($g_btn_Connect, $GUI_DISABLE)
	Else
		GUICtrlSetState($g_btn_Connect, $GUI_ENABLE)
	EndIf
	If $g_data_DeviceConnection = "Wireless" Then
		GUICtrlSetState($g_btn_GetIP, $GUI_DISABLE)
		GUICtrlSetState($g_btn_Connect, $GUI_DISABLE)
	Else
		GUICtrlSetState($g_btn_GetIP, $GUI_ENABLE)
;~ 		GUICtrlSetState($g_btn_Connect, $GUI_ENABLE)
	EndIf
EndFunc   ;==>_f_sub_UpdateWindow

Func _f_sub_DeviceInfoClear()
	_f_sub_StatusBar("Getting device info.")
	GUICtrlSetData($g_data_User, "")
	Sleep(250)
	GUICtrlSetData($g_data_Account, "")
	Sleep(250)
	GUICtrlSetData($g_data_Model, "")
	Sleep(250)
	GUICtrlSetData($g_data_Serial, "")
	Sleep(250)
	GUICtrlSetData($g_data_Battery, "")
	Sleep(250)
	GUICtrlSetData($g_data_Uptime, "")
	Sleep(250)
	GUICtrlSetData($g_data_Connection, "")
	Sleep(250)
	GUICtrlSetData($g_data_Wifi, "")
	Sleep(250)
	GUICtrlSetData($g_data_IP, "")
	Sleep(250)
	GUICtrlSetData($g_input_Title, "")
EndFunc   ;==>_f_sub_DeviceInfoClear

Func _f_sub_OptionSet()
	$g_data_ScrcpyTitle = GUICtrlRead($g_input_Title)
	If $g_data_ScrcpyTitle = "" Then
		$g_data_Title = ""
	Else
		$g_data_Title = " --window-title=" & '"' & $g_data_ScrcpyTitle & '"'
	EndIf
	If _IsChecked($g_chk_AlwaysOnTop) Then
		$g_data_AlwaysOnTop = " --always-on-top"
		_SaveIni($g_data_DeviceSelected & "_AlwaysOnTop", GUICtrlRead($g_chk_AlwaysOnTop))
	Else
		$g_data_AlwaysOnTop = ""
		_SaveIni($g_data_DeviceSelected & "_AlwaysOnTop", GUICtrlRead($g_chk_AlwaysOnTop))
	EndIf
	If _IsChecked($g_chk_Borderless) Then
		$g_data_Borderless = " --window-borderless"
		_SaveIni($g_data_DeviceSelected & "_Borderless", GUICtrlRead($g_chk_Borderless))
	Else
		$g_data_Borderless = ""
		_SaveIni($g_data_DeviceSelected & "_Borderless", GUICtrlRead($g_chk_Borderless))
	EndIf
	If _IsChecked($g_chk_FullScreen) Then
		$g_data_FullScreen = " -f"
		_SaveIni($g_data_DeviceSelected & "_FullScreen", GUICtrlRead($g_chk_FullScreen))
	Else
		$g_data_FullScreen = ""
		_SaveIni($g_data_DeviceSelected & "_FullScreen", GUICtrlRead($g_chk_FullScreen))
	EndIf
	If _IsChecked($g_chk_NoScreenSaver) Then
		$g_data_NoScreenSaver = " --disable-screensaver"
		_SaveIni($g_data_DeviceSelected & "_NoScreenSaver", GUICtrlRead($g_chk_NoScreenSaver))
	Else
		$g_data_NoScreenSaver = ""
		_SaveIni($g_data_DeviceSelected & "_NoScreenSaver", GUICtrlRead($g_chk_NoScreenSaver))
	EndIf
	If _IsChecked($g_chk_PowerOffOnExit) Then
		$g_data_PowerOffOnExit = " --power-off-on-close"
		_SaveIni($g_data_DeviceSelected & "_PowerOffOnExit", GUICtrlRead($g_chk_PowerOffOnExit))
	Else
		$g_data_PowerOffOnExit = ""
		_SaveIni($g_data_DeviceSelected & "_PowerOffOnExit", GUICtrlRead($g_chk_PowerOffOnExit))
	EndIf
	If _IsChecked($g_rad_ResolutionAuto) Then
		$g_data_Resolution = ""
		_SaveIni($g_data_DeviceSelected & "_ResolutionAuto", GUICtrlRead($g_rad_ResolutionAuto))
		_SaveIni($g_data_DeviceSelected & "_ResolutionMax", GUICtrlRead($g_rad_ResolutionMax))
	ElseIf _IsChecked($g_rad_ResolutionMax) Then
		$g_data_Resolution = " --window-height=" & _GetworkingAreaHeight()
		_SaveIni($g_data_DeviceSelected & "_ResolutionAuto", GUICtrlRead($g_rad_ResolutionAuto))
		_SaveIni($g_data_DeviceSelected & "_ResolutionMax", GUICtrlRead($g_rad_ResolutionMax))
	EndIf
	If _IsChecked($g_rad_ShortcutCtrl) Then
		$g_data_Shortcut = " --shortcut-mod=""lctrl,rctrl"""
		$g_key_Shortcut = "^"
		_SaveIni($g_data_DeviceSelected & "_ShortCutCtrl", GUICtrlRead($g_rad_ShortcutCtrl))
		_SaveIni($g_data_DeviceSelected & "_ShortCutAlt", GUICtrlRead($g_rad_ShortcutAlt))
	ElseIf _IsChecked($g_rad_ShortcutAlt) Then
		$g_data_Shortcut = " --shortcut-mod=""lalt,ralt"""
		$g_key_Shortcut = "!"
		_SaveIni($g_data_DeviceSelected & "_ShortCutCtrl", GUICtrlRead($g_rad_ShortcutCtrl))
		_SaveIni($g_data_DeviceSelected & "_ShortCutAlt", GUICtrlRead($g_rad_ShortcutAlt))
	EndIf
	If _IsChecked($g_chk_ShowTouch) Then
		$g_data_ShowTouch = " -t"
		_SaveIni($g_data_DeviceSelected & "_ShowTouch", GUICtrlRead($g_chk_ShowTouch))
	Else
		$g_data_ShowTouch = ""
		_SaveIni($g_data_DeviceSelected & "_ShowTouch", GUICtrlRead($g_chk_ShowTouch))
	EndIf
	If _IsChecked($g_chk_StayAwake) Then
		$g_data_StayAwake = " -w"
		_SaveIni($g_data_DeviceSelected & "_StayAwake", GUICtrlRead($g_chk_StayAwake))
	Else
		$g_data_StayAwake = ""
		_SaveIni($g_data_DeviceSelected & "_StayAwake", GUICtrlRead($g_chk_StayAwake))
	EndIf
	If _IsChecked($g_chk_TurnOffTheScreen) Then
		$g_data_TurnOffTheScreen = " -S"
		_SaveIni($g_data_DeviceSelected & "_TurnOffTheScreen", GUICtrlRead($g_chk_TurnOffTheScreen))
	Else
		$g_data_TurnOffTheScreen = ""
		_SaveIni($g_data_DeviceSelected & "_TurnOffTheScreen", GUICtrlRead($g_chk_TurnOffTheScreen))
	EndIf
	If _IsChecked($g_chk_ViewOnlyMode) Then
		$g_data_ViewOnlyMode = " -n"
		_SaveIni($g_data_DeviceSelected & "_ViewOnlyMode", GUICtrlRead($g_chk_ViewOnlyMode))
	Else
		$g_data_ViewOnlyMode = ""
		_SaveIni($g_data_DeviceSelected & "_ViewOnlyMode", GUICtrlRead($g_chk_ViewOnlyMode))
	EndIf
EndFunc   ;==>_f_sub_OptionSet

Func _f_sub_ScrcpyCommand()
	Sleep(5000)
	GUICtrlSetState($g_btn_ScrcpyOn, $GUI_ENABLE)
	$g_ini_ScrcpyCommand = " -s " & $g_data_DeviceSelected & $g_data_Title & $g_data_AlwaysOnTop & $g_data_Borderless & $g_data_FullScreen & $g_data_NoScreenSaver & $g_data_PowerOffOnExit & $g_data_Resolution & $g_data_Shortcut & $g_data_ShowTouch & $g_data_StayAwake & $g_data_TurnOffTheScreen & $g_data_ViewOnlyMode
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & $g_ini_ScrcpyCommand)
EndFunc   ;==>_f_sub_ScrcpyCommand

Func _f_sub_MainGuiHide()
	GUICtrlSetState($g_btn_ScrcpyOn, $GUI_DISABLE)
	GUISetState(@SW_HIDE, $g_gui_Main)
EndFunc   ;==>_f_sub_MainGuiHide

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
	GUICtrlSetData($g_lbl_SelectedDevice_1, $g_ini_DeviceUser & "'s Phone")
	GUICtrlSetData($g_lbl_SelectedDevice_2, "(" & $g_data_DeviceSelected & ")")
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

Func _f_btn_VolumeDown()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "{DOWN}")
	EndIf
EndFunc   ;==>_f_btn_VolumeDown

Func _f_btn_ScreenOn()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "+o")
	EndIf
EndFunc   ;==>_f_btn_ScreenOn

Func _f_btn_ScreenOff()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "o")
	EndIf
EndFunc   ;==>_f_btn_ScreenOff

Func _f_btn_NotificationOn()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "n")
	EndIf
EndFunc   ;==>_f_btn_NotificationOn

Func _f_btn_NotificationOff()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "+n")
	EndIf
EndFunc   ;==>_f_btn_NotificationOff

Func _f_btn_Menu()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_key_Shortcut & "m")
	EndIf
EndFunc   ;==>_f_btn_Menu

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
		_f_sub_StatusBar("Selected device: " & $g_data_DeviceSelected)
		GUICtrlSetState($g_btn_ScrcpyOn, $GUI_ENABLE)
	Else
		GUIDelete($g_gui_Child)
		GUISetState(@SW_SHOW, $g_gui_Main)
		_f_sub_StatusBar("Selected device: " & $g_data_DeviceSelected)
		GUICtrlSetState($g_btn_ScrcpyOn, $GUI_ENABLE)
	EndIf
EndFunc   ;==>_f_sub_GUIChildClose

Func _f_sub_GUIMainClose()
	_f_sub_AdbStop()
	Exit
EndFunc   ;==>_f_sub_GUIMainClose

;==>Supporting Function<==;

Func _SaveIni($_sKey, $_sValue)
	Local $sIniRead = IniRead($g_ini_Config, $g_data_DeviceSelected, $_sKey, "")
	If $sIniRead = $_sValue Then Return
	IniWrite($g_ini_Config, $g_data_DeviceSelected, $_sKey, $_sValue)
EndFunc   ;==>_SaveIni

Func _ReadIni(ByRef $_rKey, $_rValue = "")
	Return IniRead($g_ini_Config, $g_data_DeviceSelected, $_rKey, $_rValue)
EndFunc   ;==>_ReadIni

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
						$g_data_DeviceSelected = _GUICtrlListView_GetItemText($g_lvw_DeviceList, $iItem, 1)
						$g_data_DeviceConnection = _GUICtrlListView_GetItemText($g_lvw_DeviceList, $iItem, 2)
						_f_sub_DeviceSelected()
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