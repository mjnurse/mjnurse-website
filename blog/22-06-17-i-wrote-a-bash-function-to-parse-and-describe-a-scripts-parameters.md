---
title: 22-06-17 - I Wrote A Bash Function To Parse And Describe A Scripts Parameters
section: bash
---
## Overview 

I am always skipping up and down in a bash script as I add script parameters and need to add a description for the parameter in the `help_text` / header.

I decided to write a function to generate the PARAMETER description from the parameter parsing case statement in the script.  It uses the parameter case elements and comments within the case statement.

## The Function

```bash
# Parses and prints script parameter details between two comments: 
# "# Start Parse Script Parameters" and "# End Parse Script Parameters".
# Within the parameter parse case statement, parameters should be commented
# as follows:
#
# case $1 in
#   -p|--param # <list> <parameters> <as a comment>
#     # Desc: Describe the parameter in a comment starting "# Desc:"
#     # Desc: For multiple lines, all mist start with "# Desc:"
#     ...
# esac
function print_parameters() {

  echo "PARAMETERS"

  echo -e "$(cat $0 | sed -n '/^ *# Start Parse Script Parameters/,$p' \
                    | sed -n '/^ *# End Parse Script Parameters/q;p' \
                    | sed -n '/^ *-.*).*$/p; /^ *# Desc:/p' \
                    | sed 's/^ */    /; s/# Desc: */    /; s/\(^  *-.*\)) *$/\1/' \
                    | sed 's/\(^  *-.*\)) *# *\(.*\)/\n\\e[1m\1 \2\\e[0m/' \
                    | sed 's/\(^ *-.*\)/\n\\e[1m\1\\e[0m/') "
}
```

## The Parameter Parsing case Statement

Note: The function parses the case statement between the two comments: `# Start Parse Script Parameters` and `# End Parse Script Parameters`.A

An example parameter parsing case statement.

```bash
# Start Parse Script Parameters

while [[ "$1" ]]; do
  case $1 in
    -h|--help)
      # Desc: To show this help message.
      echo "$help_text"
      print_parameters
      exit
      ;;
    -e|--example) # <example-value>
      # Desc: An example parameter.
      # Desc: With a multi line description.
      shift
      username="$1"
      ;;
    *)
      echo "Error: Incorrect Parameter: $1"
      errorYN=y
      ;;
  esac
  shift
done

# End Parse Script Parameters
```

## The Output

Calling a script which contains the above function and the above parameter parsing case statement.

```bash
> example-script -h

NAME
  example-script

USAGE
  example-script

DESCRIPTION
  An example script.

AUTHOR
  mjnurse.dev - 2022

PARAMETERS

    -h|--help
        To show this help message.

    -e|--example <example-value>
        An example parameter.
        With a multi line description.
```

