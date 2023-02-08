Let's say you have a program that creates a backup file based on the files in a folder. The program consists of a few lines of code that locate and compress a set of files. What if you decide that you want to add logic that creates a backup file only if a backup hasn't been made that day? The program would need a way to check for that condition (has a backup already been made?), and then do something different based on whether the condition is true (if a backup file for the day exists, don't run backup).

## Create a code branch by using an if construct

An `if` construct evaluates a Boolean expression. If the expression evaluates as `true`, the program runs a particular branch of code. Here's what the syntax of an `if` construct looks like:

```fsharp
if <condition> then <expression>
```

A more tangible code example looks like this example:

```fsharp
let age = 66
if age > 65 
then printfn "Senior citizen"
```

## Define an alternate branch by using an else clause

When an `if` statement evaluates as `false`, use an `else` clause with the `if` construct to run a different branch of code.

Here's how you can use an `else` clause:

```fsharp
let age = 66
if age > 65 
then printfn "Senior citizen"
else printfn "Citizen"
```

## Use an if construct as an expression

So far, you've seen how you can use `if` and `else` to create different branches in the code. When the code follows different branches, it produces different results based on whether a Boolean condition evaluates as `true` or `false`. What you might not be aware of, is that when an expression is run, a value is produced.

If the code is written like this example, the result becomes clear:

```fsharp
let age = 64
let message = if age > 65 then "Senior citizen" else "Citizen"
printfn "%s" message
```

In this case, `if` and `else` work more like a ternary expression. If a condition is `true`, it returns one value. If it's `false`, it returns the other value. In either case, a value is returned. A fact that's true for all `if` expressions.

Let's revisit an earlier code example and look behind the scenes:

```fsharp
let age = 66
if age > 65 then printfn "Senior citizen" else printfn "Citizen"
```

It's the same code example you saw earlier, but now, `if` and `else` are on the same line. Because the important actions of the `printf` operation occur in the function, the function doesn't have to return an actual value. Therefore, the return value of the `printfn "Senior citizen"` expression produces a value of type `unit`.

> [!NOTE]
> `unit` is a value that acts as a placeholder when no actual value is returned. You can think of it like `void` or `None`.

Another thing to keep in mind is that you can't mix types. `if` and `else` must return the same data type or you'll get an error. For example, you can't write code that looks like this example:

```fsharp
let someCondition = true
let value = if someCondition then "hello" else 1 // not allowed
```

In this case, `if` determines that the return type is `string`, so `else` can't change that type to `int`. For the preceding code to work, you must modify it:

```fsharp
let someCondition = true
let value = if someCondition then "hello" else "1" // allowed
```

## Use an elif construct

So far, you've seen how `if` and `else` work. `elif` is another construct that you can use similar to the way you'd use `if`. Just like an `if` construct, the `elif` construct takes a Boolean value and should be added right after `if`. The `elif` construct is executed when the `if` condition evaluates as `false`. Here's an example of how to use `elif`:

```fsharp
let cardValue = 1
let cardDescription = if cardValue = 1 then "Ace" elif cardValue = 14 then "Ace" else "A card"
printfn "%s" cardDescription
```
