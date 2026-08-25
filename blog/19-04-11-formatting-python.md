---
title: 19-04-11 - Formatting Python
section: python
---

This week I got a little interested in best practice formatting for Python.

Never been a big fan of formatting tools, however I found 2 python tools and I like them both.  Both are highly configurable but the only thing I've changed so far is to extend the max line length to 110 characters and to change the indent level to 3 characters.

- pylint3 - this tool checks formatting and produces a detailed description of improvements which can be made.

- yapf - this formats python code.

## Changing the config Options

For yapf - create a style definition document as follows and then modify to change the settings.
```
yapf --style-help > ~/.style.yapf
```
The changes I made are:
```
continuation_indent_width=3
indent_width=3
column_limit=109
```

For pylint3, I've chosen to change the two settings using command line parameters.
```
pylint3 --max-line-length=110 --indent-string='   ' --indent-after-paren=3 ...
```

