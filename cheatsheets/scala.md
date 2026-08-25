---
title: Scala Cheatsheet
contents-list: h1,h2
---
<style>code {font-size: 1.2em !important} </style>

# Utilities

## REPL - Ammonite

```
> amm
```

# Hello World

## Scala Script

File: `helloWorld.sc`

```scala
def helloWorld(n: Int = 1) = {
  "hello world! " * n
}
```

To run the script in Ammonite:

```scala
> amm --predef helloWorld.sc
Loading...
Welcome to the Ammonite Repl 2.2.0 (Scala 2.13.3 Java 1.8.0_292)

@ helloWorld(3)
res1: String = "hello world! hello world! hello world! "

@ Bye!
```

## Scala App

```scala
object Main extends App {
   println("hello world!")
}
```
# Data Types

## Hierarchy

```scala
Any -> AnyVal -> Double, Float, Long, Int, Short, Byte, Char, Unit, Boolean
    -> AnyRef -> List, Iterable, Seq, Strings, Other Scala / Java Classes
```

## Type Casting

```scala
Byte -> Short -> Int -> Long -> Float -> Double
                     <- Char  (Char -> Int gives ASCII code)
```

# Values And Variables

```scala
val a, b: Int = 2     // Eval when set. Constant. Both set to 2
lazy val c: Int = 2   // Eval FIRST time used
def x: String = "22"  // Eval EVERY time used. Constant
var y: Char = '2'     // Eval when set, can be updated, avoid
var z: Any = 12       // Can store any value

val i: Int = 0x0FF    // i = 255.  Assigning a Hex literal
val l: Long = 0x0FFL  // l = 255.  'L' signifies a Long literal
val f: Float = 1.5e2F // f = 150.  'F' signifies a Float literal
val d: Double = 1.5e3 // d = 1500
val b: Boolean = true

val s = "hi"
println(s.getClass())         // class java.lang.String
println(s.isInstanceOf[Int])  // false
```

## String / Char Literals

Char | Description | | Char | Description
--- | --- | --- | --- | ---
`\n` | linefeed | | `\b` | backspace
`\t` | tab | | `\f` | form feed
`\r` | carriage return | | `\"` | double quote
`\’` | single quote | | `\\` | backslash

# Operators

```scala
1.+(3)  // 4.  1 + 3
10 / 7  // Yields: Int = 1 
10F / 7 // Yields: Float 1.42..

val t: Boolean = true; val f: Boolean = false
println(t || f, t && f, !f)  // Yields: (true, false, true)

a += 1; b -= 1; c*= 2; d /= 2; val e = 5; e %= 3 // Yields: 2
```

**Note**: Scala uses short-circuit (lazy) evaluation so with  `(false || val)`, `val` will not be evaluated.

# Strings

`"""` - triple double quotes - multiline string.

## 3 String Types

### s"String"

```scala
val v = "Yo"; println(v + " Martin")     // Yields: "Yo Martin"
val v = "Yo"; println(s"$v ${v} Martin") // Yields: "Yo Yo Martin"
println(s"${3+4}")                       // Yields: "7"
```

### f"String"

`$[var]%[flag][Width].[Precision][Type]`

**Flag**: `-`: Left align, `+`: show +, `0`: leading 0's, `,`: comma numbers

**Type**: `s`: strings, `d`: decimal integers, `f`: floating-point numbers, `t`: date/time values

```scala
val pi = 3.14159F
println(f"$pi%6.2f")   // Yields: "  3.14"
println(f"$pi%-6.2f")  // Yields: "3.14  "
println(f"$pi%+6.2f")  // Yields: "+3.14 "
println(f"$pi%06.2f")  // Yields: "003.14"
val d = 100000000
println(f"$d%,d")      // Yields: "100,000,000"
```

### raw"String"

```scala
println(raw"one\ntwo") // Yields: "one\ntwo"
```

## String Functions

