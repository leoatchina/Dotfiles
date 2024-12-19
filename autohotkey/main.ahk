; #是win, !是alt, ^是ctrl, +是shift
#Persistent
EnvGet, UserProfile, USERPROFILE
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
    else If FileExist(UserProfile . "\AppData\Local\Follow\Follow.exe")
        Run % UserProfile . "\AppData\Local\Follow\Follow.exe"
    else
        Run "C:\Scoop\apps\follow\current\follow.exe"
    Return
return
; ----------------
; 激活不同的软件
; ---------------
CapsLock & i::
IfWinExist ahk_exe joplin.exe
    WinActivate
else
    Run "C:\Scoop\apps\joplin\current\Joplin.exe"
Return
CapsLock & t::
if GetKeyState("Alt"){
    IfWinExist superProductivity.exe
        WinActivate
    else If FileExist("C:\Scoop\apps\super-productivity\current\Super Productivity.exe")
        Run "C:\Scoop\apps\super-productivity\current\Super Productivity.exe"
    else If FileExist("C:\Program Files\WindowsApps\53707johannesjo.SuperProductivity_10.1.1.0_x64__ch45amy23cdv6\app\superProductivity.exe")
        Run "C:\Program Files\WindowsApps\53707johannesjo.SuperProductivity_10.1.1.0_x64__ch45amy23cdv6\app\superProductivity.exe"
    Return
}
else {
    IfWinExist ahk_exe telegram.exe
        WinActivate
    else
        Run "C:\Scoop\apps\telegram\current\Telegram.exe"
    Return
}
CapsLock & o::
IfWinExist ahk_exe obsidian.exe
    WinActivate
else
    Run "C:\Scoop\apps\obsidian\current\Obsidian.exe"
Return
CapsLock & y::
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
else If FileExist("C:\Scoop\apps\windows-terminal\current\WindowsTerminal.exe")
    Run "C:\Scoop\apps\windows-terminal\current\WindowsTerminal.exe"
else If FileExist("C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.21.2911.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe")
    Run "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.21.2911.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe"
Return
CapsLock & 4::
if GetKeyState("Alt"){
    IfWinExist ahk_exe wezterm-gui.exe
        WinActivate
    else If FileExist("C:\Scoop\apps\wezterm-nightly\current\wezterm-gui.exe")
        Run "C:\Scoop\apps\wezterm-nightly\current\wezterm-gui.exe"
    else If FileExist("C:\Scoop\apps\wezterm\current\wezterm-gui.exe")
        Run "C:\Scoop\apps\wezterm\current\wezterm-gui.exe"
    Return
}else{
    IfWinExist ahk_exe alacritty.exe
        WinActivate
    else If FileExist("C:\Scoop\apps\alacritty\current\alacritty.exe")
        Run "C:\Scoop\apps\alacritty\current\alacritty.exe"
    Return
}
CapsLock & 5::
IfWinExist ahk_exe windsurf.exe
    WinActivate
else If FileExist(UserProfile . "\AppData\Local\Programs\Windsurf\Windsurf.exe")
    Run % UserProfile . "\AppData\Local\Programs\Windsurf\Windsurf.exe"
Return
CapsLock & 6::
IfWinExist ahk_exe cursor.exe
    WinActivate
else If FileExist(UserProfile . "\AppData\Local\Programs\cursor\Cursor.exe")
    Run % UserProfile . "\AppData\Local\Programs\cursor\Cursor.exe"
else
    Run "C:\Scoop\apps\cursor\current\Cursor.exe"
Return
CapsLock & 7::
IfWinExist ahk_exe quark.exe
    WinActivate
else If FileExist(UserProfile . "\AppData\Local\Programs\Quark\quark.exe")
    Run % UserProfile . "\AppData\Local\Programs\Quark\quark.exe"
Return
CapsLock & 8::
if GetKeyState("Alt"){
    IfWinExist ahk_exe firefox.exe
        WinActivate
    else
        Run "C:\Scoop\apps\firefox\current\firefox.exe"
    Return
}
else IfWinExist ahk_exe zen.exe
    WinActivate
else If FileExist("C:\Program Files\Zen Browser\zen.exe")
    Run "C:\Program Files\Zen Browser\zen.exe"
Return
CapsLock & 9::
IfWinExist ahk_exe positron.exe
    WinActivate
else
    Run "C:\Scoop\apps\Positron\current\positron.exe"
Return
CapsLock & 0::
if GetKeyState("Alt"){
    IfWinExist ahk_exe zed.exe
        WinActivate
    else If FileExist("C:\Scoop\apps\zed-nightly\current\zed.exe")
        Run "C:\Scoop\apps\zed-nightly\current\zed.exe"
    Return
}
else IfWinExist ahk_exe code.exe
    WinActivate
else If FileExist("C:\Users\Admin\AppData\Local\Programs\Microsoft VS Code\Code.exe")
    Run % UserProfile . "\AppData\Local\Programs\Microsoft VS Code\Code.exe"
else If FileExist("C:\Scoop\apps\vscode\current\Code.exe")
    Run "C:\Scoop\apps\vscode\current\Code.exe"
Return
CapsLock & -::
IfWinExist ahk_exe gvim.exe
    WinActivate
else If FileExist("C:\Scoop\apps\vim-nightly\current\gvim.exe")
    Run "C:\Scoop\apps\vim-nightly\current\gvim.exe"
Return
CapsLock & =::
if GetKeyState("Alt"){
    IfWinExist ahk_exe neovide.exe
        WinActivate
    else If FileExist("C:\Scoop\apps\neovide\current\neovide.exe")
        Run "C:\Scoop\apps\neovide\current\neovide.exe"
    Return
}
else IfWinExist ahk_exe nvim-qt.exe
    WinActivate
else If FileExist("C:\Scoop\apps\neovim-qt\current\bin\nvim-qt.exe")
    Run "C:\Scoop\apps\neovim-qt\current\bin\nvim-qt.exe"
Return
CapsLock & \::
IfWinExist ahk_exe notepad--.exe
    WinActivate
else
    Run "C:\Scoop\apps\notepad--\current\Notepad--.exe"
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
; Input method control change
; ------------------------------------
CapsLock & Ctrl::^`
Ctrl & CapsLock::^`
CapsLock & .::^.
; 输入法切换
CapsLock & Enter::
{
    Send #{Space}
    Return
}
; 两个输入法切换
CapsLock & RShift::
{
    Send ^#{Space}
    Return
}
; 切换到英文输入法，
CapsLock & LShift::
{
    Send ^+0
    Return
}
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
; 使用示例
CapsLock & Space::
{
    SwitchInputMethod()
    Return
}
; ------------------------------------
; utools clipboard
; ------------------------------------
CapsLock & z::
{
    if GetKeyState("Alt")
        Send ^#!c
    else
        Send #!c
    Return
}
; ----------------
; CapsLockToggle
; ----------------
CapsLock & RCtrl::SendInput {Blind}{CapsLock DownTemp}
CapsLock & RCtrl up::SendInput {Blind}{CapsLock Up}
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
