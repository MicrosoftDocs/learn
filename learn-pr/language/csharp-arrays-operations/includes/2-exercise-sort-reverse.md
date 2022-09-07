Suppose you work for a logistics company. You've been asked to write code that keeps track of pallets that are filled with building supplies. That list of pallets will be reordered. How can you maintain such a list?

## Use array methods to sort elements in an array

The `Array` class contains methods that we can use to manipulate the content, arrangement, and size of an array. In this exercise, you'll write code that performs various operations on an array of pallet identifiers, which may be the start of an application to track and optimize the usage of pallets for the company.

### Step 1 - Create an array of pallets, then sort them

Add the following code to the .NET Editor:

```csharp-interactive
string[] pallets = { "B14", "A11", "B12", "A13" };

Console.WriteLine("Sorted...");
Array.Sort(pallets);
foreach (var pallet in pallets)
{
    Console.WriteLine($"-- {pallet}");
}
```

Focus on the line of code `Array.Sort(pallets);`. Here, we're using the `Sort()` method of the `Array` class to sort the items in the array alphanumerically.

When you run the code, you'll get the following output:

```output
Sorted...
-- A11
-- A13
-- B12
-- B14
```

### Step 2 - Reverse the order of the pallets

Next, add code to reverse the order of the pallets by calling the `Array.Reverse()` method. Update your code from step 1 to match the following code listing:

```csharp-interactive
string[] pallets = { "B14", "A11", "B12", "A13" };

Console.WriteLine("Sorted...");
Array.Sort(pallets);
foreach (var pallet in pallets)
{
    Console.WriteLine($"-- {pallet}");
}

Console.WriteLine("");
Console.WriteLine("Reversed...");
Array.Reverse(pallets);
foreach (var pallet in pallets)
{
    Console.WriteLine($"-- {pallet}");
}
```

Focus on the line of code `Array.Reverse(pallets);`. Here, we're using the `Reverse()` method of the `Array` class to reverse the order of items.

Now, run the code and compare the reversed list against the sorted list:

```output
Sorted...
-- A11
-- A13
-- B12
-- B14

Reversed...
-- B14
-- B12
-- A13
-- A11
```

## Recap

Here are a few important ideas that we covered in this unit:

- The `Array` class has methods that can manipulate the size and contents of an array.
- Use the `Sort()` method to manipulate the order based on the given data type of the array.
- Use the `Reverse()` method to flip the order of the elements in the array.
