# Manipulating control flow I: streams
Manipulating control flow to circumvent function eager evaluation order in Racket.

In Racket, `cons` is a functon, and so obeys eager evaluation. This means that all lists built up using `cons` are eagerly evaluated i.e. all list elements are evaluated when the list is constructed.

---
### Recursive definition of `stream`
- A stream is either empty or
- A thunk wrapping a **value** `cons` with a thunk wrapping another **stream**.

> we give the name thunk to any nullary function whose purpose is to delay the evaluation of its body expression.

<img src="images/stream1.png" width=300px><br>
<img src="images/stream2.png" width=300px>

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

---
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

---
# Type systems
A **type system** is the set of rules in a programming language governing the semantics of types in the language.

---
### **Strong** typing vs. **weak** typing
 In a `strongly-typed` language, every value has a fixed type at every point during the execution of a program.