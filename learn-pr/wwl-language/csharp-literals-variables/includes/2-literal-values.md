
A **literal** is a hard-coded value that never changes. When you write `Console.WriteLine("Hello");`, the text `"Hello"` is a literal—it's exactly what you want to display, no more, no less.

## Common literal data types

C# has several data types for different kinds of values:

| Data Type | Purpose | Examples |
|-----------|---------|----------|
| `string` | Text (multiple characters) | `"Hello"`, `"Alice"`, `"123 Main St"` |
| `char` | A single character | `'a'`, `'Z'`, `'1'` |
| `int` | Whole numbers | `42`, `-5`, `1000` |
| `decimal` | Numbers with decimals | `3.14`, `99.99`, `-0.5` |
| `bool` | True or false | `true`, `false` |

## Using different literals

When you use a literal value in your code, C# needs to know what type it is:

```csharp
Console.WriteLine("Hello");        // string literal - uses double quotes
Console.WriteLine('H');            // char literal - uses single quote for ONE character
Console.WriteLine(42);             // int literal - just a number
Console.WriteLine(3.14);           // decimal literal - needs the decimal point
Console.WriteLine(true);           // bool literal - true or false
```

Output:
```output
Hello
H
42
3.14
True
```

## Why literals matter

Different data types are treated differently by C#. A string `"42"` is text and can't be used for math, but the integer `42` can. For example:

```csharp
Console.WriteLine("42" + "1");     // Text concatenation: "421"
Console.WriteLine(42 + 1);         // Math: 43
```

Understanding the difference between types helps you write correct code from the start.
