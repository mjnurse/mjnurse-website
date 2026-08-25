---
title: 19-01-22 - Emulating sudo in dos cmd
section: Notes
---

I found a useful method for running a dos command as Administrator.

Create a script `sudo.bat`:
```
@echo Set objShell = CreateObject("Shell.Application") > %temp%\sudo.tmp.vbs
@echo args = Right("%*", (Len("%*") - Len("%1"))) >> %temp%\sudo.tmp.vbs
@echo objShell.ShellExecute "%1", args, "", "runas" >> %temp%\sudo.tmp.vbs
@cscript %temp%\sudo.tmp.vbs
```
To open a new cmd window running as administrator:
```
> sudo cmd
```

<hr>
