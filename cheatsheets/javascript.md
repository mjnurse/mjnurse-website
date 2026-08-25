---
title: Javascript Cheat Sheet
contents-list: h1,h2
---
<style>code {font-size: 1.3em !important} </style>

# Basics

## Including Javascript On A Page

```javascript
// On page script
<script type="text/javascript">  ...  </script>

// Include external JS file
<script src="filename.js"></script>
```
## Functions

## Standard Function

```javascript
function add(a, b) {return a + b;}

console.log(add(1, 2)); // 3
```

## Lamda Function / Arrow Function

```javascript
const add = function(a, b) {return a + b;}

console.log(add(1, 2)); // 3

const add = (a, b) => {return a + b;}

console.log(add(1, 2)); // 3

// One parameter

const cube = a => {return a * a * a;}

console.log(cube(2)); // 8

// No parameters

const rnd = _ => {return Math.random();}

console.log(rnd()); // Some random number
```

## Misc

```javascript
// Edit DOM element
document.getElementById("elementID").innerHTML="Hello World!";

// Output
console.log(a);          // Write to the browser console
document.write(a);       // Write to the HTML
alert(a);                // Output in an alert box
confirm("Really?");      // Yes/no dialogue, returns true/false depending on user click
prompt("Your age?","0"); // Input dialogue. Second argument is the initial value

// Comments
/* Multi line
   comment */

// Delay 1 second
setTimeout(function () { ...  }, 1000);
```

# Data Types

```javascript
var age=18;                           // Number
var name="Jane";                      // String
var name={first:"Jane", last:"Doe"};  // Object
var truth=false;                      // Boolean
var sheets=["HTML","CSS","JS"];       // Array
var a; typeof a;                      // Undefined
var a=null;                           // Value null
```

# Objects

```javascript
var student={ // Object name
  firstName: "Jane", // List of properties and values
  lastName: "Doe",
  age: 18,
  fullName: function() { // Object function
    return this.firstName+" "+this.lastName;
  }
}
student.age=19;          // Setting value
name=student.fullName(); // Call object function
```

# Variables

```javascript
var b="init";       // String
var d=1+2+"3";      // "33"
var e=[2,3,5,8];    // Array
var g=/()/;         // RegEx
var h=function(){}; // Function object
const PI=3.14;      // Constant
let z='zzz';        // Block scope local variable
let a??=10;         // Only assign is a is Nullish (null or undefined)
```

## Strict Mode

```javascript
"use strict"; // Use strict mode to write secure code
x=1;          // Throws an error because variable is not declared
```

## Values

```javascript
false, true                  // Boolean
18, 3.14, 0b10011, 0xF6, NaN // Number
"flower", 'John'             // String
undefined, null ,Infinity    // Special
```

## Operators

```javascript
x=100%48; // 4 Modulo 100/48
&  // AND         5 & 1  (0101 & 0001) (1)     1
|  // OR          5 | 1  (0101 | 0001) (101)   5
~  // NOT         ~ 5    (~0101)       (1010) 10
^  // XOR         5 ^ 1  (0101 ^ 0001) (100)   4
<< // left shift  5 << 1 (0101 << 1)   (1010) 10
>> // right shift 5 >> 1 (0101 >> 1)   (10)    2
```
```javascript
person.age === person[age] // Member
!(a == b)   // Logical not
typeof a    // Type (number, object, function...)
a == b      // Equals
a != b      // Unequal
a === b     // Strict equal (datatypes must also match)
a !== b     // Strict unequal (value or datatypes don't match)
a && b
a || b
```

# Conditions

## If Then Else

```javascript
if ((age >= 14) && (age < 19)) {
  group = 1;
} else if (age < 60) {
  group = 2;
} else {
  group = 3;
}
```

## In Line

```javascript
console.log(a>b?'a biggest':'b biggest');
```

## Switch

```javascript
switch (new Date().getDay()) {
    case 6:
        text="Saturday";
        break;
    case 0:
        text="Sunday";
        break;
    default:
        text="Whatever";
}
```

## Defined Or Not

```javascript
let val;

if (val) { Will not go here }

if (!val) { Will go here }
```

```javascript
const person_obj = 'nonsense';

console.log(person.obj.name.first); // Error!

// Check if it's defined
console.log(person_obj && person_obj.name && person_obj.name.first); // undefined.

// Cleaner option.
console.log(person_obj?.name?.first); // undefined.

```

# Loops

## For Loop

```javascript
var arr=[1, 2, 4]; var sum=0;
for (var i=0; i<a.length; i++) {
    sum += a[i];
}
html="";
for (var i of custOrder) { ... }
```

## While Loop / Do While Loop

