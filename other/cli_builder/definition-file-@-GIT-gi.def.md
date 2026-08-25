---
title: @ GIT CLI
---
## Definition file `gi.def`

```bash
@ GIT

aliasLeadChars: gi

# ---------------------------------------------------------------------------------------
= GENERAL
# ---------------------------------------------------------------------------------------

add commit push (acp) [<-f|--force>] [<message>] :: \
    force_yn=n; \
    if [[ $1 == -f || $1 == --force ]]; then \
        force_yn=y; \
        shift; \
    fi; \
    if [[ "$1" == "" ]]; then \
        message="Various"; \
    else \
        message="$1"; \
    fi; \
    [ -f ./gen-readme ] && ./gen-readme; \
    git add .; \
    git status; \
    if [[ "$1" != "-f" ]]; then \
        read -p 'Press a key to continue, CTRL-C to abort' dummy; \
    fi; \
    git commit -m 'Various'; \
    git push origin

list branches local (lbl) [-d] :: \
    if [[ $1 == -d ]]; then \
        git branch --format='%(creatordate:short), %(refname:short)' | column -s, -t | sort; \
    else \
        git branch --format='%(creatordate:short), %(refname:short)' | column -s, -t; \
    fi \
    ## -d - order by commit data

list branches remote (lbr) [-d] :: \
    if [[ $1 == -d ]]; then \
        git branch -r --format='%(creatordate:short), %(refname:short)' | column -s, -t | sort; \
    else \
        git branch -r --format='%(creatordate:short), %(refname:short)' | column -s, -t; \
    fi \
    ## -d - order by commit data

clone (c) <url> :: \
    git clone $1

create archive (ca) <name> :: \
    git archive --format-zip HEAD -o $1.zip \
    ## Create <name>.zip - contains the contents of the current checked out repo (no .git)

create bundle (cb) <name> :: \
    git bundle create $1.bundle --all \
    ## Creates <name>.bundle - contains the repo with history

fetch (f) :: git fetch

history (h) :: \
    git log > /tmp/gi1; \
    while read line; do echo $line; \ 
        if [[ ${line:0:6} == commit ]]; then \
            git diff-tree --no-commit-id --name-only -r ${line:7:99} | \
            tr "\n" " " | fold -s -w 100; echo; \
        fi; \
    done < /tmp/gi1 | \
    sed "s/^  *//; /^$/d; s/^commit/${l80}\n${c_yel}Commit:/" | \
    sed "s/^Author/${c_lcya}Author/; s/^Date/${c_lgre}Date/; s/$/${c_whi}/"; \
    rm -f /tmp/gi1 /tmp/gi2

pull (pu) :: \
    git pull

push origin (po) :: \
    git push origin

cmd gitsearch() { \
    show_branch_yn=n; \
    if [[ $1 == -b ]]; then \
        show_branch_yn=y; \
    fi; \
    rm -f /tmp/gi-cli.tmp*; \
    grep_args=""; \
    [ -n "$1" ] && grep_args="$grep_args --grep=$1"; \
    [ -n "$2" ] && grep_args="$grep_args --grep=$2"; \
    [ -n "$3" ] && grep_args="$grep_args --grep=$3"; \
    git log --all --oneline --all-match $grep_args > /tmp/gi-cli.tmp2; \
    if [[ $show_branch_yn == n ]]; then \
        cat /tmp/gi-cli.tmp2; \
    else \
        echo "$(wc -l < /tmp/gi-cli.tmp2) hits -  fetching branch details"; \
        while read hash msg; do \
            branches=$(git branch --all --contains "$hash" | head -1 | sed 's/^ *//'); \
            echo  "$branches || $msg" >> /tmp/gi-cli.tmp; \
            printf "."; \
        done < /tmp/gi-cli.tmp2; \
        echo; column -s "||" -t < /tmp/gi-cli.tmp; \
    fi; \
    rm -f  /tmp/gi-cli.tmp*; }

search commit messages (scm) [<-b>] <word> [<word>] [<word>] :: \
    gitsearch $1 $2 $3 \
    ## (-b show branch name)

status (s) :: git status

switch branch (sb) <branch-name> :: \
    git checkout $1 ## (git checkout)
```

