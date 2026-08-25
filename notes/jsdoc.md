---
title: JSDoc - Documenting Javascript
---

### Basic Format

```
/** A class that does something. */
class SomeClass extends SomeBaseClass {
  /**
   * Operates on an instance of MyClass and returns something.
   * @param {!MyClass} obj An object that for some reason needs detailed
   *     explanation that spans multiple lines.
   * @param {!OtherClass} obviousOtherClass
   * @return {boolean} Whether something occurred.
   */
  someMethod(obj, obviousOtherClass) { ... }

  /** @override */
  overriddenMethod(param) { ... }
}

/**
 * Demonstrates how top-level functions follow the same rules.  This one
 * makes an array.
 * @param {TYPE} arg
 * @return {!Array<TYPE>}
 * @template TYPE
 */
function makeArray(arg) { ... }

/** @const @private {!Foo} A short bit of JSDoc. */
this.foo_ = foo;
```

### Some More Complex Examples

```
/**
 * A fancier event target that does cool things.
 * @implements {Iterable<string>}
 */
class MyFancyTarget extends EventTarget {
  /**
   * @param {string} arg1 An argument that makes this more interesting.
   * @param {!Array<number>} arg2 List of numbers to be processed.
   */
  constructor(arg1, arg2) {
    // ...
  }
};

/**
 * Records are also helpful.
 * @extends {Iterator<TYPE>}
 * @record
 * @template TYPE
 */
class Listable {
  /** @return {TYPE} The next item in line to be returned. */
  next() {}
}
```

### Enums / typedefs

All enums and typedefs must be documented with appropriate JSDoc tags (@typedef or @enum) on the preceding line. Public enums and typedefs must also have a description. Individual enum items may be documented with a JSDoc comment on the preceding line.
```
/**
 * A useful type union, which is reused often.
 * @typedef {!Bandersnatch|!BandersnatchType}
 */
let CoolUnionType;

/**
 * Types of bandersnatches.
 * @enum {string}
 */
const BandersnatchType = {
  /** This kind is really frumious. */
  FRUMIOUS: 'frumious',
  /** The less-frumious kind. */
  MANXOME: 'manxome',
};
```

Typedefs are useful for defining short record types, or aliases for unions, complex functions, or generic types. Typedefs should be avoided for record types with many fields, since they do not allow documenting individual fields, nor using templates or recursive references. For large record types, prefer @record.

### Method and Function Comments

Method descriptions begin with a verb phrase that describes what the method does. This phrase is not an imperative sentence, but instead is written in the third person, as if there is an implied This method ... before it.

```
/** A class that does something. */
class SomeClass extends SomeBaseClass {
  /**
   * Operates on an instance of MyClass and returns something.
   * @param {!MyClass} obj An object that for some reason needs detailed
   *     explanation that spans multiple lines.
   * @param {!OtherClass} obviousOtherClass
   * @return {boolean} Whether something occurred.
   */
  someMethod(obj, obviousOtherClass) { ... }

  /** @override */
  overriddenMethod(param) { ... }
}

/**
 * Demonstrates how top-level functions follow the same rules.  This one
 * makes an array.
 * @param {TYPE} arg
 * @return {!Array<TYPE>}
 * @template TYPE
 */
function makeArray(arg) { ... }
```
In anonymous functions annotations are generally optional. If the automatic type inference is insufficient or explicit annotation improves readability, then annotate param and return types like this:
```
promise.then(
    /** @return {string} */
    (/** !Array<string> */ items) => {
      doSomethingWith(items);
      return items[0];
    });
```

### Property Comments

Property types must be documented. The description may be omitted for private properties, if name and type provide enough documentation for understanding the code.

Publicly exported constants are commented the same way as properties.

