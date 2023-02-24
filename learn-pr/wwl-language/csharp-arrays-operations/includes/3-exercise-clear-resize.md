As we continue building a pallet tracker for our logistics company, suppose we also need track new pallets and remove old pallets from tracking. How can we accomplish this?

## Use array methods to clear and resize an array

The `Array.Clear()` method allows us to remove the contents of specific elements in our array, and the `Array.Resize()` method adds or removes elements from our array.

### Step 1 - Clear items from the array

Comment out or delete the code from the previous unit in the .NET Editor, then add the following code listing:

```csharp-interactive
string[] pallets = { "B14", "A11", "B12", "A13" };
Console.WriteLine("");

Array.Clear(pallets, 0, 2);
Console.WriteLine($"Clearing 2 ... count: {pallets.Length}");
foreach (var pallet in pallets)
{
    Console.WriteLine($"-- {pallet}");
}
```

Focus on the line of code `Array.Clear(pallets, 0, 2);`. Here, we're using the `Array.Clear()` method to clear the values stored in the elements of the `pallets` array starting at index `0` and clearing `2` elements.

When you run the code, you'll notice that the values stored in the first two elements of the array have been cleared out. As we can tell from the `Length` property and the `foreach` statement, the elements still exist, but they're now empty.

```output
Clearing 2 ... count: 4
-- 
-- 
-- B12
-- A13
```

## Empty string versus null

When you use `Array.Clear()`, the elements that were cleared no longer reference a string in memory. In fact, the element points to nothing at all. This is an important distinction that can be difficult to grasp at first.

What if we attempted to retrieve the value of an element that was affected by the `Array.Clear()` method? Could we do it?

### Step 2 - Access the value of a cleared element

We'll take two passes at accessing the value of a cleared element to see how the C# compiler works with a null value.

Add two lines of code before and after calling the `Array.Clear()` method:

```
Console.WriteLine($"Before: {pallets[0]}");
Array.Clear(pallets, 0, 2);
Console.WriteLine($"After: {pallets[0]}");
```

Make sure your code matches the following code listing:

```csharp-interactive
string[] pallets = { "B14", "A11", "B12", "A13" };
Console.WriteLine("");

Console.WriteLine($"Before: {pallets[0]}");
Array.Clear(pallets, 0, 2);
Console.WriteLine($"After: {pallets[0]}");

Console.WriteLine($"Clearing 2 ... count: {pallets.Length}");
foreach (var pallet in pallets)
{
    Console.WriteLine($"-- {pallet}");
}
```

When you run the code, you should get the following output:

```output

Before: B14
After:
Clearing 2 ... count: 4
--
--
-- B12
-- A13
```

If you focus on the line of output `After: `, you might think that the value stored in `pallets[0]` is an empty string. However, the C# Compiler implicitly converts the null value to an empty string for presentation.

### Step 3 - Call a string helper method on a cleared element

To prove that the value stored in `pallets[0]` after being cleared is null, we'll modify the code example to call the `ToLower()` method on `pallets[0]`. If it's a string, it should work fine, but if it's null, it should cause the code to throw an exception.

Update your code to add the call to the `ToLower()` method on each time we attempt to write `pallets[0]` to the console:

```csharp
Console.WriteLine($"Before: {pallets[0].ToLower()}");
Array.Clear(pallets, 0, 2);
Console.WriteLine($"After: {pallets[0].ToLower()}");
```

Make sure your code matches the following code listing:

```csharp-interactive
string[] pallets = { "B14", "A11", "B12", "A13" };
Console.WriteLine("");

Console.WriteLine($"Before: {pallets[0].ToLower()}");
Array.Clear(pallets, 0, 2);
Console.WriteLine($"After: {pallets[0].ToLower()}");

Console.WriteLine($"Clearing 2 ... count: {pallets.Length}");
foreach (var pallet in pallets)
{
    Console.WriteLine($"-- {pallet}");
}
```

This time, when you run the code, you'll get a large error message. If you parse through the text, you'll find the following message:

```output
System.NullReferenceException: Object reference not set to an instance of an object.
```

