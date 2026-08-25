---
title: Run WSL Bash Script using Windows Scheduler
---

1 - Open Task Scheduler (taskschd.msc from Run or Start menu)

2 - Click Create Basic Task (or Create Task for more options)

3 - Set your trigger (schedule)

4 - For the Action, choose Start a program:

    Program/script: `C:\Windows\System32\cmd.exe`

    Arguments: `/c wsl -d Ubuntu -u martin -- /home/martin/your-script.sh`

    note `/c` closes the window when the scvript completes, `/k` would keep it open.

5 - Make sure your script is executable (chmod +x script.sh) and has a shebang (#!/bin/bash)