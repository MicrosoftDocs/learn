Although loops are designed to repeat a block of code, sometimes you need more control over how the loop executes. For example, you might want to exit a loop early, or skip certain iterations without stopping the loop entirely.

C# gives you precise control over loop execution with two statements: `break` and `continue`.

## Break: exit the loop early

The `break` statement immediately ends the loop, regardless of its condition. It tells C# to stop executing the loop and move on to the next line of code after the loop block.

```csharp
for (int count = 0; count < 10; count++)
{
    if (count == 5)
    {
        break;
    }
    Console.WriteLine(count);
}

Console.WriteLine("Loop ended.");
```

Output:

```output
0
1
2
3
4
Loop ended.
```

Line order matters. The `break` statement must come **after** the condition you want to check, but **before** the code you want to skip. In the example above, the loop stops before printing 5.

## Continue: skip to the next iteration

The `continue` statement tells C# to skip the rest of the code below it and immediately jump to the next iteration of the loop. For example, you might want to skip a certain number in a sequence.

```csharp
for (int count = 0; count < 6; count++)
{
    if (count == 3)
    {
        continue;
    }
    Console.WriteLine(count);
}
```

Output:

```output
0
1
2
4
5
```

In this example, the `continue` statement forces C# to skip the `Console.WriteLine()` line below it and jump to the next iteration of the loop. Use this statement when you want to ignore certain iterations without stopping the entire loop.

## Managing while loops with break

Both keywords work the same way in `while` loops. Combining a `while` loop with a `break` statement is a common pattern for handling unpredictable user input.

For example, you might want to keep running code until the user types a specific word to exit.

```csharp
while (true)
{
    Console.Write("Type 'exit' to stop the loop: ");
    string userInput = Console.ReadLine();

    if (userInput.ToLower() == "exit")
    {
        break;
    }

    Console.WriteLine($"You entered: {userInput}");
}

Console.WriteLine("Goodbye!");
```

`while (true)` creates a loop that runs forever. The `break` statement is the only way to exit it. This pattern lets you prompt the user repeatedly and exit gracefully when they explicitly want to stop.

## Using continue in while loops

Using `continue` in a `while` loop requires careful attention to the loop's condition. If you use `continue` without updating the condition first, you can create an infinite loop.

```csharp
int currentSlot = 0;

while (currentSlot < 5)
{
    currentSlot++; // Crucial: the update happens before the continue check

    if (currentSlot == 3)
    {
        Console.WriteLine($"Skipping item slot {currentSlot}.");
        continue;
    }

    Console.WriteLine($"Successfully processed item in slot {currentSlot}.");
}

Console.WriteLine("Inventory scan complete!");
```

In this example, the loop increments `currentSlot` at the start of each iteration. When it reaches 3, the `continue` statement skips the processing line and jumps back to the loop's condition check. If the increment line came after the `continue` statement, the loop would never reach 5, and it would run forever.

When you use `continue` in a `while` loop, always update your condition before the `continue` statement to avoid creating an infinite loop.

> [!TIP]
> Use break and continue sparingly. Overusing them can make a loop's flow harder to follow. When possible, rewrite the loop's condition instead of adding another break or continue.
