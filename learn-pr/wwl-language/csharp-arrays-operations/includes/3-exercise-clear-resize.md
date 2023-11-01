As you continue building a pallet tracker for the logistics company, suppose you also need track new pallets and remove old pallets from tracking. How can you accomplish creating tracking functionality for adding and removing pallets?

## Use array methods to clear and resize an array

The `Array.Clear()` method allows you to remove the contents of specific elements in your array, and the `Array.Resize()` method adds or removes elements from your array.

1. Delete or use the line comment operator `//` to comment out all of the code from the previous exercises.

1. Update your code in the Visual Studio Code Editor as follows:

    ```csharp
    string[] pallets = { "B14", "A11", "B12", "A13" };
    Console.WriteLine("");

    Array.Clear(pallets, 0, 2);
    Console.WriteLine($"Clearing 2 ... count: {pallets.Length}");
    foreach (var pallet in pallets)
    {
        Console.WriteLine($"-- {pallet}");
    }

    ```

1. Take a minute to focus on the line of code `Array.Clear(pallets, 0, 2);`.

    Here you're using the `Array.Clear()` method to clear the values stored in the elements of the `pallets` array starting at index `0` and clearing `2` elements.

1. On the Visual Studio Code **File** menu, select **Save**.

    The Program.cs file must be saved before building or running the code.

1. In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

    A Terminal panel should open, and should include a command prompt showing that the Terminal is open to your TestProject folder location.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.

    > [!NOTE]
    > If you see a message saying "Couldn't find a project to run", ensure that the Terminal command prompt displays the expected TestProject folder location. For example: `C:\Users\someuser\Desktop\csharpprojects\TestProject>`

    When you run the code, you'll see that the values stored in the first two elements of the array have been cleared out. In the `Length` property and the `foreach` statement, the elements still exist, but they're now empty.

    ```Output
    Clearing 2 ... count: 4
    -- 
    -- 
    -- B12
    -- A13

    ```

## Empty string versus null

When you use `Array.Clear()`, the elements that were cleared no longer reference a string in memory. In fact, the element points to nothing at all. pointing to nothing is an important concept that can be difficult to grasp at first.

What if you attempt to retrieve the value of an element that was affected by the `Array.Clear()` method, could you do it?

### Access the value of a cleared element

Two approaches are needed to determine the value of a cleared element to see how the C# compiler works with a null value.

1. Insert new code lines around the `Array.Clear(pallets, 0, 2);` code line as follows:

    ```csharp
    Console.WriteLine($"Before: {pallets[0]}");
    Array.Clear(pallets, 0, 2);
    Console.WriteLine($"After: {pallets[0]}");

    ```

1. Verify your code should match the following code listing:

    ```csharp
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

1. Save your code file, and then use Visual Studio Code to run your code.

    You should see the following output:

    ```Output
    Before: B14
    After:
    Clearing 2 ... count: 4
    --
    --
    -- B12
    -- A13

    ```

If you focus on the line of output `After: `, you may think that the value stored in `pallets[0]` is an empty string. However, the C# Compiler implicitly converts the null value to an empty string for presentation.

### Call a string helper method on a cleared element

To prove that the value stored in `pallets[0]` after being cleared is null, you'll modify the code example to call the `ToLower()` method on `pallets[0]`. If it's a string, it should work fine. But if it's null, it should cause the code to throw an exception.

1. To call the `ToLower()` method each time you attempt to write `pallets[0]` to the console, update your code as follows::

    ```csharp
    Console.WriteLine($"Before: {pallets[0].ToLower()}");
    Array.Clear(pallets, 0, 2);
    Console.WriteLine($"After: {pallets[0].ToLower()}");
    ```

1. Make sure your code matches the following code listing:

    ```csharp
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

1. Save your code file, and then use Visual Studio Code to run your code. This time, when you run the code, you'll see a large error message. If you parse through the text, you'll see the following message:

    ```Output
    System.NullReferenceException: Object reference not set to an instance of an object.

    ```

    This exception is thrown because the attempt to call the method on the contents of the `pallets[0]` element happens before the C# Compiler has a chance to implicitly convert null to an empty string.

    The moral of the story is that `Array.Clear()` will remove an array element's reference to a value if one exists. To fix this, you might check for null before attempt to print the value.

    To avoid the error, add an `if` statement before accessing an array element that is potentially null.

```csharp
if (pallets[0] != null)
    Console.WriteLine($"After: {pallets[0].ToLower()}");
```

### Resize the array to add more elements

1. Next, rework the code listing from Step 1 to include code to resize the array. When complete, your code should match the following code listing:

    ```csharp
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

1. Take a few minutes to focus on the line `Array.Resize(ref pallets, 6);`. 

    Here, you're calling the `Resize()` method passing in the `pallets` array by reference, using the `ref` keyword. In some cases, methods require you pass arguments by value (the default) or by reference (using the ref keyword). The reasons why this is necessary requires a long and complicated explanation about of how objects are managed in .NET. Unfortunately, that is beyond the scope of this module. When in doubt, you're recommended to look at Intellisense or Microsoft Docs for examples on how to properly call a given method.

    In this case, you're resizing the `pallets` array from four elements to `6`. The new elements are added at the end of the current elements. The two new elements will be null until you assign a value to them.

1. Save your code file, and then use Visual Studio Code to run your code. When you run the code, you should see the following output.

    ```Output
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

### Resize the array to remove elements

Conversely, you can remove array elements using `Array.Resize()`.

1. Update your code in the Visual Studio Code Editor as follows:

    ```csharp
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

1. Save your code file, and then use Visual Studio Code to run your code. When you run the code, you should see the following output:

    ```Output
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

    Notice that calling `Array.Resize()` didn't eliminate the first two null elements. Rather, it removed the last three elements. Notably, last three elements were removed even though they contained string values.

### Can you remove null elements from an array?

If the `Array.Resize()` method doesn't remove empty elements from an array, is there another helper method that will do the job automatically? No. The best way to empty elements from an array would be to count the number of non-null elements by iterating through each item and increment a variable (a counter). Next, you would create a second array that is the size of the counter variable. Finally, you would loop through each element in the original array and copy non-null values into the new array.

## Recap

Here's a few important ideas that you covered in this unit:

- Use the `Clear()` method to empty the values out of elements in the array.
- Use the `Resize()` method to change the number of elements in the array, removing or adding elements from the end of the array.
- New array elements and cleared elements are null, meaning they don't point to a value in memory.