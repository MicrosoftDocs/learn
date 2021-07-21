All programs usually consist of many steps where it operates on data. As part of running all those steps it's common to store the intermittent result, the data, in a named reference. By doing so, it allows you to later read or manipulate it. Named references are commonly referred to as variables.

## Variables

To declare a variable in F# you use the `let` keyword, followed by the name of the variable. You can also assign a value to your variable at the moment of declaration, like in this example:

```fsharp
let name = "Chris"
```

Once a variable is assigned to a variable, it can't be changed, it's immutable. The following code would not compile and produces an error saying something like "error FS0027: This value is not mutable.":

```fsharp
let name = "Chris"
name <- "Luis" // not allowed
```

### Making it mutable

You can change variables however, but you need to signal that you want to make them _mutable_. By using the keyword `mutable` in your variable definition you will be able to change a value without a compilation error, like in the below code:

```fsharp
let mutable name = "Chris"
name <- "Luis" // this statement is now allowed
```

## Variable types

There exist a range of different types in F#. Many of the types have to do with storing numbers of different size and with our without decimals. Other types are associated with text string or boolean variables. Here's list of types that you are likely to encounter when you start out learning F#:

| Type | Description |
|--|--|
| bool | possible values are `true` or `false` |
| int | Values from -2,147,483,648 to 2,147,483,647. |
| string | Unicode text |
| float, double | A 64-bit floating point type. |

### Type is inferred

When you declare a variable, you can do so with or without type. If you don't provide a type when you declare a variable, the F# compiler will make a best guess on what the type should be by the value you assign to the variable. Consider the below statements:

```fsharp
let age = 65 // int
let PI = 3.14 // float
let name = "my name" // string
```

The compiler will _infer_ what the types should be, and it's right. You can however, be more explicit about what you want the type to be. To assign a data you use the syntax `variableName:<type>`, like in this code:

```fsharp
let sum:float = 0.0
``` 

## Printing to the screen

You often want to be able to print to the screen. It could be for various reasons such as:

- **Application output**. The application is doing some sort of calculation and you want to see the output
- **Debugging**. As part of debugging your code you might have to output the result at given point to understand what's going wrong.

There are other reasons too for wanting to output to the screen, but the two scenarios mentioned above are the most common.

So how would you print to the screen? In F# there are three different functions you could be using `printf`, `printfn`, and even `Console.WriteLine`. So what's the difference?

- `printfn`, it prints to `stdout` and adds a newline character.
- `printf`, prints to `stdout` but no newline character.
- `Console.WriteLine`, this function is from the `System` namespace and work in all .NET languages.

Ok, you know the difference, but which one to use? Well, `printfn` and `printf` are considered more idiomatic and preferred in F#.

### Formatting

Aa part of printing to the screen, you might want to combine text and numbers or you want the output to be formatted in a certain way.

To format you can use a .NET function like `string.Format`, which uses positional arguments like so `string.Format("My name is {0} and I live in {1}", "Chris", "UK")`. You can also use format specifiers (this is the most commonly used way to format in F#) as part of what you're trying to print, like in this example:

```fsharp
let name = "Chris"
printf "Hi %s" name
// prints: Hi Chris
```  

Here you can see how the formatter `%s` is used to mix the first string with the variable `name`. There are many format specifiers but here are some you are likely to enounter:

|Specifier  |Description  | Example |
|---------|---------|-------|
| %s    | used for strings and unescaped contents | printf "Hello %s" name |
| %d, %i | Formatted as a decimal integer, signed if the basic integer type is signed  | printf "Age: %i" 65 |
| %b | boolean `true` or `false` | printf "Setting on: " true |

There's a lot more information on formatting. If you want to know about all the capabilities, here's the [formatting in F# doc](https://docs.microsoft.com/en-us/dotnet/fsharp/language-reference/plaintext-formatting)
