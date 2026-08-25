---
title: Anonymous Functions - Functions as a Parameter
---
## Anonymous Functions
```scala
def sum(f: Int => Int, a: Int, b: Int): Int = if (a == b) f(a) else f(a) + sum(f, a+1, b)
```

Currying is defining a function piecewise one parameter section after another.
```scala
def sum(f: Int => Int)(a: Int, b: Int): Int = if (a > b) 0 else f(a) + sum(f)(a+1, b)
```

## Passing a function into a function
```scala
scala> def head(word: String, length: Int): String = {word.substring(0, length)}
head: (word: String, length: Int)String

scala> // Define a function which returns a function which inturn takes a trim function and applies the trim
scala> // twice separating the values with a separator string.

scala> def repeater(separator: String) =
     | (word: String, length: Int, trimFunc:(String, Int) => String) =>
     | {trimFunc(word, length)+separator+trimFunc(word, length)}
repeater: (separator: String)(String, Int, (String, Int) => String) => String

scala> // Run repeater which returns a function.

scala> val repeat = repeater("--")
repeat: (String, Int, (String, Int) => String) => String = $$Lambda$3382/2122078060@17d38c41

scala> // Run the function repeat passing in the head function as the trimFunc.

scala> val str = repeat("Martin", 4, head)
str: String = Mart--Mart
```

## Returning a function from a function
```scala
// Create a function which is passed a separator string and then returns a function which can be called
// with a word string and which returns the word twice separated by the separator string.

scala> def repeater(separator: String) = (word: String) => {word + separator + word}
repeater: (separator: String)String => String

scala> val repeat = repeater(",")
repeat: String => String = $$Lambda$3302/820261397@33db1faa

scala> repeat("hi")
res1: String = hi,hi
```
<hr>
