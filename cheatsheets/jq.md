---
title: jq
---

## Multi-level filter

Source JSON
```json
{
  "a": 1,
  "b": {
    "c": 2,
    "d": 3
  },
  "e": [
    {
      "f": 6,
      "g": 7
    },
    {
      "f": 8,
      "g": 9
    }
  ]
}

```
Filter section `b` to only show children `c` and filter section `e` to only show children `g`.

Command: `jq '.b |= {c} | .e[] |= {g} | {e, b, a}'`

```json
{
  "a": 1,
  "b": {
    "c": 2
  },
  "e": [
    {
      "g": 7
    },
    {
      "g": 9
    }
  ]
}
 ```

## Sort / Order a subset of keys / a sub-section

Source JSON
 ```json
 {
  "a": 1,
  "b": {
    "f": 2,
    "d": 3
  }
}
 ```
 
Command `jq '{a: .a, b: (.b | to_entries | sort_by(.key) | from_entries)}'`

 ```json
 {
  "a": 1,
  "b": {
    "d": 3,
    "f": 2
  }
}
 ```

