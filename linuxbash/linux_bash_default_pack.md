---
title: Linux bash default Pack
---

Packs contain bash scripts which have been compressed and converted to a
base64 string.  This is a convenient way to copy a set of bash scripts
into a linux environment using only a command line terminal.

<script>
  let packText=`# --------------------------------------------------------------------------------------------------
# CONTENTS: file-watch-do, cls, calc
# --------------------------------------------------------------------------------------------------
# FILE: file-watch-do 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA7VW32/bNhB+519xo2UozkA7LtCHJbG3oHHaAMsP2A72YBuGLFEWF4vSKKppUOd/35GSJdVxtwLL+CKKd/
fdd7zvZLd+6uWZ6q2E7HH5GVZeFpGIb9Kl5l/0gJLbi5sRAVyh2HD25Gk/YkECDP4wW/DsORwlCgKhuK8T9dwBTwbAPTRrEXMQGk
QGcRKIUPAAVC4xzE/iGN26hDxMLj4eSjFLUi0SmS3g3OaQXsyHcF4GDmG220LqKbRprrLhgpC7++n13e2EWEgWbhkLFf8r59J/hv
OM+4kMsqE1mjXhGnTEofZJQvAj7j9mICSU/l245KGXb2wl/fIUuV+OJh/G1zahRfzxS7E5jRc6lf5PQkeY0liqMJPPIn/3+i4epp
/uxoXPnzJXGe+uEShfdYVp07uT/i+EFi3dCMkH9BuOTYqv22a5xTxecfX9FlLyxFfLgGf+/5Yg9fzHZeE2oEHRCUqIUcTA+XrSm3
fnvRei1fOATjGN6xgLsMiFEDPEicJkErexZxSFkS34iH3PM29tOp/EUEm+S+wpwlZHrdax1ehLZbLPdrtU2vErw/3FGMdmOhofsD
Uks2/s9WaOO5dz5S72LEgB+7s7pA/mcQql8QULEiHMZkCdPoXBACgLKWy3jfd6BigsFmdGZNJqJotEqO1u8vtodL+cXt+MBk6/Ye
ObjO879EkoCLm6HFBMBC24etXqcOOtCQlz6ZsrhzXXy8DTHL5aqB3dq8uCX7jHyizrzpQtwh5WRCw3PXCOrMvPtP2pfdOetG9ppz
KHAqVmy2f6OcUmA0uVkDoEtz39DdrpXLqwhSxRGpjEnfbEBli/AuDBP+IXBThHRyhWhmQ6HWBrDe9PyvW6HAvqRwngfCgp5PoUJr
4nza5xba7Td80kaO/RGIZw0n2f0UZZ5YeSvBDiexkvahRFGsaMZrcs2s5/rakWSZ1KzjUa/yJ09XJ2Rnjm+bWU3hWt2etMiWaFR5
snOH3lu0E18jDzvyxmtF+ishA9q/OD0PbrYWo3bqjx2ts6FZpDUZaAwY8DVrd8GDWgtdSLyJFSiTo9IG63jndBJho/M7n5Tu3Kh2
I+6tkiqeKflzbIaAqlVQ1Ek36HNFy+DSFPkaExw18fLDFILGx5NtuBGMeia3vRxcWUUXZ8Npyn4NQj3ZDYv5K005nI4qr2K6sZ7y
6ycaPsP6yG2vaqwwmEcS5PkeYxfdNszvHbk6dIFT4kcbrBvyz0zfGJ7czfHMSc4dcJAAA=
' | base64 -d | gunzip > file-watch-do; chmod u+x file-watch-do
# --------------------------------------------------------------------------------------------------
# FILE: cls 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA5WQvU7DMBRG9/sUF3fIAkkhE0OHqFRQJFrUnwmkyHZuiKnjRPY1oW9PEEidkMp6pO/o6JtcZDH4TBmXkf
tAJUMDDdm+ZPrkmYBV8bQARG0DXuHckvTI5FvjpEXpKuwj8/GEVKxr8gD7bXH/uwO4W2znm+XzbrlejehcSQpQ7HcP6824ad9d9I
HSN8NNVKnpxpib6fUtiJ9YaxzNxLlmAQOpsqKg/z3spT6ULbWK/EyMZxkdLiuqZbQsACZYdRRcwijtII8Bh84fsDY+MLJpCX0XR3
fokAejKYXeG8c1Jq/TPH/JHxPQ3yV/4S/D1RG9rAEAAA==
' | base64 -d | gunzip > cls; chmod u+x cls
# --------------------------------------------------------------------------------------------------
# FILE: calc 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA41UXVPiMBR9z6+4xjoIIwbYfVq2zojrqOP6MYJP6jJtCTRrmzBJirjIf9+bFoo4ij5kSG7POffekxu2t1
hmNAuFZFxOIAxMTGKejPuWT61PyeXhxTEBiIIkgjocqTQN5AASIXkey5LAKk3IbffwpMTdqbEVSpoH+LnE4PGAkKvr3tnVZRdx9f
ilXnd5cA/QjdUTuBO4rPvEAQQChLRcB5EVE57jfgeZjGIIJLz6ArthVH1VTEE3SDfiHzc58UjJCdcWZJaGXINVcN7ZgwtcJ7h6uK
47yPt13D26OcuLRNqZBBuv2sQWIDNQmVZgqDSkWWLFOHnewyCHii6ijjDWfCIUQjU3CELdw9ve6dUNSqZ/ZaYN3x8JG2fhvlDoaa
vRahBamO589ekHLlPyxMP+gJvoM9w4iB77KXe9+nTAhwGWQQmx+tmnPf0M3qyxvV1jc7yGohelOVqK2zTvkxKbjn3qzcpJQHh+xX
NKMhOMuO/t8ihWQG/d6QcqImNnZ3HBtTmFF7Aa6gOg99IdDMetYQA1BmxEq4SIIdzdAfWaFHwfKIWHh7bzT6JPhbY3y3NhzlUEey
jOU2GhSYaCEOd3H73GgnejwALDUpizo0rLJEvMO7lKeiNXe4pFwsvKtkr0QOXjjXftNdGrfKzKKa7mx7LK0ja6jGO1i227XVDfzP
dSIcRnlryBlrO8nqYD6HuLrsXOOxhbXI1BD7jfaiOINRut7+4acvnqOudiA2cj8eQz4kZ270vsjRLXX5f4QCfUPHhct7u2dNk9B3
xRbqzyFF5tNcdTdl9jozbgRLPiVzNvthyluZvwZYriX2ClspBdaFUM+8OK2r+1GVTe77Qk+eAVeusDV8QoHKyG/6MGuQncNxOLoS
UDJTkh/wH7RzuWBAYAAA==
' | base64 -d | gunzip > calc; chmod u+x calc

`;
</script>

