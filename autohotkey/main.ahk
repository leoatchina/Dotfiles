; #是win, !是alt, ^是ctrl, +是shift
#Persistent
SetCapsLockState, AlwaysOff
EnvGet, UserProfile, USERPROFILE
; 检测Scoop安装位置
ScoopPath := "C:\Scoop"
if (FileExist("C:\Scoop"))
    ScoopPath := "C:\Scoop"
else if (FileExist("D:\Scoop"))
    ScoopPath := "D:\Scoop"
else if (FileExist(UserProfile . "\scoop"))
    ScoopPath := UserProfile . "\scoop"
Return
; ------------------------------------
; follow && Reload scripts
; ------------------------------------
CapsLock & r::
if GetKeyState("Alt")
    Reload
else{
    IfWinExist ahk_exe follow.exe
        WinActivate
    else If FileExist(UserProfile . "\AppData\Local\folo\folo.exe")
        Run % UserProfile . "\AppData\Local\folo\folo.exe"
    else
        Run % ScoopPath . "\apps\folo\current\folo.exe"
    Return
}
; ----------------
; 激活不同的软件
; ---------------
; note
CapsLock & t::
if GetKeyState("Alt"){
    IfWinExist Heynote.exe
        WinActivate
    else If FileExist(UserProfile . "\AppData\Local\Programs\Heynote\Heynote.exe")
        Run % UserProfile . "\AppData\Local\Programs\Heynote\Heynote.exe"
    else If FileExist(ScoopPath . "\apps\Heynote\current\Heynote.exe")
        Run % ScoopPath . "\apps\Heynote\current\Heynote.exe"
    Return
}else IfWinExist ahk_exe telegram.exe
    WinActivate
else If FileExist(UserProfile . "\AppData\Roaming\Telegram Desktop\Telegram.exe")
    Run % UserProfile . "\AppData\Roaming\Telegram Desktop\Telegram.exe"
Return
; ----------------
; Explorer
; ----------------
CapsLock & e::
IfWinExist ahk_exe feishu.exe
    WinActivate
else If FileExist(UserProfile . "\AppData\Local\Feishu\Feishu.exe")
    Run % UserProfile . "\AppData\Local\Feishu\Feishu.exe"
Return
CapsLock & o::
if GetKeyState("Alt"){
    IfWinExist ahk_exe joplin.exe
        WinActivate
    else If FileExist(UserProfile . "\AppData\Local\Programs\Joplin\Joplin.exe")
        Run % UserProfile . "\AppData\Local\Programs\Joplin\Joplin.exe"
    else If FileExist(ScoopPath . "\apps\joplin\current\Joplin.exe")
        Run % ScoopPath . "\apps\joplin\current\Joplin.exe"
    Return
}else IfWinExist ahk_exe obsidian.exe
    WinActivate
else If FileExist(ScoopPath . "\apps\obsidian\current\Obsidian.exe")
    Run % ScoopPath . "\apps\obsidian\current\Obsidian.exe"
Return
; editor && browser
CapsLock & 1::
IfWinExist ahk_exe msedge.exe
    WinActivate
else
    Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
Return
CapsLock & 2::
IfWinExist ahk_exe chrome.exe
    WinActivate
else If FileExist("C:\Program Files\Google\Chrome\Application\chrome.exe")
    Run "C:\Program Files\Google\Chrome\Application\chrome.exe"
else
    Run % ScoopPath . "\apps\googlechrome\current\chrome.exe"
Return
CapsLock & b::
IfWinExist ahk_exe zen.exe
    WinActivate
else If FileExist(ScoopPath . "\apps\zen-browser\current\zen.exe")
    Run % ScoopPath . "\apps\zen-browser\current\zen.exe"
else If FileExist(UserProfile . "\AppData\Local\Zen Browser\zen.exe")
    Run % UserProfile . "\AppData\Local\Zen Browser\zen.exe"
else If FileExist("C:\Program Files\Zen Browser\zen.exe")
    Run "C:\Program Files\Zen Browser\zen.exe"
Return
; main editors
CapsLock & 3::
IfWinExist ahk_exe Cursor.exe
    WinActivate
else If FileExist(UserProfile . "\AppData\Local\Programs\Cursor\Cursor.exe")
    Run % UserProfile . "\AppData\Local\Programs\Cursor\Cursor.exe"
Return
CapsLock & 4::
IfWinExist ahk_exe windsurf.exe
    WinActivate
