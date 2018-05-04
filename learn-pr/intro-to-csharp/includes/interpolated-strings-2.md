In the previous quickstart, you used an interpolated string to insert one string inside of another. An interpolated string expression can be any data type, though. Let's try an interpolated string that has values of multiple data types.

The following example includes interpolated expressions with a `Vegetable` object, a member of the `Unit` enumeration, a <xref:System.DateTime> value, and a <xref:System.Decimal> value. Run it in the interactive window.

```csharp
public class Vegetable
{
    public Vegetable(string name) => Name = name;

    public string Name { get; }

    public override string ToString() => Name;
}

public class Example
{
    public enum Unit { item, pound, ounce, dozen };

    public static void Main()
    {
        var item = new Vegetable("eggplant");
        var date = DateTime.Now;
        var price = 1.99m;
        var unit = Unit.item;
        Console.WriteLine($"On {date}, the price of {item} was {price} per {unit}.");
    }
}
```

Note that one of the interpolated expressions includes the `item` object in the result string that's displayed to the console, and in this case the string "eggplant" is inserted into the result string. That's because, when the type of an interpolated expression is not a string, the C# compiler does the following:

- If the interpolated expression is `null`, the interpolated expression returns an empty string ("", or <xref:System.String.Empty?displayProperty=nameWithType>).

- If the interpolated expression is not `null`, the `ToString` method of the type of the interpolated expression is called. You can test this by commenting out the definition of the `Vegetable.ToString` method in the example by putting a comment symbol (`//`) in front of it. In the output, the string "eggplant" is replaced by the fully qualified type name (the namespace defined by the C# REPL along with the type name), which is the default behavior of the <xref:System.Object.ToString?displayProperty=nameWithType> method.

In the output from this example, the date is too precise (the price of eggplant does not vary by the second), and the price value doesn't indicate a unit of currency. In the next step, you'll learn how to fix those issues by controlling the format of strings returned by interpolated expressions.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).