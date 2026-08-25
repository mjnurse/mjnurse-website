---
title: Promises
---

## Example 1

An example using no function short hands.

```javascript
const rndInt = max => {return Math.floor(Math.random() * max) + 1}
const timeMS = (prevTime = 0) => {return Date.now() - prevTime}

function prom(resolveFunc, rejectFunc) {
  // Waste some time
  let x;
  for (let i = 0; i < 1000000000; i++) {
    x = i * i * i * i * i * i;
  }
  // So we can test both the resolve and reject paths
  if (rndInt(2) == 2) {
    resolveFunc('Promise - a success value');
  } else {
    rejectFunc('Promise - a failure value');
  }
}

function resolve(value) {
  console.log('resolve value:', value, timeMS(startTime));
}

function reject(value) {
  console.log('reject value:', value, timeMS(startTime));
}

const startTime = timeMS();
console.log('start - create promises', timeMS(startTime));

const prom1 = new Promise(prom);
const prom2 = new Promise(prom);

console.log('promises created', timeMS(startTime));

prom1.then(resolve, reject);
prom2.then(resolve, reject);

console.log('end', timeMS(startTime));
```

<hr>
