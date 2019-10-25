The following code is one possible solution for the challenge from the previous unit.

```csharp-interactive
string orderStream = "B123,C234,A345,C15,B177,G3003,C235,B179";
string[] items = orderStream.Split(',');

foreach (var item in items)
{
    if (item.StartsWith("B"))
    {
        Console.WriteLine(item);
    }
}
```

This code is merely "*one possible solution*" because we didn't specify which technique to apply to which line of output.  However, you should have used both the `Console.WriteLine()` and `Console.Write()` methods to produce the desired output.

```output
B123
B177
B179
```

If you were successful, congratulations!  Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, maybe you should review the previous units before you continue on.  All new ideas we discuss in other modules will depend on your understanding of the ideas that were presented in this module.
