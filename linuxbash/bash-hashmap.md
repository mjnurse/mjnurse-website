---
title: Bash Hashmap 
---

Bash supports associative arrays / hashmaps!

```bash
# Declare COUNTRIES hashmap which maps city names to Countries, and add some values.
#
# -A means associative array (hashmap)
# -r means read-only
$ declare -A COUNTRIES=(
  ["London"]="UK"
  ["Paris"]="France"
  ["Birmingham"]="UK"
)

# Add additional value
$ COUNTRIES["New York"]="US"

# Echo the hashamp - returns nothing
$ echo $COUNTRIES

# Echo below returns nothing for $COUNTRIES and then prints ["Paris"]
$ echo $COUNTRIES["Paris"]
[Paris]

# Get the country for Paris
$ echo ${COUNTRIES["Paris"]}
France

# Get all country entries
$ echo ${COUNTRIES[@]}
France US UK UK

# Get all the city names
$ echo ${!COUNTRIES[@]}
Paris New York London Birmingham

# Loop through all entries and display city and country
$ for city in "${!COUNTRIES[@]}"; do echo $city - ${COUNTRIES[$city]}; done
Paris - France
New York - US
London - UK
Birmingham - UK
```

