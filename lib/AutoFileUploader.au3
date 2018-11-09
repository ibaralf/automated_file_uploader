; Main file to generate .Execute
; NOTES:
; - Created 11/08/2018
; - Tested only on Win 10

#include <Logger.au3>
#include <Arguments.au3>
#include <WindowUtils.au3>

Global $windowTag = "[Class:#32770]"
Global $directoryTag = "[CLASS:ToolbarWindow32; INSTANCE:3]"
Global $filesTag = "[CLASS:Edit; INSTANCE:1]"

Func _uploadFiles()
   If _isFlagPresent('-h') = True
	  _displayHelp
   EndIf

EndFunc

Func _displayHelp()
   ConsoleWrite("" & @CR)
   ConsoleWrite("Windows Auto File Uploader" & @CR)
   ConsoleWrite("Parameters:  (*) required " & @CR)
   ConsoleWrite("  -d, directory path of files (*)" & @CR)
   ConsoleWrite("  -f, list of files to upload, space separated (*)" & @CR)
   ConsoleWrite("  -h, show help" & @CR)
   ConsoleWrite("" & @CR)
   Exit
EndFunc

_uploadFiles