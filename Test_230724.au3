;==>"Made with️ ❤ in Bangladesh"

Opt("GUIOnEventMode", 1)
Opt("GUICloseOnESC", 1)

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
#include "include\GUIExtender.au3"

Global $g_array_Devices, $g_btn_Back, $g_btn_Connect, $g_btn_DeviceReboot, $g_btn_DeviceShutdown, $g_btn_DeviceUnlock, $g_btn_DisplayPowerOnOff, $g_btn_GetIP, $g_btn_Home, $g_btn_Menu, $g_btn_NotificationOff, $g_btn_NotificationOn, $g_btn_Power, $g_btn_Refresh, $g_btn_Reset, $g_btn_ScrcpyOn, $g_btn_ScreenOff, $g_btn_ScreenOn, $g_btn_Switch, $g_btn_VolumeDown, $g_btn_VolumeUP, $g_chk_AlwaysOnTop, $g_chk_Borderless, $g_chk_FullScreen, $g_chk_NoScreenSaver, $g_chk_PowerOffOnExit, $g_chk_ShowTouch, $g_chk_StayAwake, $g_chk_TurnOffTheScreen, $g_chk_ViewOnlyMode, $g_cmdout_AdbStart, $g_cmdout_AdbStart1, $g_cmdout_AdbStop, $g_cmdout_AdbStop1, $g_cmdout_DeviceAccount, $g_cmdout_DeviceApi, $g_cmdout_DeviceBattery, $g_cmdout_DeviceIP, $g_cmdout_DeviceListGet, $g_cmdout_DeviceModel, $g_cmdout_DeviceName, $g_cmdout_DeviceSerial, $g_cmdout_DeviceUptime, $g_cmdout_DeviceUser, $g_cmdout_DeviceVersion, $g_cmdout_DeviceWifi, $g_cmdout_DeviceWifiC, $g_cmdout_DeviceWifiC2, $g_cmdout_GetIP, $g_cmd_AdbStart, $g_cmd_AdbStop, $g_cmd_Connect, $g_cmd_DeviceAccount, $g_cmd_DeviceApi, $g_cmd_DeviceBattery, $g_cmd_DeviceIP, $g_cmd_DeviceListGet, $g_cmd_DeviceModel, $g_cmd_DeviceName, $g_cmd_DeviceSerial, $g_cmd_DeviceUptime, $g_cmd_DeviceUser, $g_cmd_DeviceVersion
Global $g_cmd_DeviceWifi, $g_cmd_DeviceWifiC, $g_cmd_GetIP, $g_data_Account, $g_data_AlwaysOnTop, $g_data_Battery, $g_data_Borderless, $g_data_Connection, $g_data_DeviceAccount, $g_data_DeviceApi, $g_data_DeviceBattery, $g_data_DeviceBatteryAC, $g_data_DeviceBatteryUSB, $g_data_DeviceConnection, $g_data_DeviceIP, $g_data_DeviceListGet, $g_data_DeviceModel, $g_data_DeviceName, $g_data_DeviceSelected, $g_data_DeviceSerial, $g_data_DeviceUptime, $g_data_DeviceUser, $g_data_DeviceVersion, $g_data_DeviceWifi, $g_data_FullScreen, $g_data_GetIP, $g_data_IP, $g_data_Model, $g_data_NoScreenSaver, $g_data_PowerOffOnExit, $g_data_Resolution, $g_data_ScrcpyTitle, $g_data_SectionState, $g_data_Serial, $g_data_Shortcut, $g_data_ShowTouch, $g_data_StayAwake, $g_data_Title, $g_data_TurnOffTheScreen, $g_data_Uptime, $g_data_User, $g_data_Version, $g_data_ViewOnlyMode, $g_data_Wifi, $g_font_Bold, $g_font_Name, $g_font_Size, $g_graphic_Line, $g_group_Details, $g_group_DeviceList, $g_group_Options, $g_group_Parameter, $g_group_Resolution, $g_group_SelectedDevice, $g_group_Shortcut, $g_group_Touch, $g_group_Wireless, $g_gui_Child, $g_gui_Main
Global $g_ini_AlwaysOnTop, $g_ini_Borderless, $g_ini_Config, $g_ini_DeviceAccount, $g_ini_DeviceConnection, $g_ini_DeviceModel, $g_ini_Devices, $g_ini_DeviceSerial, $g_ini_DeviceUser, $g_ini_DeviceVersion, $g_ini_FullScreen, $g_ini_NoScreenSaver, $g_ini_PowerOffOnExit, $g_ini_ScrcpyCommand, $g_ini_ShowTouch, $g_ini_StayAwake, $g_ini_TurnOffTheScreen, $g_ini_ViewOnlyMode, $g_ini_WiFiAddress, $g_input_IPAddress, $g_input_Title, $g_key_Shortcut, $g_lbl_Account_1, $g_lbl_Account_2, $g_lbl_Battery_1, $g_lbl_Battery_2, $g_lbl_Connection_1, $g_lbl_Connection_2, $g_lbl_IP_1, $g_lbl_IP_2, $g_lbl_Model_1, $g_lbl_Model_2, $g_lbl_Parameter, $g_lbl_SelectedDevice_1, $g_lbl_SelectedDevice_2, $g_lbl_Serial_1, $g_lbl_Serial_2, $g_lbl_Title_1, $g_lbl_Title_2, $g_lbl_Uptime_1, $g_lbl_Uptime_2, $g_lbl_User_1, $g_lbl_User_2, $g_lbl_Version_1, $g_lbl_Version_2, $g_lbl_Wifi_1, $g_lbl_Wifi_2, $g_lvw_DeviceList, $g_rad_ResolutionAuto, $g_rad_ResolutionMax, $g_rad_ShortcutAlt, $g_rad_ShortcutCtrl, $g_regex_DeviceAccount, $g_regex_DeviceBattery, $g_regex_DeviceBatteryAC, $g_regex_DeviceBatteryUSB, $g_regex_DeviceUser, $g_regex_DeviceWifi, $g_Status
Global $g_ini_Config = @ScriptDir & "\Config.ini"

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

