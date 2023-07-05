#include <ButtonConstants.au3>
#include <Clipboard.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <File.au3>
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

Opt("GUIOnEventMode", 1) ;0=disabled, 1=OnEvent mode enabled
Opt("GUICoordMode", 1) ;1=absolute, 0=relative, 2=cell
Opt("GUICloseOnESC", 1) ;1=ESC  closes, 0=ESC won't close
Opt("MustDeclareVars", 1) ;0=disabled, 1=MustDeclareVars mode enabled

Global $adbdevices, $ADBOutput1, $ADBOutput2, $AlwaysOnTopP, $AlwaysOnTopV, $AlwaysOnTop_Check, $BorderlessP, $BorderlessV, $Borderless_Check, $DetailsGroup, $DeviceList, $DeviceListGroup, $DeviceManufacturer, $DeviceManufacturerCommand, $DeviceModel, $DeviceModelCommand, $Device_Manager_Tab, $FinalParam, $FullScreenP, $FullScreenV, $FullScreen_Check, $GetIP_Button, $GoWireless_Button, $mGUI, $cGUI, $ini, $IPAddress, $ipBat, $ModelName_Label, $NoScreenSaverP, $NoScreenSaverV, $NoScreenSaver_Check, $On_Button, $OptionsGroup, $Parameter, $ParameterGroup, $PowerOffOnExitP, $PowerOffOnExitV, $PowerOffOnExit_Check, $Refresh_Button, $Reset_Button, $ResolutionGroup, $ResolutionA_Radio, $ResolutionM_Radio, $ResolutionP, $Scrcpy_Tab, $SelectedDeviceGroupScrcpy, $SelectedDeviceGroupViewer, $SelectedDeviceScrcpyValue, $SelectedDeviceViewerValue, $SelectedTab, $SerialValue, $ShortCutA_Radio, $ShortCutC_Radio, $ShortCutKey, $ShortCutP, $ShowTouchP, $ShowTouchV, $ShowTouch_Check, $ShortCutGroup, $StatusBar, $StayAwakeP, $StayAwakeV, $StayAwake_Check, $Tab, $TurnOffTheScreenP, $TurnOffTheScreenV, $TurnOffTheScreen_Check, $Viewer_Tab, $ViewOnlyModeP, $ViewOnlyModeV, $ViewOnlyMode_Check, $WiFiAddressV, $WirlessGroup, $TouchGroup, $VolumeUP_Button, $VolumeDown_Button, $NotificationOn_Button, $NotificationOff_Button, $ScreenOn_Button, $ScreenOff_Button, $Menu_Button, $Power_Button, $Back_Button, $Home_Button, $Switch_Button, $SelectedDeviceGroupControl, $SelectedDeviceControlValue
Global $ini = "settings.ini"

Call(MainProgram)

Func MainProgram()
	Call(GUIMain)
	Call(ReadSettings)
	Call(ADBStart)
	Call(DeviceListGet)
	Call(DeviceListSet)

	While 1
		Sleep(100)     ; Sleep to reduce CPU usage
	WEnd
EndFunc   ;==>MainProgram

Func RefreshClick()
	Call(DeviceListGet)
	Call(DeviceListSet)
EndFunc   ;==>RefreshClick

Func ResetClick()
	Call(ADBStop)
	Call(ADBStart)
	Call(DeviceListGet)
	Call(DeviceListSet)
EndFunc   ;==>ResetClick

Func GetIPClick()
	Call(GetIP)
	Call(ReadSettings)
EndFunc   ;==>GetIPClick

Func GoWirelessClick()
	Call(GoWireless)
	Call(DeviceListGet)
	Call(DeviceListSet)
EndFunc   ;==>GoWirelessClick

Func ParameterClick()
	Call(ParameterUpdate)
	Call(Parameters)
EndFunc   ;==>ParameterClick

Func OnClick()
	Call(ScrcpyOn)
	Call(GUIChild)
	Call(ScrcpyRun)
EndFunc   ;==>OnClick

