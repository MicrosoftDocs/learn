All programs usually consist of many steps where the program operates on data. As part of running all those steps, it's common to store the intermittent result, the data, in a named reference. Then you can read or manipulate the data later. Named references are commonly referred to as *variables*.

## Variables, bind a value

Variables are named references bound to a value, that you want to keep referring to in your code. In F#, it's thought of as binding a value. So what you do is to assign, or *bind*, a value to a named reference, a variable. To bind a value, you use the `let` keyword, a name for your reference and assign a value to it, like in the below code:

```fsharp
let name = "Chris"
```

`name` is the named reference and "Chris" its bound value.

After a value is assigned to a variable, it can't be changed, it's immutable. The following code wouldn't compile and produces an error saying something like "error FS0027: This value is not mutable."

```fsharp
let name = "Chris"
name <- "Luis" // not allowed
```

### Make it mutable

You can change variables, but you need to signal that you want to make them *mutable*. By using the keyword `mutable` in your variable definition, you can change a value without a compilation error, like in the following code:

```fsharp
let mutable name = "Chris"
name <- "Luis" // this statement is now allowed
```

## Variable types

A range of different types exist in F#. Many of the types have to do with storing numbers of different sizes and with or without decimals. Other types are associated with text string or Boolean variables. Here's a list of types that you're likely to encounter when you start learning F#.

| Type | Description |
|--|--|
| bool | possible values are `true` or `false` |
| int | Values from -2,147,483,648 to 2,147,483,647. |
| string | Unicode text |
| float, double | A 64-bit floating point type. |

### Type is inferred

When you declare a variable, you can do so with or without type. If you don't provide a type when you declare a variable, the F# compiler makes a best guess on what the type should be by the value you assign to the variable. Consider the following statements:

```fsharp
let age = 65 // int
let PI = 3.14 // float
let name = "my name" // string
```

The compiler *infers* what the types should be, and it's right. You can also be more explicit about what you want the type to be. To assign a data, you use the syntax `variableName:<type>`, like in this code:

```fsharp
let sum:float = 0.0
```

## Print to the screen

You often want to be able to print to the screen. It could be for various reasons, such as:

- **Application output**: The application is doing some sort of calculation, and you want to see the output.
- **Debugging**: As part of debugging your code, you might have to output the result at a given point to understand what's going wrong.

There are other reasons for wanting to output to the screen, but the preceding two scenarios are the most common.

So how would you print to the screen? In F#, there are three different functions you can use. They're `printf`, `printfn`, and even `Console.WriteLine`. So what's the difference?

- `printf`: It prints to `stdout` inline (no newline character).
- `printfn`: It prints to `stdout` adds a newline character.
- `Console.WriteLine`: This function is from the `System` namespace and works in all .NET languages.

Now you know the difference, but which one should you use? Well, `printf` and `printfn` are considered more idiomatic and preferred in F#.

## Formatting

As part of printing to the screen, you might want to combine text and numbers. Or you might want the output to be formatted in a certain way, such as by using:

- **Positional arguments**: To format, you can use a .NET function like `string.Format`, which uses positional arguments like `string.Format("My name is {0} and I live in {1}", "Chris", "UK")`.
- **String interpolation**: Another way to combine variables and text is to use something called interpolation. To use it, you need to precede the string with a `$` sign and indicate placeholders with brackets `{}`. Here's an example of using interpolation:

   ```fsharp
   let name = "Luis"
   let company = "Microsoft"
   printfn $"Name: {name}, Company: {company}"
   ```

   You can also add expressions in between the brackets, like so:

   ```fsharp
   let firstNumber = 2000
   let secondNumber = 21
   printfn $"The year is: {firstNumber + secondNumber}"
   ```

   > [!NOTE]
   > There's no type checking using interpolation, so it might seem straightforward to use. Be sure to combine things correctly.

- **Specifiers**: You can also use format specifiers as part of what you're trying to print. Using specifiers is the most commonly used way to format in F#. Here's an example:

    ```fsharp
    let name = "Chris"
    printf "Hi %s" name
    // prints: Hi Chris
    ```  

    Here you can see how the formatter `%s` is used to mix the first string with the variable `name`.

    > [!NOTE]
    > When you use formatters like %s or %i, the compiler checks types. If your positional argument isn't of the type you've specified, it throws an error.

### Format specifiers

There are many format specifiers. Here are some you're likely to encounter.

|Specifier  |Description  | Example |
|---------|---------|-------|
| %s    | Used for strings and unescaped contents | printf "Hello %s" name |
| %d, %i | Formatted as a decimal integer, signed if the basic integer type is signed  | printf "Age: %i" 65 |
| %b | Boolean `true` or `false` | printf "Setting on: %b" true |

There's more information on formatting. If you want to know about all the capabilities, see the [formatting in F# doc](/dotnet/fsharp/language-reference/plaintext-formatting).
