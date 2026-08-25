---
title: Tail Recursion
---

A tail recursive function can reuse the stack frame - ie reuse the same area of memory to hold its current state for each recursive call.  A non tail recursive function needs to use additional memory for each recursive call.  A non tail recursive function applies logic to the result returned from each recursive iteration.  This means that the state of every iteration need to be maintained.

A non tail recursive function should be avoided where the number of recursive iterations is large.

## Not Tail Recursive

```scala
def f(...): Int = if (...) x else x + f(...)
``` 
This requires additional stack space each iteration.

## Tail Recursive

```scala
def f(...): Int = if (...) x else f(x)
``` 
This is called tail recursive, the stack frame can be reused.

## Example

```scala
// Not tail recursive.
//
// Note that the function multiplies the value return by the child iteration.

def fac(v: Int): Int = {
   if (v == 1) v else v * f(v - 1)
}

// Tail recursive
//
// Note that Int value returned from each iteration is not used by the parent iteration.

def fac2(v: Int): Int = { 
   def loop(a: Int, b: Int): Int = {
      if (b == 0) a else loop(a * b, b - 1)
      loop(1, v) 
   }
}
```

<hr>