```javascript
while (i<100) { ...  }
do { ... } while i<100);
```

## Break

```javascript
for (var i=0; i<10; i++) {
  if (i == 5) { break; }
}
```

## Continue

```javascript
for (var i=0; i<10; i++) {
  if (i == 5) { continue; } // Skips the rest of the cycle
  document.write(i + ", "); // 5 not output
}
```

# Strings

```javascript
var esc='I don\'t \n know'; // \n new line
var len=abc.length;         // String length
```
```javascript
"abc".indexOf("lmno");      // Find substring, -1 if doesn't contain
"abc".lastIndexOf("lmno");  // Last occurrence
"abc".slice(3, 6);          // Cuts out "def", negative values count from behind
"abc".replace("abc","123"); // Find and replace, takes regular expressions
"abc".toUpperCase();        // Convert to upper case
"abc".toLowerCase();        // Convert to lower case
"abc".concat(" ", str2);    // Abc + " " + str2
"abc".charAt(2);            // Character at index: "c"
"abc"[2];                   // Unsafe, abc[2]="C" doesn't work
"abc".charCodeAt(2);        // Character code at index: "c" -> 99
"abc".split(",");           // Splitting a string on commas gives an array
"abc".split("");            // Splitting on characters
128.toString(16);           // Number to hex(16), octal (8) or binary (2)
"abc".padEnd(4,'-');        // Rpad
"abc".padStart(4,'-');      // Lpad
```

# Numbers and Math

```javascript
var pi=3.141;
pi.toFixed(0);    // Returns 3
pi.toFixed(2);    // Returns 3.14 - for working with money
pi.toPrecision(2) // Returns 3.1
pi.valueOf();     // Returns number
```
```javascript
Number(true);           // Converts to number
Number(new Date())      // Number of milliseconds since 1970
parseInt("3 months");   // Returns the first number: 3
parseFloat("3.5 days"); // Returns 3.5
Number.MAX_VALUE        // Largest possible JS number
Number.MIN_VALUE        // Smallest possible JS number
Number.NEGATIVE_INFINITY
Number.POSITIVE_INFINITY
```
```javascript
var pi=Math.PI;
Math.round(4.4);       // 4 - rounded
Math.pow(2,8);         // 256 - 2 to the power of 8
Math.sqrt(49);
Math.abs(-3.14);       // 3.14 - absolute, positive value
Math.ceil(3.14);       // 4 - rounded up
Math.floor(3.99);      // 3 - rounded down
Math.sin(0);           // 0 - sine OTHERS: tan,atan,asin,acos,
Math.min(0, 3, -2, 2); // -2 - the lowest value
Math.max(0, 3, -2, 2); // 3 - the highest value
Math.log(1);           // 0 natural logarithm
Math.exp(1);           // 2.7182 pow(E,x)
Math.random();         // Random number between 0 and 1
```
```javascript
Math.floor(Math.random() * 5) + 1; // Random integer, from 1 to 5
```

# Dates / Times

```javascript
Date("2017-06-23"); // Date declaration. Also: Date("June 23 2017")
Date("2017");       // Is set to Jan 01
Date("2017-06-23T12:00:00-09:45");
Date("Jun 23 2017 07:45:00 GMT+0100 (Tokyo Time)");
Date(2012,10,23,17,34,32) // 2012-11-23T17:34:32.000Z
```
```javascript
Date.now());         // Milliseconds passed since 1970
```
Date in the format: YYYYMMDDHH24MISS

```javascript
date = new Date();
date.toISOString().replace(/[ZT:-]/g,'').replace(/\..*/g,'');
```
```javascript
var d=new Date();    // Thu Aug 22 2019 16:26:11 GMT+0100 (British Summer Time)
Number(d)            // Milliseconds passed since 1970
d.getDay();          // Getting the weekday
d.getDate();         // Day as a number (1-31)
d.getDay();          // Weekday as a number (0-6)
d.getFullYear();     // Four digit year (yyyy)
d.getHours();        // Hour (0-23)
d.getMilliseconds(); // Milliseconds (0-999)
d.getMinutes();      // Minutes (0-59)
d.getMonth();        // Month (0-11)
d.getSeconds();      // Seconds (0-59)
d.getTime();         // Milliseconds since 1970
```
```javascript
d.setDate();         // Day as a number (1-31)
d.setFullYear();     // Year (optionally month and day)
d.setHours();        // Hour (0-23)
d.setMilliseconds(); // Milliseconds (0-999)
d.setMinutes();      // Minutes (0-59)
d.setMonth();        // Month (0-11)
d.setSeconds();      // Seconds (0-59)
d.setTime();         // Milliseconds since 1970)

d.setDate(d.getDate()+7); // Adds a week to a date
```

