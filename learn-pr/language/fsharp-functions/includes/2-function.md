Usually, you find yourself in a situation where your code looks repetitive. It's doing the same thing in many places, or there are only minor differences. In situations like these, think about how to make code reusable. The way to tackle this situation is to extract these expressions and make one or more functions. A function is a fundamental building block in many programming languages, and F# is no different.

## A function

A function is a named reference with a body that consists of one or more expressions. It can also have parameters. A function starts with the keyword `let` and the name of the function. Next, there's an assignment operator, and to the right of this operator is the function body.

Here's the syntax of a function:

```fsharp
let <function name> <parameters> = <function body>
```

An actual function example, as shown with the preceding example syntax, looks like so:

```fsharp
let add a b = a + b 
```

In this example, the name of the function is `add` and the parameters are `a` and `b`. The function body adds the two parameters together, `a+b`, and returns the result.

### Return values

As you saw in the first example, there's no `return` keyword to state what's being returned. In F#, the information in the last line of a function is what's being returned. Consider this multiline function:

```fsharp
let addAndMultiply a b c = 
    let sum = a + b
    let product = sum * c
    product
```

By placing `product` on the last line, it tells you what's being returned. So how do you call a function like this?

### Call a function

To call, or invoke, a function, use the name of the function and add any parameters you want to use, separated by a space character. For example, to call the `addAndMultiply()` function, enter the following code:

```fsharp
addAndMultiply 2 3 3 // 15
```

To see the results of the function, you can either assign it to a variable or print it out directly, like so:

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

This code fails on the last line with the following message:

```output
error FS0001: This expression was expected to have type
    'int'    
but here has type
    'string'    
```

The reason for the failure is that F# already determined what parameter type should be used, and it decided on integer. The reason it decided on integer was because of the information in the second row, `let sum = add 2 2`. The function `add()` was used in a way that stated that the parameter type was definitely integer.

If the second row didn't exist, your code works:

```fsharp
let add a b = a + b
// let sum = add 2 2 
let concat = add "hello" "world" // will work
```

The compiler sees that the first use of the function is made with strings and concludes that the parameter type is string. So, context and first use infer the type.

### Explicit types

There are situations where you want to be explicit, both about what type of parameters to take and what the function returns. It helps readability to be specific, even though the compiler most likely doesn't need it.

Take the following function, for example:

```fsharp
let convert a =
    int a
```

To add types to it, you add `:<type>`, like so:

```fsharp
let convert (a:string) =
    int a
```

The parameter now has the type `string` via the code `let convert (a:string)`. You can now be even more explicit, by adding a return type. To do so, add another `:<type>` right after your parameter:

```fsharp
let convert (a:string) :int =
    int a
```

Now parentheses enclose the parameter, as shown in `(a:string)`. The return type is the last `:<type>` annotation to happen, which is `:int`. F# is clever enough to figure out most scenarios, but sometimes you need to help the code by being more explicit. Another benefit to adding types is that it makes it easier for another developer to figure out what's going on.
