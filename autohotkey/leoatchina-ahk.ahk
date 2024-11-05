; #是win, !是alt, ^是ctrl, +是shift
#Persistent
SetCapsLockState, AlwaysOff
; ------------------------------------
; follow && Reload scripts
; ------------------------------------
CapsLock & r::
if GetKeyState("Alt")
    Reload
else
    IfWinExist ahk_exe follow.exe
        WinActivate
    else
        Run "C:\Scoop\apps\follow\current\follow.exe"
    Return
return
; ------------------------------------
; right alt + 1 ~ 0 , and -/= , map to f1-f12
; ------------------------------------
RAlt & 1::
    Send, {F1}
return
RAlt & 2::
    Send, {F2}
return
RAlt & 3::
    Send, {F3}
return
RAlt & 4::
    Send, {F4}
return
RAlt & 5::
    Send, {F5}
return
RAlt & 6::
    Send, {F6}
return
RAlt & 7::
    Send, {F7}
return
RAlt & 8::
    Send, {F8}
return
RAlt & 9::
    Send, {F9}
return
RAlt & 0::
    Send, {F10}
return
RAlt & -::
    Send, {F11}
return
RAlt & =::
    Send, {F12}
return
RShift & Esc::
    Send, {~}
return
RAlt & Esc::
    Send, ``
return
; ----------------
; 激活不同的软件
; ---------------
CapsLock & LShift::
IfWinExist ahk_exe telegram.exe
    WinActivate
else
    Run "C:\Scoop\apps\telegram\current\Telegram.exe"
Return
CapsLock & i::
IfWinExist ahk_exe joplin.exe
    WinActivate
else
    Run "C:\Scoop\apps\joplin\current\Joplin.exe"
Return
CapsLock & t::
IfWinExist ahk_exe logseq.exe
    WinActivate
else
    Run "C:\Scoop\apps\logseq\current\logseq.exe"
Return
CapsLock & o::
IfWinExist ahk_exe obsidian.exe
    WinActivate
else
    Run "C:\Scoop\apps\obsidian\current\Obsidian.exe"
Return
CapsLock & z::
IfWinExist ahk_exe zotero.exe
    WinActivate
else
    Run "C:\Scoop\apps\zotero\current\zotero.exe"
Return
CapsLock & 1::
IfWinExist ahk_exe msedge.exe
    WinActivate
else
    Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
Return
CapsLock & 2::
IfWinExist ahk_exe chrome.exe
    WinActivate
else
    Run "C:\Scoop\apps\googlechrome\current\chrome.exe"
Return
CapsLock & 3::
IfWinExist ahk_exe WindowsTerminal.exe
    WinActivate
else
    Run "C:\Scoop\apps\windows-terminal\current\WindowsTerminal.exe"
Return
CapsLock & 4::
IfWinExist ahk_exe wezterm-gui.exe
    WinActivate
else
    Run "C:\Scoop\apps\wezterm-nightly\current\wezterm-gui.exe"
Return
CapsLock & 5::
IfWinExist ahk_exe cursor.exe
    WinActivate
else
    Run "C:\Scoop\apps\cursor\current\Cursor.exe"
Return
CapsLock & 6::
IfWinExist ahk_exe code.exe
    WinActivate
else
    Run "C:\Scoop\apps\vscode\current\Code.exe"
Return
CapsLock & 7::
IfWinExist ahk_exe quark.exe
    WinActivate
else If FileExist("C:\Users\Admin\AppData\Local\Programs\Quark\quark.exe")
    Run "C:\Users\Admin\AppData\Local\Programs\Quark\quark.exe"
else If FileExist("C:\Users\LEO\AppData\Local\Programs\Quark\quark.exe")
    Run "C:\Users\LEO\AppData\Local\Programs\Quark\quark.exe"
Return
CapsLock & 8::
IfWinExist ahk_exe zen.exe
    WinActivate
else If FileExist("C:\Scoop\apps\zen-browser\current\zen.exe")
    Run "C:\Scoop\apps\zen-browser\current\zen.exe"
else IfWinExist ahk_exe firefox.exe
    WinActivate
else
    Run "C:\Scoop\apps\firefox\current\firefox.exe"
Return
CapsLock & 9::
IfWinExist ahk_exe positron.exe
    WinActivate
else
    Run "C:\Scoop\apps\Positron\current\positron.exe"
Return
CapsLock & 0::
IfWinExist ahk_exe zed.exe
    WinActivate
else If FileExist("C:\Scoop\apps\zed-nightly\current\zed.exe")
    Run "C:\Scoop\apps\zed-nightly\current\zed.exe"
else IfWinExist ahk_exe notepad--.exe
    WinActivate
else
    Run "C:\Scoop\apps\notepad--\current\notepad--.exe"