```scala
// compareTo
String1.compareTo(string2) -> Int : greater/less/equal
"A".compareTo("A") // Yields: 0
"A".compareTo("B") // Yields: -1
"C".compareTo("A") // Yields: 2

// equals / equalsIgnoreCase
String1.equals(String2) -> Boolean
"martin".equals("fred") // Yields: false

// findAllIn
Regex.findAllIn(String) -> Iterator
"t.* ".r.findAllIn("there's the dog") // Yields: scala.util.matching.Regex.MatchIterator
"t.* ".r.findAllIn("there's the dog").foreach(println) // Yields: there's the

// findFirstIn
Regex.findFirstIn(String) -> String
"th. ".r.findFirstIn("there's the dog") // Yields: Option[String] = Some("the ")

// intersect
String1.intersect(String2) -> String
"Martin".intersect("tank") // Yields: "atn"

// matches
String1.matches(String2) -> Boolean : String2 is Regex Expression
"martin".matches("m.{4}n") // Yields: true 

// split
String.split(Char) -> Array(String, ..)
"a b c".split(' ') // Yields: Array("a", "b", "c")

// toLowerCase
"HI".toLowerCase // As toLowerCase has no parameters the () are omitted.

// toString
val v = 123; v.toString // As toString has no parameters the () are omitted.

// toUpperCase
"hello".toUpperCase // As toUpperCase has no parameters the () are omitted.
```

# Regexp

```scala
"[a-z].*".r // Yields: scala.util.matching.Regex = [a-z].*

val numPattern = "[0-9]+".r
for (n <- numPattern.findAllIn("a11b12c13")) println(n) // Yields: 11 12 13
numPattern.findAllIn("a 2 3").toArray                   // Yields: Array(2,3)
numPattern.replaceAllIn("a 2 3", "x").toArray           // Yields: Array(a,x,x)

val spacePattern = """\s+""".r                                   // """ - Instead of "\\s+"
for (s <- spacePattern.findAllIn("abc 12 def")) println("found") // Yields: found found

// Regexp Groups
val numItemPttn = "([0-9]+) ([a-z]+)".r()
val numItemPttn(num, item) = "99 bottles" // Yields: num=99, item=bottles
for (numItemPttn(num, item) <- numItemPttn.findAllIn("5 cats, 3 dogs")) {
   println(item, num)
} // Yields: (cats,5)(dogs,3)
```
# Collections

## Seq

### Hierarchy

```scala
Seq -> IndexedSeq -> Vector, Array, ArrayBuffer, Range 
    -> LinearSeq  -> List, Stream (now called a LazyList)
```

**LinearSeq** collections have efficient head and tail operations. 
**IndexedSeq** collections have efficient apply and length operations.

### Examples

```scala
@ val s = Seq(1, "two", '3', 1) // s: Seq[Any] = List(1, "two", '3', 1)
@ s.apply(1) // res1: Any = "two"
@ s(2)       // res2: Any = '3'
@ s.foreach(println) // Prints all elements
@ s.filter(_.isInstanceOf[Int]) //res3: Seq[Any] = List(1, 1)
```

### Arrays (an IndexedSeq) Fixed Length

```scala

// filter(), map(), sorted, reverse, length
@ val a = Array(5, 2, 3, 4, 1)  // a: Array[Int] = Array(5, 2, 3, 4, 1)
@ val e = a.filter(_ % 2 == 0)  // e: Array[Int] = Array(2, 4)
@ val d = a.map(_ * 2)          // d: Array[Int] = Array(10, 4, 6, 8, 2)
@ val r = d.sorted.reverse      // r: Array[Int] = Array(10, 8, 6, 4, 2)
@ val l = d.length              // l: Int = 5

// mkString(separator: String) or mkString(start: String, sep: String, end: String)
@ val s = a.mkString("")            // s: String = "52341"
@ val s = a.mkString("[", ",", "]") // s: String = "[5,2,3,4,1]"

// range(start, end, [interval])
@ val a = Array.range(0, 10, 3) // a: Array[Int] = Array(0, 3, 6, 9)

// fill(number of entries)(value)
@ val a = Array.fill(2)("a")    // a: Array[String] = Array("a", "a")

// Create a fixed size 'empty' array
@ val a = new Array[Int](4)     // a: Array[Int] = Array(0, 0, 0, 0)

// Update array element
@ a(2) = 2; a                   // a: Array[Int] = Array(0, 0, 2, 0)

// toArray
@ val a = "Hello".toArray       // a: Array[Char] = Array('H', 'e', 'l', 'l', 'o') 

// Multi dimensional Array - An Array or Array's
@ val a = Array.ofDim[Int](2, 3) // a: Array[Array[Int]] = Array(Array(0, 0, 0), Array(0, 0, 0))

// Traverse Array.
for (i <- a) println(i)
```

