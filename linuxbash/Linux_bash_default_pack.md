---
title: Linux bash default Pack
---

Packs contain bash scripts which have been compressed and converted to a
base64 string.  This is a convenient way to copy a set of bash scripts
into a linux environment using only a command line terminal.

<script>
  let packText=`# --------------------------------------------------------------------------------------------------
# CONTENTS: calc, cls, file-watch-do
# --------------------------------------------------------------------------------------------------
# FILE: calc 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA41UXVPiMBR9z6+4hjoIIwbYfRLrjLiO67h+jOCTukxaAs1aWiZJERf573vTQoEVtZnJ0Nyce+5H7qG0wx
KtmCcjJqIJeFwHJBDhuGfE1LiUXJ9cnRHA5fPQhxqcxqMRj/oQykiktiTkJlaE3HdOzteQD/HYyDjST3C0ROHxmJCb2+7FzXUnRd
aCt1rNRktPdnWC+AWsBWz8A5LBJMJkZITivpETkaN/8STyA+ARrN3CnudX1lJbkmgk0fKv0HA04WEijnOa0ziaCGWWdjAxXLb34Q
r3Oe4u7ts20vw465zeXaT5p74XEZhg1QWsDxItoDwtwyBWMEpCI8fh635mVZnVeoyVmMg40aCERhBSn9x3f97cpayjP1GitDgYSh
Mk3oGMsevNerNOaPYwtvMu/eAdKHkRXq8vtP8Vbsz9595IjDyhXNoXA46JUEKMenVpV72CM6uXSlU2x0fKqomVwDbj5ygtlRIzGr
vUmeXTgvB0COaUJJoPhevsCT+Igd7b0yEyosfu7mIAqnMKb2AU1PpAHyN70AI/NQOoMmBDWiFEDuDhAajToOC6QCk8PbVsByPsVM
btzNJYGHNlwRqy81QaaJCBJMR2vIfdxoT3fG6AYSrMtqNC8yBLzJZYuXs9ZXsJZCjyzHZydD9eCADf22lgt/IRyye9AiXganj4bt
JhbS0KyTtLN2+xrA1Dq7WK859U8nAFpbJO66Heww8D5XLKQyzlU1BO7wtuAw5Jk265uWzjzWKaNOYr3GYLoaxRb363k5OmWtnmef
WJZwH386/cC3B0C3EUILotTvQpm6cEf/7oYauVjRurdxwOq5s0sFNdCXXKHqts2AKULMt+FXNmS63MrYQ3A2d/dyuuBfmCsazZb5
bV9a3FoPxZL3JXF5yMdZuAshsKxyu9F2uE0DxD6kAODOnHkSD/AJbOEwQqBwAA
' | base64 -d | gunzip > calc; chmod u+x calc
# --------------------------------------------------------------------------------------------------
# FILE: cls 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA5WQvU7DMBRG9/sUF3fIAkkhE0OHqFRQJFrUnwmkyHZuiKnjRPY1oW9PEEidkMp6pO/o6JtcZDH4TBmXkf
tAJUMDDdm+ZPrkmYBV8bQARG0DXuHckvTI5FvjpEXpKuwj8/GEVKxr8gD7bXH/uwO4W2znm+XzbrlejehcSQpQ7HcP6824ad9d9I
HSN8NNVKnpxpib6fUtiJ9YaxzNxLlmAQOpsqKg/z3spT6ULbWK/EyMZxkdLiuqZbQsACZYdRRcwijtII8Bh84fsDY+MLJpCX0XR3
fokAejKYXeG8c1Jq/TPH/JHxPQ3yV/4S/D1RG9rAEAAA==
' | base64 -d | gunzip > cls; chmod u+x cls
# --------------------------------------------------------------------------------------------------
# FILE: file-watch-do 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA7VW33PiNhB+11+xFWYc0hGEm7mHJoE2cyF3mWl+DJDpAzCMsWWsBsuuLF8uc+R/v5VsbIfk2us01QtCu9
pvd79vBa2fenmmeishe1x+hpWXRSTim3Sp+Rc9oOT67GpEAFcoNpw9eNqPWJAAgz/MFjx7DgeJgkAo7utEPXbAkwFwD81axByEBp
FBnAQiFDwAlUu85idxjG5dQu4mZx9fg5glqRaJzBZwajGkF/MhnJYXhzDbbSH1FNo0V9lwQcjN7fTy5npCbEgWbhkLFf8r59J/hN
OM+4kMsqE1mjXhGnTEofZJQvAj7t9nICSU/l0456GXb2wl/fIUcz8fTT6MLy2gjfjjTbGYxgudSv8HoSOENJbqmsGzkb/bvrO76a
ebceHzp8xVxrtrDJSvusLQ9O6o/wuhBaUbIfmAPsuxmeJL2mxuMY9XXH2fQkoe+GoZ8Mz/3wBSz79fFm4DGhRMUEKMIgbO16PevD
vvPRGtHgd0ijCuYyzAIhdCRIgThWASt7FnFIU3W/ARec8zb22YT2KoJN8l9hTDVket1qHV6FNlsp/tdqm0wxeG27Mxjs10NH7F1p
DMvrHXmznuXM6Vu9izYArI7+6Q3pmPYyiNT1iQCGE2A+r0KQwGQFlIYbttfK9ngMJicWJEJq1mskiE2u4mv49Gt8vp5dVo4PQbNr
7J+L5Dn4SCkIvzAUUgaMHFC6rDjbcmJMylb1oOa66Xgac5fLWhdulenBf5hXtZmWXdmbJF2MMqEZubHjgH1uVn2v7UvmpP2te0U5
lDgVKz5TP9mCLJwFIlpA7BbU9/g3Y6ly5sIUuUBiZxpz2xAdavAvDgb+MXBTgHByhWhsl0OsDWGt4fletlOTaoHyWA86GkkOtjmP
ieNLtG21yn75pJ0N69MQzhqPs+o42yyoeSPBHiexkvahQFDGNGs1sWbee/1qkWoE4l5zoa/yJ09eXkhPDM8wmShmQu7WzZ1hcqKG
cRjw4bcttNqCVxj8P6RhWQWtkUl1kITcvzu7tG4UNi2mDcUO6VN7YcXwjbuhIFrdVrYQIU0kTtlmDBj4NVZPx7xIDW01JEHSmVqO
NX5sOtY7sgE40vVb4LZXiBYsRSxT8vrafRIkqyGqRmPR3ScHl+hTxEBnuGv1pYc5BYgPJstgtiHAsO924XnSpv2bHbcJ6CUz8FDW
n+Y5J2qhNZ9Ge/sjrjXfcabWT/YdE6zl51SCqMc3ncEPKbYu6ivn0hFNOGD0mcbvBvD33z+MSy9A2KX52MGwoAAA==
' | base64 -d | gunzip > file-watch-do; chmod u+x file-watch-do

`;
</script>