Func _f_sub_GUIMain()
	$g_gui_Main = GUICreate("Droid Control", 400, 350, -1, -1, BitOR($WS_POPUP, $WS_CAPTION))
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

	$g_group_Parameter = GUICtrlCreateGroup("Parameter", 5, 190, 390, 130, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_lbl_Parameter = GUICtrlCreateEdit($g_ini_ScrcpyCommand, 10, 205, 380, 110, BitOR($ES_READONLY, $ES_AUTOVSCROLL))
	GUICtrlSetColor(-1, 0x006A4E)
	GUICtrlSetFont(-1, 8.5, $g_font_Bold)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_Status = _GUICtrlStatusBar_Create($g_gui_Main)
	_GUICtrlStatusBar_SetMinHeight($g_Status, 25)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	GUISetState(@SW_SHOWNORMAL)
EndFunc   ;==>_f_sub_GUIMain

Func _f_sub_AdbStart()
	_GUICtrlEdit_AppendText($g_lbl_Parameter, "shell@droid_control:/ $ " & @CRLF & "Starting ADB Server.")
	$g_cmd_AdbStart = Run(@ComSpec & " /c " & "adb start-server", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_AdbStart)
	$g_cmdout_AdbStart = StdoutRead($g_cmd_AdbStart)
	Local $g_cmdout_AdbStart1 = StderrRead($g_cmd_AdbStart)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & @CRLF & "shell@droid_control:/ $ " & @CRLF & $g_cmdout_AdbStart1)
EndFunc   ;==>_f_sub_AdbStart

Func _f_sub_DeviceListGet()
	IniDelete($g_ini_Config, "Devices")
	$g_cmd_DeviceListGet = Run(@ComSpec & " /c adb devices", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_DeviceListGet)
	$g_cmdout_DeviceListGet = StdoutRead($g_cmd_DeviceListGet)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & "shell@droid_control:/ $ " & @CRLF & "Searching . . .")
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & @CRLF & "shell@droid_control:/ $ " & @CRLF & "Receiving connected device name.")
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
		_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & @CRLF & "shell@droid_control:/ $ " & @CRLF & $g_array_Devices[1])
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
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & @CRLF & "shell@droid_control:/ $ " & @CRLF & "Stoping ADB Server.")
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & @CRLF & "shell@droid_control:/ $ " & @CRLF & $g_cmdout_AdbStop1)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & @CRLF & "shell@droid_control:/ $ " & @CRLF & $g_cmdout_AdbStop)
EndFunc   ;==>_f_sub_AdbStop

Func _f_sub_GetIP()
	$g_cmd_GetIP = Run(@ComSpec & " /c " & "adb -s " & $g_data_DeviceSelected & " shell getprop dhcp.wlan0.ipaddress", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmd_GetIP)
	$g_cmdout_GetIP = StdoutRead($g_cmd_GetIP)
	$g_data_GetIP = StringStripWS($g_cmdout_GetIP, 2)
	_GUICtrlEdit_AppendText($g_lbl_Parameter, @CRLF & @CRLF & "shell@droid_control:/ $ " & @CRLF & "Device IP address: " & $g_data_GetIP)
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

Func _f_sub_GUIMainClose()
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
					EndIf
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY