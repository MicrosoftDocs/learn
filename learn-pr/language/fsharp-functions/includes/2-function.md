Usually you find yourself in a situation where your code looks repetitive, it's doing the same thing in many places or there's minor differences. In situations like these, you should start thinking how to make code reusable. The answer how to tackle this situation is to extract these expressions and make one or more functions. A function is a fundamental building block in numerous programming languages, F# is no different.

## A function

A function is a named reference that has a body consisting of one or more expressions. On top of that it can have parameters. A function starts with `let` keyword and the name of the function. Then there's an assignment operator and to the right of said operator is the function body. Below is the syntax of a function.

```fsharp
let <function name> <parameters> = <function body>
```

An actual function example, given the example syntax above, looks like so:

```fsharp
let add a b = a + b 
```

In this example, the name of the function is `add` and the parameters are `a` and `b`. The function body adds the two parameters together `a+b` and ends up returning the result.

### Return values

As you've seen on the first example, there was no `return` keyword to state what's being returned. In F#, what's on the last line of a function is what's being returned. Consider this multiline function below:

```fsharp
let addAndMultiply a b c = 
    let sum = a + b
    let product = sum * c
    product
```

By placing `product` on the last line, it's what's being returned. So how do you call such a function?

### Calling a function

To call, or invoke a function, use the name of the function and add any parameters you wish to use separated by a space character. Take the example `addAndMultiply` function from above, to call it, type the following:

```fsharp
addAndMultiply 2 3 3 // 15
```

To see the results of the function, you can either assign it to a variable or print it out directly like so:

```fsharp
let sum = addAndMultiply 2 3 3
printfn "%i" sum
// OR
printfn "%i" (addAndMultiply 2 3 3)
```

### Inferred types

Let's take the following code:

```fsharp
let add a b = a + b
let sum = add 2 2 
let concat = add "hello" "world" // will give compilation error
```

This code will fail on the last line with the following message:

```output
error FS0001: This expression was expected to have type
    'int'    
but here has type
    'string'    
```

The reason, is that F# already made up its mind what parameter types there should be, it decided on integer. The reason it decided on integer was the second row `let sum = add 2 2` where the function `add` was used in a way stating that the parameters definitely was integer. However, if the second row doesn't exist your code will work:

```fsharp
let add a b = a + b
// let sum = add 2 2 
let concat = add "hello" "world" // will work
```

At this point, the compiler sees that the first usage of the function is made with strings and therefore concludes that strings it is. So the type gets inferred by context and first use.

### Explicit types

There are situations where you want to be explicit, both about what type parameters take and what the function returns. It helps readability to be specific, even though the compiler most likely doesn't need it:

Take the following function for example:

```fsharp
let convert a =
    int a
```

To add types to it, you add a `: <type>`, like so:

```fsharp
let convert (a:string) =
    int a
```

The parameter now has the type `int` via this code `let cardType a:int`. However, this code will no longer compile. The way the compiler works, it assumes, the same parameter type in means the return type should be the same. You're shown an error like so:

```output
error FS0001: This expression was expected to have type
    'string'    
but here has type
    'int'
```

To make this code, you also need to specify a return type for the function, to do so, add another `: <type>` right after your parameter like so:

```fsharp
let convert (a:string): int =
    int a
```

Now the parameter is enclosed by parenthesis `(a:string)` and the return type is the last `:<type>` annotation to happen, `:int`, now your code works again.
