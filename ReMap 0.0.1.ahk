#SingleInstance force
#NoEnv
SetBatchLines, -1

#ctrls = 6  ;How many Hotkey controls to add?
Loop,% #ctrls {
 Gui, Add, Text, xm, Enter Hotkey #%A_Index%:
 IniRead, savedHK%A_Index%, Hotkeys.ini, Hotkeys, %A_Index%, %A_Space%
 If savedHK%A_Index%                                       ;Check for saved hotkeys in INI file.
  Hotkey,% savedHK%A_Index%, Label%A_Index%                 ;Activate saved hotkeys if found.
 StringReplace, noMods, savedHK%A_Index%, ~                  ;Remove tilde (~) and Win (#) modifiers...
 StringReplace, noMods, noMods, #,,UseErrorLevel              ;They are incompatible with hotkey controls (cannot be shown).
 Gui, Add, Hotkey, x+6 vHK%A_Index% gGuiLabel, %noMods%        ;Add hotkey controls and show saved hotkeys.
 Gui, Add, CheckBox, x+6 vCB%A_Index% Checked%ErrorLevel%, Win  ;Add checkboxes to allow the Windows key (#) as a modifier...
}                                                                ;Check the box if Win modifier is used.
Gui, Show,,Re:Map 0.0.2
  r = vk0x8
  s1 = {%Label1%}{vk0x67}{%r%}
  s2 = {%Label2%}{vk0x68}{%r%}
  s3 = {%Label3%}{vk0x64}{%r%}
  s4 = {%Label4%}{vk0x65}{%r%}
  s5 = {%Label5%}{vk0x61}{%r%}
  s6 = {%Label6%}{vk0x62}{%r%}
  SBF = {alt down}{Numpad3 down}{Numpad2 down}{alt up}{Numpad3 up}{Numpad2 up}
return
GuiClose:
 ExitApp

GuiLabel:
 If %A_GuiControl% in +,^,!,+^,+!,^!,+^!    ;If the hotkey contains only modifiers, return to wait for a key.
  return
 If InStr(%A_GuiControl%,"vk07")            ;vk07 = MenuMaskKey (see below)
  GuiControl,,%A_GuiControl%, % lastHK      ;Reshow the hotkey, because MenuMaskKey clears it.
 Else
  validateHK(A_GuiControl)
return

validateHK(GuiControl) {
 global lastHK
 Gui, Submit, NoHide
 lastHK := %GuiControl%                     ;Backup the hotkey, in case it needs to be reshown.
 num := SubStr(GuiControl,3)                ;Get the index number of the hotkey control.
 If (HK%num% != "") {                       ;If the hotkey is not blank...
  StringReplace, HK%num%, HK%num%, SC15D, AppsKey      ;Use friendlier names,
  StringReplace, HK%num%, HK%num%, SC154, PrintScreen  ;  instead of these scan codes.
  If CB%num%                                ;  If the 'Win' box is checked, then add its modifier (#).
   HK%num% := "#" HK%num%
  checkDuplicateHK(num)
 }
 If (savedHK%num% || HK%num%)               ;Unless both are empty,
  setHK(num, savedHK%num%, HK%num%)         ;  update INI/GUI
}

checkDuplicateHK(num) {
 global #ctrls
 Loop,% #ctrls
  If (HK%num% = savedHK%A_Index%) {
   dup := A_Index
   Loop,6 {
    GuiControl,% "Disable" b:=!b, HK%dup%   ;Flash the original hotkey to alert the user.
    Sleep,200
   }
   GuiControl,,HK%num%,% HK%num% :=""       ;Delete the hotkey and clear the control.
   break
  }
}

setHK(num,INI,GUI) {
 If INI                           ;If previous hotkey exists,
  Hotkey, %INI%, Label%num%, Off  ;  disable it.
 If GUI                           ;If new hotkey exists,
  Hotkey, %GUI%, Label%num%, On   ;  enable it.
 IniWrite,% GUI ? GUI:null, Hotkeys.ini, Hotkeys, %num%
 savedHK%num%  := HK%num%
 TrayTip, Label%num%,% !INI ? GUI " ON":!GUI ? INI " OFF":GUI " ON`n" INI " OFF"
}

#MenuMaskKey vk07                 ;Requires AHK_L 38+
#If ctrl := HotkeyCtrlHasFocus()
 *AppsKey::                       ;Add support for these special keys,
 *BackSpace::                     ;  which the hotkey control does not normally allow.
 *Delete::
 *Enter::
 *Escape::
 *Pause::
 *PrintScreen::
 *Space::
 *Tab::
  modifier := ""
  If GetKeyState("Shift","P")
   modifier .= "+"
  If GetKeyState("Ctrl","P")
   modifier .= "^"
  If GetKeyState("Alt","P")
   modifier .= "!"
  Gui, Submit, NoHide             ;If BackSpace is the first key press, Gui has never been submitted.
  If (A_ThisHotkey == "*BackSpace" && %ctrl% && !modifier)   ;If the control has text but no modifiers held,
   GuiControl,,%ctrl%                                       ;  allow BackSpace to clear that text.
  Else                                                     ;Otherwise,
   GuiControl,,%ctrl%, % modifier SubStr(A_ThisHotkey,2)  ;  show the hotkey.
  validateHK(ctrl)
 return
#If

HotkeyCtrlHasFocus() {
 GuiControlGet, ctrl, Focus       ;ClassNN
 If InStr(ctrl,"hotkey") {
  GuiControlGet, ctrl, FocusV     ;Associated variable
  Return, ctrl
 }
}

;These labels may contain any commands for their respective hotkeys to perform.
Label1:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x67}{%r%}
      else
      SendInput, %s1%
  }
  return
Label2:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x67}{%r%}
      else
      SendInput, %s2%
  }
  return

Label3:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x67}{%r%}
      else
      SendInput, %s3%
  }
  return

Label4:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x67}{%r%}
      else
      SendInput, %s4%
  }
  return

Label5:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x67}{%r%}
      else
      SendInput, %s5%
  }
  return

Label6:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x67}{%r%}
      else
      SendInput, %s6%
  }
  return
