The C# language defines the precedence of different mathematics operations
with rules consistent with the rules you learned in mathematics.
Multiplication and division take precedence over addition and subtraction.
Explore that by running the following code in the interactive window:

```csharp
int a = 5;
int b = 4;
int c = 2;
int d = a + b * c;
Console.WriteLine(d);
```

The output demonstrates that the multiplication is performed before the addition.

You can force a different order of operation by adding parentheses around
the operation or operations you want performed first:

```csharp
int a = 5;
int b = 4;
int c = 2;
int d = (a  + b) * c;
Console.WriteLine(d);
```

Explore more by combining many different operations. Replace the fourth line above with something like this:

```csharp
int d = (a + b) - 6 * c + (12 * 4) / 3 + 12;
```

You may have noticed an interesting behavior for integers. Integer
division always produces an integer result, even when you'd expect
the result to include a decimal or fractional portion.

If you haven't seen this behavior, try the following:

```csharp
int a = 7;
int b = 4;
int c = 3;
int d = (a  + b) / c;
Console.WriteLine(d);
```

Click **Run** again to see the results.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).
