---
title: Adding git-bash Command Line Options
---

To add command line options to `git-bash.exe` you need to instead use `sh.exe`.

```cmd
> "C:\Program Files\Git\bin\sh.exe" --help

GNU bash, version 5.2.15(1)-release-(x86_64-pc-msys)
Usage:  /usr/bin/bash [GNU long option] [option] ...
        /usr/bin/bash [GNU long option] [option] script-file ...
GNU long options:
        --debug
        --debugger
        --dump-po-strings
        --dump-strings
        --help
        --init-file
        --login
        --noediting
        --noprofile
        --norc
        --posix
        --pretty-print
        --protected
        --rcfile
        --restricted
        --verbose
        --version
        --wordexp
Shell options:
        -ilrsD or -c command or -O shopt_option         (invocation only)
        -abefhkmnptuvxBCEHPT or -o option
Type `/usr/bin/bash -c "help set"' for more information about shell options.
Type `/usr/bin/bash -c help' for more information about shell builtin commands.
Use the `bashbug' command to report bugs.

bash home page: <http://www.gnu.org/software/bash>
General help using GNU software: <http://www.gnu.org/gethelp/>
```

