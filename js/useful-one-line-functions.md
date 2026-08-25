---
title: Useful One Line Functions
---

<style>code {font-size: 1.3em !important} </style>

```javascript
const rndInt = (max) => Math.floor(Math.random() * max) + 1;
```

```javascript
const timeMS = (prevTime = 0) => Date.now() - prevTime;
```

```javascript
let DEBUG = true; const debug = (...args) => DEBUG && console.log('DEBUG:', args);
```

```javascript
const delay = (ms) => new Promise((res) => setTimeout(res, ms));
```

```javascript
const concat = (...args) => args.join(' ');
```

Not quite one line

```js
const cls = () => {
  log('\u001b[3J\u001b[1J');
  console.clear();
};
```

<hr>
