The following code is one possible solution for the challenge from the previous unit.

```csharp
string[] values = { "12.3", "45", "ABC", "11", "DEF" };

decimal total = 0m;
string message = "";

foreach (var value in values)
{
    decimal number; // stores the TryParse "out" value
    if (decimal.TryParse(value, out number))
    {
        total += number;
    } else
    {
        message += value;
    }
}

Console.WriteLine($"Message: {message}");
Console.WriteLine($"Total: {total}");
```

This code is merely "*one possible solution*" because there's likely several ways to solve this challenge. The proposed solution relies on `TryParse()`, however it's possible you have another approach that works equally well. Just make sure your result matches the following output:

```Output
Message: ABCDEF
Total: 68.3
```

If you were successful, congratulations!

> [!IMPORTANT]
> If you had trouble completing this challenge, maybe you should review the previous units before you continue on.
