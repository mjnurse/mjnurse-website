---
title: Set Default User For WSL Ubuntu
---

Useful if WSL switches to `root` as the default user.

The command depend on the version of Ubuntu you have installed.  Press the windows key and type "Ubuntu" and you should see the Unbuntu app listed which may include a version number.  If so, add this to the end on the `ubuntu` command.

```
ubuntu config --default-user martin

# Or for, for example, version 22.04:

ubuntu2204 -- default-user martin
```

