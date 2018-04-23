Run the following code in the interactive window. To do that, type the following code block in the interactive window and click the **Run** button:

```csharp
int a = 5;
int b = 6;
if (a + b > 10)
    Console.WriteLine("The answer is greater than 10.");
```

Modify the declaration of `b` so that the sum is less than 10:

```csharp
int b = 3;
```

Click the **Run** button again. Because the answer is less than 10, nothing is printed. The **condition** you're testing is false. You don't have any code to execute because you've only
written one of the possible branches for an `if` statement: the true branch.

> [!TIP]
> As you explore C# (or any programming language), you'll
> make mistakes when you write code. The **compiler** will
> find those errors and report them to you. When the output
> contains error messages, look closely at the example code,
> and the code in the interactive window to see what to fix.
> That exercise will help you learn the structure of C# code.

This first sample shows the power of `if` and boolean types. A *boolean* is a variable that can have one of two values: `true` or `false`. C# defines a special type, `bool` for boolean variables. The `if` statement checks the value of a `bool`. When the value is `true`, the statement following the `if` executes. Otherwise, it is skipped.

This process of checking conditions and executing statements based on those conditions is very powerful. Let's explore more.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).