Func GUIMain()
	$mGUI = GUICreate("Droid Control", 400, 450, -1, -1, BitOR($WS_POPUP, $WS_CAPTION))
	GUISetOnEvent($GUI_EVENT_CLOSE, "GUIMainClose")
	$Tab = GUICtrlCreateTab(1, 1, 400, 425)
	GUICtrlSetOnEvent(-1, "TabChange")
	$Device_Manager_Tab = GUICtrlCreateTabItem("Device Manager")
	$DeviceListGroup = GUICtrlCreateGroup("Device List", 5, 25, 390, 120, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$DeviceList = _GUICtrlListView_Create($mGUI, "#|Device|Connection", 10, 40, 305, 100)
	_GUICtrlListView_SetExtendedListViewStyle($DeviceList, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
	_GUICtrlListView_SetColumnWidth($DeviceList, 0, 50)
	_GUICtrlListView_SetColumnWidth($DeviceList, 1, 175)
	_GUICtrlListView_SetColumnWidth($DeviceList, 2, 80)
	_GUICtrlListView_JustifyColumn($DeviceList, 0, 2)
	_GUICtrlListView_JustifyColumn($DeviceList, 1, 2)
	_GUICtrlListView_JustifyColumn($DeviceList, 2, 2)
	$Refresh_Button = GUICtrlCreateButton("Refresh", 320, 40, 70, 48)
	GUICtrlSetOnEvent(-1, "RefreshClick")
	$Reset_Button = GUICtrlCreateButton("Reset", 320, 93, 70, 47)
	GUICtrlSetOnEvent(-1, "ResetClick")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$WirlessGroup = GUICtrlCreateGroup("Wireless", 5, 150, 390, 40, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$GetIP_Button = GUICtrlCreateButton("Get IP", 10, 165, 70, 20)
	GUICtrlSetOnEvent(-1, "GetIPClick")
	$IPAddress = _GUICtrlIpAddress_Create($mGUI, 115, 165, 170, 20)
	_GUICtrlIpAddress_Set($IPAddress, $WiFiAddressV)
	$GoWireless_Button = GUICtrlCreateButton("Go Air", 320, 165, 70, 20)
	GUICtrlSetOnEvent(-1, "GoWirelessClick")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$DetailsGroup = GUICtrlCreateGroup("Details", 5, 195, 390, 100, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$ModelName_Label = GUICtrlCreateLabel("", 10, 210, 380, 20, $SS_CENTER)
	GUICtrlSetFont(-1, 10, 700, 0, "")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$Viewer_Tab = GUICtrlCreateTabItem("Viewer")
	$SelectedDeviceGroupViewer = GUICtrlCreateGroup("Selected Device", 5, 25, 390, 40, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$SelectedDeviceViewerValue = GUICtrlCreateLabel("", 10, 40, 380, 20, $SS_CENTER)
	GUICtrlSetFont(-1, 10, 700, 0, "")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$Scrcpy_Tab = GUICtrlCreateTabItem("Scrcpy")
	$SelectedDeviceGroupScrcpy = GUICtrlCreateGroup("Selected Device", 5, 25, 390, 40, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$SelectedDeviceScrcpyValue = GUICtrlCreateLabel("", 10, 40, 380, 20, $SS_CENTER)
	GUICtrlSetFont(-1, 10, 700, 0, "")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$ResolutionGroup = GUICtrlCreateGroup("Resolution", 325, 70, 70, 65, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$ResolutionA_Radio = GUICtrlCreateRadio("Auto", 330, 85, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	$ResolutionM_Radio = GUICtrlCreateRadio("Max", 330, 110, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$ShortCutGroup = GUICtrlCreateGroup("ShortCut", 325, 140, 70, 65, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$ShortCutC_Radio = GUICtrlCreateRadio("Ctrl", 330, 155, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	$ShortCutA_Radio = GUICtrlCreateRadio("Alt", 330, 180, 60, 20, $GUI_SS_DEFAULT_RADIO)
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$OptionsGroup = GUICtrlCreateGroup("Options", 5, 70, 315, 190, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$FullScreen_Check = GUICtrlCreateCheckbox("Full Screen", 10, 85, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	$PowerOffOnExit_Check = GUICtrlCreateCheckbox("Power Off On Exit", 112, 85, 96, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	$AlwaysOnTop_Check = GUICtrlCreateCheckbox("Always On Top", 213, 85, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	$ViewOnlyMode_Check = GUICtrlCreateCheckbox("View Only Mode", 10, 120, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	$ShowTouch_Check = GUICtrlCreateCheckbox("Show Touch", 112, 120, 96, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	$NoScreenSaver_Check = GUICtrlCreateCheckbox("No ScreenSaver", 213, 120, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	$TurnOffTheScreen_Check = GUICtrlCreateCheckbox("Turn Off The Screen", 10, 155, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	$StayAwake_Check = GUICtrlCreateCheckbox("Stay Awake", 112, 155, 96, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	$Borderless_Check = GUICtrlCreateCheckbox("Borderless", 213, 155, 97, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_MULTILINE))
	GUICtrlSetOnEvent(-1, "ParameterClick")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$On_Button = GUICtrlCreateButton("On", 325, 210, 70, 50)
	GUICtrlSetOnEvent(-1, "OnClick")

	$ParameterGroup = GUICtrlCreateGroup("Parameter", 5, 300, 390, 120, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$Parameter = GUICtrlCreateLabel($FinalParam, 10, 315, 380, 100, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateTabItem("")

	$StatusBar = _GUICtrlStatusBar_Create($mGUI)
	_GUICtrlStatusBar_SetMinHeight($StatusBar, 25)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	GUISetState(@SW_SHOWNORMAL)
EndFunc   ;==>GUIMain

Func ReadSettings()
	$AlwaysOnTopV = IniRead($ini, "Main", "AlwaysOnTop", 4)
	GUICtrlSetState($AlwaysOnTop_Check, $AlwaysOnTopV)
	$FullScreenV = IniRead($ini, "Main", "FullScreen", 4)
	GUICtrlSetState($FullScreen_Check, $FullScreenV)
	$BorderlessV = IniRead($ini, "Main", "Borderless", 1)
	GUICtrlSetState($Borderless_Check, $BorderlessV)
	$WiFiAddressV = IniRead($ini, "Main", "WiFiAddress", "192.168.1.2")
	$NoScreenSaverV = IniRead($ini, "Main", "NoScreenSaver", 4)
	GUICtrlSetState($NoScreenSaver_Check, $NoScreenSaverV)
	$PowerOffOnExitV = IniRead($ini, "Main", "PowerOffOnExit", 1)
	GUICtrlSetState($PowerOffOnExit_Check, $PowerOffOnExitV)
	$ViewOnlyModeV = IniRead($ini, "Main", "ViewOnlyMode", 4)
	GUICtrlSetState($ViewOnlyMode_Check, $ViewOnlyModeV)
	$SerialValue = IniRead($ini, "Main", "Serial", "")
	$ShowTouchV = IniRead($ini, "Main", "ShowTouch", 4)
	GUICtrlSetState($ShowTouch_Check, $ShowTouchV)
	$StayAwakeV = IniRead($ini, "Main", "StayAwake", 4)
	GUICtrlSetState($StayAwake_Check, $StayAwakeV)
	$TurnOffTheScreenV = IniRead($ini, "Main", "TurnOffTheScreen", 1)
	GUICtrlSetState($TurnOffTheScreen_Check, $TurnOffTheScreenV)
	$FinalParam = IniRead($ini, "Main", "FinalParameter", "")
	GUICtrlSetData($Parameter, $FinalParam)

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
	StatusBarWrite($ADBOutput2)
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
	Local $ipTxt = "FOR /F ""tokens=2"" %%G IN ('adb -s " & $SerialValue & " shell ip addr show wlan0 ^|find ""inet ""') DO set ipfull=%%G"
	_FileWriteToLine(@ScriptDir & "\Core\ip.bat", 1, $ipTxt, True, True)
	Local $iPID2 = RunWait(@ComSpec & " /c " & @ScriptDir & "\Core\ip.bat", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($iPID2)
	$ipBat = StringStripWS(_ClipBoard_GetData(), $STR_STRIPTRAILING)
	_GUICtrlIpAddress_Set($IPAddress, $ipBat)
	_SaveIni("WiFiAddress", $ipBat)
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
	If Not $SerialValue = "" Then
		Local $DeviceManufacturerCommand = Run(@ComSpec & " /c adb -s " & $SerialValue & " shell getprop ro.product.manufacturer", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($DeviceManufacturerCommand)
		Global $DeviceManufacturer = StringStripWS(StringUpper(StdoutRead($DeviceManufacturerCommand)), 8)
		Local $DeviceModelCommand = Run(@ComSpec & " /c adb -s " & $SerialValue & " shell getprop ro.product.model", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($DeviceModelCommand)
		Global $DeviceModel = StringStripWS(StdoutRead($DeviceModelCommand), 8)
		GUICtrlSetData($ModelName_Label, $DeviceManufacturer & " " & $DeviceModel)
		GUICtrlSetData($SelectedDeviceViewerValue, $DeviceManufacturer & " " & $DeviceModel & " (" & $SerialValue & ")")
		GUICtrlSetData($SelectedDeviceScrcpyValue, $DeviceManufacturer & " " & $DeviceModel & " (" & $SerialValue & ")")
	EndIf
EndFunc   ;==>DeviceDetails

Func TabChange()
	If _GUICtrlTab_GetCurSel($Tab) = 0 Then ; zero based index of current selected TabItem
		WinSetState($DeviceList, "", @SW_SHOW)
		_GUICtrlIpAddress_ShowHide($IPAddress, @SW_SHOW)
		Call(Parameters)
	Else
		WinSetState($DeviceList, "", @SW_HIDE)
		_GUICtrlIpAddress_ShowHide($IPAddress, @SW_HIDE)
		Call(Parameters)
	EndIf
EndFunc   ;==>TabChange

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
	GUICtrlSetFont(-1, 10, 700, 0, "")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$TouchGroup = GUICtrlCreateGroup("Scrcpy Control", 5, 65, 245, 215, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
	$VolumeUP_Button = GUICtrlCreateButton("Volume +", 50, 80, 75, 35)
	GUICtrlSetOnEvent(-1, "VolumeUPClick")
	$VolumeDown_Button = GUICtrlCreateButton("Volume -", 130, 80, 75, 35)
	GUICtrlSetOnEvent(-1, "VolumeDownClick")
	$NotificationOn_Button = GUICtrlCreateButton("Notification On", 50, 120, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "NotificationOnClick")
	$NotificationOff_Button = GUICtrlCreateButton("Notification Off", 130, 120, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "NotificationOffClick")
	$ScreenOn_Button = GUICtrlCreateButton("Screen On", 50, 160, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "ScreenOnClick")
	$ScreenOff_Button = GUICtrlCreateButton("Screen Off", 130, 160, 75, 35, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "ScreenOffClick")
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
		_SaveIni("Serial", "")
		GUIDelete($cGUI)
		GUISetState(@SW_SHOW, $mGUI)
		GUICtrlSetState($On_Button, $GUI_ENABLE)
	Else
		_SaveIni("Serial", "")
		GUIDelete($cGUI)
		GUISetState(@SW_SHOW, $mGUI)
		GUICtrlSetState($On_Button, $GUI_ENABLE)
	EndIf
EndFunc   ;==>GUIChildClose

Func GUIMainClose()
	If WinExists("[CLASS:SDL_app]", "") Then
		WinClose("[CLASS:SDL_app]", "")
		RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
		_SaveIni("Serial", "")
		Exit
	Else
		RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
		_SaveIni("Serial", "")
		Exit
	EndIf
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
						Call(DeviceDetails)
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
;==>"Made with️ ❤ in Bangladesh"
