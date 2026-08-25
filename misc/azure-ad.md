---
title: Azure AD - Find My AD Group Memberships
---

First authenticate - this command will pop up a window to sign in.

```shell
> Connect-AzureAD

Account              Environment TenantId           TenantDomain AccountType
-------              ----------- --------           ------------ -----------
martinnurse@demo.com AzureCloud  c780234d-ed5b-4ccd demo.com     User
```

Get my AD group memberships.

```shell
> Get-AzureADUser -SearchString martinnurse@demo.com `
  | Get-AzureADUserMembership `
  | % {Get-AzureADObjectByObjectId -ObjectId $_.ObjectId `
  | select DisplayName,ObjectType,MailEnabled,SecurityEnabled,ObjectId} `
  | ft

DisplayName      ObjectType MailEnabled SecurityEnabled ObjectId
-----------      ---------- ----------- --------------- --------
Sport And Social Group             True           False a3c234fe-82ba-4223-9e87
AllStaff         Group             True            True 7869b234-1f75-433d-b9d5
...
```

