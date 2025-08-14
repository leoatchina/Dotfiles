; #是win, !是alt, ^是ctrl, +是shift
#Persistent
EnvGet, UserProfile, USERPROFILE
SetCapsLockState, AlwaysOff
; ------------------------------------
; right alt + 1 ~ 0 , and -/= , map to f1-f12
; ------------------------------------
RAlt & 1::
    Send, {F1}
Return
RAlt & 2::
    Send, {F2}
Return
RAlt & 3::
    Send, {F3}
Return
RAlt & 4::
    Send, {F4}
Return
RAlt & 5::
    Send, {F5}
Return
RAlt & 6::
    Send, {F6}
Return
RAlt & 7::
    Send, {F7}
Return
RAlt & 8::
    Send, {F8}
Return
RAlt & 9::
    Send, {F9}
Return
RAlt & 0::
    Send, {F10}
Return
RAlt & -::
    Send, {F11}
Return
RAlt & =::
    Send, {F12}
Return
RShift & Esc::
    Send, {~}
Return
RAlt & Esc::
    Send, ```
Return