## Contents
```bash
Bad option: -m
```

<button onCLick='copyToClipboard(packText)'>Copy To Clipboard</button>

```bash
# --------------------------------------------------------------------------------------------------
# CONTENTS: calc, cls, file-watch-do
# --------------------------------------------------------------------------------------------------
# FILE: calc 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA41UXVPiMBR9z6+4hjoIIwbYfRLrjLiO67h+jOCTukxaAs1aWiZJERf573vTQoEVtZnJ0Nyce+5H7qG0wx
KtmCcjJqIJeFwHJBDhuGfE1LiUXJ9cnRHA5fPQhxqcxqMRj/oQykiktiTkJlaE3HdOzteQD/HYyDjST3C0ROHxmJCb2+7FzXUnRd
aCt1rNRktPdnWC+AWsBWz8A5LBJMJkZITivpETkaN/8STyA+ARrN3CnudX1lJbkmgk0fKv0HA04WEijnOa0ziaCGWWdjAxXLb34Q
r3Oe4u7ts20vw465zeXaT5p74XEZhg1QWsDxItoDwtwyBWMEpCI8fh635mVZnVeoyVmMg40aCERhBSn9x3f97cpayjP1GitDgYSh
Mk3oGMsevNerNOaPYwtvMu/eAdKHkRXq8vtP8Vbsz9595IjDyhXNoXA46JUEKMenVpV72CM6uXSlU2x0fKqomVwDbj5ygtlRIzGr
vUmeXTgvB0COaUJJoPhevsCT+Igd7b0yEyosfu7mIAqnMKb2AU1PpAHyN70AI/NQOoMmBDWiFEDuDhAajToOC6QCk8PbVsByPsVM
btzNJYGHNlwRqy81QaaJCBJMR2vIfdxoT3fG6AYSrMtqNC8yBLzJZYuXs9ZXsJZCjyzHZydD9eCADf22lgt/IRyye9AiXganj4bt
JhbS0KyTtLN2+xrA1Dq7WK859U8nAFpbJO66Heww8D5XLKQyzlU1BO7wtuAw5Jk265uWzjzWKaNOYr3GYLoaxRb363k5OmWtnmef
WJZwH386/cC3B0C3EUILotTvQpm6cEf/7oYauVjRurdxwOq5s0sFNdCXXKHqts2AKULMt+FXNmS63MrYQ3A2d/dyuuBfmCsazZb5
bV9a3FoPxZL3JXF5yMdZuAshsKxyu9F2uE0DxD6kAODOnHkSD/AJbOEwQqBwAA
' | base64 -d | gunzip > calc; chmod u+x calc
# --------------------------------------------------------------------------------------------------
# FILE: cls 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA5WQvU7DMBRG9/sUF3fIAkkhE0OHqFRQJFrUnwmkyHZuiKnjRPY1oW9PEEidkMp6pO/o6JtcZDH4TBmXkf
tAJUMDDdm+ZPrkmYBV8bQARG0DXuHckvTI5FvjpEXpKuwj8/GEVKxr8gD7bXH/uwO4W2znm+XzbrlejehcSQpQ7HcP6824ad9d9I
HSN8NNVKnpxpib6fUtiJ9YaxzNxLlmAQOpsqKg/z3spT6ULbWK/EyMZxkdLiuqZbQsACZYdRRcwijtII8Bh84fsDY+MLJpCX0XR3
fokAejKYXeG8c1Jq/TPH/JHxPQ3yV/4S/D1RG9rAEAAA==
' | base64 -d | gunzip > cls; chmod u+x cls
# --------------------------------------------------------------------------------------------------
# FILE: file-watch-do 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA7VW33PiNhB+11+xFWYc0hGEm7mHJoE2cyF3mWl+DJDpAzCMsWWsBsuuLF8uc+R/v5VsbIfk2us01QtCu9
pvd79vBa2fenmmeishe1x+hpWXRSTim3Sp+Rc9oOT67GpEAFcoNpw9eNqPWJAAgz/MFjx7DgeJgkAo7utEPXbAkwFwD81axByEBp
FBnAQiFDwAlUu85idxjG5dQu4mZx9fg5glqRaJzBZwajGkF/MhnJYXhzDbbSH1FNo0V9lwQcjN7fTy5npCbEgWbhkLFf8r59J/hN
OM+4kMsqE1mjXhGnTEofZJQvAj7t9nICSU/l0456GXb2wl/fIUcz8fTT6MLy2gjfjjTbGYxgudSv8HoSOENJbqmsGzkb/bvrO76a
ebceHzp8xVxrtrDJSvusLQ9O6o/wuhBaUbIfmAPsuxmeJL2mxuMY9XXH2fQkoe+GoZ8Mz/3wBSz79fFm4DGhRMUEKMIgbO16PevD
vvPRGtHgd0ijCuYyzAIhdCRIgThWASt7FnFIU3W/ARec8zb22YT2KoJN8l9hTDVket1qHV6FNlsp/tdqm0wxeG27Mxjs10NH7F1p
DMvrHXmznuXM6Vu9izYArI7+6Q3pmPYyiNT1iQCGE2A+r0KQwGQFlIYbttfK9ngMJicWJEJq1mskiE2u4mv49Gt8vp5dVo4PQbNr
7J+L5Dn4SCkIvzAUUgaMHFC6rDjbcmJMylb1oOa66Xgac5fLWhdulenBf5hXtZmWXdmbJF2MMqEZubHjgH1uVn2v7UvmpP2te0U5
lDgVKz5TP9mCLJwFIlpA7BbU9/g3Y6ly5sIUuUBiZxpz2xAdavAvDgb+MXBTgHByhWhsl0OsDWGt4fletlOTaoHyWA86GkkOtjmP
ieNLtG21yn75pJ0N69MQzhqPs+o42yyoeSPBHiexkvahQFDGNGs1sWbee/1qkWoE4l5zoa/yJ09eXkhPDM8wmShmQu7WzZ1hcqKG
cRjw4bcttNqCVxj8P6RhWQWtkUl1kITcvzu7tG4UNi2mDcUO6VN7YcXwjbuhIFrdVrYQIU0kTtlmDBj4NVZPx7xIDW01JEHSmVqO
NX5sOtY7sgE40vVb4LZXiBYsRSxT8vrafRIkqyGqRmPR3ScHl+hTxEBnuGv1pYc5BYgPJstgtiHAsO924XnSpv2bHbcJ6CUz8FDW
n+Y5J2qhNZ9Ge/sjrjXfcabWT/YdE6zl51SCqMc3ncEPKbYu6ivn0hFNOGD0mcbvBvD33z+MSy9A2KX52MGwoAAA==
' | base64 -d | gunzip > file-watch-do; chmod u+x file-watch-do
```
