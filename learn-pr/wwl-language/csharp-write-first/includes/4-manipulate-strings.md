
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=808f8f0e-548f-4bc0-aad4-0573f77b6578]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Text is one of the most common types of data in programming. In C#, text is represented as a **string**—a sequence of characters enclosed in double quotes. C# provides many built-in ways to manipulate and format strings.

## Concatenation (joining strings together)

You can join two or more strings together into a single string using the `+` operator:

```csharp
string first = "Hello";
string last = "world";
string message = first + ", " + last + "!";
Console.WriteLine(message);
```

Output:
```output
Hello, world!
```

While concatenation works great for simple combinations, it can become messy when you try to mix variables, punctuation, and spaces together.

## A better way: String interpolation

A cleaner, modern way to combine strings and variables is with **string interpolation**. To create this kind of string, place a dollar sign (`$`) directly before your opening quote, and place any variable names inside curly braces `{}`:

```csharp
string name = "Alex";
Console.WriteLine($"Hello, {name}!");
```

Output:
```output
Hello, Alex!
```

You can try running this code yourself in the [C# Code Editor](https://microsoftlearning.github.io/c-sharp-minor).

### A cleaner way to combine input and output

String interpolation solves the problem we saw earlier with `Console.ReadLine()`. Now you can mix text and variables easily:

```csharp
string name = Console.ReadLine();
Console.WriteLine($"Hello, {name}! Nice to meet you.");
```

This is much cleaner than concatenating with `+`.

> [!NOTE]
> If you forget the `$` prefix (e.g., `Console.WriteLine("Hello, {name}")`), C# won't look inside the braces—it will literally print `{name}` on the screen.

## Common string methods

C# strings have many built-in methods for common operations. To use a method, type the variable name, a dot, and the method name followed by parentheses:

| Method | What it does | Example | Result |
|---|---|---|---|
| `.ToUpper()` | Converts text to uppercase | `"hello".ToUpper()` | `"HELLO"` |
| `.ToLower()` | Converts text to lowercase | `"HELLO".ToLower()` | `"hello"` |
| `.Replace(old, new)` | Swaps out specific characters | `"cat".Replace("c", "b")` | `"bat"` |
| `.Length` | Returns the number of characters | `"Alex".Length` | `4` |

## Practical example

Here's how you might use these techniques together:

```csharp
Console.Write("What's your name? ");
string name = Console.ReadLine();
string greeting = $"Welcome, {name.ToUpper()}!";
Console.WriteLine(greeting);
```

If the user types `alex`, the output is:
```output
What's your name? alex
Welcome, ALEX!
```

Notice how `.ToUpper()` converted the user's input to uppercase, and string interpolation made it easy to combine everything together.

::: zone-end

