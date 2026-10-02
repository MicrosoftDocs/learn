Once your program has more than a handful of methods, keeping everything in a single file becomes hard to navigate. C# helps you organize code with **namespaces**, and reuse code from other files and libraries with the `using` directive.

## Using code from the .NET class library

Many of the methods you've already used, like `Console.WriteLine()`, come from the .NET Class Library, organized into namespaces. The `System` namespace, for example, contains fundamental types like `Console` and `Random`.

Some namespaces are available without an explicit `using` directive, but others need to be brought in before you can use their types.

```csharp
using System.Text;

StringBuilder builder = new StringBuilder();
builder.Append("Hello, ");
builder.Append("world!");
Console.WriteLine(builder.ToString()); // Output: Hello, world!
```

The `using System.Text;` directive brings the `StringBuilder` type into scope, so you can refer to it by its short name instead of its full name, `System.Text.StringBuilder`.

## Organizing your own code with namespaces

A **namespace** groups related classes and methods under a shared name, which helps you avoid naming collisions as your project grows.

```csharp
namespace MathUtilities
{
    class Calculator
    {
        public static int Add(int a, int b)
        {
            return a + b;
        }
    }
}
```

From another file in the same project, you bring that namespace into scope with `using`, then call its method through the class name.

```csharp
using MathUtilities;

Console.WriteLine(Calculator.Add(2, 3)); // Output: 5
```

## Using an alias

If a namespace or type name is long, or clashes with another name, you can give it a shorter alias with `using` and `=`.

```csharp
using Calc = MathUtilities.Calculator;

Console.WriteLine(Calc.Add(2, 3)); // Output: 5
```

## Why namespaces matter

-   They keep related code grouped under one name, so large projects stay organized.
-   They prevent naming collisions between your code and code from other libraries.
-   They make it clear where a type or method comes from, just by reading a file's using directives.
