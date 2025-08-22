; AutoHotkey v2 Script
; ------------------------------------
; Configuration
; ------------------------------------
#Warn VarUnset, Off
#SingleInstance
SetCapsLockState("AlwaysOff")
; ------------------------------------
; Global Variables - Detect Scoop Path
; ------------------------------------
global ScoopPath,UserProfile,AppDataLocal
UserProfile := EnvGet("USERPROFILE")
AppDataLocal := UserProfile . "\AppData\Local"
if DirExist("C:\Scoop"){
    ScoopPath := "C:\Scoop"
}
else if DirExist("D:\Scoop"){
    ScoopPath := "D:\Scoop"
}
else if DirExist(UserProfile . "\scoop"){
    ScoopPath := UserProfile . "\scoop"
}
else{
    ScoopPath := ""
}
; ------------------------------------
; Helper Function to Launch or Activate Apps
; ------------------------------------
LaunchOrActivate(winTitle, paths*) {
    if WinExist(winTitle) {
        WinActivate(winTitle)
    } else {
        for path in paths {
            if FileExist(path) {
                Run(path)
                return
            }
        }
    }
}

; ------------------------------------
; Application Hotkeys
; ------------------------------------
; Reload script
CapsLock & r:: {
    if GetKeyState("Alt")
        Reload()
    else
        LaunchOrActivate("ahk_exe folo.exe", ScoopPath . "\apps\folo\current\folo.exe")
}

; Feishu
CapsLock & e:: LaunchOrActivate("ahk_exe feishu.exe", AppDataLocal . "\Feishu\Feishu.exe")

; Telegram / Heynote
CapsLock & t:: {
    if GetKeyState("Alt")
        LaunchOrActivate("ahk_exe Heynote.exe",  ScoopPath . "\apps\Heynote\current\Heynote.exe")
    else
        LaunchOrActivate("ahk_exe telegram.exe", A_AppData . "\Telegram Desktop\Telegram.exe")
}

; Obsidian / Joplin
CapsLock & o:: {
    if GetKeyState("Alt")
        LaunchOrActivate("ahk_exe joplin.exe", ScoopPath . "\apps\joplin\current\Joplin.exe")
    else
        LaunchOrActivate("ahk_exe obsidian.exe", ScoopPath . "\apps\obsidian\current\Obsidian.exe")
}

