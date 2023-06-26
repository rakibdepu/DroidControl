#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#Include <GuiComboBox.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <GUIListView.au3>
#include <GuiStatusBar.au3>
#include <ListViewConstants.au3>
#include <WindowsConstants.au3>
#Include <WinAPI.au3>

Opt("GUIOnEventMode", 1) ; Change to OnEvent mode

Global $ini = "settings.ini"

ReadSettings()

#Region ### START Koda GUI section ### Form=hgui.kxf
;$MainGUI = GUICreate("Scrcpy Helper", 405, 525, 184, 129, -1, BitOR($WS_EX_LAYERED,$WS_EX_TOPMOST))
;GUISetBkColor(0x000000)
;_WinAPI_SetLayeredWindowAttributes($MainGUI, 0x000000, 250)

$MainGUI = GUICreate("Scrcpy Helper", 400, 525, 0, Default, $WS_POPUP)
GUISetOnEvent($GUI_EVENT_CLOSE, "Off")
$MainGroup = GUICtrlCreateGroup("", 10, 6, 380, 489)
$DeviceGroup = GUICtrlCreateGroup("Device", 20, 18, 360, 118, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
Local $DeviceList = GUICtrlCreateListView("#|Device|Serial", 30, 36, 260, 90, BitOR($GUI_SS_DEFAULT_LISTVIEW,$WS_HSCROLL,$WS_BORDER,$BS_CENTER), BitOR($WS_EX_CLIENTEDGE,$LVS_EX_GRIDLINES,$LVS_EX_CHECKBOXES,$LVS_EX_FULLROWSELECT))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 46)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 140)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 70)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($DeviceList), 0, 2)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($DeviceList), 1, 2)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($DeviceList), 2, 2)
GUICtrlSetTip(-1, "Double click on device")
$Refresh = GUICtrlCreateButton("Refresh", 300, 36, 70, 90)
GUICtrlSetOnEvent($Refresh, "Refresh")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$ADBGroup = GUICtrlCreateGroup("ADB", 20, 142, 360, 58, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
$GoWireless = GUICtrlCreateButton("Go Wireless", 220, 160, 70, 30, $BS_MULTILINE)
GUICtrlSetTip(-1, "Enter IP address")
GUICtrlSetOnEvent($GoWireless, "GoWireless")
$ADBKill = GUICtrlCreateButton("ADB Reboot", 300, 160, 70, 30, $BS_MULTILINE)
GUICtrlSetOnEvent($ADBKill, "ADBKill")
$IPAddress = _GUICtrlIpAddress_Create($MainGUI, 30, 160, 180, 30, -1, 0)
_GUICtrlIpAddress_Set($IPAddress,$WiFiAddressV)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$ScrcpyGroup = GUICtrlCreateGroup("Scrcpy", 20, 206, 360, 49, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
$Resolution = GUICtrlCreateCombo("", 300, 224, 70, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData($Resolution, "Max|Auto", "Max")
GUICtrlSetTip(-1, "Resolution")
_GUICtrlComboBox_SelectString($Resolution, $ResolutionV)
GUICtrlSetOnEvent(GUICtrlRead($Resolution), "Param")
$FullScreenC = GUICtrlCreateCheckbox("", 30, 224, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Full Screen")
GUICtrlSetState($FullScreenC, $FullScreenV)
GUICtrlSetOnEvent($FullScreenC, "Param")
$PowerOffOnCloseC = GUICtrlCreateCheckbox("", 60, 224, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Power Off On Close")
GUICtrlSetState($PowerOffOnCloseC, $PowerOffOnCloseV)
GUICtrlSetOnEvent($PowerOffOnCloseC, "Param")
$AlwaysOnTopC = GUICtrlCreateCheckbox("", 90, 224, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Always On Top")
GUICtrlSetState($AlwaysOnTopC, $AlwaysOnTopV)
GUICtrlSetOnEvent($AlwaysOnTopC, "Param")
$ReadOnlyModeC = GUICtrlCreateCheckbox("", 120, 224, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Read Only Mode")
GUICtrlSetState($ReadOnlyModeC, $ReadOnlyModeV)
GUICtrlSetOnEvent($ReadOnlyModeC, "Param")
$ShowTouchC = GUICtrlCreateCheckbox("", 150, 224, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Show Touch")
GUICtrlSetState($ShowTouchC, $ShowTouchV)
GUICtrlSetOnEvent($ShowTouchC, "Param")
$NoScreenSaverC = GUICtrlCreateCheckbox("", 180, 224, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "No Screensaver")
GUICtrlSetState($NoScreenSaverC, $NoScreenSaverV)
GUICtrlSetOnEvent($NoScreenSaverC, "Param")
$TurnOffTheScreenC = GUICtrlCreateCheckbox("", 210, 224, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Turn off the screen")
GUICtrlSetState($TurnOffTheScreenC, $TurnOffTheScreenV)
GUICtrlSetOnEvent($TurnOffTheScreenC, "Param")
$StayAwakeC = GUICtrlCreateCheckbox("", 240, 224, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Stay Awake")
GUICtrlSetState($StayAwakeC, $StayAwakeV)
GUICtrlSetOnEvent($StayAwakeC, "Param")
$HideBorderC = GUICtrlCreateCheckbox("", 270, 224, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Hide Border")
GUICtrlSetState($HideBorderC, $HideBorderV)
GUICtrlSetOnEvent($HideBorderC, "Param")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TouchGroup = GUICtrlCreateGroup("Touch", 20, 261, 260, 183, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
$ShortCutC = GUICtrlCreateRadio("", 120, 279, 20, 20, BitOR($GUI_SS_DEFAULT_RADIO, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Ctrl")
$ShortCutA = GUICtrlCreateRadio("", 160, 279, 20, 20, BitOR($GUI_SS_DEFAULT_RADIO, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Alt")
$VolumeUP = GUICtrlCreateButton("+", 30, 309, 50, 35)
GUICtrlSetTip(-1, "Volume UP")
GUICtrlSetOnEvent($VolumeUP, "TVolUP")
$ScreenOn = GUICtrlCreateButton("Screen On", 90, 309, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent($ScreenOn, "TSOn")
$NotificationOn = GUICtrlCreateButton("Notification On", 160, 309, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent($NotificationOn, "TNOn")
$Menu = GUICtrlCreateButton("Menu", 220, 309, 50, 35)
GUICtrlSetTip(-1, "Menu")
GUICtrlSetOnEvent($Menu, "TMenu")
$VolumeDown = GUICtrlCreateButton("-", 30, 354, 50, 35)
GUICtrlSetTip(-1, "Volume Down")
GUICtrlSetOnEvent($VolumeDown, "TVolDown")
$ScreenOff = GUICtrlCreateButton("Screen Off", 90, 354, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent($ScreenOff, "TSOff")
$NotificationOff = GUICtrlCreateButton("Notification Off", 160, 354, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent($NotificationOff, "TNOff")
$Power = GUICtrlCreateButton("Power", 220, 354, 50, 35)
GUICtrlSetTip(-1, "Power On/Off")
GUICtrlSetOnEvent($Power, "TPower")
$Back = GUICtrlCreateButton("<", 65, 399, 50, 35)
GUICtrlSetTip(-1, "Back")
GUICtrlSetOnEvent($Back, "TBack")
$Home = GUICtrlCreateButton("?", 125, 399, 50, 35)
GUICtrlSetTip(-1, "Home")
GUICtrlSetOnEvent($Home, "THome")
$Switch = GUICtrlCreateButton("=", 185, 399, 50, 35)
GUICtrlSetTip(-1, "Switch")
GUICtrlSetOnEvent($Switch, "TSwitch")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$OnOFFGroup = GUICtrlCreateGroup("", 290, 261, 90, 183)
$On = GUICtrlCreateButton("On", 300, 276, 70, 74)
GUICtrlSetOnEvent($On, "On")
$Off = GUICtrlCreateButton("Off", 300, 360, 70, 74)
GUICtrlSetOnEvent($Off, "Off")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Parameter = GUICtrlCreateLabel("", 20, 448, 360, 39, BitOR($ES_AUTOVSCROLL, $ES_READONLY), 0)
GUICtrlSetData($Parameter, "")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$StatusBar1 = _GUICtrlStatusBar_Create($MainGUI)
_GUICtrlStatusBar_SetBkColor($StatusBar1, 0xD1B499)
_GUICtrlStatusBar_SetMinHeight($StatusBar1, 20)
If IniRead($ini, "Main", "ShortCutCtrl", "") = 1 Then
	GUICtrlSetState($ShortCutC,$GUI_CHECKED)
ElseIf IniRead($ini, "Main", "ShortCutAlt", "") = 1 Then
	GUICtrlSetState($ShortCutA,$GUI_CHECKED)
EndIf
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

ADBStart()

While 1
        Sleep(100) ; Sleep to reduce CPU usage
WEnd

Func ReadSettings()
	Global $ResolutionV = IniRead($ini, "Main", "Size", "Max")
	Global $AlwaysOnTopV = IniRead($ini, "Main", "AlwaysOnTop", 4)
	Global $FullScreenV = IniRead($ini, "Main", "FullScreen", 4)
	Global $HideBorderV = IniRead($ini, "Main", "HideBorder", 1)
	Global $WiFiAddressV = IniRead($ini, "Main", "WiFiAddress", "192.168.1.2")
	Global $NoScreenSaverV = IniRead($ini, "Main", "NoScreenSaver", 4)
	Global $PowerOffOnCloseV = IniRead($ini, "Main", "PowerOffOnClose", 1)
	Global $ReadOnlyModeV = IniRead($ini, "Main", "ReadOnlyMode", 4)
	Global $SerialV = IniRead($ini, "Main", "Serial", "")
	Global $ShowTouchV = IniRead($ini, "Main", "ShowTouch", 4)
	Global $StayAwakeV = IniRead($ini, "Main", "StayAwake", 4)
	Global $TurnOffTheScreenV = IniRead($ini, "Main", "TurnOffTheScreen", 1)
	Global $Parameter = IniRead($ini, "Main", "Parameter", "")
EndFunc   ;==>ReadSettings

Func Refresh()
	IniDelete ( $ini, "Devices" )
	Local $iPID = Run(@ComSpec & " /c adb devices", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($iPID)
	$adbdevices = StdoutRead($iPID)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : 	$adbdevices = ' & 	$adbdevices & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	Local $pattern = "(?m)^(.*?)\s*device$"
	Local $ADBOutput = StringRegExp($adbdevices, $pattern, 3)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : 	$ADBOutput = ' & 	$ADBOutput & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	If $ADBOutput = "" Then
		IniWriteSection($ini, "Devices", $WiFiAddressV)
	Else
		IniWriteSection($ini, "Devices", $ADBOutput)
	EndIf
	_GUICtrlListView_DeleteAllItems($DeviceList)
	DeviceRefresh()
EndFunc   ;==>Refresh

Func DeviceRefresh()
	$aList = IniReadSection($ini, "Devices")
	_GUICtrlListView_BeginUpdate($DeviceList)
	If Not @error Then
		For $i = 1 To $aList[0][0]
			;ConsoleWrite($aList[$i][0] & @CRLF)
			_GUICtrlListView_AddItem($DeviceList, $i)
			$aStr = StringSplit($aList[$i][0], " ", 1)
			_GUICtrlListView_AddSubItem($DeviceList, $i-1, $aStr[1], 1)
			_GUICtrlListView_AddSubItem($DeviceList, $i-1, $aStr[2], 2)
		Next
		_GUICtrlListView_EndUpdate($DeviceList)
	EndIf
EndFunc   ;==>DeviceRefresh

Func GoWireless()
	If _GUICtrlIpAddress_IsBlank($IPAddress) Then
		MsgBox($MB_SYSTEMMODAL, "", "Enter IP Address.")
		_GUICtrlIpAddress_SetFocus($IPAddress, 0)
	Else
		RunWait(@ComSpec & " /c " & "adb connect " & _GUICtrlIpAddress_Get($IPAddress), "", @SW_HIDE)
		_SaveIni("WiFiAddress", _GUICtrlIpAddress_Get($IPAddress))
		Refresh()
	EndIf
EndFunc   ;==>GoWireless

Func ADBStart()
	RunWait(@ComSpec & " /c " & "adb start-server", "", @SW_HIDE)
	Refresh()
EndFunc   ;==>ADBReboot

Func ADBKill()
	RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
	ADBStart()
EndFunc   ;==>ADBReboot

Func Param()
    For $i = 0 To _GUICtrlListView_GetItemCount($DeviceList)
        If _GUICtrlListView_GetItemChecked($DeviceList, $i) Then
            Global $SerialV = _GUICtrlListView_GetItemText($DeviceList, $i, 1)
        EndIf
    Next
	_SaveIni("Serial", $SerialV)
	If GUICtrlRead($Resolution) = "Max" Then
		Global $ResolutionP = " --window-height=691"
		_SaveIni("Size", "Max")
	Else
		Global $ResolutionP = ""
		_SaveIni("Size", "Auto")
	EndIf
	If _IsChecked($FullScreenC) Then
		Global $FullScreenP = " -f"
		_SaveIni("FullScreen", GUICtrlRead($FullScreenC))
	Else
		Global $FullScreenP = ""
		_SaveIni("FullScreen", GUICtrlRead($FullScreenC))
	EndIf
	If _IsChecked($PowerOffOnCloseC) Then
		Global $PowerOffOnCloseP = " --power-off-on-close"
		_SaveIni("PowerOffOnClose", GUICtrlRead($PowerOffOnCloseC))
	Else
		Global $PowerOffOnCloseP = ""
		_SaveIni("PowerOffOnClose", GUICtrlRead($PowerOffOnCloseC))
	EndIf
	If _IsChecked($AlwaysOnTopC) Then
		Global $AlwaysOnTopP = " --always-on-top"
		_SaveIni("AlwaysOnTop", GUICtrlRead($AlwaysOnTopC))
	Else
		Global $AlwaysOnTopP = ""
		_SaveIni("AlwaysOnTop", GUICtrlRead($AlwaysOnTopC))
	EndIf
	If _IsChecked($ReadOnlyModeC) Then
		Global $ReadOnlyModeP = " -n"
		_SaveIni("ReadOnlyMode", GUICtrlRead($ReadOnlyModeC))
	Else
		Global $ReadOnlyModeP = ""
		_SaveIni("ReadOnlyMode", GUICtrlRead($ReadOnlyModeC))
	EndIf
	If _IsChecked($ShowTouchC) Then
		Global $ShowTouchP = " -t"
		_SaveIni("ShowTouch", GUICtrlRead($ShowTouchC))
	Else
		Global $ShowTouchP = ""
		_SaveIni("ShowTouch", GUICtrlRead($ShowTouchC))
	EndIf
	If _IsChecked($NoScreenSaverC) Then
		Global $NoScreenSaverP = " --disable-screensaver"
		_SaveIni("NoScreenSaver", GUICtrlRead($NoScreenSaverC))
	Else
		Global $NoScreenSaverP = ""
		_SaveIni("NoScreenSaver", GUICtrlRead($NoScreenSaverC))
	EndIf
	If _IsChecked($TurnOffTheScreenC) Then
		Global $TurnOffTheScreenP = " -S"
		_SaveIni("TurnOffTheScreen", GUICtrlRead($TurnOffTheScreenC))
	Else
		Global $TurnOffTheScreenP = ""
		_SaveIni("TurnOffTheScreen", GUICtrlRead($TurnOffTheScreenC))
	EndIf
	If _IsChecked($StayAwakeC) Then
		Global $StayAwakeP = " -w"
		_SaveIni("StayAwake", GUICtrlRead($StayAwakeC))
	Else
		Global $StayAwakeP = ""
		_SaveIni("StayAwake", GUICtrlRead($StayAwakeC))
	EndIf
	If _IsChecked($HideBorderC) Then
		Global $HideBorderP = " --window-borderless"
		_SaveIni("HideBorder", GUICtrlRead($HideBorderC))
	Else
		Global $HideBorderP = ""
		_SaveIni("HideBorder", GUICtrlRead($HideBorderC))
	EndIf
	If _IsChecked($ShortCutC) Then
		Global $ShortCutP = " --shortcut-mod=""lctrl,rctrl"""
		Global $ShortCutKey = "^"
		_SaveIni("ShortCutCtrl", GUICtrlRead($ShortCutC))
		_SaveIni("ShortCutAlt", GUICtrlRead($ShortCutA))
	ElseIf _IsChecked($ShortCutA) Then
		Global $ShortCutP = " --shortcut-mod=""lalt,ralt"""
		Global $ShortCutKey = "!"
		_SaveIni("ShortCutCtrl", GUICtrlRead($ShortCutC))
		_SaveIni("ShortCutAlt", GUICtrlRead($ShortCutA))
	EndIf
	SumParam()
EndFunc   ;==>Param

Func SumParam()
	Global $FinalParam = " -s " & $SerialV & $ResolutionP & $ShortCutP & $FullScreenP &  $PowerOffOnCloseP & $AlwaysOnTopP & $ReadOnlyModeP & $ShowTouchP & $NoScreenSaverP & $TurnOffTheScreenP & $StayAwakeP & $HideBorderP
	_SaveIni("FinalParameter", $FinalParam)
	GUICtrlSetData($Parameter, $FinalParam)
	RunScrcpy()
EndFunc   ;==>SumParam

Func RunScrcpy()
	Run(@ComSpec & " /c " & "scrcpy" & $FinalParam, "", @SW_HIDE)
EndFunc   ;==>RunScrcpy

Func On()
	Param()
EndFunc   ;==>On

Func Off()
	If WinExists("[CLASS:SDL_app]", "") Then
		WinClose("[CLASS:SDL_app]", "")
		RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
		Exit
	Else
		RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
		Exit
	EndIf
EndFunc   ;==>Off

Func _SaveIni($_sKey, $_sValue)
    Local $sSection = "Main"
    Local $sIniRead = IniRead($ini, $sSection, $_sKey, "")
    If $sIniRead = $_sValue Then Return
    IniWrite($ini, $sSection, $_sKey, $_sValue)
EndFunc   ;==>_SaveIni

Func _IsChecked($idControlID)
        Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

Func TVolUP()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "{UP}")
	EndIf
EndFunc   ;==>TVolUP

Func TSOn()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "o")
	EndIf
EndFunc   ;==>TSOn

Func TNOn()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "n")
	EndIf
EndFunc   ;==>TNOn

Func TMenu()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "m")
	EndIf
EndFunc   ;==>TMenu

Func TVolDown()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "{DOWN}")
	EndIf
EndFunc   ;==>TVolDown

Func TSOff()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "+o")
	EndIf
EndFunc   ;==>TSOff

Func TNOff()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "+n")
	EndIf
EndFunc   ;==>TNOff

Func TPower()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "p")
	EndIf
EndFunc   ;==>TPower

Func TBack()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "b")
	EndIf
EndFunc   ;==>TBack

Func THome()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "h")
	EndIf
EndFunc   ;==>THome

Func TSwitch()
	If WinActivate("[CLASS:SDL_app]", "") Then
		Send($ShortCutKey & "s")
	EndIf
EndFunc   ;==>TSwitch
;==>"Made with️ ❤ in Bangladesh"
