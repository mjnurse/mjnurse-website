---
title: 22-10-06 - Create The Equivalent To .bashrc For Windows CMD
---

**WARNING**: This did break an application which ran (in the background) in (I assume) some CMD shell... Took me an age to work this out.

Create a `cmdrc.bat` file, for example:

```
@echo off
set GITHUB_TOKEN=[here is my github token]
```

Get this executed each time a `CMD` session starts by adding a registry key specifying the path of the `cmdrc.bat` file.  The following script should be run as Admin:

```
:: ##################################################################################
@echo off
color 04
title Add cmd rc to registry

:: ##################################################################################
set "OpenCurrentFolderKey=HKLM\SOFTWARE\Microsoft\Command Processor"
set "cmdRcPath=C:\scripts\cmdrc.bat"
REG ADD "%OpenCurrentFolderKey%" /v "AutoRun" /t REG_EXPAND_SZ /d "\"%cmdRcPath%\""

:: ##################################################################################
pause>nul
exit /b
   
:: ##################################################################################
```

