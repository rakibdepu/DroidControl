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
#include <Clipboard.au3>
#include <StaticConstants.au3>
#include <File.au3>

Opt("GUIOnEventMode", 1) ; Change to OnEvent mode

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

ReadSettings()

#Region ### START Koda GUI section ### Form=hgui.kxf
;$MainGUI = GUICreate("Scrcpy Helper", 405, 525, 184, 129, -1, BitOR($WS_EX_LAYERED,$WS_EX_TOPMOST))
;GUISetBkColor(0x000000)
;_WinAPI_SetLayeredWindowAttributes($MainGUI, 0x000000, 250)

$MainGUI = GUICreate("Scrcpy Helper", 400, 600, 0, Default, $WS_POPUP)
GUISetOnEvent($GUI_EVENT_CLOSE, "Off")
$MainGroup = GUICtrlCreateGroup("", 10, 6, 380, 489)
$DeviceGroup = GUICtrlCreateGroup("Device List", 20, 18, 360, 118, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
Local $DeviceList = GUICtrlCreateListView("#|Serial|Connection", 30, 36, 260, 90, BitOR($GUI_SS_DEFAULT_LISTVIEW,$WS_HSCROLL,$WS_BORDER,$BS_CENTER), BitOR($WS_EX_CLIENTEDGE,$LVS_EX_GRIDLINES, $LVS_SHOWSELALWAYS, $LVS_EX_FULLROWSELECT))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 30)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 139)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 80)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($DeviceList), 0, 2)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($DeviceList), 1, 2)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($DeviceList), 2, 2)
GUICtrlSetTip(-1, "Double click on device")
$Refresh = GUICtrlCreateButton("Refresh", 300, 36, 70, 65)
GUICtrlSetOnEvent($Refresh, "Refresh")
$ADBKill = GUICtrlCreateButton("Reset", 300, 106, 70, 20, $BS_MULTILINE)
GUICtrlSetOnEvent($ADBKill, "ADBKill")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$ADBGroup = GUICtrlCreateGroup("ADB", 20, 142, 360, 48, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
$GetIP = GUICtrlCreateButton("Get IP", 30, 160, 70, 20, $BS_MULTILINE)
GUICtrlSetOnEvent($GetIP, "GetIP")
$GoWireless = GUICtrlCreateButton("Go Air", 300, 160, 70, 20, $BS_MULTILINE)
GUICtrlSetTip(-1, "Enter IP address")
GUICtrlSetOnEvent($GoWireless, "GoWireless")
$IPAddress = _GUICtrlIpAddress_Create($MainGUI, 110, 160, 180, 20, -1, 0)
_GUICtrlIpAddress_Set($IPAddress, $WiFiAddressV)
$DetailsGroup = GUICtrlCreateGroup("Details", 20, 206, 360, 100, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
$SerialName = GUICtrlCreateLabel("Serial:", 30, 224, 70, 20)
$SerialData = GUICtrlCreateLabel($SerialV, 70, 224, 170, 20)
$ModelName = GUICtrlCreateLabel("IP:", 30, 240, 70, 20)
$ModelData = GUICtrlCreateLabel("", 70, 240, 170, 20)

GUICtrlCreateGroup("", -99, -99, 1, 1)
$ScrcpyGroup = GUICtrlCreateGroup("Scrcpy", 20, 306, 360, 49, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
$Resolution = GUICtrlCreateCombo("", 300, 324, 70, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData($Resolution, "Max|Auto", "Max")
GUICtrlSetTip(-1, "Resolution")
_GUICtrlComboBox_SelectString($Resolution, $ResolutionV)
GUICtrlSetOnEvent(GUICtrlRead($Resolution), "Param")
$FullScreenC = GUICtrlCreateCheckbox("", 30, 324, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Full Screen")
GUICtrlSetState($FullScreenC, $FullScreenV)
GUICtrlSetOnEvent($FullScreenC, "Param")
$PowerOffOnCloseC = GUICtrlCreateCheckbox("", 60, 324, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Power Off On Close")
GUICtrlSetState($PowerOffOnCloseC, $PowerOffOnCloseV)
GUICtrlSetOnEvent($PowerOffOnCloseC, "Param")
$AlwaysOnTopC = GUICtrlCreateCheckbox("", 90, 324, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Always On Top")
GUICtrlSetState($AlwaysOnTopC, $AlwaysOnTopV)
GUICtrlSetOnEvent($AlwaysOnTopC, "Param")
$ReadOnlyModeC = GUICtrlCreateCheckbox("", 120, 324, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Read Only Mode")
GUICtrlSetState($ReadOnlyModeC, $ReadOnlyModeV)
GUICtrlSetOnEvent($ReadOnlyModeC, "Param")
$ShowTouchC = GUICtrlCreateCheckbox("", 150, 324, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Show Touch")
GUICtrlSetState($ShowTouchC, $ShowTouchV)
GUICtrlSetOnEvent($ShowTouchC, "Param")
$NoScreenSaverC = GUICtrlCreateCheckbox("", 180, 324, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "No Screensaver")
GUICtrlSetState($NoScreenSaverC, $NoScreenSaverV)
GUICtrlSetOnEvent($NoScreenSaverC, "Param")
$TurnOffTheScreenC = GUICtrlCreateCheckbox("", 210, 324, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Turn off the screen")
GUICtrlSetState($TurnOffTheScreenC, $TurnOffTheScreenV)
GUICtrlSetOnEvent($TurnOffTheScreenC, "Param")
$StayAwakeC = GUICtrlCreateCheckbox("", 240, 324, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Stay Awake")
GUICtrlSetState($StayAwakeC, $StayAwakeV)
GUICtrlSetOnEvent($StayAwakeC, "Param")
$HideBorderC = GUICtrlCreateCheckbox("", 270, 324, 20, 20, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Hide Border")
GUICtrlSetState($HideBorderC, $HideBorderV)
GUICtrlSetOnEvent($HideBorderC, "Param")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TouchGroup = GUICtrlCreateGroup("Touch", 20, 361, 260, 183, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
$ShortCutC = GUICtrlCreateRadio("", 120, 379, 20, 20, BitOR($GUI_SS_DEFAULT_RADIO, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Ctrl")
$ShortCutA = GUICtrlCreateRadio("", 160, 379, 20, 20, BitOR($GUI_SS_DEFAULT_RADIO, $BS_PUSHLIKE))
GUICtrlSetTip(-1, "Alt")
$VolumeUP = GUICtrlCreateButton("+", 30, 409, 50, 35)
GUICtrlSetTip(-1, "Volume UP")
GUICtrlSetOnEvent($VolumeUP, "TVolUP")
$ScreenOn = GUICtrlCreateButton("Screen On", 90, 409, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent($ScreenOn, "TSOn")
$NotificationOn = GUICtrlCreateButton("Notification On", 160, 409, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent($NotificationOn, "TNOn")
$Menu = GUICtrlCreateButton("Menu", 220, 409, 50, 35)
GUICtrlSetTip(-1, "Menu")
GUICtrlSetOnEvent($Menu, "TMenu")
$VolumeDown = GUICtrlCreateButton("-", 30, 454, 50, 35)
GUICtrlSetTip(-1, "Volume Down")
GUICtrlSetOnEvent($VolumeDown, "TVolDown")
$ScreenOff = GUICtrlCreateButton("Screen Off", 90, 454, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent($ScreenOff, "TSOff")
$NotificationOff = GUICtrlCreateButton("Notification Off", 160, 454, 50, 35, $BS_MULTILINE)
GUICtrlSetOnEvent($NotificationOff, "TNOff")
$Power = GUICtrlCreateButton("Power", 220, 454, 50, 35)
GUICtrlSetTip(-1, "Power On/Off")
GUICtrlSetOnEvent($Power, "TPower")
$Back = GUICtrlCreateButton("<", 65, 499, 50, 35)
GUICtrlSetTip(-1, "Back")
GUICtrlSetOnEvent($Back, "TBack")
$Home = GUICtrlCreateButton("?", 125, 499, 50, 35)
GUICtrlSetTip(-1, "Home")
GUICtrlSetOnEvent($Home, "THome")
$Switch = GUICtrlCreateButton("=", 185, 499, 50, 35)
GUICtrlSetTip(-1, "Switch")
GUICtrlSetOnEvent($Switch, "TSwitch")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$OnOFFGroup = GUICtrlCreateGroup("", 290, 361, 90, 183)
$On = GUICtrlCreateButton("On", 300, 376, 70, 74)
GUICtrlSetOnEvent($On, "On")
$Off = GUICtrlCreateButton("Off", 300, 460, 70, 74)
GUICtrlSetOnEvent($Off, "Off")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Parameter = GUICtrlCreateLabel("", 20, 548, 360, 39, BitOR($ES_AUTOVSCROLL, $ES_READONLY), 0)
GUICtrlSetData($Parameter, "")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$StatusBar1 = _GUICtrlStatusBar_Create($MainGUI)
_GUICtrlStatusBar_SetBkColor($StatusBar1, 0xD1B499)
_GUICtrlStatusBar_SetMinHeight($StatusBar1, 15)
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

Func Refresh()
	IniDelete ( $ini, "Devices" )
	Local $iPID1 = Run(@ComSpec & " /c adb devices", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($iPID1)
	$adbdevices = StdoutRead($iPID1)
	$ADBOutput1 = StringReplace(StringReplace(StringStripWS(StringTrimLeft($adbdevices, 26), $STR_STRIPTRAILING), @CR, ""), "	device", " USB =")
	ConsoleWrite('(' & @ScriptLineNumber & ')' & $ADBOutput1 & @CRLF)
    $ADBOutput2 = StringReplace($ADBOutput1, ":5555 USB =", ":5555 Wireless =")
    ConsoleWrite('(' & @ScriptLineNumber & ')' & $ADBOutput2 & @CRLF)
	IniWriteSection($ini, "Devices", $ADBOutput2)
	_GUICtrlListView_DeleteAllItems($DeviceList)
	DeviceRefresh()
EndFunc   ;==>Refresh

Func DeviceRefresh()
	$aList = IniReadSection($ini, "Devices")
	ConsoleWrite('(' & @ScriptLineNumber & ')' & $aList & @CRLF)
	_GUICtrlListView_BeginUpdate($DeviceList)
	For $i = 1 To $aList[0][0]
		_GUICtrlListView_AddItem($DeviceList, $i)
		$aStr = StringSplit($aList[$i][0], " ", 1)
		_GUICtrlListView_AddSubItem($DeviceList, $i-1, $aStr[1], 1)
		_GUICtrlListView_AddSubItem($DeviceList, $i-1, $aStr[2], 2)
	Next
	_GUICtrlListView_EndUpdate($DeviceList)
	AdlibRegister("DetailsExec")
EndFunc   ;==>DeviceRefresh

Func GetIP()
	$ipTxt = "FOR /F ""tokens=2"" %%G IN ('adb -s " & $SerialV & " shell ip addr show wlan0 ^|find ""inet ""') DO set ipfull=%%G"
	_FileWriteToLine(@ScriptDir & "\Core\ip.bat", 1, $ipTxt, True, True)
	Local $iPID2 = RunWait(@ComSpec & " /c " & @ScriptDir & "\Core\ip.bat", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	ProcessWaitClose($iPID2)
	$ipBat = StringStripWS(_ClipBoard_GetData(), $STR_STRIPTRAILING)
	_GUICtrlIpAddress_Set($IPAddress, $ipBat)
	GUICtrlSetData($ModelData, $ipBat)
	_SaveIni("WiFiAddress", $ipBat)
	ReadSettings()
EndFunc   ;==>GetIP

Func GoWireless()
	If _GUICtrlIpAddress_IsBlank($IPAddress) Then
		MsgBox($MB_SYSTEMMODAL, "", "Enter IP Address.")
		_GUICtrlIpAddress_SetFocus($IPAddress, 0)
	Else
		RunWait(@ComSpec & " /c " & "adb connect " & _GUICtrlIpAddress_Get($IPAddress), "", @SW_HIDE)
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

Func DetailsExec()
    For $i = 0 To _GUICtrlListView_GetItemCount($DeviceList)
        If _GUICtrlListView_GetItemSelected($DeviceList, $i) Then
            $SerialV = _GUICtrlListView_GetItemText($DeviceList, $i, 1)
        EndIf
	AdlibRegister("Param")
    Next
EndFunc   ;==>DetailsExec
Func Param()
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