else If FileExist(UserProfile . "\AppData\Local\Programs\Windsurf\Windsurf.exe")
    Run % UserProfile . "\AppData\Local\Programs\Windsurf\Windsurf.exe"
Return
CapsLock & 5::
IfWinExist ahk_exe gvim.exe
    WinActivate
else If FileExist(ScoopPath . "\apps\vim-nightly\current\gvim.exe")
    Run % ScoopPath . "\apps\vim-nightly\current\gvim.exe"
Return
; important progs
CapsLock & 6::
IfWinExist ahk_exe mobaxterm.exe
    WinActivate
else If FileExist(ScoopPath . "\apps\mobaxterm\current\mobaxterm.exe")
    Run % ScoopPath . "\apps\mobaxterm\current\mobaxterm.exe"
Return
CapsLock & 7::
IfWinExist ahk_exe quark.exe
    WinActivate
else If FileExist(UserProfile . "\AppData\Local\Programs\Quark\quark.exe")
    Run % UserProfile . "\AppData\Local\Programs\Quark\quark.exe"
Return
CapsLock & 8::
IfWinExist ahk_exe zed.exe
    WinActivate
else If FileExist(ScoopPath . "\apps\zed\current\zed.exe")
    Run % ScoopPath . "\apps\zed\current\zed.exe"
Return
CapsLock & 9::
IfWinExist ahk_exe positron.exe
    WinActivate
else If FileExist(UserProfile . "\AppData\Local\Programs\positron\positron.exe")
    Run % UserProfile . "\AppData\Local\Programs\positron\positron.exe"
Return
CapsLock & 0::
IfWinExist ahk_exe code.exe
    WinActivate
else If FileExist(UserProfile . "\AppData\Local\Programs\Microsoft VS Code\Code.exe")
    Run % UserProfile . "\AppData\Local\Programs\Microsoft VS Code\Code.exe"
Return
CapsLock & -::
IfWinExist ahk_exe nvim-qt.exe
    WinActivate
else If FileExist(ScoopPath . "\apps\neovim-qt\current\bin\nvim-qt.exe")
    Run % ScoopPath . "\apps\neovim-qt\current\bin\nvim-qt.exe"
Return
CapsLock & =::
IfWinExist ahk_exe neovide.exe
    WinActivate
else If FileExist(ScoopPath . "\apps\neovide\current\neovide.exe")
    Run % ScoopPath . "\apps\neovide\current\neovide.exe"
Return
CapsLock & z::
IfWinExist ahk_exe zotero.exe
    WinActivate
else If FileExist(ScoopPath . "\apps\zotero\current\zotero.exe")
    Run % ScoopPath . "\apps\zotero\current\zotero.exe"
Return
; seach using utools
CapsLock & /::
    Send ^#!f
Return
; windows terminal
CapsLock & f::
if GetKeyState("Alt"){
    IfWinExist ahk_exe notepad--.exe
        WinActivate
    else
        Run % ScoopPath . "\apps\notepad--\current\Notepad--.exe"
    Return
}else IfWinExist ahk_exe WindowsTerminal.exe
    WinActivate
else If FileExist(UserProfile . "\AppData\Local\Microsoft\WindowsApps\wt.exe")
    Run % UserProfile . "\AppData\Local\Microsoft\WindowsApps\wt.exe"
Return
; wezterm
CapsLock & g::
IfWinExist ahk_exe wezterm-gui.exe
    WinActivate
else If FileExist(ScoopPath . "\apps\wezterm-nightly\current\wezterm-gui.exe")
    Run % ScoopPath . "\apps\wezterm-nightly\current\wezterm-gui.exe"
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
Capslock & q::Send, {ESC}
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
    SendInput {Backspace}
else
    SendInput {Del}
return
; ----------------
; Volume control
; ----------------
CapsLock & m::
if GetKeyState("Alt")
    IfWinExist ahk_exe Motrix.exe
        WinActivate
    else If FileExist(UserProfile . "\AppData\Local\Programs\Motrix\Motrix.exe")
        Run % UserProfile . "\AppData\Local\Programs\Motrix\Motrix.exe"
    else If FileExist(ScoopPath . "\apps\motrix\current\motrix.exe")
        Run % ScoopPath . "\apps\motrix\current\motrix.exe"
    else{
        Return
    }
else
    Send {Volume_Mute}
