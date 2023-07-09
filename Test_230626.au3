;==>"Made with️ ❤ in Bangladesh"

Opt("GUIOnEventMode", 1)
Opt("GUICoordMode", 1)
Opt("GUICloseOnESC", 1)
Opt("MustDeclareVars", 1)

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

Global $adbdevices, $ADBOutput1, $ADBOutput2, $AlwaysOnTopP, $AlwaysOnTopV, $AlwaysOnTop_Check, $BatFile, $BatTxt1, $BatTxt2, $BatTxt3, $BorderlessP, $BorderlessV, $Borderless_Check, $DetailsGroup, $DeviceList, $DeviceListGroup, $DeviceManufacturer, $DeviceManufacturerCommand, $DeviceModel, $DeviceModelCommand, $Device_Manager_Tab, $FinalParam, $FullScreenP, $FullScreenV, $FullScreen_Check, $GetIP_Button, $GoWireless_Button, $mGUI, $cGUI, $ini, $IPAddress, $ipBat, $ModelName_Label, $NoScreenSaverP, $NoScreenSaverV, $NoScreenSaver_Check, $On_Button, $OptionsGroup, $Parameter, $ParameterGroup, $PowerOffOnExitP, $PowerOffOnExitV, $PowerOffOnExit_Check, $Refresh_Button, $Reset_Button, $ResolutionGroup, $ResolutionA_Radio, $ResolutionM_Radio, $ResolutionP, $Scrcpy_Tab, $SelectedDeviceGroupScrcpy, $SelectedDeviceGroupViewer, $SelectedDeviceScrcpyValue, $SelectedDeviceViewerValue, $SelectedTab, $SerialValue, $ShortCutA_Radio, $ShortCutC_Radio, $ShortCutKey, $ShortCutP, $ShowTouchP, $ShowTouchV, $ShowTouch_Check, $ShortCutGroup, $StatusBar, $StayAwakeP, $StayAwakeV, $StayAwake_Check, $Tab, $TurnOffTheScreenP, $TurnOffTheScreenV, $TurnOffTheScreen_Check, $Viewer_Tab, $ViewOnlyModeP, $ViewOnlyModeV, $ViewOnlyMode_Check, $WiFiAddressV, $WirlessGroup, $TouchGroup, $VolumeUP_Button, $VolumeDown_Button, $NotificationOn_Button, $NotificationOff_Button, $ScreenOn_Button, $ScreenOff_Button, $Menu_Button, $Power_Button, $Back_Button, $Home_Button, $Switch_Button, $SelectedDeviceGroupControl, $SelectedDeviceControlValue, $Slogan, $Title_Label_1, $Title_Label_2, $Account_Label_1, $Account_Label_2, $Model_Label_1, $Model_Label_2, $Serial_Label_1, $Serial_Label_2, $Wifi_Label_1, $Wifi_Label_2, $IP_Label_1, $IP_Label_2, $Connection_Label_1, $Connection_Label_2, $Battery_Label_1, $Battey_Label_2, $Uptime_Label_1, $Uptime_Label_2
Global $ini = @ScriptDir & "\Core\Config.ini"
Global $sFontName = "Baloo Da 2"
Global $sFontSize = 10
Global $sFontBold = 700

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
	$BatFile = @ScriptDir & "\Core\ip.bat"
	$BatTxt1 = "FOR /F ""tokens=2"" %%G IN ('adb -s " & $SerialValue & " shell ip addr show wlan0 ^|find ""inet ""') DO set ipfull=%%G"
	$BatTxt2 = "FOR /F ""tokens=1 delims=/"" %%G in (""%ipfull%"") DO set ip=%%G"
	$BatTxt3 = "echo %ip%|clip"
	If Not FileExists($BatFile) Then
		_FileCreate($BatFile)
		_FileWriteToLine($BatFile, 1, $BatTxt1, True, True)
		_FileWriteToLine($BatFile, 2, $BatTxt2, True, True)
		_FileWriteToLine($BatFile, 3, $BatTxt3, True, True)
	EndIf
EndFunc   ;==>StartupCheck