The compiler throws this exception because we attempted to call the method on the contents of the `pallets[0]` element before the C# Compiler had a chance to implicitly convert null to an empty string.

The moral of the story is that `Array.Clear()` will remove an array element's reference to a value if one exists. To fix this, we might check for null before attempt to print the value.

To accomplish this, we can add an `if` statement before accessing an array element that is potentially null.

```csharp
if (pallets[0] != null)
    Console.WriteLine($"After: {pallets[0].ToLower()}");
```

### Step 4 - Resize the array to add more elements

Next, rework the code listing from Step 1 to include additional code to resize the array. When complete, your code should match the following code listing:

```csharp-interactive
string[] pallets = { "B14", "A11", "B12", "A13" };
Console.WriteLine("");

Array.Clear(pallets, 0, 2);
Console.WriteLine($"Clearing 2 ... count: {pallets.Length}");
foreach (var pallet in pallets)
{
    Console.WriteLine($"-- {pallet}");
}

Console.WriteLine("");
Array.Resize(ref pallets, 6);
Console.WriteLine($"Resizing 6 ... count: {pallets.Length}");

pallets[4] = "C01";
pallets[5] = "C02";

foreach (var pallet in pallets)
{
    Console.WriteLine($"-- {pallet}");
}
```

Focus on the line `Array.Resize(ref pallets, 6);`. Here, we're calling the `Resize()` method passing in the `pallets` array by reference, using the `ref` keyword. In some cases, methods require that you pass arguments by value (the default) or by reference (using the ref keyword). The reasons this is necessary would require significant explanation of how objects are managed in .NET; unfortunately, that's beyond the scope of this module. When in doubt, we recommend looking at Intellisense or Microsoft Learn for examples on how to properly call a given method.

In this case, we're resizing the `pallets` array from four elements to `6`. The new elements are added at the end of the current elements. The two new elements will be null until we assign a value to them.

When you run the code, you should get the following output:

```output
Clearing 2 ... count: 4
-- 
-- 
-- B12
-- A13

Resizing 6 ... count: 6
-- 
-- 
-- B12
-- A13
-- C01
-- C02
```

### Step 5 - Resize the array to remove elements

Conversely, we can remove array elements using `Array.Resize()`:

```csharp-interactive
string[] pallets = { "B14", "A11", "B12", "A13" };
Console.WriteLine("");

Array.Clear(pallets, 0, 2);
Console.WriteLine($"Clearing 2 ... count: {pallets.Length}");
foreach (var pallet in pallets)
{
    Console.WriteLine($"-- {pallet}");
}

Console.WriteLine("");
Array.Resize(ref pallets, 6);
Console.WriteLine($"Resizing 6 ... count: {pallets.Length}");

pallets[4] = "C01";
pallets[5] = "C02";

foreach (var pallet in pallets)
{
    Console.WriteLine($"-- {pallet}");
}

Console.WriteLine("");
Array.Resize(ref pallets, 3);
Console.WriteLine($"Resizing 3 ... count: {pallets.Length}");

foreach (var pallet in pallets)
{
    Console.WriteLine($"-- {pallet}");
}
```

When you run the code, you should get the following output:

```output
Clearing 2 ... count: 4
--
--
-- B12
-- A13

Resizing 6 ... count: 6
--
--
-- B12
-- A13
-- C01
-- C02

Resizing 3 ... count: 3
--
--
-- B12
```

Notice that calling `Array.Resize()` didn't eliminate the first two null elements. Rather, it removed the last three elements, despite the fact that they contained string values.

### Can we remove null elements from an array?

If the `Array.Resize()` method doesn't remove empty elements from an array, is there another helper method that will do this automatically? No. The best way to accomplish this would be to count the number of non-null elements by iterating through each item and increment a variable (a counter). Next, you'd create a second array that's the size of the counter variable. Finally, you'd loop through each element in the original array and copy non-null values into the new array.

## Recap

Here are a few important ideas that we covered in this unit:

- Use the `Clear()` method to empty the values out of elements in the array.
- Use the `Resize()` method to change the number of elements in the array, removing or adding elements from the end of the array.
- New array elements and cleared elements are null, meaning they don't point to a value in memory.
