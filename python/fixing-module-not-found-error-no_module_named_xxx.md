---
title: Fixing ModuleNotFoundError - No module named xxx
---

`pip` tells you that (for example) the module `requests` is installed but `import requests` fails in a Python program.

This may be because the libraries are being stored in a location not in the list of locations searched by Python.

Type `pip show packagename` to get the location of the installed package.

Next, open python and type:

```python
import sys
print(sys.path)
```

This lists the locations python searches for any packages.

If the two don't overlap, you can append a path to list searched:

```python
sys.path.append('package_location_seen_in_step_1')
```

I believe this may only be temporary.

Instead, I copied the contents of the location of the identified by `pip show packagename` to a location in the list from `sys.path` and this fixed things.

