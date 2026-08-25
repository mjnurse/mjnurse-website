---
title: Creating a Javascript Module
---

## First We Create a Module

**myModule.js**

This contains one private function `rndInt` and one public (exported) function `rndColor`.

I have also included a check with code which will run when `myModule.js` is run directly.  This might be useful for unit tests in the module (not sure).

```javascript
const rndInt = (max) => Math.floor(Math.random() * max) + 1;

exports.rndColor = () => '#' + (rndInt(256)-1).toString(16) +
    (rndInt(256)-1).toString(16) + (rndInt(256)-1).toString(16);

if (process.argv[1].match(/myModule.js$/g)) {
  console.log('myModule run directly');
}
```

## Second We Use the Module

**myProgram.js**

```javascript
const m = require('./myModule');

console.log(m.rndColor());
```

<hr>
