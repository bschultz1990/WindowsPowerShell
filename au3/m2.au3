HotKeySet("{ESC}", "Terminate")

While 1
    MouseMove(@DesktopWidth / 2, @DesktopHeight / 2)
    Sleep(1000)
    MouseMove(@DesktopWidth / 2, (@DesktopHeight / 2) + 1)
WEnd

Func Terminate()
    Exit
EndFunc