# Arrays

```javascript
var dogs=["Bulldog", "Beagle", "Labrador"];
var dogs=new Array("Bulldog", "Beagle", "Labrador");  // Declaration
```
```javascript
alert(dogs[1]);         // Access value at index, first item being [0]
dogs[0]="Bull Terrier"; // Change the first item
```
```javascript
for (var i=0; i<dogs.length; i++) { console.log(dogs[i]); }
```
```javascript
dogs.toString();                     // Convert to string: results "Bulldog,Beagle,Labrador"
dogs.join(" * ");                    // Join: "Bulldog * Beagle * Labrador"
dogs.pop();                          // Remove last element
dogs.push("Chihuahua");              // Add new element to the end
dogs[dogs.length]="Chihuahua";       // The same as push
dogs.includes('Boxer');              // Returns True / False
dogs.includes('Boxer', 3);           // Includes from position 3 onwards
dogs.shift();                        // Remove first element
dogs.unshift("Chihuahua");           // Add new element to the beginning
delete dogs[0];                      // Change element to undefined (not recommended)
dogs.splice(2, 0, "Pug", "Boxer");   // Add elements (where, how many to remove, element list)
var animals=dogs.concat(cats,birds); // Join two arrays (dogs followed by cats and birds)
dogs.slice(1,4);                     // Elements from [1] to [4-1]
dogs.sort();                         // Sort string alphabetically
dogs.reverse();                      // Sort string in descending order
x.sort(function(a, b){return a-b});  // Numeric sort
x.sort(function(a, b){return b-a});  // Numeric descending sort
```
```javascript
x.sort(function(a, b){return 0.5-Math.random()}); // Random order sort
```

## Others

```javascript
concat, copyWithin, every, fill, filter, find, findIndex, forEach, indexOf, isArray, join,
lastIndexOf, map, pop, push, reduce, reduceRight, reverse, shift, slice, some, sort, splice,
toString, unshift, valueOf
```

# Global Functions()

```javascript
eval();                  // Executes a string as if it was script code
```
```javascript
String(23);              // Return string from number
```
```javascript
(23).toString();         // Return string from number
```
```javascript
Number("23");            // Return number from string
```
```javascript
decodeURI(enc);          // Decode URI. Result: "my page.asp"
```
```javascript
encodeURI(uri);          // Encode URI. Result: "my%page.asp"
```
```javascript
decodeURIComponent(enc); // Decode a URI component
```
```javascript
encodeURIComponent(uri); // Encode a URI component
```
```javascript
isFinite();              // Is variable a finite, legal number
```
```javascript
isNaN();                 // Is variable an illegal number
```
```javascript
parseFloat();            // Returns floating point number of string
```
```javascript
parseInt();              // Parses a string and returns an integer
```

## Regular Expressions

```javascript
var a=str.search(/CheatSheet/i);
```

## Modifiers

```javascript
i  // Perform case-insensitive matching
g  // Perform a global match
m  // Perform multiline matching
```

## Patterns

```javascript
\         // Escape character
\d        // Find a digit
\s        // Find a whitespace character
\b        // Find match at beginning or end of a word
n+        // Contains at least one n
n*        // Contains zero or more occurrences of n
n?        // Contains zero or one occurrences of n
^         // Start of string
$         // End of string
\uxxxx    // Find the Unicode character
.         // Any single character
(a bar b) // A or b
(...)     // Group section
[abc]     // In range (a, b or c)
[0-9]     // Any of the digits between the brackets
[^abc]    // Not in range
\s        // White space
a?        // Zero or one of a
a*        // Zero or more of a
a*        // ?Zero or more, ungreedy
a+        // One or more of a
a+?       // One or more, ungreedy
a{2}      // Exactly 2 of a
a{2,}     // 2 or more of a
a{,5}     // Up to 5 of a
a{2,5}    // 2 to 5 of a
a{2,5}?   // 2 to 5 of a, ungreedy
[:punct:] // Any punctuation symbol
[:space:] // Any space character
[:blank:] // Space or tab
```

## Errors

```javascript
try {                    // Block of code to try
    undefinedFunction();
}
catch(err) {             // Block to handle errors
    console.log(err.message);
}
```

## Throw Error

```javascript
throw "My error message"; // Throw a text
```

## Input Validation

```javascript
var x=document.getElementById("mynum").value; // Get input value
try {
    if(x == "")  throw "empty";         // Error cases
    if(isNaN(x)) throw "not a number";
    x=Number(x);
    if(x > 10)   throw "too high";
}
catch(err) {                            // If there's an error
    document.write("Input is " + err);  // Output error
    console.error(err);                 // Write the error in console
}
finally {
    document.write("</br />Done");      // Executed regardless of the try / catch result
}
```

