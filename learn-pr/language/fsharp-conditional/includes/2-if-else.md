Let's say you have a program that creates a backup file based on the files in folder. The program consists of few lines of code locating and compressing a set of files. What if you suddenly wanted to add logic that said, only create such a backup file if a backup hasn't been done that day. Such a program would need a way to perform a check so it has a different behavior based on a condition of file existing or not.

## Create a code branch with `if`

An `if` construct evaluates a boolean expression. If said expression evaluates to `true`, it runs a different branch of code. Here's what an `if` syntax looks like:

```fsharp
if <condition> then <expression>
```

A more tangible code example would look like so:

```fsharp
let age = 66
if age > 65 
then printfn "Senior citizen"
```

## Define an alternate branch with `else`

An `else` clause is used with an `if` to express that if the `if` statement evaluates to `false` then the `else` branch is run instead.

Here's how you can use an else:

```fsharp
let age = 66
if age > 65 
then printfn "Senior citizen"
else printfn "Citizen"
```

## `If` as an expression

So far you've seen how `if` and `else` have created different branches to the code that produces a different result based on whether a boolean condition evaluates to `true` or `false`. What's always happening, that you might not be aware of, is that when an expression is run, it produces a value. It becomes clearer if the code is written like so instead:

```fsharp
let age = 64
let message = if age > 65 then "Senior citizen" else "Citizen"
printfn "%s" message
```

In this case, the `if` and `else` behave more like a ternary expression where if a condition is true, it returns that value, and if false it returns the other value. In fact, `if` always behaves this way. Let's revisit a previous code example and see that that is the case:

```fsharp
let age = 66
if age > 65 then printfn "Senior citizen" else printfn "Citizen"
```

Same code example as before, with the difference being that `if` and `else` have been put on the same line. The expression being run `printfn "Senior citizen"` produces a value of type `unit`.

> [!NOTE]
> `unit` is a value that acts as a placeholder when no actual value is returned. You can think of it like `void` or `None`.

Another thing to keep in mind is that you can't mix types, the `if` and `else` needs to return the same data type or you will get an error. You can't for example write code like so:

```fsharp
let someCondition = true
let value = if someCondition then "hello" else 1 // not allowed
```

In this case, the `if` decides that the return type is 'string', so the `else` can't decide to change that to `int`. You would need to modify the code like so for the above to work:

```fsharp
let someCondition = true
let value = if someCondition then "hello" else "1" // allowed
```

## Elif

So far you've seen `if` and `else`, but there's another construct `elif` that you would use in much the same way as an `if`. Just like an `if`, the `elif` takes a boolean and it should be added right next to the `if`. The `elif` is executed if the `if` evaluates to `false`. Here's an example of using `elif`:

```fsharp
let cardValue = 1
let cardDescription = if cardValue = 1 then "Ace" elif cardValue = 14 then "Ace" else "A card"
printfn "%s" cardDescription
```
