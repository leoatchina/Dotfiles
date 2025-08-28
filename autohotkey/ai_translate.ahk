; AutoHotkey v2 Script

; ------------------------------------
; GoldenDict
; ------------------------------------
CapsLock & i:: {
  if GetKeyState("Alt") {
    Send("^!+i")
  }
  else {
    Send("^!+g")
  }
}

TranslateSelection() {
    if WinActive("ahk_class CabinetWClass") {
      Return
    }
    A_Clipboard := ""
    Send("^c")
    if ClipWait(1) {
        cliplen := StrLen(A_Clipboard)
        if (cliplen > 20 || cliplen < 2) {
          ; Avoid translating non-words
          Return
        }
        ; Run GoldenDict with the selected text
        Run('C:\tools\GoldenDict\GoldenDict.exe "' . A_Clipboard . '"')
    }
}

~LButton:: {
    if (A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < DllCall("GetDoubleClickTime")) {
        TranslateSelection()
    }
}
