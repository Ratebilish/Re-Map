#IfWinActive Warcraft III
#SingleInstance force   ;force a single instance
#HotkeyInterval 0   ;disable the warning dialog if a key is held down
#InstallKeybdHook   ;Forces the unconditional installation of the keyboard hook
#UseHook On     ;might increase responsiveness of hotkeys
#MaxThreads 20      ;use 20 (the max) instead of 10 threads
SetBatchLines, -1   ;makes the script run at max speed
SetKeyDelay , -1, 0   ;faster response (might be better with -1, 0)
;Thread, Interrupt , -1, -1 ;not sure what this does, could be bad for timers
SetTitleMatchMode Regex
SetDefaultMouseSpeed, 0 ;Move the mouse faster for mouse moving commands
Process, Priority, AutoHotkey.exe, High

s1 = vk0x67
s2 = vk0x68
s3 = vk0x64
s4 = vk0x65
s5 = vk0x61
s6 = vk0x62
r = vk0x8
SBF = {alt down}{Numpad3 down}{Numpad2 down}{alt up}{Numpad3 up}{Numpad2 up}

1::
~+1::
2::
~+2::
3::
~+3::
4::
~+4::
Space::
~+Space::
6::
~+6::
  {
    if A_ThisHotkey = Space
    SendInput, %SBF%{%s6%}{%r%}
    else
    SendInput, {%A_ThisHotkey%}{%s6%}{%r%} 
  }
  return