## Alias file

```bash
# Completion function
_gi_complete() {
    local cur prev all
    all=""
    for ((i = 1; i < ${#COMP_WORDS[@]}; i++)); do
        word="${COMP_WORDS[i]}"
        [[ $word != -* ]] && all+="$word "
    done
    all="$(echo $all | xargs)"
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev_step=1
    prev="${COMP_WORDS[COMP_CWORD-$prev_step]}"
    while [[ "${prev:0:1}" == "-" ]]; do
        let prev_step=prev_step+1
        prev="${COMP_WORDS[COMP_CWORD-$prev_step]}"
    done

}
complete -F _gi_complete gi @gihe @giacp @gilbl @gilbr @gic @gica @gicb @gif @gih @gipu @gipo @giscm @gis @gisb

# Shortcut aliases
alias @gihe='gi gihe'
alias @giacp='gi giacp'
alias @gilbl='gi gilbl'
alias @gilbr='gi gilbr'
alias @gic='gi gic'
alias @gica='gi gica'
alias @gicb='gi gicb'
alias @gif='gi gif'
alias @gih='gi gih'
alias @gipu='gi gipu'
alias @gipo='gi gipo'
alias @giscm='gi giscm'
alias @gis='gi gis'
alias @gisb='gi gisb'
```

## Bash script

