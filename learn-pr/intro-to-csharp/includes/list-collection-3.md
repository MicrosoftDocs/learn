Our samples use relatively small lists, but your applications may often create lists with many more elements, sometimes numbering in the thousands. To find elements in these larger collections, you need to search the list for different items. The <xref:System.Collections.Generic.List%601.IndexOf%2A> method searches for an item and returns the index of the item. Try this to see how it works.  Add the following code below what you've written so far:

```csharp
var index = names.IndexOf("Felipe");
if (index != -1)
    Console.WriteLine($"The name {names[index]} is at index {index}");
var notFound = names.IndexOf("Not Found");
    Console.WriteLine($"When an item is not found, IndexOf returns {notFound}");
```

You may not know if an item is in the list, so you should always check the index returned by <xref:System.Collections.Generic.List%601.IndexOf%2A>. If it is -1, the item was not found.
The items in your list can be sorted as well. The <xref:System.Collections.Generic.List%601.Sort%2A> method sorts all the items in the list in their normal order (alphabetically in the case of strings). Add this code and run again:

```csharp
names.Sort();
foreach (var name in names)
{
    Console.WriteLine($"Hello {name.ToUpper()}!");
}
```

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).