Return
CapsLock & -::
IfWinExist ahk_exe gvim.exe
    WinActivate
else
    Run "C:\Scoop\apps\vim-nightly\current\gvim.exe"
Return
CapsLock & =::
IfWinExist ahk_exe neovide.exe
    WinActivate
else
    Run "C:\Scoop\apps\neovide\current\neovide.exe"
Return
; ----------------
; screen shot
; ---------------
#f::Send ^{F1}
#b::Send !{F1}
#u::Send !{F2}
; ----------------
; ESC
; ----------------
Capslock & q::
Send {ESC}
Return
; ------------------------------------
; disable ctrl+win+d / shift+space
; ------------------------------------
^<#d::ESC
; ----------------
; Tab/Shift-Tab
; ----------------
CapsLock & n::
Send ^{Tab}
Return
CapsLock & p::
Send ^+{Tab}
Return
; ----------------
; Del/Bs
; ----------------
CapsLock & x::
if GetKeyState("Alt")
    Send {Backspace}
else
    SendInput {Del}
return
; ----------------
; CapsLockToggle
; ----------------
CapsLock & backspace::SendInput {Blind}{CapsLock DownTemp}
CapsLock & backspace up::SendInput {Blind}{CapsLock Up}
; ----------------
; Volume control
; ----------------
CapsLock & m::Send {Volume_Mute}
CapsLock & ]::Send {Volume_Up}
CapsLock & [::Send {Volume_Down}
; ----------------
; Explorer
; ----------------
CapsLock & e::Run explorer.exe
; ----------------
; Left, Down, Up, Right
; ----------------
CapsLock & a::Send {Blind}{Left DownTemp}
CapsLock & a up::Send {Blind}{Left Up}
CapsLock & s::Send {Blind}{Down DownTemp}
CapsLock & s up::Send {Blind}{Down Up}
CapsLock & w::Send {Blind}{Up DownTemp}
CapsLock & w up::Send {Blind}{Up Up}
CapsLock & d::Send {Blind}{Right DownTemp}
CapsLock & d up::Send {Blind}{Right Up}
CapsLock & j::Send {Blind}{Down DownTemp}
CapsLock & j up::Send {Blind}{Down Up}
CapsLock & k::Send {Blind}{Up DownTemp}
CapsLock & k up::Send {Blind}{Up Up}
; ----------------
; Home End
; ----------------
CapsLock & h::SendInput {Blind}{Home DownTemp}
CapsLock & h up::SendInput {Blind}{Home Up}
CapsLock & l::SendInput {Blind}{End DownTemp}
CapsLock & l up::SendInput {Blind}{End Up}
; ----------------
; PgUp PgDn
; ----------------
CapsLock & b::SendInput {Blind}{PgUp DownTemp}
CapsLock & b up::SendInput {Blind}{PgUp Up}
CapsLock & f::SendInput {Blind}{PgDn DownTemp}
CapsLock & f up::SendInput {Blind}{PgDn Up}
; ------------------------------------
; GoldenDict
; ------------------------------------
CapsLock & g::
if GetKeyState("Alt")
    Send ^!+i
else
    Send ^!+g
return
; ------------------------------------
; Input method control change
; ------------------------------------
CapsLock & Enter::
Send {LWin Down}{Space Down}
KeyWait, Enter
Send {LWin Up}{Space Up}
Return
CapsLock & Space::
Send {Ctrl Down}{LWin Down}{Space Down}
KeyWait, Space
Send {Ctrl Up}{LWin Up}{Space Up}
Return
CapsLock & Ctrl::^`
Ctrl & CapsLock::^`
CapsLock & .::^.
; ------------------------------------
; utools clipboard
; ------------------------------------
CapsLock & Alt::#!c
CapsLock & Rshift::^#!c
; ------------------------------------
; 将剪贴板的内容转换为纯文本
; ------------------------------------
CapsLock & y::
Clipboard = %Clipboard%
clipwait 0.1
Return
; ------------------------------------
; 去除复制来的内容里的回车
; ------------------------------------
CapsLock & u::
tmp := RegExReplace(clipboard, "(\S.*?)\R(.*?\S)", "$1 $2")
clipboard := tmp
clipwait 0.1
Return
; ------------------------------------
; copy paste
; ------------------------------------
CapsLock & v::Send {Shift down}{Ins}{Shift up}
CapsLock & c::Send {Ctrl down}{Ins}{Ctrl up}
; ------------------------------------
; proe, 两侧键作为中键
; ------------------------------------
#NoEnv
#SingleInstance Force
#InstallKeybdHook
#InstallMouseHook
#UseHook
#IfWinActive ahk_exe xtop.exe
XButton1::MButton
XButton2::MButton
