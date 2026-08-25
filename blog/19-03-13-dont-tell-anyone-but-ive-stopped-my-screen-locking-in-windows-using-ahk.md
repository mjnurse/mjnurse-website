---
title: 19-03-13 - Dont Tell Anyone But Ive Stopped My Screen Locking In Windows Using AHK
---

I'm working on 2 computers right now.  One automatically locks after 5 minutes.  Really great for security but maddening for me.

It's a policy setting which I can't override.

I keep knocking the mouse to keep it unlocked.  I then dawned on me that AHK could do that for me.

```
; Script to stop the screen locking in Windows by generating some mouse activity.

#Persistent
#SingleInstance Force

SetTimer, MoveMouse

; Check the time that has passed since the last key press or mouse move, if its greater than 60 seconds
; move the mouse 1 pixel and then back.

MoveMouse:
If ( A_TimeIdle > 60000 ) {
  MouseMove, 1 , 1,, R
  MouseMove, -1,-1,, R
}
Return
```

<hr>
