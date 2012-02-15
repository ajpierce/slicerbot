;;
; Base Options
;
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay, 1000

;;
; Global Variables
;
BaseDir = C:\Users\andrew\Documents\ahk\
AcceptPng     = accept.png
LockboxPng    = lockbox_black.png
LockboxTextPng = lockboxes_black.png
SlicePng      = slice.png
DropdownIcon  = dropdown.png
Tier1         = tier1.png
Tier2         = tier2.png
Tier3         = tier3.png
Tier4         = tier4.png
Tier5         = tier5.png

HaveLoot = false
Done     = false
MaxTier  = 3

F1::    ; Press F1 to activate the script
Loop
{
  Slice()
  Sleep 500
  loop 5
  {
    Shuffle(200,200)
  }
  if Done = true
  {
    MsgBox All done!
    return
  }
}  

F2::    ; Press F2 to stop the madness
Done = true

Slice()
{
  global BaseDir, SlicePng, LockboxTextPng
  Send {n}
  Sleep 1000
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *90 *TransBlack %BaseDir%%SlicePng%
  if ErrorLevel = 0 ; found the slice icon
  {
    SendEvent {click %FoundX%, %FoundY%}
    Sleep 1000
    ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *80 *TransBlack %BaseDir%%LockboxTextPng%
    if ErrorLevel = 0 ; Found a quest that gives lockboxes
    {
      SendEvent {click %FoundX%, %FoundY%, 2}
    }
    else {
      ChangeTier()
    }
  }
  Accept()
  Send {Esc}
}

ChangeTier()
{
}

Accept()
{
  global BaseDir, AcceptPng, HaveLoot
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 *TransBlack %BaseDir%%AcceptPng%
  if ErrorLevel = 0 
  {
    SendEvent {click %FoundX%, %FoundY%}
    sleep 500
    OpenLockbox()
  } 
}

OpenLockbox() ; in your inventory for opening
{
  global BaseDir, LockboxPng
  Send {b}    ; open the inventory

  Sleep 1000
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *100 *TransBlack %BaseDir%%LockboxPng%
  if ErrorLevel = 0
    SendEvent {click %FoundX%, %FoundY%, right}
  Send {Esc}  ; Close the inventory when you're done :)
}

Shuffle(left, right)  ; shuffle left then right for for left ms and right ms
{
    Send {q down}
    sleep %left%
    Send {q up}
    Send {e down}
    sleep %right%
    Send {e up}
}
