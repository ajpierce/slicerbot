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
PendingText   = pending.png
Tier1         = tier1.png
Tier2         = tier2.png
Tier3         = tier3.png
Tier4         = tier4.png
Tier5         = tier5.png

HaveLoot = false
Done     = false
MaxTier  = 4
Strikes  = 0

F1::    ; Press F1 to activate the script
Done = false
Loop
{
  Slice()
  Sleep 500
  loop 5
  {
    Shuffle(200,200)
  }
  OpenLockbox()   ; Open any lockboxes we have lying around
  if Done = true
  {
    MsgBox All done!
    return
  }
}  

F2::    ; Press F2 to stop the madness
Done = true
return

Slice()
{
  global BaseDir, SlicePng
  Send {n}
  Sleep 1000
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *90 *TransBlack %BaseDir%%SlicePng%
  if ErrorLevel = 0 ; found the slice icon
  {
    SendEvent {click %FoundX%, %FoundY%}
    Sleep 1000
    ClickLockboxText()
  }
  Accept()
  CheckPending()
  Send {Esc}
}

CheckPending()
{
  global BaseDir, PendingText
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *90 *TransBlack %BaseDir%%PendingText%
  if ErrorLevel = 0 ; Found a quest that gives lockboxes
  {
    SendEvent {click %FoundX%, %FoundY%, 2}
    sleep 500
    Accept()
  }
}

ClickLockboxText()
{
  global BaseDir, LockboxTextPng, Strikes
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *80 *TransBlack %BaseDir%%LockboxTextPng%
  if ErrorLevel = 0 ; Found a quest that gives lockboxes
  {
    SendEvent {click %FoundX%, %FoundY%, 2}
  }
  else {
    ChangeTier()
    if Strikes < 3
      ClickLockboxText()  ; TODO: Fix recursion?  Does it matter?
    else
      Strikes := 0
  }
}

ChangeTier()
{
  global BaseDir, DropdownIcon, MaxTier, Strikes
  Strikes := Strikes+1
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 *TransBlack %BaseDir%%DropdownIcon%
  if ErrorLevel = 0 ; Found a quest that gives lockboxes
  {
    SendEvent {click %FoundX%, %FoundY%}
    LevelDown := MaxTier-1
    sleep 500
    SetTier%LevelDown%()
  }
}

SetTier3()
{
  global BaseDir, Tier3
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *100 *TransBlack %BaseDir%%Tier3%
  if ErrorLevel = 0 ; Found a quest that gives lockboxes
  {
    SendEvent {click %FoundX%, %FoundY%}
  }
  else
  {
    SetTier2()
  }
}

SetTier2()
{
  global BaseDir, Tier2
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *100 *TransBlack %BaseDir%%Tier2%
  if ErrorLevel = 0 ; Found a quest that gives lockboxes
  {
    SendEvent {click %FoundX%, %FoundY%}
  }
  else
  {
    SetTier1()
  }
}

SetTier1()
{
  global BaseDir, Tier2
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *100 *TransBlack %BaseDir%%Tier1%
  if ErrorLevel = 0 ; Found a quest that gives lockboxes
  {
    SendEvent {click %FoundX%, %FoundY%}
  }
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
