;#include <Logger.au3>
; Windows explorer Uploader
; TODO: Some rechecking might be overkill, modify as this
;       becomes more robust.
; NOTES:
; - Giving control focus then clicking seems to ensure control is truly active
;   ControlFocus
;   ControlClick

Func _getWindowHandle($winTag, $activateWindow)
   $winHandle = ""
   $nretry = 0
   $windowFound = False
   WinWait($winTag, "", 5)
   While $windowFound <> True and $nretry < 3
	  _logger("INFO", "SEACH FOR WIN - " & $winTag)
	  $nretry = $nretry + 1
	  If WinExists($winTag) Then
		 $winHandle = WinGetHandle($winTag)
		 If @error Then
			_logger("WARNING", "Error getting window handle, retrying - " & $winTag)
		 Else
			_logger("INFO", "Window handle found - " & $winTag)
			$windowFound = True
		 EndIf
	  Else
		 _logger("INFO", "Finding window, retrying - " & $winTag)
		 Sleep(1000)
	  EndIf
   WEnd
   If $nretry = 3 Then
	  _logger("ERROR", "Window not found - " & $winTag)
   Else
	  If $activateWindow = True Then
		 WinActivate($winHandle)
		 WinWaitActive($winHandle, "", 8)
	  EndIf
   EndIf
   Return $winHandle
EndFunc

Func _checkControlExist($winTag, $ctrlTag)
   $winHandle = $winTag
   If IsHWnd($winTag) = 0 Then
	  $winHandle = _getWindowHandle($winTag, True)
   EndIf
   $ctrlHandle = ""
   $nretry = 0
   $ctrlFound = False
   While $ctrlFound <> True and $nretry < 2
	  _logger("INFO", "SEACHING CONTROL - " & $ctrlTag)
	  $nretry = $nretry + 1
	  $ctrlHandle = ControlGetHandle($winHandle, "", $ctrlTag)
	  If $ctrlHandle = 0 Then
		 _logger("WARNING", "Control Handle not found, retry - " & $ctrlTag)
		 sleep(1000)
	  Else
		 _logger("INFO", "Control handle found - " & $ctrlTag)
		 $ctrlFound = True
	  EndIf
   WEnd
   Return $ctrlFound
EndFunc

Func _clickControl($hWin, $btnCtrl)
   If _checkControlExist($hWin, $btnCtrl) = True Then
	  ControlClick ($hWin, "", $btnCtrl)
   Else
	  _logger("ERROR", "Cannot click control not found - " & $btnCtrl)
   EndIf
EndFunc

; Wait max of 4 seconds till windows is closed
Func _waitTillWindowClosed($hWin)
   $winStillExist = True
   $nwait = 0
   While $winStillExist and $nwait < 5
	  $nwait = $nwait + 1
	  If WinExists($hWin) Then
		 _logger("INFO", "Window still exist, waiting")
		 Sleep(1000)
	  Else
		 $winStillExist = False
	  EndIf
   WEnd
   If $winStillExist Then
	  _logger("ERROR", "Window did not close")
	  Return False
   EndIf
   _logger("INFO", "Window verified closed")
   Return True
EndFunc

; Specific method to set the directory path via the files ControlClick. This avoid
; having to right click, delete, then set path.
; However, several other ways to accomplish this.
Func _sendVerifyDirectory($hWin, $filesCtrl, $dirCtrl, $dirPath)
   $nretry = 0
   $textVerified = False
   While $textVerified <> True and $nretry < 2
	  ControlFocus ($hWin, "", $filesCtrl)
	  ControlClick ($hWin, "", $filesCtrl)
	  ControlSetText($hWin, "", $filesCtrl, "")
	  $nretry = $nretry + 1
	  ControlSend($hWin, "", $filesCtrl, $dirPath, "{ENTER}")
	  Sleep(300)
	  ControlSend($hWin, "", $filesCtrl, "{ENTER}")
	  Sleep(800)
	  $readPath = ControlGetText($hWin, "", $dirCtrl)
	  If StringInStr($readPath, $dirPath) <> 0 Then
		 _logger("INFO", "Setting directory path verified - " & $readPath)
		 $textVerified = True
	  Else
		 _logger("INFO", "Sent path not same - " & $dirPath & "::" & $readPath)
		 Sleep(2000)
	  EndIf
   WEnd
   Return $textVerified
EndFunc

; TODO: refactor to combine with _sendVerifyDirectoy
Func _setControlText($hWin, $ctrlTag, $setText)
   $nretry = 0
   $textVerified = False
   While $textVerified <> True and $nretry < 2
	  ControlSetText($hWin, "", $ctrlTag, "")
	  Sleep(1000)
	  ControlSend($hWin, "", $ctrlTag, $setText)
	  Sleep(300)
	  $readText = ControlGetText($hWin, "", $ctrlTag)
	  If $readText = $setText Then
		 _logger("INFO", "Send control text verified - " & $readText)
		 $textVerified = True
	  Else
		 _logger("INFO", "Sent text not same - " & $readText)
		 Sleep(2000)
	  EndIf
   WEnd
EndFunc

Func _sendTextToControl($hWin, $filesCtrl, $textToSend)
   $isSuccess = False
   ;$winHandle = _getWindowHandle($winTag, True)
   ;If IsHWnd($winHandle) = 0 Then
	;  _logger("ERROR", "_sendTextToControl needs a valid WindowHandler")
	;  Return False
   ;EndIf
   if _checkControlExist($hWin, $filesCtrl) = True Then
	  ; Overkill? might be
	  ControlFocus ($hWin, "", $filesCtrl )
	  ControlClick($hWin, "", $filesCtrl)
	  Sleep(100)
	  $isSuccess = _setControlText($hWin, $filesCtrl, $textToSend)
   Else
	  _logger("ERROR", "Control not found - " &$filesCtrl)
   EndIf
   Return $isSuccess
EndFunc

; NOT USED
Func _navigateToDirectory($winTag, $fileCtrlTag, $directoryStr, $dirCtrlTag)
   $winHandle = _getWindowHandle($winTag, True)
   If IsHWnd($winHandle) = 0 Then
	  _logger("ERROR", "_sendTextToWindow needs a valid WindowHandler")
	  Return False
   EndIf

EndFunc

; For testing
;Global $winId = "[Class:#32770]"
;Global $filesId = "[CLASS:Edit; INSTANCE:1]"
;Global $dirId = "[CLASS:ToolbarWindow32; INSTANCE:3]"
;_logger("INFO", "START")
;_sendTextToControl("[Class:#32770]", "[CLASS:Edit; INSTANCE:1]", "D:\Users\ibarra.alfonso\Documents")
;_sendTextToControl("[Class:#32770]", "[CLASS:ToolbarWindow32; INSTANCE:3]", "D:\Users\ibarra.alfonso\Documents")
;_sendVerifyDirectory($winId, $filesId, $dirId, "D:\Users\ibarra.alfonso\Documents\seed_files")

