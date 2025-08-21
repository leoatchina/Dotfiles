; AutoHotkey v2 Script

; ------------------------------------
; right alt + 1 ~ 0 , and -/= , map to f1-f12
; ------------------------------------
RAlt & 1::Send("{F1}")
RAlt & 2::Send("{F2}")
RAlt & 3::Send("{F3}")
RAlt & 4::Send("{F4}")
RAlt & 5::Send("{F5}")
RAlt & 6::Send("{F6}")
RAlt & 7::Send("{F7}")
RAlt & 8::Send("{F8}")
RAlt & 9::Send("{F9}")
RAlt & 0::Send("{F10}")
RAlt & -::Send("{F11}")
RAlt & =::Send("{F12}")

RShift & Esc::Send("~")
RAlt & Esc::Send("```")
