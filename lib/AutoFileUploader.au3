; Main file to generate .Execute
; NOTES:
; - Created 11/08/2018
; - Tested only on Win 10, please create a PR if you
;   add other Win version support
; TODO:
; - support spaces in file names

#include <Logger.au3>
#include <Arguments.au3>
#include <WindowUtils.au3>

; Windows explorer (not the browser, leave it to MS to not come up
; with a different name :)
Global $windowTag = "[Class:#32770]" ; Window class
Global $directoryTag = "[CLASS:ToolbarWindow32; INSTANCE:3]" ; Directory  path control (top field)
Global $filesTag = "[CLASS:Edit; INSTANCE:1]" ; Files control (near botton txt field)
Global $openButtonTag = "[CLASS:Button; INSTANCE:1]"
Global $cancelButtonTag = "[CLASS:Button; INSTANCE:2]"

Func _runUploader()
   _initializeArguments()
   If _isFlagPresent('-h') = True Then
	  _displayHelp()
   EndIf
   If _isFlagPresent('-d') <> True or _isFlagPresent('-f') <> True Then
	  _displayRequirements()
   EndIf
   _uploadFiles()
EndFunc

Func _uploadFiles()
   $hWin = _getWindowHandle($windowTag, True)
   $directory = _getCmdLineValue('-d')
   $files = _getCmdLineValue('-f')
   $files = _addQuotes($files)
   _logger("INFO", "passed directory: " & $directory)
   _logger("INFO", "passed files: " & $files)
   _sendVerifyDirectory($hWin, $filesTag, $directoryTag, $directory)
   _sendTextToControl($hWin, $filesTag, $files)
   _clickControl($hWin, $openButtonTag)
   If _waitTillWindowClosed($hWin) <> True Then
	  _clickControl($hWin, $openButtonTag)
   EndIf
EndFunc

Func _addQuotes($spacedString)
   $quotedString = ""
   $arrayValues = StringSplit($spacedString, " ")
   For $i = 1 To $arrayValues[0]
	  $fname = $arrayValues[$i]
	  $quotedString = $quotedString & '"' & $fname & '" '
   Next
   Return StringStripWS($quotedString, $STR_STRIPTRAILING)
EndFunc

Func _displayHelp()
   ConsoleWrite("" & @CR)
   ConsoleWrite("Windows Auto File Uploader" & @CR)
   ConsoleWrite("Parameters:  (*) required " & @CR)
   ConsoleWrite("  -d, directory path of files (*)" & @CR)
   ConsoleWrite("  -f, list of files to upload, space separated (*)" & @CR)
   ConsoleWrite("  -h, show help" & @CR)
   ConsoleWrite("Ex: " & @CR)
   ConsoleWrite("  ps>  AutoFileUploader.exe -d D:\Users\ibarraa\Documents -f fname1.txt fname2.txt" & @CR)
   ConsoleWrite("" & @CR)
   Exit
EndFunc

Func _displayRequirements()
   ConsoleWrite("" & @CR)
   ConsoleWrite("MISSING REQUIRED PARAMETERS: (see below)" & @CR)
   _displayHelp()
EndFunc

_runUploader()

;~ ;$s1 = "D:\Users\ibarra.alfonso\Documents\seed_files "
;~ $s2 = "Address: D:\Users\ibarra.alfonso\Documents\seed_files"

;~ If StringInStr($s2, $s1) Then
;~    ConsoleWrite("STR FOUND")
;~ EndIf
