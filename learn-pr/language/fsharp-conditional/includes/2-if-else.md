Let's say you have a program that creates a backup file based on the files in folder. The program consists of a few lines of code that locate and compress a set of files. What if you decide you want to add logic that creates a backup file only if a backup hasn't been made that day? The program would need a way to check for that condition (has a backup already been made), and then has different behavior based on whether the condition is true (if a backup file for the day exists, don't run backup).

## Create a code branch by using an if construct

An `if` construct evaluates a Boolean expression. If the expression evaluates to `true`, it runs a different branch of code. Here's what an `if` syntax looks like:

```fsharp
if <condition> then <expression>
```

A more tangible code example would look like this example:

```fsharp
let age = 66
if age > 65 
then printfn "Senior citizen"
```

## Define an alternate branch by using an else clause

An `else` clause is used with an `if` construct to express that if the `if` statement evaluates to `false`, the `else` branch is run instead.

Here's how you can use an `else` clause:

```fsharp
let age = 66
if age > 65 
then printfn "Senior citizen"
else printfn "Citizen"
```

## Use an if construct as an expression

So far, you've seen how you can use `if` and `else` to create different branches to the code. When the code follows different branches, it produces different results based on whether a Boolean condition evaluates to `true` or `false`. What's always happening, that you might not be aware of, is that when an expression is run, it produces a value. It becomes clearer if the code is written like this example:

```fsharp
let age = 64
let message = if age > 65 then "Senior citizen" else "Citizen"
printfn "%s" message
```

In this case, `if` and `else` work more like a ternary expression. If a condition is `true`, it returns that value. If it is `false`, it returns the other value. In fact, this is true for `if` in all instances. Let's revisit a previous code example and see that that's the case:

```fsharp
let age = 66
if age > 65 then printfn "Senior citizen" else printfn "Citizen"
```

It's the same code example you saw earlier, but now, `if` and `else` are on the same line. The `printfn "Senior citizen"` expression produces a value of type `unit`.

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

So far, you've seen how `if` and `else` work. `elif` is another construct that you can use similar to the way you'd use `if`. Just like an `if` construct, the `elif` construct takes a Boolean and should be added right after `if`. The `elif` constructed is executed if the `if` evaluates to `false`. Here's an example of using `elif`:

```fsharp
let cardValue = 1
let cardDescription = if cardValue = 1 then "Ace" elif cardValue = 14 then "Ace" else "A card"
printfn "%s" cardDescription
```
