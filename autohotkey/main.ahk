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
LaunchOrActivate(Title, paths*) {
    if (SubStr(Title, 1, 8) != "ahk_exe ")
        winTitle := "ahk_exe " . Title
    else
        winTitle := Title
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
; General Hotkeys
; ------------------------------------
CapsLock & q:: Send("{Esc}")
; Disable system hotkeys
^<#d:: Send("{Esc}")

; Tab navigation
CapsLock & n:: {
    if GetKeyState("Alt")
        LaunchOrActivate("notepad--.exe", ScoopPath . "\apps\notepad--\current\Notepad--.exe", ScoopPath . "\apps\notepad3\current\notepad3.exe")
    else
        Send("^{Tab}")
}

CapsLock & p:: {
    if GetKeyState("Alt")
        LaunchOrActivate("PotPlayerMini.exe", ScoopPath . "\apps\potplaher\current\PotPlayerMini.exe")
    else
        Send("^+{Tab}")
}

CapsLock & Tab:: Send("^{Tab}")
CapsLock & LShift:: Send("^+{Tab}")

; Volume control
CapsLock & m:: {
    if GetKeyState("Alt")
        LaunchOrActivate("Motrix.exe", AppDataLocal . "\Programs\Motrix\Motrix.exe")
    else
        Send("{Volume_Mute}")
}
CapsLock & [:: Send("{Volume_Down}")
CapsLock & ]:: Send("{Volume_Up}")

; CapsLock + WheelDown = Right scroll
CapsLock & WheelDown:: Send("{WheelRight}")
; CapsLock + WheelUp = Left scroll
CapsLock & WheelUp:: Send("{WheelLeft}")

; Delete / Backspace
CapsLock & x:: {
    if GetKeyState("Alt")
        Send("{Backspace}")
    else
        Send("{Del}")
}
; ------------------------------------
; Application Hotkeys
; ------------------------------------
CapsLock & r:: {
    if GetKeyState("Alt")
        Reload()
    else
        LaunchOrActivate("telegram.exe", A_AppData . "\Telegram Desktop\telegram.exe")
}

CapsLock & f:: {
    if GetKeyState("Alt")
        LaunchOrActivate("folo.exe", ScoopPath . "\apps\folo\current\folo.exe")
    else
        LaunchOrActivate("feishu.exe", AppDataLocal . "\Feishu\Feishu.exe")
}

; terminal
CapsLock & t:: {
    if GetKeyState("Alt")
        LaunchOrActivate("alacritty.exe", ScoopPath . "\apps\alacritty\current\alacritty.exe")
    else
        LaunchOrActivate("WindowsTerminal.exe", AppDataLocal . "\Microsoft\WindowsApps\wt.exe")
}

; note softwares
CapsLock & o:: {
    if GetKeyState("Alt")
        LaunchOrActivate("obsidian.exe", ScoopPath . "\apps\obsidian\current\Obsidian.exe")
    else
        LaunchOrActivate("joplin.exe", ScoopPath . "\apps\joplin\current\Joplin.exe")
}

CapsLock & e:: {
    if GetKeyState("Alt")
        LaunchOrActivate("Heynote.exe",  ScoopPath . "\apps\Heynote\current\Heynote.exe")
    else
        LaunchOrActivate("360FileBrowser64.exe", A_AppData . "\360FileBrowser\360FileBrowser64.exe")
}

CapsLock & z:: {
    if GetKeyState("Alt")
        LaunchOrActivate("zotero.exe", ScoopPath . "\apps\zotero\current\zotero.exe")
    else
        LaunchOrActivate("zed.exe", ScoopPath . "\apps\zed\current\zed.exe")
}

; Browsers & Editors
CapsLock & b:: {
    if GetKeyState("Alt") {
        LaunchOrActivate("ahk_exe firefox.exe", ScoopPath . "\apps\firefox\current\firefox.exe")
    } else {
        LaunchOrActivate("ahk_exe zen.exe", "C:\Program Files\Zen Browser\zen.exe")
    }
}

CapsLock & 1:: LaunchOrActivate("msedge.exe", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
CapsLock & 2:: LaunchOrActivate("chrome.exe", "C:\Program Files\Google\Chrome\Application\chrome.exe")
CapsLock & 3:: LaunchOrActivate("Cursor.exe", AppDataLocal . "\Programs\Cursor\Cursor.exe")
CapsLock & 4:: LaunchOrActivate("windsurf.exe", AppDataLocal . "\Programs\Windsurf\Windsurf.exe")
CapsLock & 5:: LaunchOrActivate("qoder.exe", AppDataLocal . "\Programs\qoder\qoder.exe")
CapsLock & 6:: LaunchOrActivate("tabby.exe", ScoopPath . "\apps\tabby\current\tabby.exe")
CapsLock & 7:: LaunchOrActivate("quark.exe", AppDataLocal . "\Programs\Quark\quark.exe")
CapsLock & 8:: LaunchOrActivate("trae.exe", AppDataLocal . "\Programs\trae\trae.exe")
CapsLock & 9:: LaunchOrActivate("Positron.exe", AppDataLocal . "\Programs\Positron\Positron.exe")
CapsLock & 0:: LaunchOrActivate("code.exe", AppDataLocal . "\Programs\Microsoft VS Code\Code.exe")
CapsLock & -:: LaunchOrActivate("nvim-qt.exe", ScoopPath . "\apps\neovim-qt\current\bin\nvim-qt.exe")
CapsLock & =:: LaunchOrActivate("neovide.exe", ScoopPath . "\apps\neovide\current\neovide.exe")

; -------------------
; search
; -------------------
; Utools intergration
CapsLock & /:: Send("^#+!f")

; -------------------
; Clipboard
; -------------------
CapsLock & y:: Send("^{Ins}")
; using utools
CapsLock & v:: {
    if GetKeyState("Alt") {
        Send("^#+!.")
    } else {
        Send("^#!.")
    }
}
; Remove line breaks from clipboard
CapsLock & u:: {
    if GetKeyState("Alt") {
        A_Clipboard := RegExReplace(A_Clipboard, "(\S.*?)\R(.*?\S)", "$1 $2")
    } else {
        A_Clipboard := A_Clipboard ; Force update
    }
    ClipWait(0.1)
}
CapsLock & Ctrl:: Send("^#!.")
Ctrl & CapsLock:: Send("^#!.")
; ------------------------------------
; Screen shot
; ------------------------------------
CapsLock & c:: {
    ; utools
    if GetKeyState("Alt")
        Send("#!+s")
    else
        Send("#+s")
}
; snipaste
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
CapsLock & Backspace:: Send("#{Space}")
CapsLock & Enter:: Send("^#{Space}")

GetCurrentInputLocaleID() {
    WinID := WinGetID("A")
    ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", WinID, "Ptr", 0)
    return DllCall("GetKeyboardLayout", "UInt", ThreadID, "UPtr")
}

SwitchChsEng() {
    InputLocaleID := GetCurrentInputLocaleID()
    ; 0x04090409 is English (US)
    if (InputLocaleID == 0x04090409) ; 67699721 in decimal
        Send("^#{Space}") ; Switch to Chinese
    else
        Send("^{Space}") ; Switch to English
}
CapsLock & Space:: SwitchChsEng()

; IME control helpers: close IME to force English mode inside IME-based layouts (e.g., Microsoft Pinyin)
GetImeOpen(winTitle := "A") {
    hwnd := WinGetID(winTitle)
    hIMC := DllCall("imm32\ImmGetContext", "ptr", hwnd, "ptr")
    open := 0
    if (hIMC) {
        open := DllCall("imm32\ImmGetOpenStatus", "ptr", hIMC, "int")
        DllCall("imm32\ImmReleaseContext", "ptr", hwnd, "ptr", hIMC)
    }
    return open
}

SetImeOpen(open := false, winTitle := "A") {
    hwnd := WinGetID(winTitle)
    hIMC := DllCall("imm32\ImmGetContext", "ptr", hwnd, "ptr")
    if (hIMC) {
        DllCall("imm32\ImmSetOpenStatus", "ptr", hIMC, "int", open ? 1 : 0)
        DllCall("imm32\ImmReleaseContext", "ptr", hwnd, "ptr", hIMC)
    }
}

ForceSwitchToEnglish() {
    ; If already en-US (0409), do nothing
    if ((GetCurrentInputLocaleID() & 0xFFFF) == 0x0409)
        return

    ; Load the en-US layout (US keyboard) and request the active window to switch to it
    hklEn := DllCall("LoadKeyboardLayout", "Str", "00000409", "UInt", 0, "UPtr")
    hwnd := WinGetID("A")
    ; WM_INPUTLANGCHANGEREQUEST (0x50): wParam=0, lParam=HKL
    SendMessage(0x50, 0, hklEn, , "ahk_id " hwnd)
    Sleep(10)

    if ((GetCurrentInputLocaleID() & 0xFFFF) != 0x0409) {
        ; Try activating directly as a fallback
        DllCall("ActivateKeyboardLayout", "UPtr", hklEn, "UInt", 0)
        Sleep(10)
    }

    ; Final fallback: cycle Win+Space a few times to land on 0409
    tries := 4
    while ((GetCurrentInputLocaleID() & 0xFFFF) != 0x0409 && tries-- > 0) {
        Send("#{Space}")
        Sleep(10)
    }
}
; 单击 CapsLock 在抬起时触发切到英文；与其它键组合时不触发
CapsLock::Return
CapsLock up:: {
    ; 仅当 CapsLock 单独按下/抬起（未与其它键组合）时才切英文
    if (A_PriorKey = "CapsLock") {
        ForceSwitchToEnglish()
    }
}
; ------------------------------------
; Remap side mouse buttons to middle button for xtop.exe
; ------------------------------------
#HotIf WinActive("ahk_exe xtop.exe")
XButton1::MButton
XButton2::MButton
#HotIf
