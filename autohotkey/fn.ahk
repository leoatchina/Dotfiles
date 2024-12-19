; #是win, !是alt, ^是ctrl, +是shift
#Persistent
EnvGet, UserProfile, USERPROFILE
SetCapsLockState, AlwaysOff
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
    Send, ```
return