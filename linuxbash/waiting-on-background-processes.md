---
title: Waiting On Background Processes
---

The `wait` command waits for all background processes start in the current session to end.

Example:

```bash
#!/bin/bash

function f1() {
  echo "process 1, sleeping 3s"
  sleep 3
  echo "process 1 complete"
}

function f2() {
  echo "process 2, sleeping 2s"
  sleep 2 
  echo "process 2 complete"
}

f1 &
f2 &

wait

echo "all done"
```

Output:

```text
$ xxx
process 1, sleeping 3s
process 2, sleeping 2s
process 2 complete
process 1 complete
all done

$
```

<hr>
