The most fundamental thing a program can do is communicate with you. In C#, you display output to the console using the `Console.WriteLine()` method.

## Using Console.WriteLine()

The `Console.WriteLine()` method outputs text to the console. You call it by passing the text you want to display inside parentheses, enclosed in double quotes:

```csharp
Console.WriteLine("Hello, world!");
```

Output:
```output
Hello, world!
```

You can run this code yourself in the [C# Code Editor](https://microsoftlearning.github.io/c-sharp-minor).

### Double quotes are required

In C#, text must always be enclosed in double quotes (`"`). Single quotes (`'`) won't work for text. Make sure you use the straight quotes (`"`) and not curly quotes.

### The semicolon is important

Notice the semicolon (`;`) at the end of the line. In C#, every instruction must end with a semicolon. It tells the computer you've finished entering the command.

## Printing multiple items

You can pass multiple values to `Console.WriteLine()` by separating them with commas. C# automatically inserts a space between each item:

```csharp
Console.WriteLine("Hello", "world!");
```

Output:
```output
Hello world!
```

## Using escape characters

Sometimes you need more control over formatting—like starting a new line, adding a tab space, or including quotation marks inside your text. You can't just press <kbd>Enter</kbd> or <kbd>Tab</kbd> inside your quotes. Instead, C# uses **escape characters**, which are special combinations that start with a backslash (`\`):

| Escape sequence | What it does | Example | Output |
|---|---|---|---|
| `\n` | Moves text to a new line | `Console.WriteLine("Line 1\nLine 2");` | `Line 1`<br>`Line 2` |
| `\t` | Adds a tab space | `Console.WriteLine("Name:\tAlex");` | `Name:   Alex` |
| `\\` | Prints a literal backslash | `Console.WriteLine("Path: C:\\Users");` | `Path: C:\Users` |
| `\"` | Prints a double quote | `Console.WriteLine("She said, \"Hi!\"");` | `She said, "Hi!"` |

Make sure to use the backslash (`\`) and not the forward slash (`/`).

## Console.Write() vs. Console.WriteLine()

There's another method called `Console.Write()` that works similarly to `Console.WriteLine()`, but with one important difference:

- `Console.WriteLine()` adds a line break at the end, moving the next output to a new line
- `Console.Write()` prints to the current line without adding a line break

Example:
```csharp
Console.Write("Hello");
Console.Write(" ");
Console.Write("world!");
```

Output:
```output
Hello world!
```

If you used `Console.WriteLine()` instead, the output would be:
```output
Hello

world!
```
