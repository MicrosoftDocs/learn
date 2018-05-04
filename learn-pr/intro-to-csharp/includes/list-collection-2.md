The collection you created uses the <xref:System.Collections.Generic.List%601> type. This type stores sequences of elements. You specify the type of the elements between the angle brackets.

One important aspect of this <xref:System.Collections.Generic.List%601> type is that it can grow or shrink, enabling you to add or remove elements. Add the following code below the code you've already written:

```csharp
Console.WriteLine();
names.Add("Maria");
names.Add("Bill");
names.Remove("Ana");
foreach (var name in names)
{
    Console.WriteLine($"Hello {name.ToUpper()}!");
}
```

You've added two more names to the end of the list. You've also removed one as well.

The <xref:System.Collections.Generic.List%601> enables you to reference individual items by **index** as well. You access items using the `[` and `]` tokens. Add the following code below what you've already written and try it:

```csharp
Console.WriteLine($"My name is {names[0]}.");
Console.WriteLine($"I've added {names[2]} and {names[3]} to the list.");
```

You're not allowed to access past the end of the list. You can check how long the list is using the <xref:System.Collections.Generic.List%601.Count%2A> property. Add the following code to try it:

```csharp
Console.WriteLine($"The list has {names.Count} people in it");
```

Click **Run** again to see the results. In C#, indices start at 0, so the largest valid index is one less than the number of items in the list.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).