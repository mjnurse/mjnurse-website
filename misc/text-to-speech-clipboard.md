---
title: Text To Speech - Clipboard
section: Misc
---

I've been using the Microsoft Word text-to-speech function for a while to proof read text.  Works great but the text needs to be a Word document or I need to copy and paste it there first.  I've been looking online for an application to read aloud the clipboard.  It's surprisingly difficult to find an application.  I then thought about AHK and (convinced it would be far to complex for AHK) I ran a search.  I was wrong, a very simple AHK script now means I can read aloud the contents of the clipboard in any application. 
```
; Read aloud the clipboard (text-to-speech).
^F9::
clipboard := ""
Send ^c
ClipWait, 0.5
textToRead := clipboard
voice:=ComObjCreate("SAPI.SpVoice")
voice.Rate := 0
voice.Speak(textToRead, 1)
return

; Stop reading aloud.
^F10::
voice.Speak("",0x1|0x2)
Return

; Pause/resume reading aloud.
^F11::
status := voice.Status.RunningState
If status = 0 ; paused
	voice.Resume
Else If status = 2 ; reading
	voice.Pause
Return

; Toggle read speed.
^F12::
readRate := voice.Rate
If readRate < 4
   voice.Rate := readRate + 2
Else
   voice.Rate := 0
Return
```