### List 

**Lists** are Immutable.  **ListBuffer** is the Mutable counterpart.

Lists are linear.  This means is that if you want to access a central element in a List, the compiler has to start from the beginning and linearly progress through the List until it finds the element you are trying to access.

```scala
// ::, Nil - element::list is know as cons, Nil is a list terminator
@ val l = 1::(2::(3::Nil)) // l: List[Int] = List(1, 2, 3)
@ val l = 1::2::3::Nil     // l: List[Int] = List(1, 2, 3) - can avoid brackets

// Append: use :+, Prepend: use ::, Concat two lists: use :::
@ val l2 = l:+0    // l2: List[Int] = List(1, 2, 3, 0)
@ val l3 = 9::l    // l3: List[Int] = List(9, 1, 2, 3)
@ val l4 = l2:::l3 // l4: List[Int] = List(1, 2, 3, 0, 9, 1, 2, 3)

// head, tail, value at position 
@ val h = l4.head // h: Int = 1
@ val t = l4.tail // t: List[Int] = List(2, 3, 0, 9, 1, 2, 3)
@ val i = l4(1)   // i: Int = 2
```

### Vector

Vectors are indexed, when you want to access a central element in a Vector, the compiler can directly go to that index and access the element in constant time.

```scala
@ val v = Vector.empty       // v: Vector[Nothing] = Vector()
@ val v = Vector(1, 2, 3, 0) // v: Vector[Int] = Vector(1, 2, 3, 0)

// Prepend / Append: use +:,  Concatenation: use ++
@ val v2 = 8+:v   // v2: Vector[Int] = Vector(8, 1, 2, 3, 0)
@ val v2 = v::v2  // v3: Vector[Int] = Vector(1, 2, 3, 0, 8, 1, 2, 3, 0)
```

### Range 

```scala
@ val r = 1 to 6       // r: Range.Inclusive = Range(1, 2, 3, 4, 5, 6)
@ val r = 1 to 6 by 3  // r: Range = Range(1, 4)
@ val r = 1 until 6    // r: Range = Range(1, 2, 3, 4, 5)
```

### Variable Length Arrays - Array Buffers

```scala
import scala.collection.mutable.ArrayBuffer
@ val a = ArrayBuffer[Any]() // a: ArrayBuffer[Any] = ArrayBuffer()

// +=, -=, remove(position, [num elements]), insert(after position, value), trimEnd(num elements)
@ a += ('a', 1, "hi", 'a')   // res1: ArrayBuffer[Any] = ArrayBuffer('a', 1, "hi", 'a')
@ a -= 'a'                   // res2: ArrayBuffer[Any] = ArrayBuffer(1, "hi", 'a')
@ a.remove(1)                // res3: Any = "hi"
@ a                          // res4: ArrayBuffer[Any] = ArrayBuffer(1, 'a')
@ a.insert(1, "hi"); a       // res5: ArrayBuffer[Any] = ArrayBuffer(1, "hi", 'a')
@ a.trimEnd(2); a            // res6: ArrayBuffer[Any] = ArrayBuffer(1)

// toArray, toBuffer
@ a.toArray  // Creates a fixed size Array from Array Buffer.
@ a.toBuffer // Creates an Array Buffer from a fixed size Array.
```

## Set

Duplicates values removed.

