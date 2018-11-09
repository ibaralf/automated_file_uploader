#include <Logger.au3>
; Windows explorer Uploader

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

Func _sendVerifyDirectory($hWin, $filesCtrl, $dirCtrl, $dirPath)
   $nretry = 0
   $textVerified = False
   While $textVerified <> True and $nretry < 2
	  ControlSetText($hWin, "", $filesCtrl, "")
	  $nretry = $nretry + 1
	  ControlSend($hWin, "", $filesCtrl, $dirPath)
	  Sleep(500)
	  ControlSend($hWin, "", $filesCtrl, "{ENTER}")
	  Sleep(300)
	  $readPath = ControlGetText($hWin, "", $dirCtrl)
	  If StringInStr($readPath, $dirPath) <> 0 Then
		 _logger("INFO", "Setting directory path verified - " & $readPath)
		 $textVerified = True
	  Else
		 _logger("INFO", "Sent path not same - " & $readPath)
		 Sleep(2000)
	  EndIf
   WEnd
   Return $textVerified
EndFunc

Func _sendTextToControl($winTag, $filesCtrl, $textToSend, $dirCtrl)
   $winHandle = _getWindowHandle($winTag, True)
   If IsHWnd($winHandle) = 0 Then
	  _logger("ERROR", "_sendTextToControl needs a valid WindowHandler")
	  Return False
   EndIf
   if _checkControlExist($winHandle, $ctrlTag) Then
	  ControlFocus ($winHandle, "", $ctrlTag )
	  ControlClick($winHandle, "", $ctrlTag)
	  Sleep(100)
	  _sendVerifyDirectory($winHandle, $filesCtrl,
   Else
	  _logger("ERROR", "Control not found - " &$ctrlTag)
   EndIf
EndFunc

Func _navigateToDirectory($winTag, $fileCtrlTag, $directoryStr, $dirCtrlTag)
   $winHandle = _getWindowHandle($winTag, True)
   If IsHWnd($winHandle) = 0 Then
	  _logger("ERROR", "_sendTextToWindow needs a valid WindowHandler")
	  Return False
   EndIf

EndFunc

Global $winId = "[Class:#32770]"
Global $filesId = "[CLASS:Edit; INSTANCE:1]"
Global $dirId = "[CLASS:ToolbarWindow32; INSTANCE:3]"
;_logger("INFO", "START")
;_sendTextToControl("[Class:#32770]", "[CLASS:Edit; INSTANCE:1]", "D:\Users\ibarra.alfonso\Documents")
;_sendTextToControl("[Class:#32770]", "[CLASS:ToolbarWindow32; INSTANCE:3]", "D:\Users\ibarra.alfonso\Documents")
_sendVerifyDirectory($winId, $filesId, $dirId, "D:\Users\ibarra.alfonso\Documents\seed_files")