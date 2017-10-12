;~ This software was designed by the power of boredom and lazyness
;~ use with caution !
;~ the subnet mask is always 255.255.255.0
;~ V0.1 beta :v (25/11/2016)
;~ A.A Productions


#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <WindowsConstants.au3>

#RequireAdmin  			;to be compiled with the software !!!

#Region ### START Koda GUI section ###
Global $Form1_1 = GUICreate("Fast IP Changer :D", 267, 400, -1, -1)

Global $Group1 = GUICtrlCreateGroup(" IP Setting  ", 24, 16, 217, 225)
Global $DhcpButton = GUICtrlCreateRadio("DHCP", 40, 40, 113, 17)
Global $Radio2 = GUICtrlCreateRadio("192.168.1.200  /  192.168.1.1", 40, 72, 209, 17)
Global $Radio3 = GUICtrlCreateRadio("192.168.0.200  /  192.168.0.254", 40, 104, 209, 17)
Global $Radio4 = GUICtrlCreateRadio("192.168.0.200  /  192.168.0.1", 40, 136, 177, 17)
Global $Custom = GUICtrlCreateRadio("Custom", 40, 160, 113, 17)
Global $IPAddress1 = _GUICtrlIpAddress_Create($Form1_1, 56, 184, 130, 21)
_GUICtrlIpAddress_Set($IPAddress1, "192.168.1.203")
Global $IPAddress2 = _GUICtrlIpAddress_Create($Form1_1, 56, 208, 130, 21)
_GUICtrlIpAddress_Set($IPAddress2, "192.168.1.1")
GUICtrlCreateGroup("", -99, -99, 1, 1)

Global $Group2 = GUICtrlCreateGroup(" DNS Setting", 24, 248, 217, 97)
Global $Radio5 = GUICtrlCreateRadio("Google DNS", 40, 272, 113, 17)
;GUICtrlSetState(-1, $GUI_DISABLE)
Global $Radio6 = GUICtrlCreateRadio("Open DNS", 40, 304, 113, 17)
;GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("", -99, -99, 1, 1)

Global $ApplyButton = GUICtrlCreateButton("Apply", 32, 360, 81, 25)
Global $ExitButton = GUICtrlCreateButton("Exit", 152, 360, 81, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $cmd1 ,$cmd2

While 1
	$nMsg = GUIGetMsg()

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $DhcpButton
			GUICtrlSetState ( $Radio5, 132 )
			GUICtrlSetState ( $Radio6, 132 )
		Case $Radio2
			GUICtrlSetState ( $Radio5, 65 )
			GUICtrlSetState ( $Radio6, 64 )

		Case $Radio3
			GUICtrlSetState ( $Radio5, 65 )
			GUICtrlSetState ( $Radio6, 64 )

		Case $Radio4
			GUICtrlSetState ( $Radio5, 65 )
			GUICtrlSetState ( $Radio6, 64 )

		Case $Custom
			GUICtrlSetState ( $Radio5, 65 )
			GUICtrlSetState ( $Radio6, 64 )

		Case $ApplyButton
			If GUICtrlRead($DhcpButton) = $GUI_CHECKED Then
				$cmd1 = 'netsh interface ip set address name="Wireless Network Connection" dhcp'
				$cmd2 = 'netsh interface ip set dns name="Wireless Network Connection" dhcp'

			ElseIf GUICtrlRead($Radio2) = $GUI_CHECKED Then
				$cmd1 = 'netsh interface ip set address "Wireless Network Connection" static "192.168.1.200" "255.255.255.0" "192.168.1.1"'

			ElseIf GUICtrlRead($Radio3) = $GUI_CHECKED Then
				$cmd1 = 'netsh interface ip set address "Wireless Network Connection" static "192.168.0.200" "255.255.255.0" "192.168.0.254"'

			ElseIf GUICtrlRead($Radio4) = $GUI_CHECKED then
				$cmd1 = 'netsh interface ip set address "Wireless Network Connection" static "192.168.0.200" "255.255.255.0" "192.168.0.1"'
			ElseIf GUICtrlRead($Custom) = $GUI_CHECKED then
				$cmd1 = 'netsh interface ip set address "Wireless Network Connection" static "' & _GUICtrlIpAddress_Get($IPAddress1) & '" "255.255.255.0" "' & _GUICtrlIpAddress_Get($IPAddress2) & '"'
;~ 				MsgBox(0,0,'netsh interface ip set address "Wireless Network Connection" static "' & _GUICtrlIpAddress_Get($IPAddress1))
			EndIf


			If GUICtrlRead($Radio5) = $GUI_CHECKED Then
				$cmd2 = 'netsh interface ip set dns name="Wireless Network Connection" static 8.8.8.8 && netsh interface ip add dns name="Wireless Network Connection" 8.8.4.4 index=2'
			ElseIf GUICtrlRead($Radio6) = $GUI_CHECKED Then
				$cmd2 = 'netsh interface ip set dns name="Wireless Network Connection" static 208.67.222.222 && netsh interface ip add dns name="Wireless Network Connection" 208.67.220.220 index=2'
			EndIf

			If $cmd1 = '' Or $cmd2 ='' Then
			Else
				Local $nResult = Run('"' & @ComSpec & '" /c ' & $cmd1 & ' && ' & $cmd2, @SystemDir);, @SW_HIDE)
				ProcessWaitClose($nResult)
;~ 				MsgBox (0 ,"lol",'"' & @ComSpec & '" /c /E:ON ' & $cmd1 & ' & ' & $cmd2)
			EndIf

		Case $ExitButton
			Exit


	EndSwitch
WEnd

















