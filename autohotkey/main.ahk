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
CapsLock & r:: {
    if GetKeyState("Alt")
        Reload()
    else
        LaunchOrActivate("ahk_exe telegram.exe", A_AppData . "\Telegram Desktop\telegram.exe")
}

CapsLock & f:: {
    if GetKeyState("Alt")
        LaunchOrActivate("ahk_exe folo.exe", ScoopPath . "\apps\folo\current\folo.exe")
    else
        LaunchOrActivate("ahk_exe feishu.exe", AppDataLocal . "\Feishu\Feishu.exe")
}

; terminal
CapsLock & t:: {
    if GetKeyState("Alt")
        LaunchOrActivate("ahk_exe alacritty.exe", ScoopPath . "\apps\alacritty\current\alacritty.exe")
    else
        LaunchOrActivate("ahk_exe WindowsTerminal.exe", AppDataLocal . "\Microsoft\WindowsApps\wt.exe")
}

; note softwares
CapsLock & o:: {
    if GetKeyState("Alt")
        LaunchOrActivate("ahk_exe joplin.exe", ScoopPath . "\apps\joplin\current\Joplin.exe")
    else
        LaunchOrActivate("ahk_exe obsidian.exe", ScoopPath . "\apps\obsidian\current\Obsidian.exe")
}

CapsLock & e:: {
    if GetKeyState("Alt")
        LaunchOrActivate("ahk_exe notepad--.exe", ScoopPath . "\apps\notepad--\current\Notepad--.exe")
    else
        LaunchOrActivate("ahk_exe Heynote.exe",  ScoopPath . "\apps\Heynote\current\Heynote.exe")
}

CapsLock & z:: {
    if GetKeyState("Alt")
        LaunchOrActivate("ahk_exe zotero.exe", ScoopPath . "\apps\zotero\current\zotero.exe")
    else
        LaunchOrActivate("ahk_exe zed.exe", ScoopPath . "\apps\zed\current\zed.exe")
}

; Browsers & Editors
CapsLock & 1:: LaunchOrActivate("ahk_exe msedge.exe", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
CapsLock & 2:: LaunchOrActivate("ahk_exe chrome.exe", "C:\Program Files\Google\Chrome\Application\chrome.exe")
CapsLock & 3:: LaunchOrActivate("ahk_exe Cursor.exe", AppDataLocal . "\Programs\Cursor\Cursor.exe")
CapsLock & 4:: LaunchOrActivate("ahk_exe windsurf.exe", AppDataLocal . "\Programs\Windsurf\Windsurf.exe")
CapsLock & 5:: LaunchOrActivate("ahk_exe qoder.exe", AppDataLocal . "\Programs\qoder\qoder.exe")
CapsLock & 6:: LaunchOrActivate("ahk_exe tabby.exe", ScoopPath . "\apps\tabby\current\tabby.exe")
CapsLock & 7:: LaunchOrActivate("ahk_exe quark.exe", AppDataLocal . "\Programs\Quark\quark.exe")
CapsLock & 8:: LaunchOrActivate("ahk_exe trae.exe", AppDataLocal . "\Programs\trae\trae.exe")
CapsLock & 9:: LaunchOrActivate("ahk_exe Positron.exe", AppDataLocal . "\Programs\Positron\Positron.exe")
CapsLock & 0:: LaunchOrActivate("ahk_exe code.exe", AppDataLocal . "\Programs\Microsoft VS Code\Code.exe")
CapsLock & -:: LaunchOrActivate("ahk_exe nvim-qt.exe", ScoopPath . "\apps\neovim-qt\current\bin\nvim-qt.exe")
CapsLock & =:: LaunchOrActivate("ahk_exe neovide.exe", ScoopPath . "\apps\neovide\current\neovide.exe")

; Utools intergration 
CapsLock & /:: Send("^#+!f")

; Clipboard
CapsLock & v:: {
    if GetKeyState("Alt") {
        Send("^#+!.")
    } else {
        Send("^#!.")
    }
}
; zen && firefox
CapsLock & b:: {
    if GetKeyState("Alt") {
        LaunchOrActivate("ahk_exe firefox.exe", ScoopPath . "\apps\firefox\current\firefox.exe")
    } else {
        LaunchOrActivate("ahk_exe zen.exe", "C:\Program Files\Zen Browser\zen.exe")
    }
}
; Monitor focus switching
CapsLock & Ctrl:: Send("^#!.")
Ctrl & CapsLock:: Send("^#!.")

; ------------------------------------
; General Hotkeys
; ------------------------------------
; Capture
CapsLock & c:: Send("#+s")

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
CapsLock & [:: Send("{Volume_Down}")
CapsLock & ]:: Send("{Volume_Up}")

CapsLock & y:: Send("^{Ins}")
; ------------------------------------
; Horizontal Scrolling with CapsLock + Wheel
; ------------------------------------
; CapsLock + WheelDown = Right scroll
CapsLock & WheelDown:: Send("{WheelRight}")
; CapsLock + WheelUp = Left scroll
CapsLock & WheelUp:: Send("{WheelLeft}")

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
CapsLock & F1:: Send("^{F1}")
CapsLock & F2:: Send("!{F1}")

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
; Window movement between monitors
; ------------------------------------
CapsLock & Left:: Send("#+{Left}")
CapsLock & Right:: Send("#+{Right}")
CapsLock & Up:: Send("#{Up}")
CapsLock & Down:: Send("#{Down}")

; ------------------------------------
; Input Method Control
; ------------------------------------
CapsLock & Shift:: Send("#{Space}")
Shift & CapsLock:: Send("#{Space}")
CapsLock & Space:: Send("^#{Space}")

GetCurrentInputLocaleID() {
    WinID := WinGetID("A")
    ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", WinID, "Ptr", 0)
    return DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
}

SwitchChsEng() {
    InputLocaleID := GetCurrentInputLocaleID()
    ; 0x04090409 is English (US)
    if (InputLocaleID == 0x04090409) ; 67699721 in decimal
        Send("^#{Space}") ; Switch to Chinese
    else
        Send("^{Space}") ; Switch to English
}
CapsLock & Enter:: SwitchChsEng()

ForceSwitchToEnglish() {
    InputLocaleID := GetCurrentInputLocaleID()
    ; 0x04090409 is English (US)
    if (InputLocaleID != 0x04090409) {
        Send("^#{Space}") ; Switch to English
    }
}
CapsLock:: ForceSwitchToEnglish()
; ------------------------------------
; Remap side mouse buttons to middle button for xtop.exe
; ------------------------------------
#HotIf WinActive("ahk_exe xtop.exe")
XButton1::MButton
XButton2::MButton
#HotIf
