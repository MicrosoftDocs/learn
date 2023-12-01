The following code is one possible solution for the challenge from the previous unit.

> [!NOTE]
> The code samples in this exercise are designed based on US culture settings, where a period (`.`) is used as the decimal separator. Building and running the code with a non-US culture setting may give unexpected results that don't match the sample output. For culture settings where the decimal separator character is different (like a comma), some samples will not match expected output or may result in errors. Replacing the decimals using your local decimal separator (such as `,`) in the sample code samples can help the sample code run as expected.
> If you want to run a program using the "en-US" culture setting, add the following code to the top of your program `using System.Globalization;` and after any other `using` statements add `CultureInfo.CurrentCulture = new CultureInfo("en-US");`.

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
