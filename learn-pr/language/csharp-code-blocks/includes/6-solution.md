The following code is one possible solution for the challenge from the previous unit:

```csharp-interactive
int[] numbers = { 4, 8, 15, 16, 23, 42 };
int total = 0;
bool found = false;

foreach (int number in numbers)
{
    total += number;
    if (number == 42) found = true;
}

if (found) Console.WriteLine("Set contains 42");

Console.WriteLine($"Total: {total}");
```

This code is merely *one possible solution*, because you may have added line feeds in different spots, and you may have formatted the code differently.  

The biggest changes to the problematic code included:

- Moving the `total` and `found` variables outside of the `foreach` statement
- Initializing both the `total` and `found` variables with sensible default values
- Removing the code blocks and extra line feeds from the `if` statements

No matter how you formatted the code, when you run it, you should get the following output:

```output
Set contains 42
Total: 108
```

If you were successful, congratulations! Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, you should review the previous units before you continue on. All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.