```scala
@ val s = Set(1, "two", '3', 1) // s: Set[Any] = Set(1, "two", '3') - no dupes
@ s(2)                          // res1: Boolean = false - Int: 2 not in set
@ s.apply("two")                // res2: Boolean = true - String: "two" in set
```

## Map (hash table)

```scala
@ val m = Map(("a",25), ('b',50), (3,'a')) // m: Map[Any, AnyVal] = Map("a"->25, 'b'->50, 3->'a')
@ m("a")     // res1: AnyVal = 25 - Same as m.get("a")
@ m.apply(3) // res2: AnyVal = 'a'
@ m(1)       // java.util.NoSuchElementException: key not found: 1
@ val v = m.getOrElse(1, "none") // v: Any = "none"

// Mutable Map
@ val m = collection.mutable.Map("MN" -> 21, "FB" -> 44)
@ m += ("XX" -> 2, "YY" -> 34) // res1: collection.mutable.Map[String, Int] = 
                               // HashMap("XX" -> 2, "YY" -> 34, "MN" -> 21, "FB" -> 44)
@ m -= "XX"                    // res2: collection.mutable.Map[String, Int] = 
                               // HashMap("YY" -> 34, "MN" -> 21, "FB" -> 44)

// Sorted Map - Stores sorted on key
val agesOrd = collection.immutable.SortedMap("MN" -> 18, "FB" -> 26) 

// 'Zipping' Array to create a Map
@ val names3 = Array("MN", "FB"); val ages3 = Array(21, 34)
@ val people = names3.zip(ages3) // Yields: Array((MN,21), (FB,34)).
```

## Tuple

```scala
@ val person = ("MN", 21, 1.84)  // person: (String, Int, Double) = ("MN", 21, 1.84)
@ println("Age:" + person._2)    // Age: 21 - In a Tuple, position starts with 1.
@ val (name,age,height) = person // name: String = "MN" age: Int = 21 height: Double = 1.84
```

# Conditional Control

```scala
// if
@ val (i, j) = (1, 2)
@ if (i == j) {
     println("match")
  } else {
     println("no match")
  }

// match
@ val i = 1
@ i match { case 1 => "one"; case _ => "other" }  // Yields: "one"

// match - Seq
@ val s = Array(1, 2, 3)
@ s match { 
      case Array(1,_,_) => "match"
      case _ => "other"
    } // Yields: "match"

// match - Tuple
@ val t: Any = (1, "hi", true)
@ t match { case (1, _, true) => "match"; case _ => "other" } // Yields "match"

// match - Types
@ val v: Any = "hi"
@ v match {
      case x: String => "a string"
      case x: Int => "an int"
      case x: Boolean => "a boolean"
    } // Yields: "a string"
```

# Conditional Expressions

```scala
val c = if (a >= 2) 2 else -2 // if(a >= 1) x = 1 else x = -1.  Needs x to be a var.
val d = if (a >= 2) 2 else () // () is a Class called Unit - it represents "no value".
```

# Block Expressions

```scala
val e = {val f = 2; val g = 2; f + g} // e == 4, takes last value of block.
val h = {val i = 2} // h == (), the Unit value. i == 2.
```

# Loops

Loops are not expressions - they have a return type of unit which is a *void* value.

```scala
// while loop
var i = 3; while (i > 0) { println(i); i -= 1 }

// do-while loop
do { println("here") } while (0 == 1) // Yields: here (always executes ay least once)

// for loop: for (variable <- generator expression) { block of code }
for (i <- 1 to 3) println(i)                                // Yields: 1 2 3
for (i <- 3 to 1 bi -1) println(i)                          // Yields: 3 2 1
for (i <- 0 until "dog".length) println(i + ":" + "dog"(i)) // Yields: 0:d 1:o 2:g
for (ch <- "Hello") println(ch)                             // Yields: H e l l o

// Complex for loops with other vars
for (i <- 0 to 1; j <- 10 to 12; if (j != 11)) println(i,j)   // Yields: (0,10)(0,12)(1,10)(1,12)
for (i <- 0 to 1; k = i + 10; j <- k to (k + 1)) println(i,j) // Yields: (0,10)(0,11)(1,11)(1,12)

// Yield creates a return expression - called a comprehension.
@ for (i <- "Hi") yield BigInt(i) // res1: IndexedSeq[BigInt] = ArraySeq(72, 105)

// Note: can use {} in place of the outer () in a for loop. {} can span multiple lines.
```