; Browsers & Editors
CapsLock & b:: LaunchOrActivate("ahk_exe zen.exe", "C:\Program Files\Zen Browser\zen.exe")
CapsLock & 1:: LaunchOrActivate("ahk_exe msedge.exe", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
CapsLock & 2:: LaunchOrActivate("ahk_exe chrome.exe", "C:\Program Files\Google\Chrome\Application\chrome.exe")
CapsLock & 3:: LaunchOrActivate("ahk_exe Cursor.exe", AppDataLocal . "\Programs\Cursor\Cursor.exe")
CapsLock & 4:: LaunchOrActivate("ahk_exe windsurf.exe", AppDataLocal . "\Programs\Windsurf\Windsurf.exe")
CapsLock & 5:: LaunchOrActivate("ahk_exe trae.exe", AppDataLocal . "\Programs\trae\trae.exe")
CapsLock & 6:: LaunchOrActivate("ahk_exe alacritty.exe", ScoopPath . "\apps\alacritty\current\alacritty.exe")
CapsLock & 7:: LaunchOrActivate("ahk_exe quark.exe", AppDataLocal . "\Programs\Quark\quark.exe")
CapsLock & 8:: LaunchOrActivate("ahk_exe zed.exe", ScoopPath . "\apps\zed\current\zed.exe")
CapsLock & 9:: LaunchOrActivate("ahk_exe Positron.exe", AppDataLocal . "\Programs\Positron\Positron.exe")
CapsLock & 0:: LaunchOrActivate("ahk_exe code.exe", AppDataLocal . "\Programs\Microsoft VS Code\Code.exe")
CapsLock & -:: LaunchOrActivate("ahk_exe nvim-qt.exe", ScoopPath . "\apps\neovim-qt\current\bin\nvim-qt.exe")
CapsLock & =:: LaunchOrActivate("ahk_exe neovide.exe", ScoopPath . "\apps\neovide\current\neovide.exe")
CapsLock & z:: LaunchOrActivate("ahk_exe zotero.exe", ScoopPath . "\apps\zotero\current\zotero.exe")

; Terminals
CapsLock & f:: {
    if GetKeyState("Alt")
        LaunchOrActivate("ahk_exe notepad--.exe", ScoopPath . "\apps\notepad--\current\Notepad--.exe")
    else
        LaunchOrActivate("ahk_exe WindowsTerminal.exe", AppDataLocal . "\Microsoft\WindowsApps\wt.exe")
}
CapsLock & g:: LaunchOrActivate("ahk_exe tabby.exe", ScoopPath . "\apps\tabby\current\tabby.exe")

; ------------------------------------
; General Hotkeys
; ------------------------------------
; Utools search
CapsLock & /:: Send("^#!f")

; Tab navigation
CapsLock & n:: Send("^{Tab}")
CapsLock & p:: Send("^+{Tab}")

; Volume control
CapsLock & m:: {
    if GetKeyState("Alt")
        LaunchOrActivate("ahk_exe Motrix.exe", AppDataLocal . "\Programs\Motrix\Motrix.exe")
    else
        Send("{Volume_Mute}")
}
CapsLock & ]:: Send("{Volume_Up}")
CapsLock & [:: Send("{Volume_Down}")

; Clipboard
LCtrl & CapsLock:: Send("#!c")
CapsLock & LCtrl:: Send("#!c")
CapsLock & y:: Send("^#!c")
CapsLock & v:: Send("+{Ins}")
CapsLock & c:: Send("^{Ins}")

; Remove line breaks from clipboard
CapsLock & u:: {
    if GetKeyState("Alt") {
        A_Clipboard := RegExReplace(A_Clipboard, "(\S.*?)\R(.*?\S)", "$1 $2")
    } else {
        A_Clipboard := A_Clipboard ; Force update
    }
    ClipWait(0.1)
}

; Delete / Backspace
CapsLock & x:: {
    if GetKeyState("Alt")
        Send("{Backspace}")
    else
        Send("{Del}")
}

; ESC
CapsLock & q:: Send("{Esc}")

; Disable system hotkeys
^<#d:: Send("{Esc}")

; Screen shot
#f:: Send("^{F1}")
#b:: Send("!{F1}")
#u:: Send("!{F2}")

; ------------------------------------
; Directional Keys (Vim & WASD style)
; ------------------------------------
SendDirKey(key, altKey, state) {
    if GetKeyState("Alt")
        Send("{" altKey " " state "}")
    else
        Send("{" key " " state "}")
}

; --- Left ---
CapsLock & a:: SendDirKey("Left", "Home", "Down")
CapsLock & h:: SendDirKey("Left", "Home", "Down")
CapsLock & a up:: SendDirKey("Left", "Home", "Up")
CapsLock & h up:: SendDirKey("Left", "Home", "Up")

; --- Right ---
CapsLock & d:: SendDirKey("Right", "End", "Down")
CapsLock & l:: SendDirKey("Right", "End", "Down")
CapsLock & d up:: SendDirKey("Right", "End", "Up")
CapsLock & l up:: SendDirKey("Right", "End", "Up")

; --- Up ---
CapsLock & w:: SendDirKey("Up", "PgUp", "Down")
CapsLock & k:: SendDirKey("Up", "PgUp", "Down")
CapsLock & w up:: SendDirKey("Up", "PgUp", "Up")
CapsLock & k up:: SendDirKey("Up", "PgUp", "Up")

; --- Down ---
CapsLock & s:: SendDirKey("Down", "PgDn", "Down")
CapsLock & j:: SendDirKey("Down", "PgDn", "Down")
CapsLock & s up:: SendDirKey("Down", "PgDn", "Up")
CapsLock & j up:: SendDirKey("Down", "PgDn", "Up")

; ------------------------------------
; Input Method Control
; ------------------------------------

CapsLock & Backspace:: Send("#{Space}")
CapsLock & Enter:: Send("^#{Space}")
CapsLock & RShift:: Send("{RCtrl}")

SwitchInputMethod() {
    WinID := WinGetID("A")
    ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", WinID, "Ptr", 0)
    InputLocaleID := DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
    ; 0x04090409 is English (US)
    if (InputLocaleID == 0x04090409) ; 67699721 in decimal
        Send("^#{Space}") ; Switch to Chinese
    else
        Send("^{Space}") ; Switch to English
}

CapsLock & Space:: SwitchInputMethod()
CapsLock:: SwitchInputMethod()

; ------------------------------------
; Remap side mouse buttons to middle button for xtop.exe
; ------------------------------------
#HotIf WinActive("ahk_exe xtop.exe")
XButton1::MButton
XButton2::MButton
#HotIf

