# Manipulating control flow I: streams
Manipulating control flow to circumvent function eager evaluation order in Racket.

In Racket, `cons` is a functon, and so obeys eager evaluation. This means that all lists built up using `cons` are eagerly evaluated i.e. all list elements are evaluated when the list is constructed.

---
### Recursive definition of `stream`
- A stream is either empty or
- A thunk wrapping a **value** `cons` with a thunk wrapping another **stream**.

> we give the name thunk to any nullary function whose purpose is to delay the evaluation of its body expression.

<img src="images/stream1.png" width=450px><br>
<img src="images/stream2.png" width=450px>

In Haskell, `cons` is already lazy. So in fact, the list data type in Haskell is actually a stream.

---
# Manipulating control flow II: the ambiguous operator `-<`
The continuation, a representation of the control flow at a given point in the execution of a program.

## `-<`
- `-<` takes an arbitrary number of argument expressions, representing the possible *choices* for the expression.
- If there are no arguments, it returns a special constant `DONE`.
- If there is at least one argument, it **evaluates** and **returns** the value of the first argument. 
- In addition, if there is more than one arguments, `-<` stores a "choice point" that contains the remaining arguments so that they can be accessed, one at a time, by calling a separate function `next`.
- Once all of the arguments have been evaluated, subsequent calls to `next` return `DONE`.


## Continuations
For each subexpression `s`, we say that its **continuation** is a representation of what remains to be evaluated after `s` itself has been evaluated.

---
### `let/cc`: reifying continuations
Continuation is a **first-class** data type in Racket.

Racket reifies continuations, meaning exposes continuations as values that a program and access and manipulate as easily as numbers and lists.

```
(let/cc <id> <body>)
```
A `let/cc` expression has the following denotational semantics:
- the value of a `let/cc` expression is equal to the value of the `<body>` expression.
- `<id>` is bound to the *continuation* of the `let/cc` expression.

Note: we can use the same syntax as function calls i.e. `(<cont> <arg>)`. Remember, continuations always take just **one argument**, the value of the "result" to put into the underscore.

---
### Calling continuations vs. calling functions
```
> (f 4)
13

> (global-cont 4)
13

> (+ 1 (f 4))
14

> (+ 1 (global-cont 4))
13
```
Calling a continuation **discards** the enclosing continuation, and replaces it with the continuation being called.

---
### Branching choices
Every time we encounter a choice expression, we *push* the corresponding thunk onto the choice stack, and every time we call `next`, we *pop* off the stack and call it.

<img src="images/choice.png" width=350px>

---
### Backtracking
```
(define (?- pred expr)
    (if (pred expr)
        expr
        (next)))
```
Here, we *automatically backtrack* on failures.


# Type systems
A **type system** is the set of rules in a programming language governing the semantics of types in the language.

---
### `Strong` typing vs. `weak` typing
In a `strongly-typed` language, every value has a fixed type at every point during the execution of a program.

A `weakly-typed` language has no such guarantees: values can be implicitly interpreted as having a completely different type at runtime than what was originally intended, e.g. `"5" + 6` is semantically valid in many languages.

---
### `Static` typing vs. `dynamic` typing
In a `statically-typed` language, the type of every expression is determined directly from the source code, before any code is actually executed.

In contrast, `dynamically-typed` languages do not perform any type-checking until the program is run.

---
### The basics of Haskell's type system
> One important difference between Haskell and Racket is that lists must contain values of the same type, so the expression `[True, 'a']` is rejected by Haskell. This also applies to `if then else` expression.

---
### Function types and currying
Haskell treats **all** functions as unary functions, and that function application is indicated by simply seperating two expressions with a space.

---
### Algebraic data types
We call types that are created using combinations of constructors and unions **algebraic data types**.

---
### Polymorphism I: type variables and generic polymorphism
In programming language theory, **polymorphism** refers to the ability of an entity (e.g. function or class) to have valid behavior in contexts of different types.

A **type variable** is an **identifier** in a type expression that can be instantiated to any type.

A **type constructor** is a **function** that takes type variable(s) and creates a new type.

For example, when we type-check the expression `head [True, False, False]`:
1. Haskell determines that the type of the argument is `[Bool]`.
2. Haskell matches the argument type `[Bool]` against the parameter type `[a]`, and instantiates the type variable `a = Bool` in the function type.
3. Haskell takes the return type `a`, with `a` instantiated to `Bool`, to recover the final concrete type `Bool` for the return type.

---
### Generic polymorphism (in Haskell and beyond)
In Haskell, lists are an example of **generic polymorphism**, a form of polymorphism in which an entity (e.g., function or class) behaves in the **same way** regardless of the type context. (e.g. list can store elements of any type. Similarly, almost every built-in list function is generic, meaning they operate on their input list regardless of what this input list contains.)