# Exception Handling

```scala
try { 
  val quotient = 10/0
  println(quotient)
}
catch {
  case ex: ArithmeticException => println("Dividing by zero is not allowed")
  case ex: ...
}
```

# Functions

`def functionName(parameters): returnType = {function body}`

## Call by Value / Call by Name

```scala
// 
@ def endless: Int = endless // an endless recursive function

// Call by Name: all => to parameter definition
// In this case a parameter y isn't used its not evaluated.
// Function endless name is passed and as it not used it not run.
@ def accessFirst(x: => Int, y: => Int) = x // function only use parameter x
@ accessFirst(1, endless) // res1: Int = 1

// Call by Value
// In this case, endless is evaluated (run) to produce a value to pass in.
// accessFirst never returns.
@ def accessFirst(x: Int, y: Int) = x
@ accessFirst(1, endless) // Never returns - actually is never run.
```

## Recursive Functions

```scala
def sumList(numberList: List[Int]): Int = numberList match { 
  case Nil => 0
  case x :: tail => x + sum(tail)
} // sumList(List(1,2,3,4,5)) - Yields 15
```

## Tail Recursive Function

**These reuse the functions stack frame**.  If the last action in the function is the recursive call, then the function is typically tail recursive.  This is only true if the final call has no other manipulation - eg. `x + fn(x)` is not tail recursive, but `fn(x - 1)` is.

```scala
// Greatest Common Factor
def gcd(x: Int, y: Int): Int = {
  if(y==0) x
  else gcd(y, x%y)
}
@ gcd(18,24) // res1: Int = 6
```

## Higher Order Functions

Functions that take functions as parameters are called higher order functions - For Example:

```scala
def add(a: Int, b: Int): Int = a + b

// A higher order function
def functionPrinter(f: (Int, Int) => Int, x: Int, y: Int) = {
   println(f(x, y))
}
@ functionPrinter(add, 1, 2) // Prints: 3
```

## Anonymous Functions

```scala
def functionPrinter(f: (Int, Int) => Int, x: Int, y: Int) = {
   println(f(x, y))
}
// (a, b) => a * b is an anonymous function
@ functionPrinter((a, b) => a * b, 1, 2) // Prints: 2

```

## Functions Returning Functions

The following function takes a function as a parameter and returns a function which runs the parameter function on all values between two parameters, summing the results.

```scala
def sum(f: Int => Int): (Int,Int) => Int ={
  def sumHelper(a: Int, b: Int): Int =
    if(a>b) 0
    else f(a) + sumHelper(a+1, b)
  sumHelper
}

def sumOfInts = sum(x => x)
println(sumOfInts(1,5)) // Prints: 15

def sumOfCubes = sum(x => x*x*x)
println(sumOfCubes(1,2)) // Prints: 8 (1*1*1 + 2*2*2) 
```

## Currying

```scala
def sumRange(f: Int => Int)(from: Int, too: Int): Int = {
   if (from > too) 0
   else f(from) + sum(f)(from + 1, too)
}
def cube(x: Int): Int = x * x * x
val sumCubes1to3 = sumRange(cube)(1, 3) // sumCubes1to3: Int = 36
val sumSquares1to3 = sumRange(x => x * x)(1, 3) // sumSquares1to3: Int = 14
```

def first(x: Int) = (y: Int) => x+y

def second = first(3)

val result = second(2)

print(result)


