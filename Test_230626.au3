#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIListView.au3>
Global $ini = "device_list.ini"
ConsoleWrite('(' & @ScriptLineNumber & ')' & $ini & @CRLF)
RunWait(@ComSpec & " /c " & "adb start-server", "", @SW_HIDE)
RunWait(@ComSpec & " /c " & "adb connect 192.168.1.147:5555", "", @SW_HIDE)

$hGUI = GUICreate("Test", 500, 500)

$cListView = GUICtrlCreateListView("", 10, 10, 400, 300)
_GUICtrlListView_AddColumn($cListView, "#", 100)
_GUICtrlListView_AddColumn($cListView, "Device", 100)
_GUICtrlListView_AddColumn($cListView, "Serial", 100)

GUISetState()

; Simulate loading file
IniDelete ( $ini, "Devices" )
Local $iPID = Run(@ComSpec & " /c adb devices", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
ProcessWaitClose($iPID)
$adbdevices = StdoutRead($iPID)
ConsoleWrite('(' & @ScriptLineNumber & ')' & $adbdevices & @CRLF)
Local $pattern = "(?m)^(.*?)\s*device$"
Local $ADBOutput = StringRegExp($adbdevices, $pattern, 3)
ConsoleWrite('(' & @ScriptLineNumber & ')' & $ADBOutput & @CRLF)
If $ADBOutput = "" Then
	IniWriteSection($ini, "Devices", $ADBOutput)
Else
	IniWriteSection($ini, "Devices", $ADBOutput)
EndIf
_GUICtrlListView_DeleteAllItems($cListView)

$sData = IniReadSection($ini, "Devices")
ConsoleWrite('(' & @ScriptLineNumber & ')' & $sData & @CRLF)
$aData = StringSplit($sData, " ")
ConsoleWrite('(' & @ScriptLineNumber & ')' & $aData & @CRLF)

For $i = 1 To $aData[0] Step 2
    $iItem = _GUICtrlListView_AddItem($cListView, $aData[$i])
    _GUICtrlListView_AddSubItem($cListView, $iItem, $aData[$i + 1], 1)
    _GUICtrlListView_AddSubItem($cListView, $iItem, $aData[$i + 2], 2)
Next

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            RunWait(@ComSpec & " /c " & "adb kill-server", "", @SW_HIDE)
			Exit
    EndSwitch
WEnd