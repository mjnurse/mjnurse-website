---
title: 20-12-21 - Javascript ASYNC AWAIT By Example
section: Javascript
---

At first sight the Javascript ASYNC / AWAIT commands can look quite confusing when in use.  But, once I wrote a worked example, it was actually quite clear.

In the example below, the function `fetchData` is declared ASYNC so that it can wrap an AWAIT on a call to `axios.get`.  I use `axios.get` to fetch a web page to introduce an unpredictable delay.  This isn't the ASYNC / AWAIT example as such.

In the main body of the example, I invoke the function `fetchData` 3 times and these run in parallel.  Due to the unpredictable nature of the web content fetch inside `fetchData` these are not expected to finish in the order they were invoked.

Having said that, I AWAIT on `fetchData` in the order I invoke them however ,the order doesn't really matter.  If, say, invocation 2 finishes before invocation 1 then as soon a invocation 1 finishes and we then move to AWAIT invocation 2, invocation 2 will return immediately.

To allow the main body of the code to AWAIT on `fetchData` I use an anonymous function declared as ASYNC to wrap the AWAIT calls.

```javascript
const axios = require('axios');

const clog = (...args) => {console.log(args);}
const timeMS = (prevTime = 0) => {return Date.now() - prevTime;}

const STARTTIME = timeMS();

// Function defined ASYNC so that functions inside can be invoked with an AWAIT.
const fetchData = async (label) => {
  clog(timeMS(STARTTIME), 'fetchData', label, 'begin');
  const result = await axios.get('https://www.bbc.co.uk/news');
  clog(timeMS(STARTTIME), 'fetchData', label, 'end');
  return result.data;
};

clog(timeMS(STARTTIME), 'main', 'begin');
const res1=fetchData(1);
const res2=fetchData(2);
const res3=fetchData(3);
clog(timeMS(STARTTIME), 'main', 'fetchData 1,2,3 invoked');

// Declare anonymous ASYNC function to wrap AWAIT function calls.
(async () => {
  // I don't expect these to finish in the order I invoked them but it doesn't
  // actually matter.  If, say, res2 finishes before res1 then as soon a res1
  // finishes and we then move to AWAIT res2, res2 will return immediately.
  await res1;
  clog(timeMS(STARTTIME), 'main', 'fetchData 1 finished');
  await res2;
  clog(timeMS(STARTTIME), 'main', 'fetchData 2 finished');
  await res3;
  clog(timeMS(STARTTIME), 'main', 'fetchData 3 finished');
})(); // The () after the definition executes the anonymous function.

clog(timeMS(STARTTIME), 'main', 'end (outside await)');
```

The output when running the above Javascript is as follows.  Note field 1 in the output is ms since since execution of the main body began.

```bash
$> node await-example.js

[ 0, 'main', 'begin' ]

[ 3, 'fetchData', 1, 'begin' ]  # A message from within fetchData function which
[ 4, 'fetchData', 2, 'begin' ]  # shows the function is running.  3 parallel
[ 5, 'fetchData', 3, 'begin' ]  # instances running.

[ 6, 'main', 'fetchData 1,2,3 invoked' ] # The main body has finished invoking fetchData

[ 7, 'main', 'end (outside await)' ] # The main body, outside the AWAIT on fetchData
                                     # finishes running

[ 326, 'fetchData', 2, 'end' ]  # A message from inside fetchData function which 
[ 363, 'fetchData', 3, 'end' ]  # shows each of the 3 instances finish running.
[ 606, 'fetchData', 1, 'end' ]  # Note they finsih in a different order than which
                                # they were invoked.

[ 607, 'main', 'fetchData 1 finished' ]  # The AWAIT on fetchData statements finish.
[ 608, 'main', 'fetchData 2 finished' ]  # Note that as invocation 2 and 3 complete
[ 609, 'main', 'fetchData 3 finished' ]  # before invocation 1, as soon as 1 finishes
                                         # the other 2 have no waiting left to do so
                                         # finish immediatly.
```

<hr>
