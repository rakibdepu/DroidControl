;==>"Made with️ ❤ in Bangladesh"

Opt("GUIOnEventMode", 1)
Opt("GUICoordMode", 1)
Opt("GUICloseOnESC", 1)
Opt("MustDeclareVars", 1)

#include <Array.au3>
#include <ButtonConstants.au3>
#include <Clipboard.au3>
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

Global $g_arrayDevices, $g_btnBack, $g_btnConnect, $g_btnGetIP, $g_btnHome, $g_btnMenu, $g_btnNotificationOff, $g_btnNotificationOn, $g_btnOn, $g_btnPower, $g_btnRefresh, $g_btnReset, $g_btnScreenOff, $g_btnScreenOn, $g_btnSwitch, $g_btnVolumeDown, $g_btnVolumeUP, $g_chkAlwaysOnTop, $g_chkBorderless, $g_chkFullScreen, $g_chkNoScreenSaver, $g_chkPowerOffOnExit, $g_chkShowTouch, $g_chkStayAwake, $g_chkTurnOffTheScreen, $g_chkViewOnlyMode, $g_cmdDeviceAccount, $g_cmdDeviceBattery, $g_cmdDeviceIP, $g_cmdDeviceListGet, $g_cmdDeviceModel, $g_cmdDeviceSerial, $g_cmdDeviceTitle, $g_cmdDeviceUptime, $g_cmdDeviceWifi, $g_cmdGetIP, $g_cmdoutDeviceAccount, $g_cmdoutDeviceBattery, $g_cmdoutDeviceListGet, $g_cmdoutDeviceTitle, $g_cmdoutDeviceUptime, $g_cmdoutDeviceWifi, $g_cmdoutGetIP, $g_dataAccount, $g_dataAlwaysOnTop, $g_dataBattery, $g_dataBorderless, $g_dataConnection, $g_dataDeviceAccount, $g_dataDeviceBattery
Global $g_dataDeviceBatteryAC, $g_dataDeviceBatteryUSB, $g_dataDeviceConnection, $g_dataDeviceIP, $g_dataDeviceListGet, $g_dataDeviceModel, $g_dataDeviceSerial, $g_dataDeviceTitle, $g_dataDeviceUptime, $g_dataDeviceWifi, $g_dataFullScreen, $g_dataIP, $g_dataModel, $g_dataNoScreenSaver, $g_dataPowerOffOnExit, $g_dataResolution, $g_dataSerial_1, $g_dataSerial_2, $g_dataShortcut, $g_dataShowTouch, $g_dataStayAwake, $g_dataTitle, $g_dataTurnOffTheScreen, $g_dataUptime, $g_dataViewOnlyMode, $g_dataWifi, $g_extfileIP, $g_graphicLine, $g_groupDetails, $g_groupDeviceList, $g_groupOptions, $g_groupParameter, $g_groupResolution, $g_groupSelectedDevice, $g_groupShortcut, $g_groupTouch, $g_groupWireless, $g_guiChild, $g_guiMain, $g_iniAlwaysOnTop, $g_iniBorderless, $g_iniDevices, $g_iniFullScreen, $g_iniNoScreenSaver, $g_iniPowerOffOnExit, $g_iniScrcpyCommand, $g_iniShowTouch, $g_iniStayAwake, $g_iniTurnOffTheScreen, $g_iniViewOnlyMode
Global $g_iniWiFiAddress, $g_inputIPAddress, $g_keyShortcut, $g_lblAccount_1, $g_lblAccount_2, $g_lblBattery_1, $g_lblBattery_2, $g_lblConnection_1, $g_lblConnection_2, $g_lblIP_1, $g_lblIP_2, $g_lblModel_1, $g_lblModel_2, $g_lblParameter, $g_lblSelectedDevice_1, $g_lblSelectedDevice_2, $g_lblSerial_1, $g_lblSerial_2, $g_lblTitle_1, $g_lblTitle_2, $g_lblUptime_1, $g_lblUptime_2, $g_lblWifi_1, $g_lblWifi_2, $g_lvwDeviceList, $g_radResolutionAuto, $g_radResolutionMax, $g_radShortcutAlt, $g_radShortcutCtrl, $g_regexDeviceAccount, $g_regexDeviceBattery, $g_regexDeviceBatteryAC, $g_regexDeviceBatteryUSB, $g_regexDeviceTitle, $g_regexDeviceWifi, $g_Slogan, $g_Status, $g_txtIP_1, $g_txtIP_2, $g_txtIP_3, $g_txtIP_4
Global $g_iniConfig = @ScriptDir & "\Core\Config.ini"
Global $g_FontName = "Baloo Da 2"
Global $g_FontSize = 9.5
Global $g_FontBold = 700

MainProgram()

Func MainProgram()
	StartupCheck()
	StatusBarWrite("Installing required components")
	GUIMain()
	StatusBarWrite("Reading settings")
	ReadSettings()
	StatusBarWrite("Starting ADB Server")
	ADBStart()
	StatusBarWrite("Searching for device")
	DeviceListGet()
	StatusBarWrite("Making a device list")
	DeviceListSet()
	StatusBarWrite("Select a device from list")
	While 1
		Sleep(100)
	WEnd