```bash
#!/usr/bin/env bash
debug_yn=n
[[ "$1" == "-d" ]] && { debug_yn=y; shift; }
[[ "${CLI_DEBUG^^}" == "TRUE" ]] && debug_yn=y

C_CYA="\x1b[96m" C_GRE="\x1b[92m" C_MAG="\x1b[95m" C_WHI="\x1b[97m" C_DEF="\x1b[0m"

# param 1 - actual number of parameters
# param 2 - required number of parameters
# param 3 - incorrect parameters message
check_params() {
  [[ "$1" < "$2" ]] && { echo -e "$3"; exit; }
}

print_command() {
  [[ $debug_yn == y ]] && { echo "COMMAND: $*" | sed 's/"/\"/g'; echo "COMMAND: $*" | sed 's/./-/g'; }
}
section="HELP"

if [[ "$1" == "help" || "$1" == "gihe" ]]; then
   [[ "$1" == "gihe" ]] && shift || shift 1
   usage="\x1b[95mhelp \x1b[96m(gihe)\x1b[97m [filter]\x1b[92m # Show help, optionally filtered by pattern\x1b[0m"
   check_params $# 0 "Usage: $usage"
   
echo -e "\x1b[92m---\x1b[0m"
echo -e "\x1b[92mGIT\x1b[0m"
echo -e "\x1b[92m---\x1b[0m"

echo -e "\x1b[95mgenerated:2026-07-14 10:39\x1b[0m"
echo
filter="$1"
if [[ -n "$filter" ]]; then
  # Show all section headers but only matching commands
  while IFS= read -r line; do
    if [[ "$line" =~ ^section= ]]; then
      # Always show section headers
      echo -e "\x1b[92m${line#section=}\x1b[0m"
    elif [[ "$line" =~ usage= ]]; then
      # Show command if it matches the filter
      cmd_line="${line#*usage=}"
      if echo "$cmd_line" | grep -iq "$filter"; then
        echo -e "   $cmd_line"
      fi
    fi
  done < <(egrep "^section=|^   usage=" "$0" | sed 's/\"//g')
else
  # Show everything
  while IFS= read -r line; do echo -e "${line}${CRESET}"; done < <(egrep "^section=|^   usage=" "$0" | sed "s/.*usage=/   /; s/.*section=/\x1b[92m/; s/\"//g")
fi
   exit
fi
section="GENERAL"

if [[ "$1 $2 $3" == "add commit push" || "$1" == "giacp" ]]; then
   [[ "$1" == "giacp" ]] && shift || shift 3
   usage="\x1b[95madd commit push \x1b[96m(giacp)\x1b[97m [-f|--force] [message]\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " force_yn=n; if [[ $1 == -f || $1 == --force ]]; then force_yn=y; shift; fi; if [[ \"$1\" == \"\" ]]; then message=\"Various\"; else message=\"$1\"; fi; [ -f ./gen-readme ] && ./gen-readme; git add .; git status; if [[ \"$1\" != \"-f\" ]]; then read -p 'Press a key to continue, CTRL-C to abort' dummy; fi; git commit -m 'Various'; git push origin"
   force_yn=n; if [[ $1 == -f || $1 == --force ]]; then force_yn=y; shift; fi; if [[ "$1" == "" ]]; then message="Various"; else message="$1"; fi; [ -f ./gen-readme ] && ./gen-readme; git add .; git status; if [[ "$1" != "-f" ]]; then read -p 'Press a key to continue, CTRL-C to abort' dummy; fi; git commit -m 'Various'; git push origin
   exit
fi

if [[ "$1 $2 $3" == "list branches local" || "$1" == "gilbl" ]]; then
   [[ "$1" == "gilbl" ]] && shift || shift 3
   usage="\x1b[95mlist branches local \x1b[96m(gilbl)\x1b[97m [-d]\x1b[92m # -d - order by commit data\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " if [[ $1 == -d ]]; then git branch --format='%(creatordate:short), %(refname:short)' | column -s, -t | sort; else git branch --format='%(creatordate:short), %(refname:short)' | column -s, -t; fi"
   if [[ $1 == -d ]]; then git branch --format='%(creatordate:short), %(refname:short)' | column -s, -t | sort; else git branch --format='%(creatordate:short), %(refname:short)' | column -s, -t; fi
   exit
fi

if [[ "$1 $2 $3" == "list branches remote" || "$1" == "gilbr" ]]; then
   [[ "$1" == "gilbr" ]] && shift || shift 3
   usage="\x1b[95mlist branches remote \x1b[96m(gilbr)\x1b[97m [-d]\x1b[92m # -d - order by commit data\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " if [[ $1 == -d ]]; then git branch -r --format='%(creatordate:short), %(refname:short)' | column -s, -t | sort; else git branch -r --format='%(creatordate:short), %(refname:short)' | column -s, -t; fi"
   if [[ $1 == -d ]]; then git branch -r --format='%(creatordate:short), %(refname:short)' | column -s, -t | sort; else git branch -r --format='%(creatordate:short), %(refname:short)' | column -s, -t; fi
   exit
fi

if [[ "$1" == "clone" || "$1" == "gic" ]]; then
   [[ "$1" == "gic" ]] && shift || shift 1
   usage="\x1b[95mclone \x1b[96m(gic)\x1b[97m <url>\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " git clone $1"
   git clone $1
   exit
fi

if [[ "$1 $2" == "create archive" || "$1" == "gica" ]]; then
   [[ "$1" == "gica" ]] && shift || shift 2
   usage="\x1b[95mcreate archive \x1b[96m(gica)\x1b[97m <name>\x1b[92m # Create <name>.zip - contains the contents of the current checked out repo (no .git)\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " git archive --format-zip HEAD -o $1.zip"
   git archive --format-zip HEAD -o $1.zip
   exit
fi

if [[ "$1 $2" == "create bundle" || "$1" == "gicb" ]]; then
   [[ "$1" == "gicb" ]] && shift || shift 2
   usage="\x1b[95mcreate bundle \x1b[96m(gicb)\x1b[97m <name>\x1b[92m # Creates <name>.bundle - contains the repo with history\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " git bundle create $1.bundle --all"
   git bundle create $1.bundle --all
   exit
fi

if [[ "$1" == "fetch" || "$1" == "gif" ]]; then
   [[ "$1" == "gif" ]] && shift || shift 1
   usage="\x1b[95mfetch \x1b[96m(gif)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " git fetch"
   git fetch
   exit
fi

if [[ "$1" == "history" || "$1" == "gih" ]]; then
   [[ "$1" == "gih" ]] && shift || shift 1
   usage="\x1b[95mhistory \x1b[96m(gih)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " git log > /tmp/gi1; while read line; do echo $line; if [[ ${line:0:6} == commit ]]; then git diff-tree --no-commit-id --name-only -r ${line:7:99} | tr \"\n\" \" \" | fold -s -w 100; echo; fi; done < /tmp/gi1 | sed \"s/^  *//; /^$/d; s/^commit/${l80}\n${c_yel}Commit:/\" | sed \"s/^Author/${c_lcya}Author/; s/^Date/${c_lgre}Date/; s/$/${c_whi}/\"; rm -f /tmp/gi1 /tmp/gi2"
   git log > /tmp/gi1; while read line; do echo $line; if [[ ${line:0:6} == commit ]]; then git diff-tree --no-commit-id --name-only -r ${line:7:99} | tr "\n" " " | fold -s -w 100; echo; fi; done < /tmp/gi1 | sed "s/^  *//; /^$/d; s/^commit/${l80}\n${c_yel}Commit:/" | sed "s/^Author/${c_lcya}Author/; s/^Date/${c_lgre}Date/; s/$/${c_whi}/"; rm -f /tmp/gi1 /tmp/gi2
   exit
fi

if [[ "$1" == "pull" || "$1" == "gipu" ]]; then
   [[ "$1" == "gipu" ]] && shift || shift 1
   usage="\x1b[95mpull \x1b[96m(gipu)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " git pull"
   git pull
   exit
fi

if [[ "$1 $2" == "push origin" || "$1" == "gipo" ]]; then
   [[ "$1" == "gipo" ]] && shift || shift 2
   usage="\x1b[95mpush origin \x1b[96m(gipo)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " git push origin"
   git push origin
   exit
fi
gitsearch() { show_branch_yn=n; if [[ $1 == -b ]]; then show_branch_yn=y; fi; rm -f /tmp/gi-cli.tmp*; grep_args=""; [ -n "$1" ] && grep_args="$grep_args --grep=$1"; [ -n "$2" ] && grep_args="$grep_args --grep=$2"; [ -n "$3" ] && grep_args="$grep_args --grep=$3"; git log --all --oneline --all-match $grep_args > /tmp/gi-cli.tmp2; if [[ $show_branch_yn == n ]]; then cat /tmp/gi-cli.tmp2; else echo "$(wc -l < /tmp/gi-cli.tmp2) hits -  fetching branch details"; while read hash msg; do branches=$(git branch --all --contains "$hash" | head -1 | sed 's/^ *//'); echo  "$branches || $msg" >> /tmp/gi-cli.tmp; printf "."; done < /tmp/gi-cli.tmp2; echo; column -s "||" -t < /tmp/gi-cli.tmp; fi; rm -f  /tmp/gi-cli.tmp*; }

if [[ "$1 $2 $3" == "search commit messages" || "$1" == "giscm" ]]; then
   [[ "$1" == "giscm" ]] && shift || shift 3
   usage="\x1b[95msearch commit messages \x1b[96m(giscm)\x1b[97m [-b] <word> [word] [word]\x1b[92m # (-b show branch name)\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " gitsearch $1 $2 $3"
   gitsearch $1 $2 $3
   exit
fi

if [[ "$1" == "status" || "$1" == "gis" ]]; then
   [[ "$1" == "gis" ]] && shift || shift 1
   usage="\x1b[95mstatus \x1b[96m(gis)\x1b[97m\x1b[0m"
   check_params $# 0 "Usage: $usage"
   print_command " git status"
   git status
   exit
fi

if [[ "$1 $2" == "switch branch" || "$1" == "gisb" ]]; then
   [[ "$1" == "gisb" ]] && shift || shift 2
   usage="\x1b[95mswitch branch \x1b[96m(gisb)\x1b[97m <branch-name>\x1b[92m # (git checkout)\x1b[0m"
   check_params $# 1 "Usage: $usage"
   print_command " git checkout $1"
   git checkout $1
   exit
fi

if [[ "$1" == "" ]]; then
  echo "No option passed"
else
  echo "$*: invalid option"
fi
echo "Try "gi help" for more information."
```
