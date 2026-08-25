---
title: Async Await with Array Assignment
section: Javascript
---

```javascript
const [user, account] = await Promise.all([
 fetch('/user'),
 fetch('/account')
 ])
```

<hr>