Return
CapsLock & ]::Send {Volume_Up}
CapsLock & [::Send {Volume_Down}
; ----------------
; direction
; like fps games
; ----------------
CapsLock & a::
if GetKeyState("Alt")
    SendInput {Blind}{Home DownTemp}
else
    Send {Blind}{Left DownTemp}
Return
CapsLock & a up::
if GetKeyState("Alt")
    SendInput {Blind}{Home Up}
else
    Send {Blind}{Left Up}
Return
CapsLock & d::
if GetKeyState("Alt")
    SendInput {Blind}{End DownTemp}
else
    Send {Blind}{Right DownTemp}
Return
CapsLock & d up::
if GetKeyState("Alt")
    SendInput {Blind}{End Up}
else
    Send {Blind}{Right Up}
Return
CapsLock & s::
if GetKeyState("Alt")
    SendInput {Blind}{PgDn DownTemp}
else
    Send {Blind}{Down DownTemp}
Return
CapsLock & s up::
if GetKeyState("Alt")
    SendInput {Blind}{PgDn Up}
else
    Send {Blind}{Down Up}
Return
CapsLock & w::
if GetKeyState("Alt")
    SendInput {Blind}{PgUp DownTemp}
else
    Send {Blind}{Up DownTemp}
Return
CapsLock & w up::
if GetKeyState("Alt")
    SendInput {Blind}{PgUp Up}
else
    Send {Blind}{Up Up}
Return
; -----------------
; like vim
; -----------------
CapsLock & h::
if GetKeyState("Alt")
    SendInput {Blind}{Home DownTemp}
else
    Send {Blind}{Left DownTemp}
Return
CapsLock & h up::
if GetKeyState("Alt")
    SendInput {Blind}{Home Up}
else
    Send {Blind}{Left Up}
Return
CapsLock & l::
if GetKeyState("Alt")
    SendInput {Blind}{End DownTemp}
else
    Send {Blind}{Right DownTemp}
Return
CapsLock & l up::
if GetKeyState("Alt")
    SendInput {Blind}{End Up}
else
    Send {Blind}{Right Up}
Return
CapsLock & j::
if GetKeyState("Alt")
    SendInput {Blind}{PgDn DownTemp}
else
    Send {Blind}{Down DownTemp}
Return
CapsLock & j up::
if GetKeyState("Alt")
    SendInput {Blind}{PgDn Up}
else
    Send {Blind}{Down Up}
Return
CapsLock & k::
if GetKeyState("Alt")
    SendInput {Blind}{PgUp DownTemp}
else
    Send {Blind}{Up DownTemp}
Return
CapsLock & k up::
if GetKeyState("Alt")
    SendInput {Blind}{PgUp Up}
else
    Send {Blind}{Up Up}
Return
; ------------------------------------
; Input method control change
; ------------------------------------
; CapsLockToggle
CapsLock & RShift::SendInput {Blind}{CapsLock DownTemp}
CapsLock & RShift up::SendInput {Blind}{CapsLock Up}
; 输入法切换
CapsLock & Backspace::
    SendInput, #{Space}
Return
; 两个输入法切换
CapsLock & Enter::
    SendInput, ^#{Space}
Return
; smart 中英切换
SwitchInputMethod() {
    WinGet, WinID,, A
    ThreadID := DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
    InputLocaleID := DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
    ; English input method
    if (InputLocaleID == 67699721) {
        SendInput, ^#{Space}
    } else {
        SendInput, ^{Space}
    }
}
CapsLock & Space::
    SwitchInputMethod()
Return
; 小狼毫
CapsLock & RCtrl::^`
RCtrl & CapsLock::^`
; ------------------------------------
; utools clipboard
; ------------------------------------
LCtrl & CapsLock::
Send #!c
Return
CapsLock & LCtrl::
Send #!c
Return
CapsLock & y::
Send ^#!c
Return
; ------------------------------------
; copy paste
; ------------------------------------
CapsLock & v::Send {Shift down}{Ins}{Shift up}
CapsLock & c::Send {Ctrl down}{Ins}{Ctrl up}
; ------------------------------------
; 去除复制来的内容里的回车
; ------------------------------------
CapsLock & u::
if GetKeyState("Alt"){
    tmp := RegExReplace(clipboard, "(\S.*?)\R(.*?\S)", "$1 $2")
    clipboard := tmp
    clipwait 0.1
    Return
}
; ------------------------------------
; 将剪贴板的内容转换为纯文本
; ------------------------------------
else{
    Clipboard = %Clipboard%
    clipwait 0.1
    Return
}
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
