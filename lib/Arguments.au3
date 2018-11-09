; Handles command line arguments
; TIP: To add/remove/modify flags, just edit $paramsFlags
#include <StringConstants.au3>
#include <Array.au3>
;#include <Logger.au3>

Local $paramFlags[3] = ["-d", "-f", "-h"]
Local $flagIndexes[3] = [-1, -1, -1]

Func _initializeArguments()
   _getFlagIndexes($CmdLine)
EndFunc

; Run initially to get indexes of flags defined in $paramFlags
Func _getFlagIndexes($passedArgs)
   For $i = 0 to UBound($paramFlags) - 1
	  $flagIndexes[$i] = _ArraySearch($passedArgs, $paramFlags[$i])
	  _logger("INFO :", "Flag Index " & $paramFlags[$i] & " " & $flagIndexes[$i])
   Next
EndFunc

; Checks if flag is passed in the argument
Func _isFlagPresent($flag)
   $flagIndex = _ArraySearch($paramFlags, $flag)
   _logger("INFO :", "FLAGX: " & $flagIndex)
   If $flagIndexes[$flagIndex] = -1 Then
	  Return False
   EndIf
   Return True
EndFunc

; Call to get argument passed with flag
Func _getCmdLineValue($flag)
   $i = _ArraySearch($paramFlags, $flag)
   If $i < 0 Then
	  _logger("WARNING", "Parameter" & $flag & " NOT FOUND." & @CR)
	  Return ""
   Else
	  $startIndex = $flagIndexes[$i]
	  $lastIndex = UBound($CmdLine)
	  _logger("INFO", "FOUND FLAG: " & $startIndex & "::" & $lastIndex)
	  _logger("INFO", "INIT X: " & $i)
	  _logger("Info", "TOTAL Args - " & $lastIndex)
	  For $x = 0 to UBound($paramFlags) - 1
		 if $flag <> $paramFlags[$x] Then
			_logger("Info", "FLAG- " & $paramFlags[$x] & " :: " & $flag)
			$nextFlagIndex = $flagIndexes[$x]
			_logger("Info", "LOOP lastX- " & $lastIndex)
			_logger("Info", "LOOP otherX- " & $nextFlagIndex)
			If $nextFlagIndex < $lastIndex and $nextFlagIndex > $startIndex Then
			   $lastIndex = $nextFlagIndex
			EndIf
		 EndIf
	  Next
	  _logger("Info", "Start Index - " & $startIndex)
	  _logger("Info", "Final Index - " & $lastIndex)
	  $cmdlineValue = ""
	  If $startIndex > 0 Then
		 For $x = $startIndex + 1 to $lastIndex - 1
			$cmdlineValue &= $CmdLine[$x] & " "
		 Next
	  EndIf
	  $cmdlineValue = StringStripWS($cmdlineValue, $STR_STRIPTRAILING)
	  _logger("INFO", ">" & $cmdlineValue & "<")
	  Return $cmdlineValue
   EndIf
EndFunc

; Method calls below to test
; _getFlagIndexes($CmdLine)
; _getCmdLineValue("-r", $CmdLine)
