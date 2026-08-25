---
title: Command Line Animation
contents-list: h1,h2
---

An example of command line animation.

```bash
#!/bin/bash

frames="/ | \\ -"

# Run a 5 second sleep command in the background
sleep 5 & pid=$!

# Check that the sleep process (above) still exists, and if so draw some animation
while kill -0 $pid 2&>1 > /dev/null;
do
    for frame in $frames;
    do
        printf "\r$frame Waiting..." 
        sleep 0.5
    done
done
printf "\n"
```

<hr>