EndFunc   ;==>MainProgram

Func RefreshClick()
	StatusBarWrite("Searching for device")
	DeviceListGet()
	StatusBarWrite("Making a device list")
	DeviceListSet()
	StatusBarWrite("Select a device from list")
EndFunc   ;==>RefreshClick

Func ResetClick()
	StatusBarWrite("Restarting ADB Server")
	ADBStop()
	ADBStart()
	StatusBarWrite("Searching for device")
	DeviceListGet()
	StatusBarWrite("Making a device list")
	DeviceListSet()
	StatusBarWrite("Select a device from list")
EndFunc   ;==>ResetClick

Func GetIPClick()
	StatusBarWrite("Geting IP Address from selected device")
	GetIP()
	ReadSettings()
EndFunc   ;==>GetIPClick

Func GoWirelessClick()
	StatusBarWrite("Try connecting to given IP")
	GoWireless()
	StatusBarWrite("Searching for device")
	DeviceListGet()
	StatusBarWrite("Making a device list")
	DeviceListSet()
	StatusBarWrite("Select a device from list")
EndFunc   ;==>GoWirelessClick

Func ParameterClick()
	StatusBarWrite("Adding select parameter in the scrcpy command line")
	ParameterUpdate()
	Parameters()
EndFunc   ;==>ParameterClick

Func OnClick()
	StatusBarWrite("Starting scrcpy command")
	ScrcpyOn()
	GUIChild()
	ScrcpyRun()
EndFunc   ;==>OnClick

Func StartupCheck()
	$g_extfileIP = @ScriptDir & "\Core\ip.bat"
	$g_txtIP_1 = "FOR /F ""tokens=2"" %%G IN ('adb -s " & $g_dataSerial_1 & " shell ip addr show wlan0 ^|find ""inet ""') DO set ipfull=%%G"
	$g_txtIP_2 = "FOR /F ""tokens=1 delims=/"" %%G in (""%ipfull%"") DO set ip=%%G"
	$g_txtIP_3 = "echo %ip%|clip"
	If Not FileExists($g_extfileIP) Then
		_FileCreate($g_extfileIP)
		_FileWriteToLine($g_extfileIP, 1, $g_txtIP_1, True, True)
		_FileWriteToLine($g_extfileIP, 2, $g_txtIP_2, True, True)
		_FileWriteToLine($g_extfileIP, 3, $g_txtIP_3, True, True)
	EndIf
EndFunc   ;==>StartupCheck