## Contents
```bash
[95mf[39m - [96mfile-watch-do:[37m         Watch a file or directory and each time it or a member is modified run a command 
```

<button onCLick='copyToClipboard(packText)'>Copy To Clipboard</button>

```bash
# --------------------------------------------------------------------------------------------------
# CONTENTS: file-watch-do, cls, calc
# --------------------------------------------------------------------------------------------------
# FILE: file-watch-do 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA7VW32/bNhB+519xo2UozkA7LtCHJbG3oHHaAMsP2A72YBuGLFEWF4vSKKppUOd/35GSJdVxtwLL+CKKd/
fdd7zvZLd+6uWZ6q2E7HH5GVZeFpGIb9Kl5l/0gJLbi5sRAVyh2HD25Gk/YkECDP4wW/DsORwlCgKhuK8T9dwBTwbAPTRrEXMQGk
QGcRKIUPAAVC4xzE/iGN26hDxMLj4eSjFLUi0SmS3g3OaQXsyHcF4GDmG220LqKbRprrLhgpC7++n13e2EWEgWbhkLFf8r59J/hv
OM+4kMsqE1mjXhGnTEofZJQvAj7j9mICSU/l245KGXb2wl/fIUuV+OJh/G1zahRfzxS7E5jRc6lf5PQkeY0liqMJPPIn/3+i4epp
/uxoXPnzJXGe+uEShfdYVp07uT/i+EFi3dCMkH9BuOTYqv22a5xTxecfX9FlLyxFfLgGf+/5Yg9fzHZeE2oEHRCUqIUcTA+XrSm3
fnvRei1fOATjGN6xgLsMiFEDPEicJkErexZxSFkS34iH3PM29tOp/EUEm+S+wpwlZHrdax1ehLZbLPdrtU2vErw/3FGMdmOhofsD
Uks2/s9WaOO5dz5S72LEgB+7s7pA/mcQql8QULEiHMZkCdPoXBACgLKWy3jfd6BigsFmdGZNJqJotEqO1u8vtodL+cXt+MBk6/Ye
ObjO879EkoCLm6HFBMBC24etXqcOOtCQlz6ZsrhzXXy8DTHL5aqB3dq8uCX7jHyizrzpQtwh5WRCw3PXCOrMvPtP2pfdOetG9ppz
KHAqVmy2f6OcUmA0uVkDoEtz39DdrpXLqwhSxRGpjEnfbEBli/AuDBP+IXBThHRyhWhmQ6HWBrDe9PyvW6HAvqRwngfCgp5PoUJr
4nza5xba7Td80kaO/RGIZw0n2f0UZZ5YeSvBDiexkvahRFGsaMZrcs2s5/rakWSZ1KzjUa/yJ09XJ2Rnjm+bWU3hWt2etMiWaFR5
snOH3lu0E18jDzvyxmtF+ishA9q/OD0PbrYWo3bqjx2ts6FZpDUZaAwY8DVrd8GDWgtdSLyJFSiTo9IG63jndBJho/M7n5Tu3Kh2
I+6tkiqeKflzbIaAqlVQ1Ek36HNFy+DSFPkaExw18fLDFILGx5NtuBGMeia3vRxcWUUXZ8Npyn4NQj3ZDYv5K005nI4qr2K6sZ7y
6ycaPsP6yG2vaqwwmEcS5PkeYxfdNszvHbk6dIFT4kcbrBvyz0zfGJ7czfHMSc4dcJAAA=
' | base64 -d | gunzip > file-watch-do; chmod u+x file-watch-do
# --------------------------------------------------------------------------------------------------
# FILE: cls 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA5WQvU7DMBRG9/sUF3fIAkkhE0OHqFRQJFrUnwmkyHZuiKnjRPY1oW9PEEidkMp6pO/o6JtcZDH4TBmXkf
tAJUMDDdm+ZPrkmYBV8bQARG0DXuHckvTI5FvjpEXpKuwj8/GEVKxr8gD7bXH/uwO4W2znm+XzbrlejehcSQpQ7HcP6824ad9d9I
HSN8NNVKnpxpib6fUtiJ9YaxzNxLlmAQOpsqKg/z3spT6ULbWK/EyMZxkdLiuqZbQsACZYdRRcwijtII8Bh84fsDY+MLJpCX0XR3
fokAejKYXeG8c1Jq/TPH/JHxPQ3yV/4S/D1RG9rAEAAA==
' | base64 -d | gunzip > cls; chmod u+x cls
# --------------------------------------------------------------------------------------------------
# FILE: calc 
# --------------------------------------------------------------------------------------------------
echo 'H4sIAAAAAAACA41UXVPiMBR9z6+4xjoIIwbYfVq2zojrqOP6MYJP6jJtCTRrmzBJirjIf9+bFoo4ij5kSG7POffekxu2t1
hmNAuFZFxOIAxMTGKejPuWT61PyeXhxTEBiIIkgjocqTQN5AASIXkey5LAKk3IbffwpMTdqbEVSpoH+LnE4PGAkKvr3tnVZRdx9f
ilXnd5cA/QjdUTuBO4rPvEAQQChLRcB5EVE57jfgeZjGIIJLz6ArthVH1VTEE3SDfiHzc58UjJCdcWZJaGXINVcN7ZgwtcJ7h6uK
47yPt13D26OcuLRNqZBBuv2sQWIDNQmVZgqDSkWWLFOHnewyCHii6ijjDWfCIUQjU3CELdw9ve6dUNSqZ/ZaYN3x8JG2fhvlDoaa
vRahBamO589ekHLlPyxMP+gJvoM9w4iB77KXe9+nTAhwGWQQmx+tmnPf0M3qyxvV1jc7yGohelOVqK2zTvkxKbjn3qzcpJQHh+xX
NKMhOMuO/t8ihWQG/d6QcqImNnZ3HBtTmFF7Aa6gOg99IdDMetYQA1BmxEq4SIIdzdAfWaFHwfKIWHh7bzT6JPhbY3y3NhzlUEey
jOU2GhSYaCEOd3H73GgnejwALDUpizo0rLJEvMO7lKeiNXe4pFwsvKtkr0QOXjjXftNdGrfKzKKa7mx7LK0ja6jGO1i227XVDfzP
dSIcRnlryBlrO8nqYD6HuLrsXOOxhbXI1BD7jfaiOINRut7+4acvnqOudiA2cj8eQz4kZ270vsjRLXX5f4QCfUPHhct7u2dNk9B3
xRbqzyFF5tNcdTdl9jozbgRLPiVzNvthyluZvwZYriX2ClspBdaFUM+8OK2r+1GVTe77Qk+eAVeusDV8QoHKyG/6MGuQncNxOLoS
UDJTkh/wH7RzuWBAYAAA==
' | base64 -d | gunzip > calc; chmod u+x calc
```
