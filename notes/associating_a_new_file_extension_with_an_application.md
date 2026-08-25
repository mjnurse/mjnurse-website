---
title: Associating a New File Extension With an Application
---

I found that in Windows 10, files with a extension not already registered cannot be associated with an application in the normal way.

One solution is to use the command line to associate the files.

```
> assoc .newextension newextnsionfile
> ftype newextensionfile="C:\Program Files (x86)\Vim\vim80\gvim.exe" "%1%
```
