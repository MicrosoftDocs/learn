Typically, programs take input. The input could come from sources such as web requests, files, or user input via a console or a graphical user interface. After you get the input data into the program, you need to ensure it's in a format that your program can work with. You also need to know how operators perform operations and calculations on the data.

## Read input from the console

To read from the console, you can use methods found in the `System` namespace. You want to use something like `Console.Readline()`. This method reads all the characters up to a newline character and places those characters in a string. Here's an example of using this method.

```fsharp
System.Console.Write "Type a value:"
let str = System.Console.ReadLine()
printfn "You typed %s" str
```

This code might work fine to store what the user enters in a string variable. But what happens if your program needs to work on the user input and wants to treat it as a number or as a Boolean and use it in an operation? At that point, you need to convert the data.

## Convert between data types

You've seen how F# implicitly infers the type of a variable by assigning a value to a variable, like so:

```fsharp
let myNumber = 3
```

But what if you have a string and you want to convert it to an `int`?

```fsharp
let myString = "3"
```

There are two main approaches:

- `System.Int32.Parse()`: Use what works in .NET, the `Parse()` function in the `System` namespace, `System.Int32.Parse()`.
- Built-in `int`: There's a built-in `int` function that you can use.

To use the first approach, write the code like so:

```fsharp
let first = "32"
let numberVersion = System.Int32.Parse first 
printfn "Number %i" numberVersion // Output: Number 32
```

To use the built-in `int` function, enter it like so:

```fsharp
let first = "32"
let numberVersion =  int first 
printfn "Number %i" numberVersion
```

So which one do you use? The version with the built-in `int` function is preferred.

## Operators

You've learned how to read input from a console and seen how that input was stored as a string. To use it in an operation, you've seen how you can convert the value from a string to an int. Conversion functions exist for most types. To do something useful with your code, you need to learn about operators. By using mathematical operators, you can add, subtract, divide, and so on. The basic data types support these operators. Here are some of the most important operators.

| Operator | Description |
|--|--|
| + | Adds two values |
| - | Subtracts one value from another |
| / | Divides the left-side value with the right-side value |
| % | Called modulus, gives the left over from dividing the left value with the right value |
| <> | Checks if two values aren't equal |
| = | Checks if two values are equal |

To use the modulus operator, for example, you enter:

```fsharp
let no = 10
let isDivisibleByTwo = no % 2 = 0
printfn "Divisible by two %b" isDivisibleByTwo
```