```scala
def func( p1: Int, p2: Int = 0, p3: Int = 0) = (p1, p2, p3) // p2 defaults to 0.  Yields: a Tuple.
val res = func( 2, p3 = 3 ) // Yields: 2,0,3.
def fac(v: Int) = {var rv = 1; for( i <- 1 to v ) rv = rv * i; rv} // Returns Int.

// Recursive functions need a return type specifying.
def fac2(n: Int): Int = if (n <= 0) 1 else n * fac2(n - 1)

// Variable argument sets.
def sum(args: Int*) = { var tot = 0; for (i <- args) tot += i; tot }
sum(1,2,3)
sum(1 to 5: _*) // _* syntax is specific to parameters.

// Procedures - no "=" between (param) and {code...}
def proc( name: String ) {"Hello " + name} // Returns Unit ie. ().  Can declare as proc(...): Unit = {...}.
```

# Mathematical Functions

```scala
import math._  // same as import scala.math._ (scala can be omitted).
sqrt(2) // Obv. many many more functions.
```

## Classes (Note Classes can be nested)

```scala
class Per { var age = 0 }
val per = new Per() // Brackets not mandatory

// Getter/Setter methods are created for all fields (inc private but they are also private).
// With a val field only a getter is created. This allows:
per.age = 21; println(per.age) // Also per.age=_(21)

// Can replace/create getters and setters:
class Per2 {
   private var privAge = 0;
   def age = privAge // getter
   def age_=(newVal: Int) { if (newVal > privAge) privAge = newVa l} // Can't get younger
}
val per2 = new Per2
per2.age = 12; per2.age = 5; println(per2.age) // Prints 12

// Bean Properties (to match JavaBeans specification).  This will generate a getName():Unit
// method and a setName(newValue: String): Unit method.
// import scala.reflect.BeanProperty
// class Per3 { @BeanProperty var name: String = _ }

// Auxiliary Constructors (all aux' constructors must call previously defined constructor).
// They are all called this.
class Per4 {
   private var name = ""
   private var age = 0;
   def this(name: String) { this(); this.name = name }
   def this(name: String, age: Int) { this(name); this.age = age }
}
val p4a = new Per4; val p4b = new Per4("MN"); val p4c = new Per4("MN",21)

// Primary Constructor.  Is the code straight after definition.  With or without parameters.
class Per5 (val name: String = "no name") {
   private val whoMsg = "This is " + name // This is the constructor code.
   def who = whoMsg
}
val per5 = new Per5("MN"); println(per5.who) // Prints This is MN.
```

## Objects

```scala
// Singletons - Constructor run on first use.
object Accs { private var accNum = 0; def newAccNum() = { accNum += 1; accNum } }
println(Accs.newAccNum, Accs.newAccNum)

// Companion Objects.  Must be in same source file.  (In REPL use :paste mode to define).
class Accs2 {
   val accNum = Accs2.newAccNum() // As Class/Object share name, class can see object.
   private var bal = 0.0;
   def payIn(amt: Double) {bal += amt}
}
object Accs2 { private var accNum = 0; def newAccNum() = { accNum += 1; accNum } }

// Objects extending a Class or a Trait - TBC...

// The apply method.  eg. Array has an apply method so we can create an Array without
// specifying new.  Useful for declarations such as Array(Array(2,3), Array(3,4))
// Note: Array(100) calls apply and create an array of one Int value 100. new Array(100)
// creates an Array os 100 Int values of 0.

// Application Objects.
object HelloWorld { def main(args: Array[String]) {println("Hello World!")}}
object HelloWorld2 extends App {println("Hello world!")}

// Enumerations
object TrafficLightColor extends Enumeration {
   type TrafficLightColor = Value
   val Red, Yellow, Green = Value
}
import TrafficLightColor._
val x: TrafficLightColor = Red;
println(TrafficLightColor.values) // Yields: a set of all the values.
```

## Packages

