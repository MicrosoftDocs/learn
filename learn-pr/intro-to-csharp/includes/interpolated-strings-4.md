Ordinarily, when the string returned by an interpolated expression is included in a result string, it has no leading or trailing spaces. Particularly for instances in which you are working with a set of data, interpolated expressions let you specify a field width and its alignment. To see this, run the following code.

```csharp
    var inventory = new Dictionary<string, int>();
    inventory.Add("hammer, ball pein", 18);
    inventory.Add("hammer, cross pein", 5);
    inventory.Add("screwdriver, Phillips #2", 14);

    Console.WriteLine($"Inventory on {DateTime.Now:d}");
    Console.WriteLine(" ");
    Console.WriteLine($"{"Item",-25}    {"Quantity",10}");
    Console.WriteLine(" ");
    foreach (var item in inventory)
        Console.WriteLine($"{item.Key,-25}     {item.Value,10}");
```

The item names are left-aligned, and their quantities are right-aligned. You specify the alignment by adding a comma (",") after the expression and designating the field width. If the field width is a positive number, the field is right-aligned:

```text
{expression, width}
```

If the field width is a negative number, the field is left-aligned:

```text
{expression, -width}
```
Try removing the negative signs from the `{"Item",-25}` and `{item.Key,-25}` interpolated expressions and run the example again. This time, the item name is right-aligned.

You can combine a field width and a format string in a single interpolated expression. The field width comes first, followed by a colon and the format string. Try the following simple program that displays three formatted strings with defined field widths.

```csharp
Console.WriteLine($"{DateTime.Now,-20:d} Hour {DateTime.Now,-10:HH} {1063.342,15:N2} feet");
```

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).