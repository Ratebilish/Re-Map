
#UseHook
IniRead, Key1, IniFile.ini, Section, Key1, % A_Space
IniRead, Key2, IniFile.ini, Section, Key2, % A_Space 
IniRead, Key3, IniFile.ini, Section, Key3, % A_Space
IniRead, Key4, IniFile.ini, Section, Key4, % A_Space
IniRead, Key5, IniFile.ini, Section, Key5, % A_Space
IniRead, Key6, IniFile.ini, Section, Key6, % A_Space

Gui, Add, Hotkey, vKey1, % Key1
Gui, Add, Hotkey, vKey2, % Key2
Gui, Add, Hotkey, vKey3, % Key3
Gui, Add, Hotkey, vKey4, % Key4
Gui, Add, Hotkey, vKey5, % Key5
Gui, Add, Hotkey, vKey6, % Key6
Gui, Add, Button, gSave, Save
Gui, Show, w250 h200, ReMap 0.0.2
return

Save:
  Gui, Submit, NoHide
  Hotkey, % PrKey1, off, UseErrorLevel
  Hotkey, % PrKey1 := Key1, Key1, on, UseErrorLevel
  Hotkey, % PrKey2, off, UseErrorLevel
  Hotkey, % PrKey2 := Key2, Key2, on, UseErrorLevel
  Hotkey, % PrKey3, off, UseErrorLevel
  Hotkey, % PrKey3 := Key3, Key3, on, UseErrorLevel
  Hotkey, % PrKey4, off, UseErrorLevel
  Hotkey, % PrKey4 := Key4, Key4, on, UseErrorLevel
  Hotkey, % PrKey5, off, UseErrorLevel
  Hotkey, % PrKey5 := Key5, Key5, on, UseErrorLevel
  Hotkey, % PrKey6, off, UseErrorLevel
  Hotkey, % PrKey6 := Key6, Key6, on, UseErrorLevel
  IniWrite, % Key1, IniFile.ini, Section, Key1
  IniWrite, % Key2, IniFile.ini, Section, Key2
  IniWrite, % Key3, IniFile.ini, Section, Key3
  IniWrite, % Key4, IniFile.ini, Section, Key4
  IniWrite, % Key5, IniFile.ini, Section, Key5
  IniWrite, % Key6, IniFile.ini, Section, Key6
  r = vk0x8
  s1 = {%Key1%}{vk0x67}{%r%}
  s2 = {%Key2%}{vk0x68}{%r%}
  s3 = {%Key3%}{vk0x64}{%r%}
  s4 = {%Key4%}{vk0x65}{%r%}
  s5 = {%Key5%}{vk0x61}{%r%}
  s6 = {%Key6%}{vk0x62}{%r%}
  SBF = {alt down}{Numpad3 down}{Numpad2 down}{alt up}{Numpad3 up}{Numpad2 up}
  return

#IfWinActive Warcraft III
#SingleInstance force   ;force a single instance
#HotkeyInterval 0   ;disable the warning dialog if a key is held down
#InstallKeybdHook   ;Forces the unconditional installation of the keyboard hook
#UseHook On     ;might increase responsiveness of hotkeys
#MaxThreads 20      ;use 20 (the max) instead of 10 threads
SetBatchLines, -1   ;makes the script run at max speed
SetKeyDelay , -1, 0   ;faster response (might be better with -1, 0)
Process, Priority, AutoHotkey.exe, High
Key1:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x67}{%r%}
      else
      SendInput, %s1%
  }
  return
Key2:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x68}{%r%}
      else
      SendInput, %s2%
  }
  return

Key3:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x64}{%r%}
      else
      SendInput, %s3%
  }
  return

Key4:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x65}{%r%}
      else
      SendInput, %s4%
  }
  return

Key5:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x61}{%r%}
      else
      SendInput, %s5%
  }
  return

Key6:
  Loop 1
  {
      if A_ThisHotkey = Space
      SendInput, %SBF%{vk0x62}{%r%}
      else
      SendInput, %s6%
  }
  return
GuiClose:
  ExitApp
