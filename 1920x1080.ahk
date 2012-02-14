#NoEnv          ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay, 1000

; Coordinates for the slice button in 1920x1080:
; 282, 455
;
; Coordinates for the first mission:
; 1555, 350

F1::    ; Press F1 to activate the script
Loop    ; infinite loop unless "break" or "return" is encountered inside.
{  
  Send n                          ; open the companion window
  Sleep 2000                      ; wait 2 seconds
  SendEvent {click 282, 455}      ; click the slicing box
  sleep 2000                      ; wait 2 seconds
  SendEvent {click 1555, 350, 2}  ; double-click the first mission
  sleep 2000                      ; wait 2 seconds
  Send {Esc}                      ; close the menu
  
  ; Look busy for 6 minutes while we wait for our companion to come back
  loop 150
  {
    Send {q down}       ; do some strafing
    sleep 1000
    Send {q up}
    Send {e down}       ; do some strafing
    sleep 1000
    Send {e up}
  }

  ; Sequence of clicks to try and hit the accept button
  sleep 600
  SendEvent {click 340, 740}    ; accept
  sleep 600
  SendEvent {click 340, 750}    ; accept
  sleep 600
  SendEvent {click 340, 760}    ; accept
  sleep 600
  SendEvent {click 340, 770}    ; accept
  sleep 600
  SendEvent {click 340, 785}    ; accept
  sleep 600
  SendEvent {click 340, 800}    ; accept
  sleep 2000
} 
