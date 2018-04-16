#include <Misc.au3>
#NoTrayIcon
#RequireAdmin

_Singleton("AU3_Shortcuts")

; ! = Alt
; + = Shift
; ^ = Control
; # = Windows
HotKeySet("^{PAUSE}",   "Quit")
HotKeySet("^{F6}",      "MoveWindow")

HotKeySet("#{NUMPAD7}", "VolDown")
HotKeySet("#{NUMPAD8}", "PlayPause")
HotKeySet("#{NUMPAD9}", "VolUp")
HotKeySet("#{NUMPAD4}", "SongPrev")
HotKeySet("#{NUMPAD6}", "SongNext")

HotKeySet("#{NUMPAD1}", "Calculator")
HotKeySet("#{NUMPAD2}", "CommandPrompt")
HotKeySet("#{NUMPAD3}", "Cygwin")


While (1)
   Sleep(500)
WEnd


Func Quit()
    ToolTip("Exiting...", 0, 0)
    Sleep(3000)
	Exit
EndFunc


; Misc Functions
Func MoveWindow()
	WinMove("[ACTIVE]", "", 0, 0)
EndFunc


; Media Keys
Func VolDown()
    Send("{VOLUME_DOWN}")
EndFunc

Func VolUp()
    Send("{VOLUME_UP}")
EndFunc

Func PlayPause()
    Send("{MEDIA_PLAY_PAUSE}")
EndFunc

Func SongNext()
    Send("{MEDIA_NEXT}")
EndFunc

Func SongPrev()
    Send("{MEDIA_PREV}")
EndFunc


; Program Shortcuts
Func Calculator()
    Run("calc.exe")
EndFunc

Func CommandPrompt()
    Run("cmd.exe")
EndFunc

Func Cygwin()
    Run("C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -")
    If @error Then
        MsgBox(0, "Error", "Failed to launch with error " & @error)
    EndIf
EndFunc
