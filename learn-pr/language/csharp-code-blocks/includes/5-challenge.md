Code challenges throughout these modules will reinforce what you've learned and help you gain some confidence before continuing on.

## Fix this code

Use what you've learned in this module to fix this poorly written code. There are many improvements that you can make. Good luck!

### Step 1: Delete all of the code in the .NET Editor from the earlier exercise.

Select all of the code in the .NET Editor, then select the `del` or `backspace` key to delete it.

### Step 2: Rewrite and fix the problematic code in the .NET Editor

Retype the following code, or use the **Run** button or the **Copy** button to add the code to the .NET Editor.

```csharp-interactive
int[] numbers = { 4, 8, 15, 16, 23, 42 };
foreach (int number in numbers)
{
    int total;
    total += number;
    if (number == 42)
    {
       bool found = true;
    }
}
if (found) 
{
    Console.WriteLine("Set contains 42");
}
Console.WriteLine($"Total: {total}");
```

Once you get it working, you should get the following output when you run the code:

```output
Set contains 42
Total: 108
```

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.
