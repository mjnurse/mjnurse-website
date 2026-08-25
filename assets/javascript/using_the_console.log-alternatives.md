---
title: 20-10-29 Using the console.log Alternatives
section: Javascript
---

## console.log()

This is the method we all use...

## console.error()

This method is useful while testing code. It is used to log errors to the browser console. By default, the error message will be highlighted with red color.

## console.warn()

This method is also used to test code. Usually, it helps in throwing warnings to the console. By default, the warning message will be highlighted with yellow color.

## console.clear()

This method is used to clear the console.

## console.time() and console.timeEnd()

Both these methods are used in conjunction with each other. Whenever we want to know the amount of time spent by a block or a function, we can make use of the time() and timeEnd() methods. Both these functions take a string as a parameter. Make sure you use the same string for both these functions to measure the time.

```javascript
console.time('timer'); 
<code>
console.timeEnd('timer');
```

## console.table()

This method generates a table inside a console, for better readability. A table will be automatically generated for an array or an object.

```javascript
console.table({a: 1, b: 2, c: 3}); 
```

## console.count()

This method is used to count the number that the function hit by this counting method. This can be used inside a loop to check how many times a particular value has been executed.

```javascript
for(let i=0; i<3; i++){
  console.count(i);
}
```

## console.group() and console.groupEnd()

These methods group() and groupEnd() allows us to group contents in a separate block, which will be indented. Just like the time() and the timeEnd() they also accept a label, of the same value. You can expand and collapse the group.

