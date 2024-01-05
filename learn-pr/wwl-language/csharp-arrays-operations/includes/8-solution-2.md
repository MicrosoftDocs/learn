The following solution provided is one of many possible solutions.

```csharp
string orderStream = "B123,C234,A345,C15,B177,G3003,C235,B179";
string[] items = orderStream.Split(',');
Array.Sort(items);

foreach (var item in items)
{
    if (item.Length == 4)
    {
        Console.WriteLine(item);
    }
    else
    {
        Console.WriteLine(item + "\t- Error");
    }
}

```

This code is merely "*one possible solution*." As long as your output matches the following, you succeeded.

```Output
A345
B123
B177
B179
C15     - Error
C234
C235
G3003   - Error
```

Continue to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, you should review the previous units before you continue.
