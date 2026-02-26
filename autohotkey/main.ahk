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
global ScoopPath, UserProfile, AppDataLocal
UserProfile := EnvGet("USERPROFILE")
AppDataLocal := UserProfile . "\AppData\Local"
if DirExist("C:\Scoop") {
    ScoopPath := "C:\Scoop"
}
else if DirExist("D:\Scoop") {
    ScoopPath := "D:\Scoop"
}
else if DirExist(UserProfile . "\scoop") {
    ScoopPath := UserProfile . "\scoop"
}
else {
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
; CapsLock tap/hold state tracking
; ------------------------------------
; 按下 CapsLock 的时刻（用于计算按住时长）
global caps_press_time := 0
; 松开 CapsLock 的时刻（用于冷却期判断，防止连击误触）
global caps_release_time := 0
; 快速点击标志：按住时长 < CAPS_TAP_MAX_MS 时置 true，持续 CAPS_TAP_BLOCK_MS 后自动清除
; 期间 #HotIf !caps_just_tapped 会屏蔽所有 CapsLock 组合键，防止延迟键事件误触
global caps_just_tapped := false
; 组合键已使用标志：CapsLock 松开时若为 true，则不触发切英文（避免组合键后意外切换）
global caps_combo_used := false

; 按住时长低于此值（ms）视为快速点击（键盘硬件/OS 延迟通常 < 50ms，故意按住的组合键一般 > 50ms）
global CAPS_TAP_MAX_MS := 50
; 快速点击后屏蔽组合键的持续时间（ms）
global CAPS_TAP_BLOCK_MS := 125
; CapsLock 连击冷却期（ms），冷却期内再次按下 CapsLock 会被忽略
global CAPS_COOLDOWN_MS := 250

ClearTapFlag() {
    global caps_just_tapped
    caps_just_tapped := false
}

; CapsLock:: 和 CapsLock up:: 必须在 #HotIf 之外，保证状态管理始终生效
CapsLock:: {
    global caps_press_time
    global caps_release_time
    global caps_just_tapped
    global caps_combo_used
    global CAPS_COOLDOWN_MS
    if (A_TickCount - caps_release_time < CAPS_COOLDOWN_MS) {
        KeyWait("CapsLock")
        return
    }
    caps_press_time := A_TickCount
    caps_just_tapped := false
    caps_combo_used := false
}

CapsLock up:: {
    global caps_press_time
    global caps_release_time
    global caps_just_tapped
    global caps_combo_used
    global CAPS_TAP_MAX_MS
    global CAPS_TAP_BLOCK_MS
    hold_duration := A_TickCount - caps_press_time
    if (hold_duration < CAPS_TAP_MAX_MS) {
        caps_just_tapped := true
        SetTimer(ClearTapFlag, -CAPS_TAP_BLOCK_MS)
    }
    if (A_PriorKey = "CapsLock" && !caps_combo_used) {
        Critical "On"
        ForceSwitchToEnglish()
        Critical "Off"
    }
    caps_release_time := A_TickCount
}

; 快速点击冷却期内屏蔽所有 CapsLock 组合键
#HotIf !caps_just_tapped
; ------------------------------------
; General Hotkeys
; ------------------------------------
CapsLock & Tab:: Send("{Esc}")
CapsLock & q:: Send("{Esc}")
; Disable system hotkeys
^<#d:: Send("{Esc}")

; Tab navigation
CapsLock & n:: {
    if GetKeyState("Alt"){
        LaunchOrActivate("notepad--.exe", ScoopPath . "\apps\notepad--\current\Notepad--.exe", ScoopPath . "\apps\notepad3\current\notepad3.exe")
    }else{
        Send("^{Tab}")
    }
}

CapsLock & p:: {
    if GetKeyState("Alt"){
        LaunchOrActivate("PotPlayerMini.exe", ScoopPath . "\apps\potplaher\current\PotPlayerMini.exe")
    }else{
        Send("^+{Tab}")
    }
}

CapsLock & LCtrl:: Send("^{Tab}")
CapsLock & LShift:: Send("^+{Tab}")

; Volume control
CapsLock & m:: {
    if GetKeyState("Alt"){
        LaunchOrActivate("Motrix.exe", AppDataLocal . "\Programs\Motrix\Motrix.exe")
    }else{
        Send("{Volume_Mute}")
    }
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
        LaunchOrActivate("wezterm-gui.exe", ScoopPath . "\apps\wezterm-nightly\current\wezterm-gui.exe")
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
        LaunchOrActivate("telegram.exe", A_AppData . "\Telegram Desktop\telegram.exe")
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
        LaunchOrActivate("Heynote.exe", ScoopPath . "\apps\Heynote\current\Heynote.exe")
    else
        LaunchOrActivate("360FileBrowser64.exe", A_AppData . "\360FileBrowser\360FileBrowser64.exe")
}
CapsLock & z:: LaunchOrActivate("zotero.exe", ScoopPath . "\apps\zotero\current\zotero.exe")

; Browsers & Editors
CapsLock & b:: {
    if GetKeyState("Alt") {
        LaunchOrActivate("ahk_exe zen.exe", "C:\Program Files\Zen Browser\zen.exe")
    } else {
        LaunchOrActivate("ahk_exe brave.exe", ScoopPath . "\apps\brave\current\brave.exe")
    }
}

CapsLock & 1:: LaunchOrActivate("msedge.exe", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
CapsLock & 2:: LaunchOrActivate("chrome.exe", "C:\Program Files\Google\Chrome\Application\chrome.exe")
CapsLock & 3:: {
    if GetKeyState("Alt") {
        LaunchOrActivate("positron.exe", AppDataLocal . "\Programs\Positron\Positron.exe")
    } else {
        LaunchOrActivate("code.exe", AppDataLocal . "\Programs\Microsoft VS Code\Code.exe")
    }
}
CapsLock & 4:: LaunchOrActivate("windsurf.exe", AppDataLocal . "\Programs\Windsurf\Windsurf.exe")
CapsLock & 5:: {
    if GetKeyState("Alt") {
        LaunchOrActivate("qoder.exe", AppDataLocal . "\Programs\Qoder\Qoder.exe")
    } else {
        LaunchOrActivate("cursor.exe", AppDataLocal . "\Programs\Cursor\Cursor.exe")
    }
}
CapsLock & 6:: LaunchOrActivate("quark.exe", AppDataLocal . "\Programs\Quark\quark.exe")
CapsLock & 7:: {
    if GetKeyState("Alt") {
        LaunchOrActivate("hexin.exe", "C:\同花顺软件\同花顺\hexin.exe")
    } else {
        LaunchOrActivate("happ.exe", "C:\同花顺远航版\bin\hexinlauncher.exe")
    }
}
CapsLock & 8:: LaunchOrActivate("zed.exe", ScoopPath . "\apps\zed\current\zed.exe")
CapsLock & 9:: {
    if GetKeyState("Alt") {
        LaunchOrActivate("antigravity_tools.exe", AppDataLocal . "\Antigravity Tools\antigravity_tools.exe")
    } else {
        LaunchOrActivate("antigravity.exe", AppDataLocal . "\Programs\antigravity\antigravity.exe")
    }
}
CapsLock & 0:: {
    if GetKeyState("Alt") {
        LaunchOrActivate("hyper.exe", ScoopPath . "\apps\hyper\current\hyper.exe")
    } else {
        LaunchOrActivate("mobaxterm.exe", ScoopPath . "\apps\mobaxterm\current\mobaxterm.exe")
    }
}
CapsLock & -:: LaunchOrActivate("neovide.exe", ScoopPath . "\apps\neovide\current\neovide.exe")
CapsLock & =:: LaunchOrActivate("nvim-qt.exe", ScoopPath . "\apps\neovim-qt\current\bin\nvim-qt.exe")
CapsLock & \:: {
    if GetKeyState("Alt") {
        LaunchOrActivate("gvim.exe", ScoopPath . "\apps\vim-nightly\current\gvim.exe")
    } else {
        LaunchOrActivate("alacritty.exe", ScoopPath . "\apps\alacritty\current\alacritty.exe")
    }
}
; -------------------
; search
; -------------------
; Utools intergration
CapsLock & /:: Send("^#+!f")
; -------------------
; Clipboard
; -------------------
CapsLock & c:: Send("^{Ins}")
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
; ------------------------------------
; Screen shot
; ------------------------------------
CapsLock & y:: {
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
CapsLock & F2:: Send("!{F2}")
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
CapsLock & .:: Send("^{.}")
SwitchChsEng() {
    InputLocaleID := GetCurrentInputLocaleID()
    ; 0x04090409 is English (US)
    if (InputLocaleID == 0x04090409) ; 67699721 in decimal
        Send("^#{Space}") ; Switch to Chinese
    else
        Send("^{Space}") ; Switch to English
}
; CapsLock & Backspace:: SwitchChsEng()

CapsLock & Enter:: Send("#{Space}")
CapsLock & Backspace:: Send("^#{Space}")

GetCurrentInputLocaleID() {
    WinID := WinGetID("A")
    ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", WinID, "Ptr", 0)
    return DllCall("GetKeyboardLayout", "UInt", ThreadID, "UPtr")
}

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
    try SendMessage(0x50, 0, hklEn, , "ahk_id " hwnd,, 1000)
    Sleep(1)
    if ((GetCurrentInputLocaleID() & 0xFFFF) != 0x0409) {
        ; Try activating directly as a fallback
        DllCall("ActivateKeyboardLayout", "UPtr", hklEn, "UInt", 0)
        Sleep(1)
    }

    ; Final fallback: cycle Win+Space a few times to land on 0409
    tries := 3
    while ((GetCurrentInputLocaleID() & 0xFFFF) != 0x0409 && tries-- > 0) {
        Send("#{Space}")
        Sleep(1)
    }
}

ForceSwitchToChinese() {
    ; Only toggle when currently in en-US; keep state if already Chinese
    if ((GetCurrentInputLocaleID() & 0xFFFF) != 0x0409)
        return
    tries := 3
    while ((GetCurrentInputLocaleID() & 0xFFFF) == 0x0409 && tries-- > 0) {
        Send("^#{Space}")
        Sleep(1)
    }
}

CapsLock & Space:: {
    global caps_combo_used
    caps_combo_used := true
    ForceSwitchToChinese()
}
#HotIf
; ------------------------------------
; Remap side mouse buttons to middle button for xtop.exe
; ------------------------------------
#HotIf WinActive("ahk_exe xtop.exe")
XButton1::MButton
XButton2::MButton
#HotIf
