Run the following code in the interactive window. To do that, type the following code block in the interactive window (replace "<name>" with your name) and click the **Run** button:

```csharp
var names = new List<string> { "<name>", "Ana", "Felipe" };
foreach (var name in names)
{
    Console.WriteLine($"Hello {name.ToUpper()}!");
}
```

You've just created a list of strings, added three names to that list, and printed out the names in all CAPS. You're using concepts that you've learned in earlier quickstarts to loop through the list. The code to display names makes use of the string interpolation feature. When you precede a `string` with the `$` character, you can embed C# code in the string declaration. The actual string replaces that C# code with the value it generates. In this example, it replaces the `{name.ToUpper()}` with each name, converted to capital letters, because you called the <xref:System.String.ToUpper%2A> method.
Let's keep exploring.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).