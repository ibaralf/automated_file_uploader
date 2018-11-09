; Logger for debugging or creating log files of events executed.
; TODO: Create env vars to control stdout and add logging to file
Func _logger($dbgLevel, $message)
   ConsoleWrite($dbgLevel & ": " & $message & @CR)
   If EnvGet("AUTOIT_DEBUG") <> "" Then
	  ConsoleWrite(_NowDate() & " " & $dbgLevel & ": " & $message & @CR)
   EndIf
   If EnvGet("AUTOIT_DISABLE_LOG") <> "" Then
	  ; file logging here
   EndIf

EndFunc
