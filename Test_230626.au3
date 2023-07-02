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

Global $GUI, $WiFiAddressV, $SelectedTab
Global $ini = "settings.ini"
Global $ResolutionV = ""
Global $AlwaysOnTopV = ""
Global $FullScreenV = ""
Global $HideBorderV = ""
Global $WiFiAddressV = ""
Global $NoScreenSaverV = ""
Global $PowerOffOnCloseV = ""
Global $ReadOnlyModeV = ""
Global $SerialV = ""
Global $ShowTouchV = ""
Global $StayAwakeV = ""
Global $TurnOffTheScreenV = ""
Global $Parameter = ""
Global $ipBat = ""

Call(ReadSettings)

#Region ### START Koda GUI section ### Form=
$GUI = GUICreate("Droid Control", 400, 450, 960, -1, BitOR($WS_POPUP, $WS_CAPTION))
GUISetOnEvent($GUI_EVENT_CLOSE, "OffClick")
$Tab = GUICtrlCreateTab(0, 0, 400, 425)
GUICtrlSetOnEvent(-1, "TabChange")
$Device_Manager_Tab = GUICtrlCreateTabItem("Device Manager")
$DeviceListGroup = GUICtrlCreateGroup("Device List", 5, 25, 390, 120, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
$DeviceList = _GUICtrlListView_Create($GUI, "#|Device|Connection", 10, 40, 305, 100)
_GUICtrlListView_SetExtendedListViewStyle($DeviceList, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
_GUICtrlListView_SetColumnWidth($DeviceList, 0, 50)
_GUICtrlListView_SetColumnWidth($DeviceList, 1, 175)
_GUICtrlListView_SetColumnWidth($DeviceList, 2, 80)
_GUICtrlListView_JustifyColumn($DeviceList, 0, 2)
_GUICtrlListView_JustifyColumn($DeviceList, 1, 2)
_GUICtrlListView_JustifyColumn($DeviceList, 2, 2)
GUICtrlSetTip($DeviceList, "Select device from list")
$Refresh_Button = GUICtrlCreateButton("Refresh", 320, 40, 70, 48)
GUICtrlSetOnEvent(-1, "RefreshClick")
$Reset_Button = GUICtrlCreateButton("Reset", 320, 93, 70, 47, $BS_MULTILINE)
GUICtrlSetOnEvent(-1, "ResetClick")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$WirlessGroup = GUICtrlCreateGroup("Wireless", 5, 148, 390, 40, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
$GetIP_Button = GUICtrlCreateButton("Get IP", 10, 163, 70, 20, $BS_MULTILINE)
GUICtrlSetOnEvent(-1, "GetIPClick")
$IPAddress = _GUICtrlIpAddress_Create($GUI, 118, 163, 170, 20)
_GUICtrlIpAddress_Set($IPAddress, $WiFiAddressV)
$GoWireless_Button = GUICtrlCreateButton("Go Air", 320, 163, 70, 20, $BS_MULTILINE)
GUICtrlSetOnEvent(-1, "GoWirelessClick")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$DetailsGroup = GUICtrlCreateGroup("Details", 5, 188, 390, 100, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
$ModelName_Label = GUICtrlCreateLabel("", 10, 203, 380, 20, $SS_CENTER)
GUICtrlSetFont(-1, 10, 700, 0, "")
;$SerialName_Label = GUICtrlCreateLabel("Serial:", 10, 198, 70, 20)
;$SerialData_Label = GUICtrlCreateLabel("SerialV", 100, 198, 170, 20)
;$ModelName_Label = GUICtrlCreateLabel("IP:", 10, 223, 70, 20)
;$ModelData_Label = GUICtrlCreateLabel("", 100, 223, 170, 20)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Viewer_Tab = GUICtrlCreateTabItem("Viewer")
$Scrcpy_Tab = GUICtrlCreateTabItem("Scrcpy")
$Options = GUICtrlCreateGroup("Options", 9, 30, 380, 49, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
$Resolution_Combo = GUICtrlCreateCombo("", 289, 48, 70, 25)
GUICtrlSetOnEvent(-1, "Param")
GUICtrlSetData($Resolution_Combo, "Max|Auto", "Max")
_GUICtrlComboBox_SelectString($Resolution_Combo, $ResolutionV)
$FullScreen_Check = GUICtrlCreateCheckbox("", 19, 48, 20, 20, $GUI_SS_DEFAULT_CHECKBOX)
GUICtrlSetState($FullScreen_Check, $FullScreenV)
GUICtrlSetOnEvent(-1, "Param")
$PowerOffOnClose_Check = GUICtrlCreateCheckbox("", 49, 48, 20, 20, $GUI_SS_DEFAULT_CHECKBOX)
GUICtrlSetState($PowerOffOnClose_Check, $PowerOffOnCloseV)
GUICtrlSetOnEvent(-1, "Param")
$AlwaysOnTop_Check = GUICtrlCreateCheckbox("", 79, 48, 20, 20, $GUI_SS_DEFAULT_CHECKBOX)
GUICtrlSetState($AlwaysOnTop_Check, $AlwaysOnTopV)
GUICtrlSetOnEvent(-1, "Param")
$ReadOnlyMode_Check = GUICtrlCreateCheckbox("", 109, 48, 20, 20, $GUI_SS_DEFAULT_CHECKBOX)
GUICtrlSetState($ReadOnlyMode_Check, $ReadOnlyModeV)
GUICtrlSetOnEvent(-1, "Param")
$ShowTouch_Check = GUICtrlCreateCheckbox("", 139, 48, 20, 20, $GUI_SS_DEFAULT_CHECKBOX)
GUICtrlSetState($ShowTouch_Check, $ShowTouchV)
GUICtrlSetOnEvent(-1, "Param")
$NoScreenSaver_Check = GUICtrlCreateCheckbox("", 169, 48, 20, 20, $GUI_SS_DEFAULT_CHECKBOX)
GUICtrlSetState($NoScreenSaver_Check, $NoScreenSaverV)
GUICtrlSetOnEvent(-1, "Param")
$TurnOffTheScreen_Check = GUICtrlCreateCheckbox("", 199, 48, 20, 20, $GUI_SS_DEFAULT_CHECKBOX)
GUICtrlSetState($TurnOffTheScreen_Check, $TurnOffTheScreenV)
GUICtrlSetOnEvent(-1, "Param")
$StayAwake_Check = GUICtrlCreateCheckbox("", 229, 48, 20, 20, $GUI_SS_DEFAULT_CHECKBOX)
GUICtrlSetState($StayAwake_Check, $StayAwakeV)
GUICtrlSetOnEvent(-1, "Param")
$HideBorder_Check = GUICtrlCreateCheckbox("", 259, 48, 20, 20, $GUI_SS_DEFAULT_CHECKBOX)
GUICtrlSetState($HideBorder_Check, $HideBorderV)
GUICtrlSetOnEvent(-1, "Param")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TouchGroup = GUICtrlCreateGroup("Touch", 9, 80, 280, 183, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
$ShortCutC_Radio = GUICtrlCreateRadio("", 109, 98, 20, 20, $GUI_SS_DEFAULT_RADIO)
GUICtrlSetOnEvent(-1, "ShortCutRadio")
$ShortCutA_Radio = GUICtrlCreateRadio("", 149, 98, 20, 20, $GUI_SS_DEFAULT_RADIO)
GUICtrlSetOnEvent(-1, "ShortCutRadio")
$VolumeUP_Button = GUICtrlCreateButton("+", 19, 128, 50, 35)
GUICtrlSetOnEvent(-1, "VolumeUPClick")
$ScreenOn_Button = GUICtrlCreateButton("Screen On", 79, 128, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent(-1, "ScreenOnClick")
$NotificationOn_Button = GUICtrlCreateButton("Notification On", 149, 128, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent(-1, "NotificationOnClick")
$Menu_Button = GUICtrlCreateButton("Menu", 209, 128, 50, 35)
GUICtrlSetOnEvent(-1, "MenuClick")
$VolumeDown_Button = GUICtrlCreateButton("-", 19, 173, 50, 35)
GUICtrlSetOnEvent(-1, "VolumeDownClick")
$ScreenOff_Button = GUICtrlCreateButton("Screen Off", 79, 173, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent(-1, "ScreenOffClick")
$NotificationOff_Button = GUICtrlCreateButton("Notification Off", 149, 173, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent(-1, "NotificationOffClick")
$Power_Button = GUICtrlCreateButton("Power", 209, 173, 50, 35)
GUICtrlSetOnEvent(-1, "PowerClick")
$Back_Button = GUICtrlCreateButton("<", 54, 218, 50, 35)
GUICtrlSetOnEvent(-1, "BackClick")
$Home_Button = GUICtrlCreateButton("?", 114, 218, 50, 35)
GUICtrlSetOnEvent(-1, "HomeClick")
$Switch_Button = GUICtrlCreateButton("=", 174, 218, 50, 35)
GUICtrlSetOnEvent(-1, "SwitchClick")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$OnOFFGroup = GUICtrlCreateGroup("", 294, 80, 95, 183)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
$On_Button = GUICtrlCreateButton("On", 304, 95, 70, 74)
GUICtrlSetOnEvent(-1, "OnClick")
$Off_Button = GUICtrlCreateButton("Off", 304, 179, 70, 74)
GUICtrlSetOnEvent(-1, "OffClick")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Parameter = GUICtrlCreateLabel("", 20, 548, 360, 39, BitOR($ES_AUTOVSCROLL, $ES_READONLY), 0)
GUICtrlSetData($Parameter, "")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
$StatusBar = _GUICtrlStatusBar_Create($GUI)
_GUICtrlStatusBar_SetMinHeight($StatusBar, 25)
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUISetState(@SW_SHOW, $GUI)
#EndRegion ### END Koda GUI section ###

Call(ADBStart)

While 1
	Sleep(100)     ; Sleep to reduce CPU usage
WEnd

Func ReadSettings()
	$ResolutionV = IniRead($ini, "Main", "Size", "Max")
	$AlwaysOnTopV = IniRead($ini, "Main", "AlwaysOnTop", 4)
	$FullScreenV = IniRead($ini, "Main", "FullScreen", 4)
	$HideBorderV = IniRead($ini, "Main", "HideBorder", 1)
	$WiFiAddressV = IniRead($ini, "Main", "WiFiAddress", "192.168.1.2")
	$NoScreenSaverV = IniRead($ini, "Main", "NoScreenSaver", 4)
	$PowerOffOnCloseV = IniRead($ini, "Main", "PowerOffOnClose", 1)
	$ReadOnlyModeV = IniRead($ini, "Main", "ReadOnlyMode", 4)
	$SerialV = IniRead($ini, "Main", "Serial", "")
	$ShowTouchV = IniRead($ini, "Main", "ShowTouch", 4)
	$StayAwakeV = IniRead($ini, "Main", "StayAwake", 4)
	$TurnOffTheScreenV = IniRead($ini, "Main", "TurnOffTheScreen", 1)
	$Parameter = IniRead($ini, "Main", "Parameter", "")
EndFunc   ;==>ReadSettings

Func RefreshClick()
	IniDelete($ini, "Devices")
	Local $iPID1 = Run(@ComSpec & " /c adb devices", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($iPID1)
	$adbdevices = StdoutRead($iPID1)
	ConsoleWrite(@ScriptLineNumber & ': ' & $adbdevices & @CRLF)
	$ADBOutput1 = StringReplace(StringReplace(StringStripWS(StringTrimLeft($adbdevices, 26), $STR_STRIPTRAILING), @CR, ""), "	device", " USB =")
	ConsoleWrite(@ScriptLineNumber & ': ' & $ADBOutput1 & @CRLF)
	$ADBOutput2 = StringReplace($ADBOutput1, ":5555 USB =", ":5555 Wireless =")
	ConsoleWrite(@ScriptLineNumber & ': ' & $ADBOutput2 & @CRLF)
	;IniWriteSection($ini, "Devices", $ADBOutput2)
	If $ADBOutput2 = "" Then
		IniWriteSection($ini, "Devices", "NO USB =")
	Else
		IniWriteSection($ini, "Devices", $ADBOutput2)
	EndIf
	_GUICtrlListView_DeleteAllItems($DeviceList)
	Call(DeviceListRefresh)
EndFunc   ;==>RefreshClick

Func DeviceListRefresh()
	$aList = IniReadSection($ini, "Devices")
	ConsoleWrite(@ScriptLineNumber & ': ' & $aList & @CRLF)
	_GUICtrlListView_BeginUpdate($DeviceList)
	For $i = 1 To $aList[0][0]
		_GUICtrlListView_AddItem($DeviceList, $i)
		$aStr = StringSplit($aList[$i][0], " ", 1)
		_GUICtrlListView_AddSubItem($DeviceList, $i - 1, $aStr[1], 1)
		_GUICtrlListView_AddSubItem($DeviceList, $i - 1, $aStr[2], 2)
	Next
	_GUICtrlListView_EndUpdate($DeviceList)
	;AdlibRegister("DeviceListClick")
EndFunc   ;==>DeviceListRefresh

Func DeviceDetails()
	If Not $SerialV = "" Then
		Local $DeviceManufacturerCommand = Run(@ComSpec & " /c adb -s " & $SerialV & " shell getprop ro.product.manufacturer", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($DeviceManufacturerCommand)
		$DeviceManufacturer = StringStripWS(StringUpper(StdoutRead($DeviceManufacturerCommand)),8)
		Local $DeviceModelCommand = Run(@ComSpec & " /c adb -s " & $SerialV & " shell getprop ro.product.model", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
		ProcessWaitClose($DeviceModelCommand)
		$DeviceModel = StringStripWS(StdoutRead($DeviceModelCommand),8)
		GUICtrlSetData($ModelName_Label, $DeviceManufacturer & " " & $DeviceModel)
	EndIf
EndFunc

Func GetIPClick()
	$ipTxt = "FOR /F ""tokens=2"" %%G IN ('adb -s " & $SerialV & " shell ip addr show wlan0 ^|find ""inet ""') DO set ipfull=%%G"
	_FileWriteToLine(@ScriptDir & "\Core\ip.bat", 1, $ipTxt, True, True)
	Local $iPID2 = RunWait(@ComSpec & " /c " & @ScriptDir & "\Core\ip.bat", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($iPID2)
	$ipBat = StringStripWS(_ClipBoard_GetData(), $STR_STRIPTRAILING)
	_GUICtrlIpAddress_Set($IPAddress, $ipBat)
	_SaveIni("WiFiAddress", $ipBat)
	Call(ReadSettings)
EndFunc   ;==>GetIPClick

Func GoWirelessClick()
	If _GUICtrlIpAddress_IsBlank($IPAddress) Then
		MsgBox($MB_SYSTEMMODAL, "", "Enter IP Address.")
		_GUICtrlIpAddress_SetFocus($IPAddress, 0)
	Else
		RunWait(@ComSpec & " /c " & "adb connect " & _GUICtrlIpAddress_Get($IPAddress), "", @SW_HIDE)
		Call(RefreshClick)
	EndIf
EndFunc   ;==>GoWirelessClick

Func ADBStart()
	RunWait(@ComSpec & " /c " & "adb start-server", "", @SW_HIDE)
	Call(RefreshClick)
EndFunc   ;==>ADBStart

Func ResetClick()
	RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
	Call(ADBStart)
EndFunc   ;==>ResetClick

Func TabChange()
	If _GUICtrlTab_GetCurSel($Tab) = 0 Then ; zero based index of current selected TabItem
		WinSetState($DeviceList, "", @SW_SHOW)
		_GUICtrlIpAddress_ShowHide($IPAddress, @SW_SHOW)
	Else
		WinSetState($DeviceList, "", @SW_HIDE)
		_GUICtrlIpAddress_ShowHide($IPAddress, @SW_HIDE)
	EndIf
EndFunc   ;==>TabChange

Func ShortCutRadio()
	If IniRead($ini, "Main", "ShortCutCtrl", "") = 1 Then
		GUICtrlSetState($ShortCutC_Radio, $GUI_CHECKED)
	ElseIf IniRead($ini, "Main", "ShortCutAlt", "") = 1 Then
		GUICtrlSetState($ShortCutA_Radio, $GUI_CHECKED)
	EndIf
EndFunc   ;==>ShortCutRadio

Func Param()
	_SaveIni("Serial", $SerialV)
	If GUICtrlRead($Resolution_Combo) = "Max" Then
		Global $ResolutionP = " --window-height=691"
		_SaveIni("Size", "Max")
	Else
		Global $ResolutionP = ""
		_SaveIni("Size", "Auto")
	EndIf
	If _IsChecked($FullScreen_Check) Then
		Global $FullScreenP = " -f"
		_SaveIni("FullScreen", GUICtrlRead($FullScreen_Check))
	Else
		Global $FullScreenP = ""
		_SaveIni("FullScreen", GUICtrlRead($FullScreen_Check))
	EndIf
	If _IsChecked($PowerOffOnClose_Check) Then
		Global $PowerOffOnCloseP = " --power-off-on-close"
		_SaveIni("PowerOffOnClose", GUICtrlRead($PowerOffOnClose_Check))
	Else
		Global $PowerOffOnCloseP = ""
		_SaveIni("PowerOffOnClose", GUICtrlRead($PowerOffOnClose_Check))
	EndIf
	If _IsChecked($AlwaysOnTop_Check) Then
		Global $AlwaysOnTopP = " --always-on-top"
		_SaveIni("AlwaysOnTop", GUICtrlRead($AlwaysOnTop_Check))
	Else
		Global $AlwaysOnTopP = ""
		_SaveIni("AlwaysOnTop", GUICtrlRead($AlwaysOnTop_Check))
	EndIf
	If _IsChecked($ReadOnlyMode_Check) Then
		Global $ReadOnlyModeP = " -n"
		_SaveIni("ReadOnlyMode", GUICtrlRead($ReadOnlyMode_Check))
	Else
		Global $ReadOnlyModeP = ""
		_SaveIni("ReadOnlyMode", GUICtrlRead($ReadOnlyMode_Check))
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
	If _IsChecked($HideBorder_Check) Then
		Global $HideBorderP = " --window-borderless"
		_SaveIni("HideBorder", GUICtrlRead($HideBorder_Check))
	Else
		Global $HideBorderP = ""
		_SaveIni("HideBorder", GUICtrlRead($HideBorder_Check))
	EndIf
	If _IsChecked($ShortCutC_Radio) Then
		Global $ShortCutP = " --shortcut-mod=""lctrl,rctrl"""
		Global $ShortCutKey = "^"
		_SaveIni("ShortCutCtrl", GUICtrlRead($ShortCutC_Radio))
		_SaveIni("ShortCutAlt", GUICtrlRead($ShortCutA_Radio))
	ElseIf _IsChecked($ShortCutC_Radio) Then
		Global $ShortCutP = " --shortcut-mod=""lalt,ralt"""
		Global $ShortCutKey = "!"
		_SaveIni("ShortCutCtrl", GUICtrlRead($ShortCutC_Radio))
		_SaveIni("ShortCutAlt", GUICtrlRead($ShortCutA_Radio))
	EndIf
	Call(SumParam)
EndFunc   ;==>Param

Func SumParam()
	Global $FinalParam = " -s " & $SerialV & $ResolutionP & $ShortCutP & $FullScreenP & $PowerOffOnCloseP & $AlwaysOnTopP & $ReadOnlyModeP & $ShowTouchP & $NoScreenSaverP & $TurnOffTheScreenP & $StayAwakeP & $HideBorderP
	_SaveIni("FinalParameter", $FinalParam)
	GUICtrlSetData($Parameter, $FinalParam)
	Call(RunScrcpy)
EndFunc   ;==>SumParam

Func RunScrcpy()
	Run(@ComSpec & " /c " & "scrcpy" & $FinalParam, "", @SW_HIDE)
EndFunc   ;==>RunScrcpy

Func OnClick()
	Call(Param)
EndFunc   ;==>OnClick

Func OffClick()
	If WinExists("[CLASS:SDL_app]", "") Then
		WinClose("[CLASS:SDL_app]", "")
		RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
		Exit
	Else
		RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
		Exit
	EndIf
EndFunc   ;==>OffClick

Func _SaveIni($_sKey, $_sValue)
	Local $sSection = "Main"
	Local $sIniRead = IniRead($ini, $sSection, $_sKey, "")
	If $sIniRead = $_sValue Then Return
	IniWrite($ini, $sSection, $_sKey, $_sValue)
EndFunc   ;==>_SaveIni

Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

Func VolumeUPClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "{UP}")
	EndIf
EndFunc   ;==>VolumeUPClick

Func ScreenOnClick()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "o")
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
		Send($ShortCutKey & "+o")
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
                        ConsoleWrite("---> Item " & $iItem + 1 & " has checked" & @LF)
						$SerialV = _GUICtrlListView_GetItemText($DeviceList, $iItem, 1)
						ConsoleWrite(@ScriptLineNumber & ': ' & $SerialV & @CRLF)
						Call(DeviceDetails)
                    EndIf
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc

;==>"Made with️ ❤ in Bangladesh"