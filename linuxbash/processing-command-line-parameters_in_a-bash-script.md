---
title: Processing Command Line Parameters in a Bash Script
---

# Option 1:

Process a single string of parameters which start with a `-`.

```bash
param=$1

# Only if parameters start with a '-'

while [[ "${param:0:1}" == "-" && "$param" != "" ]]; do
  case $param in
    -h|--help)
      echo "$help_text"
      exit
      ;;
    *a*)
      echo a
      param="${param//a/}"
      ;;
    *b*)
      echo b 
      param="${param//b/}"
      ;;
    *)
      param=""
      ;;
  esac
done
```

# Option 2:

Process a set of separate parameters (optionally with associated values).

```
while [[ "$1" != "" ]]; do
  case $1 in
    -h|--help)
      echo "$help_text"
      exit
      ;;
    -d|--debug)
      debug_yn=y
      ;;
    -s|--size)
      shift
      size=$1
      ;;
    ?*)
      break
      ;;
  esac
  shift
done
```