Func GUIMain()
	$mGUI = GUICreate("Droid Control", 400, 595, -1, -1, BitOR($WS_POPUP, $WS_CAPTION))
	GUISetOnEvent($GUI_EVENT_CLOSE, "GUIMainClose")
	$DeviceListGroup = GUICtrlCreateGroup("Device List", 5, 5, 390, 120, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$DeviceList = _GUICtrlListView_Create($mGUI, "#|Device|Connection", 10, 20, 305, 100)
	_GUICtrlListView_SetExtendedListViewStyle($DeviceList, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
	_GUICtrlListView_SetColumnWidth($DeviceList, 0, 50)
	_GUICtrlListView_SetColumnWidth($DeviceList, 1, 175)
	_GUICtrlListView_SetColumnWidth($DeviceList, 2, 80)
	_GUICtrlListView_JustifyColumn($DeviceList, 0, 2)
	_GUICtrlListView_JustifyColumn($DeviceList, 1, 2)
	_GUICtrlListView_JustifyColumn($DeviceList, 2, 2)
	$Refresh_Button = GUICtrlCreateButton("Refresh", 320, 20, 70, 48)
	GUICtrlSetOnEvent(-1, "RefreshClick")
	GUICtrlSetTip(-1, "Click to refresh device list.")
	$Reset_Button = GUICtrlCreateButton("Reset", 320, 73, 70, 47)
	GUICtrlSetOnEvent(-1, "ResetClick")
	GUICtrlSetTip(-1, "Click to reset device list.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$WirlessGroup = GUICtrlCreateGroup("Wireless", 5, 130, 390, 40, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$GetIP_Button = GUICtrlCreateButton("Get IP", 10, 145, 70, 20)
	GUICtrlSetOnEvent(-1, "GetIPClick")
	GUICtrlSetTip(-1, "Get IP from usb device.")
	$IPAddress = _GUICtrlIpAddress_Create($mGUI, 115, 145, 170, 20)
	_GUICtrlIpAddress_Set($IPAddress, $WiFiAddressV)
	$GoWireless_Button = GUICtrlCreateButton("Connect", 320, 145, 70, 20)
	GUICtrlSetOnEvent(-1, "GoWirelessClick")
	GUICtrlSetTip(-1, "Click to connect with IP.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$DetailsGroup = GUICtrlCreateGroup("Details", 5, 175, 390, 120, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$Title_Label_1 = GUICtrlCreateLabel("User: ", 10, 190, 100, 12)
	$Title_Label_2 = GUICtrlCreateLabel("", 100, 190, 200, 12)
	;GUICtrlSetFont(-1, $sFontSize, $sFontBold, 0, $sFontName, 5)
	$Account_Label_1 = GUICtrlCreateLabel("Account:", 10, 205, 100, 12)
	$Account_Label_2 = GUICtrlCreateLabel("", 100, 205, 200, 12)
	$Model_Label_1 = GUICtrlCreateLabel("Model:", 10, 220, 100, 12)
	$Model_Label_2 = GUICtrlCreateLabel("", 100, 220, 200, 12)
	$Serial_Label_1 = GUICtrlCreateLabel("Serial:", 10, 235, 100, 12)
	$Serial_Label_2 = GUICtrlCreateLabel("", 100, 235, 200, 12)
	$Wifi_Label_1 = GUICtrlCreateLabel("Wireless Network:", 10, 250, 100, 12)
	$Wifi_Label_2 = GUICtrlCreateLabel("", 100, 250, 200, 12)
	$IP_Label_1 = GUICtrlCreateLabel("IP Address:", 10, 265, 100, 12)
	$IP_Label_2 = GUICtrlCreateLabel("", 100, 265, 200, 12)
	$Connection_Label_1 = GUICtrlCreateLabel("Connected by:", 10, 280, 100, 12)
	$Connection_Label_2 = GUICtrlCreateLabel("", 100, 280, 200, 12)
	$Battery_Label_1 = GUICtrlCreateLabel("Battery Status:", 10, 295, 100, 12)
	$Battey_Label_2 = GUICtrlCreateLabel("", 100, 295, 200, 12)
	$Uptime_Label_1 = GUICtrlCreateLabel("Up Time:", 10, 310, 100, 12)
	$Uptime_Label_2 = GUICtrlCreateLabel("", 100, 310, 200, 12)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$OptionsGroup = GUICtrlCreateGroup("Options", 5, 300, 315, 190, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$FullScreen_Check = GUICtrlCreateCheckbox("Full Screen", 10, 315, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Start in fullscreen.")
	$PowerOffOnExit_Check = GUICtrlCreateCheckbox("Power Off On Exit", 112, 315, 96, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Turn the device screen off when closing scrcpy.")
	$AlwaysOnTop_Check = GUICtrlCreateCheckbox("Always On Top", 213, 315, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Make scrcpy window always on top (above other windows).")
	$ViewOnlyMode_Check = GUICtrlCreateCheckbox("View Only Mode", 10, 350, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Disable device control (mirror the device in read-only).")
	$ShowTouch_Check = GUICtrlCreateCheckbox("Show Touch", 112, 350, 96, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Enable 'show touches' on start, restore the initial value on exit.")
	$NoScreenSaver_Check = GUICtrlCreateCheckbox("No ScreenSaver", 213, 350, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Disable screensaver while scrcpy is running.")
	$TurnOffTheScreen_Check = GUICtrlCreateCheckbox("Turn Off The Screen", 10, 385, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Turn the device screen off immediately.")
	$StayAwake_Check = GUICtrlCreateCheckbox("Stay Awake", 112, 385, 96, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Keep the device on while scrcpy is running.")
	$Borderless_Check = GUICtrlCreateCheckbox("Borderless", 213, 385, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Disable window decorations (display borderless window).")
	$Slogan = GUICtrlCreateLabel("Made with️ ❤ in Bangladesh", 10, 460, 290, 30, $SS_CENTER)
	GUICtrlSetFont(-1, $sFontSize, $sFontBold, 0, $sFontName, 5)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$ResolutionGroup = GUICtrlCreateGroup("Resolution", 325, 300, 70, 65, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$ResolutionA_Radio = GUICtrlCreateRadio("Auto", 330, 315, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Set window height automatic.")
	$ResolutionM_Radio = GUICtrlCreateRadio("Max", 330, 340, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Set window height maximum.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$ShortCutGroup = GUICtrlCreateGroup("ShortCut", 325, 370, 70, 65, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$ShortCutC_Radio = GUICtrlCreateRadio("Ctrl", 330, 385, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Set 'Ctrl' as shortcut key.")
	$ShortCutA_Radio = GUICtrlCreateRadio("Alt", 330, 410, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlSetTip(-1, "Set 'Alt' as shortcut key.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$On_Button = GUICtrlCreateButton("On", 325, 440, 70, 50)
	GUICtrlSetOnEvent(-1, "OnClick")
	GUICtrlSetTip(-1, "Click to start SCRCPY.")

	$ParameterGroup = GUICtrlCreateGroup("Parameter", 5, 495, 390, 70, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$Parameter = GUICtrlCreateLabel($FinalParam, 10, 510, 380, 50, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$StatusBar = _GUICtrlStatusBar_Create($mGUI)
	_GUICtrlStatusBar_SetMinHeight($StatusBar, 25)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	GUISetState(@SW_SHOWNORMAL)
EndFunc   ;==>GUIMain

Func ReadSettings()
	$AlwaysOnTopV = IniRead($ini, "Main", "AlwaysOnTop", 4)
	GUICtrlSetState($AlwaysOnTop_Check, $AlwaysOnTopV)
	$BorderlessV = IniRead($ini, "Main", "Borderless", 4)
	GUICtrlSetState($Borderless_Check, $BorderlessV)
	$FinalParam = IniRead($ini, "Main", "FinalParameter", "")
	GUICtrlSetData($Parameter, $FinalParam)
	$FullScreenV = IniRead($ini, "Main", "FullScreen", 4)
	GUICtrlSetState($FullScreen_Check, $FullScreenV)
	$NoScreenSaverV = IniRead($ini, "Main", "NoScreenSaver", 4)
	GUICtrlSetState($NoScreenSaver_Check, $NoScreenSaverV)
	$PowerOffOnExitV = IniRead($ini, "Main", "PowerOffOnExit", 1)
	GUICtrlSetState($PowerOffOnExit_Check, $PowerOffOnExitV)
	$ShowTouchV = IniRead($ini, "Main", "ShowTouch", 4)
	GUICtrlSetState($ShowTouch_Check, $ShowTouchV)
	$StayAwakeV = IniRead($ini, "Main", "StayAwake", 4)
	GUICtrlSetState($StayAwake_Check, $StayAwakeV)
	$TurnOffTheScreenV = IniRead($ini, "Main", "TurnOffTheScreen", 1)
	GUICtrlSetState($TurnOffTheScreen_Check, $TurnOffTheScreenV)
	$ViewOnlyModeV = IniRead($ini, "Main", "ViewOnlyMode", 4)
	GUICtrlSetState($ViewOnlyMode_Check, $ViewOnlyModeV)
	$WiFiAddressV = IniRead($ini, "Main", "WiFiAddress", "192.168.1.2")
	_GUICtrlIpAddress_Set($IPAddress, $WiFiAddressV)

	If IniRead($ini, "Main", "ResolutionAuto", "") = 1 Then
		GUICtrlSetState($ResolutionA_Radio, $GUI_CHECKED)
	ElseIf IniRead($ini, "Main", "ResolutionMax", "") = 1 Then
		GUICtrlSetState($ResolutionM_Radio, $GUI_CHECKED)
	EndIf

	If IniRead($ini, "Main", "ShortCutCtrl", "") = 1 Then
		GUICtrlSetState($ShortCutC_Radio, $GUI_CHECKED)
	ElseIf IniRead($ini, "Main", "ShortCutAlt", "") = 1 Then
		GUICtrlSetState($ShortCutA_Radio, $GUI_CHECKED)
	EndIf
EndFunc   ;==>ReadSettings

Func ADBStart()
	RunWait(@ComSpec & " /c " & "adb start-server", "", @SW_HIDE)
EndFunc   ;==>ADBStart

Func DeviceListGet()
	IniDelete($ini, "Devices")
	Local $iPID1 = Run(@ComSpec & " /c adb devices", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($iPID1)
	$adbdevices = StdoutRead($iPID1)
	$ADBOutput1 = StringReplace(StringReplace(StringStripWS(StringTrimLeft($adbdevices, 26), $STR_STRIPTRAILING), @CR, ""), "	device", " USB =")
	$ADBOutput2 = StringReplace($ADBOutput1, ":5555 USB =", ":5555 Wireless =")
	If $ADBOutput2 = "" Then
		IniWriteSection($ini, "Devices", "NO USB =")
	Else
		IniWriteSection($ini, "Devices", $ADBOutput2)
	EndIf
	_GUICtrlListView_DeleteAllItems($DeviceList)
EndFunc   ;==>DeviceListGet

Func DeviceListSet()
	Local $aList = IniReadSection($ini, "Devices")
	ConsoleWrite(@ScriptLineNumber & ': ' & $aList & @CRLF)
	_GUICtrlListView_BeginUpdate($DeviceList)
	For $i = 1 To $aList[0][0]
		_GUICtrlListView_AddItem($DeviceList, $i)
		Local $aStr = StringSplit($aList[$i][0], " ", 1)
		_GUICtrlListView_AddSubItem($DeviceList, $i - 1, $aStr[1], 1)
		_GUICtrlListView_AddSubItem($DeviceList, $i - 1, $aStr[2], 2)
	Next
	_GUICtrlListView_EndUpdate($DeviceList)
EndFunc   ;==>DeviceListSet

Func ADBStop()
	RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
EndFunc   ;==>ADBStop

Func GetIP()
	$BatTxt1 = "FOR /F ""tokens=2"" %%G IN ('adb -s " & $SerialValue & " shell ip addr show wlan0 ^|find ""inet ""') DO set ipfull=%%G"
	_FileWriteToLine(@ScriptDir & "\Core\ip.bat", 1, $BatTxt1, True, True)
	Local $iPID2 = RunWait(@ComSpec & " /c " & @ScriptDir & "\Core\ip.bat", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($iPID2)
	$ipBat = StringStripWS(_ClipBoard_GetData(), $STR_STRIPTRAILING)
	_GUICtrlIpAddress_Set($IPAddress, $ipBat)
	_SaveIni("WiFiAddress", $ipBat)
	_ClipBoard_Open($mGUI)
	_ClipBoard_Empty()
	_ClipBoard_Close()
EndFunc   ;==>GetIP

Func GoWireless()
	If _GUICtrlIpAddress_IsBlank($IPAddress) Then
		MsgBox($MB_SYSTEMMODAL, "", "Enter IP Address.")
		_GUICtrlIpAddress_SetFocus($IPAddress, 0)
	Else
		RunWait(@ComSpec & " /c " & "adb connect " & _GUICtrlIpAddress_Get($IPAddress), "", @SW_HIDE)
	EndIf
EndFunc   ;==>GoWireless

Func DeviceDetails()
	If $SerialValue = "No" Then
		StatusBarWrite("No device found")
	Else
		ParameterClick()
		StatusBarWrite("Selected device: " & $SerialValue)
		$DeviceManufacturerCommand = Run(@ComSpec & " /c adb -s " & $SerialValue & " shell getprop ro.product.manufacturer", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($DeviceManufacturerCommand)
		Global $DeviceManufacturer = StringStripWS(StringUpper(StdoutRead($DeviceManufacturerCommand)), 8)
		$DeviceModelCommand = Run(@ComSpec & " /c adb -s " & $SerialValue & " shell getprop ro.product.model", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($DeviceModelCommand)
		Global $DeviceModel = StringStripWS(StdoutRead($DeviceModelCommand), 8)
		GUICtrlSetData($Title_Label_2, $DeviceManufacturer & " " & $DeviceModel)
		GUICtrlSetData($Account_Label_2, $DeviceManufacturer & " " & $DeviceModel)
		GUICtrlSetData($Model_Label_2, $DeviceManufacturer & " " & $DeviceModel)
		GUICtrlSetData($Serial_Label_2, $DeviceManufacturer & " " & $DeviceModel)
		GUICtrlSetData($Wifi_Label_2, $DeviceManufacturer & " " & $DeviceModel)
		GUICtrlSetData($IP_Label_2, $DeviceManufacturer & " " & $DeviceModel)
		GUICtrlSetData($Connection_Label_2, $DeviceManufacturer & " " & $DeviceModel)
		GUICtrlSetData($Battey_Label_2, $DeviceManufacturer & " " & $DeviceModel)
		GUICtrlSetData($Uptime_Label_2, $DeviceManufacturer & " " & $DeviceModel)
	EndIf
EndFunc   ;==>DeviceDetails

Func ParameterUpdate()
	If _IsChecked($ResolutionA_Radio) Then
		Global $ResolutionP = ""
		_SaveIni("ResolutionAuto", GUICtrlRead($ResolutionA_Radio))
		_SaveIni("ResolutionMax", GUICtrlRead($ResolutionM_Radio))
	ElseIf _IsChecked($ResolutionM_Radio) Then
		Global $ResolutionP = " --window-height=" & _GetworkingAreaHeight()
		_SaveIni("ResolutionAuto", GUICtrlRead($ResolutionA_Radio))
		_SaveIni("ResolutionMax", GUICtrlRead($ResolutionM_Radio))
	EndIf
	If _IsChecked($FullScreen_Check) Then
		Global $FullScreenP = " -f"
		_SaveIni("FullScreen", GUICtrlRead($FullScreen_Check))
	Else
		Global $FullScreenP = ""
		_SaveIni("FullScreen", GUICtrlRead($FullScreen_Check))
	EndIf
	If _IsChecked($PowerOffOnExit_Check) Then
		Global $PowerOffOnExitP = " --power-off-on-close"
		_SaveIni("PowerOffOnExit", GUICtrlRead($PowerOffOnExit_Check))
	Else
		Global $PowerOffOnExitP = ""
		_SaveIni("PowerOffOnExit", GUICtrlRead($PowerOffOnExit_Check))
	EndIf
	If _IsChecked($AlwaysOnTop_Check) Then
		Global $AlwaysOnTopP = " --always-on-top"
		_SaveIni("AlwaysOnTop", GUICtrlRead($AlwaysOnTop_Check))
	Else
		Global $AlwaysOnTopP = ""
		_SaveIni("AlwaysOnTop", GUICtrlRead($AlwaysOnTop_Check))
	EndIf
	If _IsChecked($ViewOnlyMode_Check) Then
		Global $ViewOnlyModeP = " -n"
		_SaveIni("ViewOnlyMode", GUICtrlRead($ViewOnlyMode_Check))
	Else
		Global $ViewOnlyModeP = ""
		_SaveIni("ViewOnlyMode", GUICtrlRead($ViewOnlyMode_Check))
	EndIf
	If _IsChecked($ShowTouch_Check) Then
		Global $ShowTouchP = " -t"
		_SaveIni("ShowTouch", GUICtrlRead($ShowTouch_Check))
	Else
		Global $ShowTouchP = ""
		_SaveIni("ShowTouch", GUICtrlRead($ShowTouch_Check))
	EndIf
	If _IsChecked($NoScreenSaver_Check) Then
		Global $NoScreenSaverP = " --disable-screensaver"
		_SaveIni("NoScreenSaver", GUICtrlRead($NoScreenSaver_Check))
	Else
		Global $NoScreenSaverP = ""
		_SaveIni("NoScreenSaver", GUICtrlRead($NoScreenSaver_Check))
	EndIf
	If _IsChecked($TurnOffTheScreen_Check) Then
		Global $TurnOffTheScreenP = " -S"
		_SaveIni("TurnOffTheScreen", GUICtrlRead($TurnOffTheScreen_Check))
	Else
		Global $TurnOffTheScreenP = ""
		_SaveIni("TurnOffTheScreen", GUICtrlRead($TurnOffTheScreen_Check))
	EndIf
	If _IsChecked($StayAwake_Check) Then
		Global $StayAwakeP = " -w"
		_SaveIni("StayAwake", GUICtrlRead($StayAwake_Check))
	Else
		Global $StayAwakeP = ""
		_SaveIni("StayAwake", GUICtrlRead($StayAwake_Check))
	EndIf
	If _IsChecked($Borderless_Check) Then
		Global $BorderlessP = " --window-borderless"
		_SaveIni("Borderless", GUICtrlRead($Borderless_Check))
	Else
		Global $BorderlessP = ""
		_SaveIni("Borderless", GUICtrlRead($Borderless_Check))
	EndIf
	If _IsChecked($ShortCutC_Radio) Then
		Global $ShortCutP = " --shortcut-mod=""lctrl,rctrl"""
		Global $ShortCutKey = "^"
		_SaveIni("ShortCutCtrl", GUICtrlRead($ShortCutC_Radio))
		_SaveIni("ShortCutAlt", GUICtrlRead($ShortCutA_Radio))
	ElseIf _IsChecked($ShortCutA_Radio) Then
		Global $ShortCutP = " --shortcut-mod=""lalt,ralt"""
		Global $ShortCutKey = "!"
		_SaveIni("ShortCutCtrl", GUICtrlRead($ShortCutC_Radio))
		_SaveIni("ShortCutAlt", GUICtrlRead($ShortCutA_Radio))
	EndIf
EndFunc   ;==>ParameterUpdate

Func Parameters()
	Global $FinalParam = " -s " & $SerialValue & $ResolutionP & $ShortCutP & $FullScreenP & $PowerOffOnExitP & $AlwaysOnTopP & $ViewOnlyModeP & $ShowTouchP & $NoScreenSaverP & $TurnOffTheScreenP & $StayAwakeP & $BorderlessP
	_SaveIni("FinalParameter", $FinalParam)
	GUICtrlSetData($Parameter, $FinalParam)
EndFunc   ;==>Parameters

Func ScrcpyOn()
	GUICtrlSetState($On_Button, $GUI_DISABLE)
	GUISetState(@SW_HIDE, $mGUI)
EndFunc   ;==>ScrcpyOn

Func ScrcpyRun()
	Run(@ComSpec & " /c " & "scrcpy" & $FinalParam, "", @SW_HIDE)
EndFunc   ;==>ScrcpyRun

Func GUIChild()
	$cGUI = GUICreate("Scrcpy Control", 255, 285, 1, -1, BitOR($WS_POPUP, $WS_CAPTION))
	GUISetOnEvent($GUI_EVENT_CLOSE, "GUIChildClose")
	$SelectedDeviceGroupControl = GUICtrlCreateGroup("Selected Device", 5, 5, 245, 55, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$SelectedDeviceControlValue = GUICtrlCreateLabel("", 10, 20, 235, 35, $SS_CENTER)
	GUICtrlSetData($SelectedDeviceControlValue, $DeviceManufacturer & " " & $DeviceModel & " (" & $SerialValue & ")")
	GUICtrlSetFont(-1, $sFontSize, $sFontBold, 0, $sFontName, 5)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$TouchGroup = GUICtrlCreateGroup("Scrcpy Control", 5, 65, 245, 215, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$VolumeUP_Button = GUICtrlCreateButton("Volume +", 50, 80, 75, 35)
	GUICtrlSetOnEvent(-1, "VolumeUPClick")
	$VolumeDown_Button = GUICtrlCreateButton("Volume -", 130, 80, 75, 35)
	GUICtrlSetOnEvent(-1, "VolumeDownClick")
	$ScreenOn_Button = GUICtrlCreateButton("Screen On", 50, 120, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "ScreenOnClick")
	$ScreenOff_Button = GUICtrlCreateButton("Screen Off", 130, 120, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "ScreenOffClick")
	$NotificationOn_Button = GUICtrlCreateButton("Notification On", 50, 160, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "NotificationOnClick")
	$NotificationOff_Button = GUICtrlCreateButton("Notification Off", 130, 160, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "NotificationOffClick")
	$Menu_Button = GUICtrlCreateButton("Menu", 50, 200, 75, 35)
	GUICtrlSetOnEvent(-1, "MenuClick")
	$Power_Button = GUICtrlCreateButton("Power", 130, 200, 75, 35)
	GUICtrlSetOnEvent(-1, "PowerClick")
	$Back_Button = GUICtrlCreateButton("<", 10, 240, 75, 35)
	GUICtrlSetOnEvent(-1, "BackClick")
	$Home_Button = GUICtrlCreateButton("?", 90, 240, 75, 35)
	GUICtrlSetOnEvent(-1, "HomeClick")
	$Switch_Button = GUICtrlCreateButton("=", 170, 240, 75, 35)
	GUICtrlSetOnEvent(-1, "SwitchClick")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUISetState(@SW_SHOW, $cGUI)
EndFunc   ;==>GUIChild

Func VolumeUPClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "{UP}")
	EndIf
EndFunc   ;==>VolumeUPClick

Func ScreenOnClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "+o")
	EndIf
EndFunc   ;==>ScreenOnClick

Func NotificationOnClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "n")
	EndIf
EndFunc   ;==>NotificationOnClick

Func MenuClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "m")
	EndIf
EndFunc   ;==>MenuClick

Func VolumeDownClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "{DOWN}")
	EndIf
EndFunc   ;==>VolumeDownClick

Func ScreenOffClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "o")
	EndIf
EndFunc   ;==>ScreenOffClick

Func NotificationOffClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "+n")
	EndIf
EndFunc   ;==>NotificationOffClick

Func PowerClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "p")
	EndIf
EndFunc   ;==>PowerClick

Func BackClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "b")
	EndIf
EndFunc   ;==>BackClick

Func HomeClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "h")
	EndIf
EndFunc   ;==>HomeClick

Func SwitchClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "s")
	EndIf
EndFunc   ;==>SwitchClick

Func GUIChildClose()
	If WinExists("[CLASS:SDL_app]", "") Then
		WinClose("[CLASS:SDL_app]", "")
		GUIDelete($cGUI)
		GUISetState(@SW_SHOW, $mGUI)
		StatusBarWrite("Selected device: " & $SerialValue)
		GUICtrlSetState($On_Button, $GUI_ENABLE)
	Else
		GUIDelete($cGUI)
		GUISetState(@SW_SHOW, $mGUI)
		StatusBarWrite("Selected device: " & $SerialValue)
		GUICtrlSetState($On_Button, $GUI_ENABLE)
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
	Local $sIniRead = IniRead($ini, $sSection, $_sKey, "")
	If $sIniRead = $_sValue Then Return
	IniWrite($ini, $sSection, $_sKey, $_sValue)
EndFunc   ;==>_SaveIni

Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

Func StatusBarWrite($sMessage = "")
	_GUICtrlStatusBar_SetText($StatusBar, $sMessage)
EndFunc   ;==>StatusBarWrite

Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
	Local $hListView, $tNMHDR, $hWndFrom, $iCode
	$hListView = $DeviceList
	If Not IsHWnd($hListView) Then $hListView = GUICtrlGetHandle($DeviceList)
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
						$SerialValue = _GUICtrlListView_GetItemText($DeviceList, $iItem, 1)
						_SaveIni("Serial", $SerialValue)
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