```
/** My class. */
class MyClass {
  /** @param {string=} someString */
  constructor(someString = 'default string') {
    /** @private @const {string} */
    this.someString_ = someString;

    /** @private @const {!OtherType} */
    this.someOtherThing_ = functionThatReturnsAThing();

    /**
     * Maximum number of things per pane.
     * @type {number}
     */
    this.someProperty = 4;
  }
}

/**
 * The number of times we'll try before giving up.
 * @const {number}
 */
MyClass.RETRY_COUNT = 33;
7.10 Type annotations
Type annotations are found on @param, @return, @this, and @type tags, and optionally on @const, @export, and any visibility tags. Type annotations attached to JSDoc tags must always be enclosed in braces.

7.10.1 Nullability
The type system defines modifiers ! and ? for non-null and nullable, respectively. These modifiers must precede the type.

Nullability modifiers have different requirements for different types, which fall into two broad categories:

Type annotations for primitives (string, number, boolean, symbol, undefined, null) and literals ({function(...): ...} and {{foo: string...}}) are always non-nullable by default. Use the ? modifier to make it nullable, but omit the redundant !.
Reference types (generally, anything in UpperCamelCase, including some.namespace.ReferenceType) refer to a class, enum, record, or typedef defined elsewhere. Since these types may or may not be nullable, it is impossible to tell from the name alone whether it is nullable or not. Always use explicit ? and ! modifiers for these types to prevent ambiguity at use sites.
Bad:

const /** MyObject */ myObject = null; // Non-primitive types must be annotated.
const /** !number */ someNum = 5; // Primitives are non-nullable by default.
const /** number? */ someNullableNum = null; // ? should precede the type.
const /** !{foo: string, bar: number} */ record = ...; // Already non-nullable.
const /** MyTypeDef */ def = ...; // Not sure if MyTypeDef is nullable.

// Not sure if object (nullable), enum (non-nullable, unless otherwise
// specified), or typedef (depends on definition).
const /** SomeCamelCaseName */ n = ...;
Good:

const /** ?MyObject */ myObject = null;
const /** number */ someNum = 5;
const /** ?number */ someNullableNum = null;
const /** {foo: string, bar: number} */ record = ...;
const /** !MyTypeDef */ def = ...;
const /** ?SomeCamelCaseName */ n = ...;
7.10.2 Type Casts
In cases where the compiler doesn't accurately infer the type of an expression, and the assertion functions in goog.asserts cannot remedy it , it is possible to tighten the type by adding a type annotation comment and enclosing the expression in parentheses. Note that the parentheses are required.

/** @type {number} */ (x)
7.10.3 Template Parameter Types
Always specify template parameters. This way compiler can do a better job and it makes it easier for readers to understand what code does.

Bad:

const /** !Object */ users = {};
const /** !Array */ books = [];
const /** !Promise */ response = ...;
Good:

const /** !Object<string, !User> */ users = {};
const /** !Array<string> */ books = [];
const /** !Promise<!Response> */ response = ...;

const /** !Promise<undefined> */ thisPromiseReturnsNothingButParameterIsStillUseful = ...;
const /** !Object<string, *> */ mapOfEverything = {};
Cases when template parameters should not be used:

Object is used for type hierarchy and not as map-like structure.
7.10.4 Function type expressions
Terminology Note: function type expression refers to a type annotation for function types with the keyword function in the annotation (see examples below).

Where the function definition is given, do not use a function type expression. Specify parameter and return types with @param and @return, or with inline annotations (see 7.8 Method and function comments). This includes anonymous functions and functions defined and assigned to a const (where the function jsdoc appears above the whole assignment expression).

Function type expressions are needed, for example, inside @typedef, @param or @return. Use it also for variables or properties of function type, if they are not immediately initialized with the function definition.

  /** @private {function(string): string} */
  this.idGenerator_ = googFunctions.identity;
When using a function type expression, always specify the return type explicitly. Otherwise the default return type is unknown (?), which leads to strange and unexpected behavior, and is rarely what is actually desired.

/**
 * @param {function(): *} inputFunction1 Can return any type.
 * @param {function(): undefined} inputFunction2 Definitely doesn't return
 *      anything.
 * NOTE: the return type of 'foo' itself is safely implied to be {undefined}.
 */
function foo(inputFunction1, inputFunction2) {...}
7.10.5 Whitespace
Within a type annotation, a single space or line break is required after each comma or colon. Additional line breaks may be inserted to improve readability or avoid exceeding the column limit. These breaks should be chosen and indented following the applicable guidelines (e.g. 4.5 Line-wrapping and 4.2 Block indentation: +2 spaces). No other whitespace is allowed in type annotations.

Good:

/** @type {function(string): number} */
/** @type {{foo: number, bar: number}} */
/** @type {number|string} */
/** @type {!Object<string, string>} */
/** @type {function(this: Object<string, string>, number): string} */

/**
 * @type {function(
 *     !SuperDuperReallyReallyLongTypedefThatForcesTheLineBreak,
 *     !OtherVeryLongTypedef): string}
 */

/**
 * @type {!SuperDuperReallyReallyLongTypedefThatForcesTheLineBreak|
 *     !OtherVeryLongTypedef}
 */
Bad:

// Only put a space after the colon
/** @type {function(string) : number} */

// Put spaces after colons and commas
/** @type {{foo:number,bar:number}} */

// No space in union types
/** @type {number | string} */
7.11 Visibility annotations
Visibility annotations (@private, @package, @protected) may be specified in a @fileoverview block, or on any exported symbol or property. Do not specify visibility for local variables, whether within a function or at the top level of a module. All @private names must end with an underscore.





Some document generation tool will ignore plain test formatting to use Markdown lists etc.
```
/**
 * Computes weight based on three factors:
 *   items sent
 *   items received
 *   last timestamp
 */

// Might generate: Computes weight based on three factors: items sent items received last timestamp

/**
 * This example will create a markdown list:
 *
 *  - items sent
 *  - items received
 *  - last timestamp
 */
```
<hr>
