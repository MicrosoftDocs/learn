Programs commonly take input. That input could come from sources such as web requests, files or user input via console or a graphical user interface. Once you get the input data into the program you need to ensure it's in a format that your program can work with. Additionally you will need how to learn operators to perform operations and calculations on the data.

## Input, reading from the console

To read from the console you can use methods found in the `System` namespace. You want to use something like `Console.Readline()`. This method reads all the characters up to a newline character and places those in a string. Here's an example of using said method:

```fsharp
Console.Write "Type a value:"
let str = Console.ReadLine()
printfn "You typed %s" str
```

Now, this might work fine to store what the user types into a string variable. But what happens if your program needs work on the user input and wants to treat it as a number or as a boolean and use it in an operation? At that point, you need to convert the data. 

## Convert

You've seen how F# implicitly infers the type of a variable by assigning a value to a variable like so:

```fsharp
let myNumber = 3
```

But what about if you have a string and you want to convert it to an int?

```fsharp
let myString = "3"
```

There are two main approaches:

- `System.Int32.Parse()`, Use what works in .NET, the `Parse()` function in the System namespace, `System.Int32.Parse()`.
- Built-in `int`. There's a built-in `int` function that you can use.

To use the former approach, write code like so:

```fsharp
let first = "32"
let numberVersion = System.Int32.Parse first 
printfn "Number %i" numberVersion // Ouutput: Number 32
```

To use the built-in `int`, you can instead type like so:

```fsharp
let first = "32"
let numberVersion =  first |> int 
printfn "Number %i" numberVersion
```

The latter version is using `|>`.

So which one do you use? It's usually preferred to use the built-in version with `int`.

## Operators

You've learned how to read input from a console and seen how that was stored as a string. To be able to use it in an operation you've seen how you can convert the value from string to an int. There exist conversion functions for most types. To do something useful with your code, you need to learn about operators. There are mathematical operators that allows you to add, subtract, divide and so on. The basic data types support these operators. Here are some of the most important operators

| Operator | Description |
|--|--|
| + | Adds two values |
| - | Subtract one value from another |
| / | divides the left side value with the right side value |
| % | Called modulus, gives the left over from dividing the left value with the right value |
| <> | Checks if two values are equal

To use the modulus operator for example you would type:

```fsharp
let no = 10
let isDivisibleByTwo = no % 2 <> 2
printfn "Divisible by two %b" isDivisibleByTwo
```