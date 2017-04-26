;~~~~~~~~~~~~~~~~~~~~
;      ROCKET
; Author: Edward Tran
;~~~~~~~~~~~~~~~~~~~~

isRocketEnabled=0

enable=images\enable.png
disable=images\disable.png
musicControl=images\music.png

Menu, Tray, Icon, images/logo.ico, 1

Gui -Caption +AlwaysOnTop +ToolWindow
Gui, Margin, 0, 0
Gui, Color, 2B2B2B
Gui, Add, Picture, h30 w30, %disable%
Gui, Show

; Move Active Window to bottom right
WinGetPos X, Y, Width, Height, A
MaxX := A_ScreenWidth - Width
MaxY := A_ScreenHeight - Height - 60
WinMove A, , %MaxX%, %MaxY%

; Watch cursor position
;SetTimer, WatchCursor, 100
;return

; Change color on hover
;WatchCursor:
;    MouseGetPos, xpos, ypos, id, control
;        
;    if (control = Static1) {        
;        Gui, Color, 2B2B2B
;    }
;    else {
;        Gui, Color, 4F4F4F
;    }

; Enable/Disable Rocket using hotkey
; Start + .
LWin & SC034::        
    isRocketEnabled := (isRocketEnabled = 1) ? 0 : 1 

    if isRocketEnabled = 1
        GuiControl, , static1, %enable%
    else 
        GuiControl, , static1, %disable%
        
return

; Enable/Disable Rocket by clicking on the gui
~LButton::
    MouseGetPos, xpos, ypos, id, control

    if !control
        return

    isRocketEnabled := (isRocketEnabled = 1) ? 0 : 1 

    if isRocketEnabled = 1
        GuiControl, , static1, %enable%
    else 
        GuiControl, , static1, %disable%    

return

; Default Start Button behaviour
LWin::
    if isRocketEnabled = 1
        return
    Send {LWin}

return 

; ~~~~~~~~
; Commands
; ~~~~~~~~

; Reload script
; Ctrl-Alt-R
^!r::Reload  

; Always on Top
; Ctrl-Space
^SPACE::
    if isRocketEnabled = 0
        return

    Run Commands\AlwaysOnTop.ahk

return 

; Enable Music Control
; Start-M 
LWin & m::
    if isRocketEnabled = 0
        return

    GuiControl, , static1, %musicControl%

    Sleep, 1000

    if A_PriorKey = p
        Send {Media_Play_Pause}
    else if A_PriorKey = left
        Send {Media_Prev}
    else if A_PriorKey = right
        Send {Media_Next}

    GuiControl, , static1, %enable%

return 

; Launch Terminal
; Start-T
LWin & t::
    if isRocketEnabled = 0
        return

    Run Commands\LaunchTerminal.ahk

return 
