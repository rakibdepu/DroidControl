#include <GUIConstantsEx.au3>

#include "GUIExtender.au3"

Opt("GUIOnEventMode", 1)

$hGUI_1 = GUICreate("Vertical", 300, 390, 100, 100)
GUISetOnEvent($GUI_EVENT_CLOSE, "On_Exit")

_GUIExtender_Init($hGUI_1)

_GUIExtender_Section_Create($hGUI_1, Default, 60)
GUICtrlCreateGroup(" 1 - Static ", 10, 10, 280, 50)
_GUIExtender_Section_Activate($hGUI_1, 2, "", "", 270, 40, 15, 15, 0, 1) ; Normal button

_GUIExtender_Section_Create($hGUI_1, Default, 110)
GUICtrlCreateGroup(" 2 - Extendable ", 10, 70, 280, 100)

_GUIExtender_Section_Create($hGUI_1, -99)

GUICtrlCreateGroup("", -99, -99, 1, 1)

_GUIExtender_Section_Action($hGUI_1, 4, False)

GUISetState()

While 1
	Sleep(10)
WEnd

Func On_Exit()
	Exit
EndFunc