## Error Name Values

```javascript
RangeError     // A number is "out of range"
ReferenceError // An illegal reference has occurred
SyntaxError    // A syntax error has occurred
TypeError      // A type error has occurred
URIError       // An encodeURI() error has occurred
```

## JSON

## Create JSON object

```javascript
var str='{"names":[{"first":"Hakuna","last":"Matata"},{"first":"Air","last":"Jordan"}]}';

obj = JSON.parse(str);               // Parse
document.write(obj.names[1].first);  // Access
```

## Iterate / Loop Through JSON Elements

```javascript
let json = { "name": "Martin", "age": 21 };
for (let j in json) {
  console.log(j, json[j]);  // Yields name Martin etc
}
```

## Send

```javascript
var myObj={"name":"Jane", "age":18, "city":"Chicago"}; // Create object
var myJSON=JSON.stringify(myObj);                      // Stringify
window.location="demo.php?x=" + myJSON;                // Send to php
```

## Storing And Retrieving

```javascript
myJSON=JSON.stringify(myObj);            // Storing data
localStorage.setItem("testJSON", myJSON);
text=localStorage.getItem("testJSON");   // Retrieving data
obj=JSON.parse(text);
document.write(obj.name);
```

# Promises

```javascript
function sum (a, b) {
   return Promise(function (resolve, reject) {
      setTimeout(function () {  // Send the response after 1 second
         if (typeof a !== "number" || typeof b !== "number") {  // Testing input types
            return reject(new TypeError("Inputs must be numbers"));
         }
         resolve(a + b);
      }, 1000);
   });
}

var myPromise=sum(10, 5);

myPromsise.then(function (result) {
   document.write(" 10 + 5: ", result);
   return sum(null, "foo");  // Invalid data and return another promise
}).then(function () {        // Won't be called because of the error
}).catch(function (err) {    // The catch handler is called instead, after another second
   console.error(err);       // => Please provide two numbers to sum.
});
```

## States

```javascript
pending, fulfilled, rejected
```

## Properties

```javascript
Promise.length, Promise.prototype
```

## Methods

```javascript
Promise.all(iterable), Promise.race(iterable), Promise.reject(reason), Promise.resolve(value)
```

## Events

```javascript
<button onclick="myFunction();"> Click here </button>
```

## Mouse

```javascript
onclick, oncontextmenu, ondblclick, onmousedown, onmouseenter, onmouseleave, onmousemove,
onmouseover, onmouseout, onmouseup
```

## Keyboard

```javascript
onkeydown, onkeypress, onkeyup
```

## Frame

```javascript
onabort, onbeforeunload, onerror, onhashchange, onload, onpageshow, onpagehide, onresize,
onscroll, onunload
```

## Form

```javascript
onblur, onchange, onfocus, onfocusin, onfocusout, oninput, oninvalid, onreset, onsearch,
onselect, onsubmit
```

## Drag

```javascript
ondrag, ondragend, ondragenter, ondragleave, ondragover, ondragstart, ondrop
```

## Clipboard

```javascript
oncopy, oncut, onpaste
```

## Media

```javascript
onabort, oncanplay, oncanplaythrough, ondurationchange, onended, onerror, onloadeddata,
onloadedmetadata, onloadstart, onpause, onplay, onplaying, onprogress, onratechange,
onseeked, onseeking, onstalled, onsuspend, ontimeupdate, onvolumechange, onwaiting
```

## Animation

```javascript
animationend, animationiteration, animationstart
```

## Miscellaneous

```javascript
transitionend, onmessage, onmousewheel, ononline, onoffline, onpopstate, onshow,
onstorage, ontoggle, onwheel, ontouchcancel, ontouchend, ontouchmove, ontouchstart
```

# Save Text To Local File

```javascript
function saveText(text, fileName) {
    var a=document.createElement("a");
    document.body.appendChild(a);
    a.style="display: none";

    var json=JSON.stringify(text),
        blob=new Blob([text], {type: "text/plain;charset=utf-8"}),
        url=window.URL.createObjectURL(blob);
    a.href=url;
    a.download=fileName;
    a.click();
    window.URL.revokeObjectURL(url);
}
```

# Command Line Arguments / process

```
let args = process.argv;

// 0 - command.  eg. node
// 1 - file. eg my_app
// 1 .. n - The arguments

process.exit(1);
```

# JSDoc

```javascript
/**
 * Adds two numbers together.
 * @param {int} num1 The first number.
 * @param {int} num2 The second number.
 * @returns {int} The sum of the two numbers.
 */
function sum(num1, num2) {
    return num1 + num2;
}
```
<hr>