Func GUIMain()
	$g_guiMain = GUICreate("Droid Control", 400, 595, -1, -1, BitOR($WS_POPUP, $WS_CAPTION))
	GUISetOnEvent($GUI_EVENT_CLOSE, "GUIMainClose")
	$g_groupDeviceList = GUICtrlCreateGroup("Device List", 5, 5, 390, 120, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_lvwDeviceList = _GUICtrlListView_Create($g_guiMain, "#|Device|Connection", 10, 20, 305, 100)
	_GUICtrlListView_SetExtendedListViewStyle($g_lvwDeviceList, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
	_GUICtrlListView_SetColumnWidth($g_lvwDeviceList, 0, 50)
	_GUICtrlListView_SetColumnWidth($g_lvwDeviceList, 1, 175)
	_GUICtrlListView_SetColumnWidth($g_lvwDeviceList, 2, 80)
	_GUICtrlListView_JustifyColumn($g_lvwDeviceList, 0, 2)
	_GUICtrlListView_JustifyColumn($g_lvwDeviceList, 1, 2)
	_GUICtrlListView_JustifyColumn($g_lvwDeviceList, 2, 2)
	$g_btnRefresh = GUICtrlCreateButton("Refresh", 320, 20, 70, 48)
	GUICtrlSetOnEvent(-1, "RefreshClick")
	GUICtrlSetTip(-1, "Click to refresh device list.")
	$g_btnReset = GUICtrlCreateButton("Reset", 320, 73, 70, 47)
	GUICtrlSetOnEvent(-1, "ResetClick")
	GUICtrlSetTip(-1, "Click to reset device list.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_groupWireless = GUICtrlCreateGroup("Wireless", 5, 130, 390, 40, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_btnGetIP = GUICtrlCreateButton("Get IP", 10, 145, 70, 20)
	GUICtrlSetOnEvent(-1, "GetIPClick")
	GUICtrlSetTip(-1, "Get IP from usb device.")
	$g_inputIPAddress = _GUICtrlIpAddress_Create($g_guiMain, 115, 145, 170, 20)
	_GUICtrlIpAddress_Set($g_inputIPAddress, $g_iniWiFiAddress)
	$g_btnConnect = GUICtrlCreateButton("Connect", 320, 145, 70, 20)
	GUICtrlSetOnEvent(-1, "GoWirelessClick")
	GUICtrlSetTip(-1, "Click to connect with IP.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_groupDetails = GUICtrlCreateGroup("Details", 5, 175, 390, 140, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_graphicLine = GUICtrlCreateGraphic(81, 205, 309, 140)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_PENSIZE, 1)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_COLOR, 0xDCDCDC)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_LINE, 309, 0)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_MOVE, 0, 33)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_LINE, 309, 33)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_MOVE, 0, 51)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_LINE, 309, 51)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_MOVE, 0, 69)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_LINE, 117, 69)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_MOVE, 0, 87)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_LINE, 117, 87)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_MOVE, 192, 69)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_LINE, 309, 69)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_MOVE, 192, 87)
	GUICtrlSetGraphic($g_graphicLine, $GUI_GR_LINE, 309, 87)

	$g_lblTitle_1 = GUICtrlCreateLabel("User", 10, 190, 66, 15)
	$g_lblTitle_2 = GUICtrlCreateLabel(":", 76, 190, 5, 15)
	$g_dataTitle = GUICtrlCreateLabel("", 81, 190, 309, 15)

	$g_lblAccount_1 = GUICtrlCreateLabel("Account", 10, 208, 73, 30)
	$g_lblAccount_2 = GUICtrlCreateLabel(":", 76, 208, 2, 30)
	$g_dataAccount = GUICtrlCreateLabel("", 81, 208, 309, 30)

	$g_lblModel_1 = GUICtrlCreateLabel("Device Model", 10, 241, 66, 15)
	$g_lblModel_2 = GUICtrlCreateLabel(":", 76, 241, 5, 15)
	$g_dataModel = GUICtrlCreateLabel("", 81, 241, 309, 15)

	$g_lblSerial_1 = GUICtrlCreateLabel("Device Serial", 10, 259, 66, 15)
	$g_lblSerial_2 = GUICtrlCreateLabel(":", 76, 259, 5, 15)
	$g_dataSerial_2 = GUICtrlCreateLabel("", 81, 259, 117, 15)

	$g_lblBattery_1 = GUICtrlCreateLabel("Battery Status", 10, 277, 66, 15)
	$g_lblBattery_2 = GUICtrlCreateLabel(":", 76, 277, 5, 15)
	$g_dataBattery = GUICtrlCreateLabel("", 81, 277, 117, 15)

	$g_lblUptime_1 = GUICtrlCreateLabel("Up Time", 10, 295, 66, 15)
	$g_lblUptime_2 = GUICtrlCreateLabel(":", 76, 295, 5, 15)
	$g_dataUptime = GUICtrlCreateLabel("", 81, 295, 117, 15)

	$g_lblConnection_1 = GUICtrlCreateLabel("Connected by", 202, 259, 66, 15)
	$g_lblConnection_2 = GUICtrlCreateLabel(":", 268, 259, 5, 15)
	$g_dataConnection = GUICtrlCreateLabel("", 273, 259, 117, 15)

	$g_lblWifi_1 = GUICtrlCreateLabel("Wi-Fi SSID", 202, 277, 66, 15)
	$g_lblWifi_2 = GUICtrlCreateLabel(":", 268, 277, 5, 15)
	$g_dataWifi = GUICtrlCreateLabel("", 273, 277, 117, 15)

	$g_lblIP_1 = GUICtrlCreateLabel("IP Address", 202, 295, 66, 15)
	$g_lblIP_2 = GUICtrlCreateLabel(":", 268, 295, 5, 15)
	$g_dataIP = GUICtrlCreateLabel("", 273, 295, 117, 15)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_groupOptions = GUICtrlCreateGroup("Options", 5, 320, 315, 190, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_chkFullScreen = GUICtrlCreateCheckbox("Full Screen", 10, 335, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Start in fullscreen.")
	$g_chkPowerOffOnExit = GUICtrlCreateCheckbox("Power Off On Exit", 112, 335, 96, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Turn the device screen off when closing scrcpy.")
	$g_chkAlwaysOnTop = GUICtrlCreateCheckbox("Always On Top", 213, 335, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Make scrcpy window always on top (above other windows).")
	$g_chkViewOnlyMode = GUICtrlCreateCheckbox("View Only Mode", 10, 370, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Disable device control (mirror the device in read-only).")
	$g_chkShowTouch = GUICtrlCreateCheckbox("Show Touch", 112, 370, 96, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Enable 'show touches' on start, restore the initial value on exit.")
	$g_chkNoScreenSaver = GUICtrlCreateCheckbox("No ScreenSaver", 213, 370, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Disable screensaver while scrcpy is running.")
	$g_chkTurnOffTheScreen = GUICtrlCreateCheckbox("Turn Off The Screen", 10, 405, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Turn the device screen off immediately.")
	$g_chkStayAwake = GUICtrlCreateCheckbox("Stay Awake", 112, 405, 96, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Keep the device on while scrcpy is running.")
	$g_chkBorderless = GUICtrlCreateCheckbox("Borderless", 213, 405, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Disable window decorations (display borderless window).")
	$g_Slogan = GUICtrlCreateLabel("Made with️ ❤ in Bangladesh", 10, 470, 290, 30, $SS_CENTER)
	GUICtrlSetFont(-1, $g_FontSize, $g_FontBold, 0, $g_FontName, 5)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_groupResolution = GUICtrlCreateGroup("Resolution", 325, 320, 70, 65, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_radResolutionAuto = GUICtrlCreateRadio("Auto", 330, 335, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Set window height automatic.")
	$g_radResolutionMax = GUICtrlCreateRadio("Max", 330, 360, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Set window height maximum.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_groupShortcut = GUICtrlCreateGroup("ShortCut", 325, 390, 70, 65, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_radShortcutCtrl = GUICtrlCreateRadio("Ctrl", 330, 405, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Set 'Ctrl' as shortcut key.")
	$g_radShortcutAlt = GUICtrlCreateRadio("Alt", 330, 430, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Set 'Alt' as shortcut key.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_btnOn = GUICtrlCreateButton("On", 325, 460, 70, 50)
	GUICtrlSetOnEvent(-1, "OnClick")
	GUICtrlSetTip(-1, "Click to start SCRCPY.")

	$g_groupParameter = GUICtrlCreateGroup("Parameter", 5, 515, 390, 50, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_lblParameter = GUICtrlCreateLabel($g_iniScrcpyCommand, 10, 530, 380, 30, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_Status = _GUICtrlStatusBar_Create($g_guiMain)
	_GUICtrlStatusBar_SetMinHeight($g_Status, 25)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	GUISetState(@SW_SHOWNORMAL)
EndFunc   ;==>GUIMain

Func ReadSettings()
	$g_iniAlwaysOnTop = IniRead($g_iniConfig, "Main", "AlwaysOnTop", 4)
	GUICtrlSetState($g_chkAlwaysOnTop, $g_iniAlwaysOnTop)
	$g_iniBorderless = IniRead($g_iniConfig, "Main", "Borderless", 4)
	GUICtrlSetState($g_chkBorderless, $g_iniBorderless)
	$g_iniScrcpyCommand = IniRead($g_iniConfig, "Main", "FinalParameter", "")
	GUICtrlSetData($g_lblParameter, $g_iniScrcpyCommand)
	$g_iniFullScreen = IniRead($g_iniConfig, "Main", "FullScreen", 4)
	GUICtrlSetState($g_chkFullScreen, $g_iniFullScreen)
	$g_iniNoScreenSaver = IniRead($g_iniConfig, "Main", "NoScreenSaver", 4)
	GUICtrlSetState($g_chkNoScreenSaver, $g_iniNoScreenSaver)
	$g_iniPowerOffOnExit = IniRead($g_iniConfig, "Main", "PowerOffOnExit", 1)
	GUICtrlSetState($g_chkPowerOffOnExit, $g_iniPowerOffOnExit)
	$g_iniShowTouch = IniRead($g_iniConfig, "Main", "ShowTouch", 4)
	GUICtrlSetState($g_chkShowTouch, $g_iniShowTouch)
	$g_iniStayAwake = IniRead($g_iniConfig, "Main", "StayAwake", 4)
	GUICtrlSetState($g_chkStayAwake, $g_iniStayAwake)
	$g_iniTurnOffTheScreen = IniRead($g_iniConfig, "Main", "TurnOffTheScreen", 1)
	GUICtrlSetState($g_chkTurnOffTheScreen, $g_iniTurnOffTheScreen)
	$g_iniViewOnlyMode = IniRead($g_iniConfig, "Main", "ViewOnlyMode", 4)
	GUICtrlSetState($g_chkViewOnlyMode, $g_iniViewOnlyMode)
	$g_iniWiFiAddress = IniRead($g_iniConfig, "Main", "WiFiAddress", "192.168.1.2")
	_GUICtrlIpAddress_Set($g_inputIPAddress, $g_iniWiFiAddress)

	If IniRead($g_iniConfig, "Main", "ResolutionAuto", "") = 1 Then
		GUICtrlSetState($g_radResolutionAuto, $GUI_CHECKED)
	ElseIf IniRead($g_iniConfig, "Main", "ResolutionMax", "") = 1 Then
		GUICtrlSetState($g_radResolutionMax, $GUI_CHECKED)
	EndIf

	If IniRead($g_iniConfig, "Main", "ShortCutCtrl", "") = 1 Then
		GUICtrlSetState($g_radShortcutCtrl, $GUI_CHECKED)
	ElseIf IniRead($g_iniConfig, "Main", "ShortCutAlt", "") = 1 Then
		GUICtrlSetState($g_radShortcutAlt, $GUI_CHECKED)
	EndIf
EndFunc   ;==>ReadSettings

Func ADBStart()
	RunWait(@ComSpec & " /c " & "adb start-server", "", @SW_HIDE)
EndFunc   ;==>ADBStart

Func DeviceListGet()
	IniDelete($g_iniConfig, "Devices")
	$g_cmdDeviceListGet = Run(@ComSpec & " /c adb devices", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmdDeviceListGet)
	$g_cmdoutDeviceListGet = StdoutRead($g_cmdDeviceListGet)
	$g_dataDeviceListGet = StringReplace(StringReplace(StringReplace(StringStripWS(StringTrimLeft($g_cmdoutDeviceListGet, 26), $STR_STRIPTRAILING), @CR, ""), "	device", " USB ="), ":5555 USB =", ":5555 Wireless =")
	If $g_dataDeviceListGet = "" Then
		IniWriteSection($g_iniConfig, "Devices", "NO USB =")
	Else
		IniWriteSection($g_iniConfig, "Devices", $g_dataDeviceListGet)
	EndIf
	_GUICtrlListView_DeleteAllItems($g_lvwDeviceList)
EndFunc   ;==>DeviceListGet

Func DeviceListSet()
	$g_iniDevices = IniReadSection($g_iniConfig, "Devices")
	ConsoleWrite(@ScriptLineNumber & ': ' & $g_iniDevices & @CRLF)
	_GUICtrlListView_BeginUpdate($g_lvwDeviceList)
	For $i = 1 To $g_iniDevices[0][0]
		_GUICtrlListView_AddItem($g_lvwDeviceList, $i)
		$g_arrayDevices = StringSplit($g_iniDevices[$i][0], " ", 1)
		_GUICtrlListView_AddSubItem($g_lvwDeviceList, $i - 1, $g_arrayDevices[1], 1)
		_GUICtrlListView_AddSubItem($g_lvwDeviceList, $i - 1, $g_arrayDevices[2], 2)
	Next
	_GUICtrlListView_EndUpdate($g_lvwDeviceList)
EndFunc   ;==>DeviceListSet

Func ADBStop()
	RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
EndFunc   ;==>ADBStop

Func GetIP()
	$g_txtIP_4 = "FOR /F ""tokens=2"" %%G IN ('adb -s " & $g_dataSerial_1 & " shell ip addr show wlan0 ^|find ""inet ""') DO set ipfull=%%G"
	_FileWriteToLine(@ScriptDir & "\Core\ip.bat", 1, $g_txtIP_1, True, True)
	$g_cmdGetIP = RunWait(@ComSpec & " /c " & @ScriptDir & "\Core\ip.bat", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($g_cmdGetIP)
	$g_cmdoutGetIP = StringStripWS(_ClipBoard_GetData(), $STR_STRIPTRAILING)
	_GUICtrlIpAddress_Set($g_inputIPAddress, $g_cmdoutGetIP)
	_SaveIni("WiFiAddress", $g_cmdoutGetIP)
	_ClipBoard_Open($g_guiMain)
	_ClipBoard_Empty()
	_ClipBoard_Close()
EndFunc   ;==>GetIP

Func GoWireless()
	If _GUICtrlIpAddress_IsBlank($g_inputIPAddress) Then
		MsgBox($MB_SYSTEMMODAL, "", "Enter IP Address.")
		_GUICtrlIpAddress_SetFocus($g_inputIPAddress, 0)
	Else
		RunWait(@ComSpec & " /c " & "adb connect " & _GUICtrlIpAddress_Get($g_inputIPAddress), "", @SW_HIDE)
	EndIf
EndFunc   ;==>GoWireless

Func DeviceDetails()
	If $g_dataSerial_1 = "No" Then
		StatusBarWrite("No device found")
	Else
		ParameterClick()
		StatusBarWrite("Selected device: " & $g_dataSerial_1)

		$g_cmdDeviceTitle = Run(@ComSpec & " /c adb -s " & $g_dataSerial_1 & " shell dumpsys user", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmdDeviceTitle)
		$g_cmdoutDeviceTitle = StdoutRead($g_cmdDeviceTitle)
		$g_regexDeviceTitle = StringRegExp($g_cmdoutDeviceTitle, "{[0-9]+:(.*):[0-9]+}", 3)
		$g_dataDeviceTitle = $g_regexDeviceTitle[0]
		GUICtrlSetData($g_dataTitle, $g_dataDeviceTitle)

		$g_cmdDeviceAccount = Run(@ComSpec & " /c adb -s " & $g_dataSerial_1 & " shell dumpsys account", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmdDeviceAccount)
		$g_cmdoutDeviceAccount = StdoutRead($g_cmdDeviceAccount)
		$g_regexDeviceAccount = StringRegExp($g_cmdoutDeviceAccount, "{name=(.*), type=com.google}", 3)
		For $x = 0 To UBound($g_regexDeviceAccount) - 1
			$g_regexDeviceAccount[$x] = $g_regexDeviceAccount[$x]
		Next
		$g_dataDeviceAccount = _ArrayToString($g_regexDeviceAccount, ", ")
		GUICtrlSetData($g_dataAccount, $g_dataDeviceAccount)

		$g_cmdDeviceModel = Run(@ComSpec & " /c adb -s " & $g_dataSerial_1 & " shell getprop ro.product.model", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmdDeviceModel)
		$g_dataDeviceModel = StringStripWS(StdoutRead($g_cmdDeviceModel), 8)
		GUICtrlSetData($g_dataModel, $g_dataDeviceModel)

		$g_cmdDeviceSerial = Run(@ComSpec & " /c adb -s " & $g_dataSerial_1 & " shell getprop ro.serialno", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmdDeviceSerial)
		$g_dataDeviceSerial = StringStripWS(StdoutRead($g_cmdDeviceSerial), 8)
		GUICtrlSetData($g_dataSerial_2, $g_dataDeviceSerial)

		$g_cmdDeviceBattery = Run(@ComSpec & " /c adb -s " & $g_dataSerial_1 & " shell dumpsys battery", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmdDeviceBattery)
		$g_cmdoutDeviceBattery = StdoutRead($g_cmdDeviceBattery)
		$g_regexDeviceBattery = StringRegExp($g_cmdoutDeviceBattery, "level: (.*)", 3)
		$g_dataDeviceBattery = $g_regexDeviceBattery[0]
		$g_regexDeviceBatteryAC = StringRegExp($g_cmdoutDeviceBattery, "AC powered: (.*)", 3)
		$g_dataDeviceBatteryAC = $g_regexDeviceBatteryAC[0]
		$g_regexDeviceBatteryUSB = StringRegExp($g_cmdoutDeviceBattery, "USB powered: (.*)", 3)
		$g_dataDeviceBatteryUSB = $g_regexDeviceBatteryUSB[0]
		If ($g_dataDeviceBatteryAC = "false" And $g_dataDeviceBatteryUSB = "false") Or ($g_dataDeviceBatteryAC = "true" And $g_dataDeviceBatteryUSB = "true") Then
			GUICtrlSetData($g_dataBattery, $g_dataDeviceBattery & "% (Not Charging)")
		ElseIf ($g_dataDeviceBatteryAC = "true") And ($g_dataDeviceBatteryUSB = "false") Then
			GUICtrlSetData($g_dataBattery, $g_dataDeviceBattery & "% (AC Charging)")
		Else
			GUICtrlSetData($g_dataBattery, $g_dataDeviceBattery & "% (USB Charging)")
		EndIf

		$g_cmdDeviceUptime = Run(@ComSpec & " /c adb -s " & $g_dataSerial_1 & " shell uptime", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmdDeviceUptime)
		$g_cmdoutDeviceUptime = StdoutRead($g_cmdDeviceUptime)
		$g_dataDeviceUptime = StringRegExpReplace($g_cmdoutDeviceUptime, "up time: (.*?), (.*?):(.*?):(.*), idle(.*)", "$1 $2 hrs $3 mins", 0)
		GUICtrlSetData($g_dataUptime, $g_dataDeviceUptime)

		GUICtrlSetData($g_dataConnection, $g_dataDeviceConnection)

		$g_cmdDeviceWifi = Run(@ComSpec & " /c adb -s " & $g_dataSerial_1 & " shell dumpsys connectivity", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmdDeviceWifi)
		$g_cmdoutDeviceWifi = StdoutRead($g_cmdDeviceWifi)
		$g_regexDeviceWifi = StringRegExp($g_cmdoutDeviceWifi, 'extra: "(.*)"', 3)
		$g_dataDeviceWifi = $g_regexDeviceWifi[0]
		GUICtrlSetData($g_dataWifi, $g_dataDeviceWifi)

		$g_cmdDeviceIP = Run(@ComSpec & " /c adb -s " & $g_dataSerial_1 & " shell getprop dhcp.wlan0.ipaddress", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($g_cmdDeviceIP)
		$g_dataDeviceIP = StringStripWS(StdoutRead($g_cmdDeviceIP), 8)
		GUICtrlSetData($g_dataIP, $g_dataDeviceIP)
	EndIf
EndFunc   ;==>DeviceDetails

Func ParameterUpdate()
	If _IsChecked($g_radResolutionAuto) Then
		$g_dataResolution = ""
		_SaveIni("ResolutionAuto", GUICtrlRead($g_radResolutionAuto))
		_SaveIni("ResolutionMax", GUICtrlRead($g_radResolutionMax))
	ElseIf _IsChecked($g_radResolutionMax) Then
		$g_dataResolution = " --window-height=" & _GetworkingAreaHeight()
		_SaveIni("ResolutionAuto", GUICtrlRead($g_radResolutionAuto))
		_SaveIni("ResolutionMax", GUICtrlRead($g_radResolutionMax))
	EndIf
	If _IsChecked($g_chkFullScreen) Then
		$g_dataFullScreen = " -f"
		_SaveIni("FullScreen", GUICtrlRead($g_chkFullScreen))
	Else
		$g_dataFullScreen = ""
		_SaveIni("FullScreen", GUICtrlRead($g_chkFullScreen))
	EndIf
	If _IsChecked($g_chkPowerOffOnExit) Then
		$g_dataPowerOffOnExit = " --power-off-on-close"
		_SaveIni("PowerOffOnExit", GUICtrlRead($g_chkPowerOffOnExit))
	Else
		$g_dataPowerOffOnExit = ""
		_SaveIni("PowerOffOnExit", GUICtrlRead($g_chkPowerOffOnExit))
	EndIf
	If _IsChecked($g_chkAlwaysOnTop) Then
		$g_dataAlwaysOnTop = " --always-on-top"
		_SaveIni("AlwaysOnTop", GUICtrlRead($g_chkAlwaysOnTop))
	Else
		$g_dataAlwaysOnTop = ""
		_SaveIni("AlwaysOnTop", GUICtrlRead($g_chkAlwaysOnTop))
	EndIf
	If _IsChecked($g_chkViewOnlyMode) Then
		$g_dataViewOnlyMode = " -n"
		_SaveIni("ViewOnlyMode", GUICtrlRead($g_chkViewOnlyMode))
	Else
		$g_dataViewOnlyMode = ""
		_SaveIni("ViewOnlyMode", GUICtrlRead($g_chkViewOnlyMode))
	EndIf
	If _IsChecked($g_chkShowTouch) Then
		$g_dataShowTouch = " -t"
		_SaveIni("ShowTouch", GUICtrlRead($g_chkShowTouch))
	Else
		$g_dataShowTouch = ""
		_SaveIni("ShowTouch", GUICtrlRead($g_chkShowTouch))
	EndIf
	If _IsChecked($g_chkNoScreenSaver) Then
		$g_dataNoScreenSaver = " --disable-screensaver"
		_SaveIni("NoScreenSaver", GUICtrlRead($g_chkNoScreenSaver))
	Else
		$g_dataNoScreenSaver = ""
		_SaveIni("NoScreenSaver", GUICtrlRead($g_chkNoScreenSaver))
	EndIf
	If _IsChecked($g_chkTurnOffTheScreen) Then
		$g_dataTurnOffTheScreen = " -S"
		_SaveIni("TurnOffTheScreen", GUICtrlRead($g_chkTurnOffTheScreen))
	Else
		$g_dataTurnOffTheScreen = ""
		_SaveIni("TurnOffTheScreen", GUICtrlRead($g_chkTurnOffTheScreen))
	EndIf
	If _IsChecked($g_chkStayAwake) Then
		$g_dataStayAwake = " -w"
		_SaveIni("StayAwake", GUICtrlRead($g_chkStayAwake))
	Else
		$g_dataStayAwake = ""
		_SaveIni("StayAwake", GUICtrlRead($g_chkStayAwake))
	EndIf
	If _IsChecked($g_chkBorderless) Then
		$g_dataBorderless = " --window-borderless"
		_SaveIni("Borderless", GUICtrlRead($g_chkBorderless))
	Else
		$g_dataBorderless = ""
		_SaveIni("Borderless", GUICtrlRead($g_chkBorderless))
	EndIf
	If _IsChecked($g_radShortcutCtrl) Then
		$g_dataShortcut = " --shortcut-mod=""lctrl,rctrl"""
		$g_keyShortcut = "^"
		_SaveIni("ShortCutCtrl", GUICtrlRead($g_radShortcutCtrl))
		_SaveIni("ShortCutAlt", GUICtrlRead($g_radShortcutAlt))
	ElseIf _IsChecked($g_radShortcutAlt) Then
		$g_dataShortcut = " --shortcut-mod=""lalt,ralt"""
		$g_keyShortcut = "!"
		_SaveIni("ShortCutCtrl", GUICtrlRead($g_radShortcutCtrl))
		_SaveIni("ShortCutAlt", GUICtrlRead($g_radShortcutAlt))
	EndIf
EndFunc   ;==>ParameterUpdate

Func Parameters()
	$g_iniScrcpyCommand = " -s " & $g_dataSerial_1 & $g_dataResolution & $g_dataShortcut & $g_dataFullScreen & $g_dataPowerOffOnExit & $g_dataAlwaysOnTop & $g_dataViewOnlyMode & $g_dataShowTouch & $g_dataNoScreenSaver & $g_dataTurnOffTheScreen & $g_dataStayAwake & $g_dataBorderless
	_SaveIni("FinalParameter", $g_iniScrcpyCommand)
	GUICtrlSetData($g_lblParameter, $g_iniScrcpyCommand)
EndFunc   ;==>Parameters

Func ScrcpyOn()
	GUICtrlSetState($g_btnOn, $GUI_DISABLE)
	GUISetState(@SW_HIDE, $g_guiMain)
EndFunc   ;==>ScrcpyOn

Func ScrcpyRun()
	Run(@ComSpec & " /c " & "scrcpy" & $g_iniScrcpyCommand, "", @SW_HIDE)
EndFunc   ;==>ScrcpyRun

Func GUIChild()
	$g_guiChild = GUICreate("Scrcpy Control", 255, 285, 1, -1, BitOR($WS_POPUP, $WS_CAPTION))
	GUISetOnEvent($GUI_EVENT_CLOSE, "GUIChildClose")
	$g_groupSelectedDevice = GUICtrlCreateGroup("Selected Device", 5, 5, 245, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_lblSelectedDevice_1 = GUICtrlCreateLabel("", 10, 20, 235, 18, $SS_CENTER)
	GUICtrlSetFont(-1, $g_FontSize, $g_FontBold, 0, $g_FontName, 5)
	$g_lblSelectedDevice_2 = GUICtrlCreateLabel("", 10, 38, 235, 17, $SS_CENTER)
	GUICtrlSetData($g_lblSelectedDevice_1, $g_dataDeviceTitle & "'s Phone")
	GUICtrlSetData($g_lblSelectedDevice_2, "(" & $g_dataSerial_1 & ")")
	GUICtrlSetFont(-1, $g_FontSize, $g_FontBold, 0, $g_FontName, 5)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$g_groupTouch = GUICtrlCreateGroup("Scrcpy Control", 5, 65, 245, 215, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$g_btnVolumeUP = GUICtrlCreateButton("Volume +", 50, 80, 75, 35)
	GUICtrlSetOnEvent(-1, "VolumeUPClick")
	$g_btnVolumeDown = GUICtrlCreateButton("Volume -", 130, 80, 75, 35)
	GUICtrlSetOnEvent(-1, "VolumeDownClick")
	$g_btnScreenOn = GUICtrlCreateButton("Screen On", 50, 120, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "ScreenOnClick")
	$g_btnScreenOff = GUICtrlCreateButton("Screen Off", 130, 120, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "ScreenOffClick")
	$g_btnNotificationOn = GUICtrlCreateButton("Notification On", 50, 160, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "NotificationOnClick")
	$g_btnNotificationOff = GUICtrlCreateButton("Notification Off", 130, 160, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "NotificationOffClick")
	$g_btnMenu = GUICtrlCreateButton("Menu", 50, 200, 75, 35)
	GUICtrlSetOnEvent(-1, "MenuClick")
	$g_btnPower = GUICtrlCreateButton("Power", 130, 200, 75, 35)
	GUICtrlSetOnEvent(-1, "PowerClick")
	$g_btnBack = GUICtrlCreateButton("<", 10, 240, 75, 35)
	GUICtrlSetOnEvent(-1, "BackClick")
	$g_btnHome = GUICtrlCreateButton("?", 90, 240, 75, 35)
	GUICtrlSetOnEvent(-1, "HomeClick")
	$g_btnSwitch = GUICtrlCreateButton("=", 170, 240, 75, 35)
	GUICtrlSetOnEvent(-1, "SwitchClick")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUISetState(@SW_SHOW, $g_guiChild)
EndFunc   ;==>GUIChild

Func VolumeUPClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_keyShortcut & "{UP}")
	EndIf
EndFunc   ;==>VolumeUPClick

Func ScreenOnClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_keyShortcut & "+o")
	EndIf
EndFunc   ;==>ScreenOnClick

Func NotificationOnClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_keyShortcut & "n")
	EndIf
EndFunc   ;==>NotificationOnClick

Func MenuClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_keyShortcut & "m")
	EndIf
EndFunc   ;==>MenuClick

Func VolumeDownClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_keyShortcut & "{DOWN}")
	EndIf
EndFunc   ;==>VolumeDownClick

Func ScreenOffClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_keyShortcut & "o")
	EndIf
EndFunc   ;==>ScreenOffClick

Func NotificationOffClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_keyShortcut & "+n")
	EndIf
EndFunc   ;==>NotificationOffClick

Func PowerClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_keyShortcut & "p")
	EndIf
EndFunc   ;==>PowerClick

Func BackClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_keyShortcut & "b")
	EndIf
EndFunc   ;==>BackClick

Func HomeClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_keyShortcut & "h")
	EndIf
EndFunc   ;==>HomeClick

Func SwitchClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($g_keyShortcut & "s")
	EndIf
EndFunc   ;==>SwitchClick

Func GUIChildClose()
	If WinExists("[CLASS:SDL_app]", "") Then
		WinClose("[CLASS:SDL_app]", "")
		GUIDelete($g_guiChild)
		GUISetState(@SW_SHOW, $g_guiMain)
		StatusBarWrite("Selected device: " & $g_dataSerial_1)
		GUICtrlSetState($g_btnOn, $GUI_ENABLE)
	Else
		GUIDelete($g_guiChild)
		GUISetState(@SW_SHOW, $g_guiMain)
		StatusBarWrite("Selected device: " & $g_dataSerial_1)
		GUICtrlSetState($g_btnOn, $GUI_ENABLE)
	EndIf
EndFunc   ;==>GUIChildClose

Func GUIMainClose()
	ADBStop()
	_SaveIni("Serial", "")
	Exit
EndFunc   ;==>GUIMainClose

;==>Supporting Function<==;

Func _SaveIni($_sKey, $_sValue)
	Local $sSection = "Main"
	Local $sIniRead = IniRead($g_iniConfig, $sSection, $_sKey, "")
	If $sIniRead = $_sValue Then Return
	IniWrite($g_iniConfig, $sSection, $_sKey, $_sValue)
EndFunc   ;==>_SaveIni

Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

Func StatusBarWrite($sMessage = "")
	_GUICtrlStatusBar_SetText($g_Status, $sMessage)
EndFunc   ;==>StatusBarWrite

Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
	Local $hListView, $tNMHDR, $hWndFrom, $iCode
	$hListView = $g_lvwDeviceList
	If Not IsHWnd($hListView) Then $hListView = GUICtrlGetHandle($g_lvwDeviceList)
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
						$g_dataSerial_1 = _GUICtrlListView_GetItemText($g_lvwDeviceList, $iItem, 1)
						$g_dataDeviceConnection = _GUICtrlListView_GetItemText($g_lvwDeviceList, $iItem, 2)
						_SaveIni("Serial", $g_dataSerial_1)
						DeviceDetails()
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