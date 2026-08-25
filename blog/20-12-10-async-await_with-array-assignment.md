---
title: 20-12-10 - Async Await with Array Assignment
section: Javascript
---

```javascript
const [user, account] = await Promise.all([
 fetch('/user'),
 fetch('/account')
 ])
```

<hr>