```scala
// Every package can have a single package object.  it shares the same name as the package
// and is declared at the same level (within the same parent package) as the package.

// Top of package notation - no braces required.  Chained definitions.
// -------------------------------
// package com.horstmann.impatient
// package people
// class Person ...
// -------------------------------

//package animal {
//   package object people {
//      val defaultName = "John Q. Public"
//   }
//   package people {
//      class Person {
//         var name = defaultName // A constant from the package
//      }
//   }
//}

// Can import all members of a package using import com.abc._
import java.awt.Color._
val colour1 = RED //Color.RED

// Once imported can access package members using shorter name.  Imports can be included
// anywhere in the code.  They follow usual scope rules which is useful when using them to
// deliver shorter names.
def dummy {
   import java.awt._
   val af = event.ActionEvent.ACTION_FIRST // java.awt.event.ActionEvent.ACTION_FIRST
}

import java.awt.{Color, Font} // Import only a few members
import java.awt.{Color => AwtColor} // Rename members
```

## Inheritance

```scala
// Notes: Only a primary subclass constructor can call super class constructor.

// Extending a Class
class Person3 {
   protected var sex = "unknown"
   var name = "unknown"
   var age = 0
   def getName: String = { "Name:" + name }
   def getAge: String = { "age:" + age }
}
class Worker extends Person3 {
   var salary = 0.0
   sex = "hidden" // sex is visible within subclass even though protected.
   override val getAge: String = "hidden" // override def with a String val
   override def getName: String = {
      "Worker:" + super.getName // Call the superclass method.
   }
}
val per = new Person3;
val wkr = new Worker; wkr.name="Fred"; wkr.getName  // Yields: Worker:Name:Fred
// Note wkr.age and per.age not visible.
(wkr.isInstanceOf[Person3], wkr.isInstanceOf[Worker])  // True, True
(wkr.getClass == classOf[Person3], wkr.getClass == classOf[Worker]) // False, True

// per2 has type Person{def greeting: String}.  This could be used a a parameter:
// def meet( p: Person{def greeting: String}) { println(p.name + p.greeting) }
val per2 = new Person3 {
   def greeting = {"Hello!" + name}
}

// Abstract Class cannot be instantiated - forms the basis of other classes.
abstract class Person4 { def id: Int } // abstract method - we don't know how to calc.
class Worker4 extends Person4 { def id: Int = 1231 } // Override keyword not required.
```

## Files

```scala
import com.sun.org.apache.bcel.internal.classfile.SourceFile
import scala.io.Source

// Text Files, URLS
val srcFile = Source.fromFile("c:/MJN/dummy.txt", "UTF-8")
val lineIterator = srcFile.getLines; for (l <- lineIterator) {println(l)}
val lines = srcFile.getLines.toArray
val contents = srcFile.mkString
for (c <- srcFile) println(c) // Read characters.
val words = srcFile.mkString.split("\\s+") // Array of words sep by whitespace.
srcFile.close() // Close when finished.

val srcFile2 = Source.fromURL("http://www.mjnurse.uk", "UTF-8"); srcFile2.close()
val srcFile3 = Source.fromString("one two three"); srcFile3.close() // Useful for debug.

// Write Test Files - Scala has no built in support so use java.io.PrintWriter
// val out = new PrintWriter("numbers.txt"); for (i <- 1 to 5) out.println(i); out.close()

// Binary Files - scala has no provision for binary files so use Java
// val file = new File(filename); val in = new FileInputStream(file)
// val bytes = new Array[Byte](file.length.toInt)
// in.read(bytes); in.close()

// Serialization
// class Person6 extends Serializable { val name = "unknown" }
// val fred = new Person6
//  import java.io._
// Serialize
// val out = new ObjectOutputStream(new FileOutputStream("/tmp/test.obj"))
// out.writeObject(fred); out.close()
// Deserialize
// val in = new ObjectInputStream(new FileInputStream("/tmp/test.obj"))
// val savedFred = in.readObject().asInstanceOf[Person6]
```

## sys Process

```scala
import sys.process._
"c:/MJN/hello.bat" !  // Runs cmd

"c:/MJN/hello.bat" !! // Runs cmd returns String

// #| is pipe, #> and #< are redirect.
// "ls" #| "grep xxx" !
// "ls" #> new File("x") !
```

<hr>
