Run the following code in the interactive window. To do that, type the following code block in the interactive window (replace "\<name>" with your name) and click the **Run** button:

```csharp
var name = "<name>";
Console.WriteLine($"Hello, {name}. It's a pleasure to meet you!");
```

When you run the program, it displays a single string that includes your name in the greeting. The string included in the <xref:System.Console.WriteLine%2A> method call is an *interpolated string*. It's a kind of template that lets you construct a single string (called the *result string*) from a string that includes embedded code. Interpolated strings are particularly useful for inserting values into a string or concatenating (joining together) strings.

This simple example contains the two elements that every interpolated string must have:

- A string literal that begins with the `$` character before its opening quotation mark character. There can't be any spaces between the `$` symbol and the quotation mark character. (If you'd like to see what happens if you include one, insert a space after the `$` character in the interactive window and click the **Run** button. The C# compiler complains, "Unexpected character '$'".)

- One or more *interpolated expressions*. An interpolated expression is indicated by an opening and closing brace (`{` and `}`). You can put any C# expression that returns a value (including `null`) inside the braces.

Let's try a few more interpolated string examples with some other data types.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).