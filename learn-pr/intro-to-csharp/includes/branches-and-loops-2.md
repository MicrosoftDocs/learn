
To execute different code in both the true and false branches, you
create an `else` branch that executes when the condition is false. Try this:

```csharp
int a = 5;
int b = 3;
if (a + b > 10)
    Console.WriteLine("The answer is greater than 10");
else
    Console.WriteLine("The answer is not greater than 10");
```

The statement following the `else` keyword executes only when the condition being tested is `false`. Combining `if` and `else` with boolean conditions provides all the power you need.

> [!IMPORTANT]
> The indentation under the `if` and `else` statements is for human readers.
> The C# language doesn't treat indentation or whitespace as significant.
> The statement following the `if` or `else` keyword will be executed based
> on the condition. All the samples in this quickstart follow a common
> practice to indent lines based on the control flow of statements.

Because indentation is not significant, you need to use `{` and `}` to
indicate when you want more than one statement to be part of the block
that executes conditionally. C# programmers typically use those braces
on all `if` and `else` clauses. The following example is the same as what you
just created. Try it.

```csharp
int a = 5;
int b = 3;
if (a + b > 10)
{
    Console.WriteLine("The answer is greater than 10");
}
else
{
    Console.WriteLine("The answer is not greater than 10");
}
```

> [!TIP]
> Through the rest of this quickstart, the code samples all include the braces,
> following accepted practices.

You can test more complicated conditions:

```csharp
int a = 5;
int b = 3;
int c = 4;
if ((a + b + c > 10) && (a > b))
{
    Console.WriteLine("The answer is greater than 10");
    Console.WriteLine("And the first number is greater than the second");
}
else
{
    Console.WriteLine("The answer is not greater than 10");
    Console.WriteLine("Or the first number is not greater than the second");
}
```

The `&&` represents "and". It means both conditions must be true to execute
the statement in the true branch.  These examples also show that you can have multiple
statements in each conditional branch, provided you enclose them in `{` and `}`.

You can also use  `||` to represent "or":

```csharp
int a = 5;
int b = 3;
int c = 4;
if ((a + b + c > 10) || (a > b))
{
    Console.WriteLine("The answer is greater than 10");
    Console.WriteLine("Or the first number is greater than the second");
}
else
{
    Console.WriteLine("The answer is not greater than 10");
    Console.WriteLine("And the first number is not greater than the second");
}
```

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).