Another common loop statement that you'll see in C# code is the
`for` loop. Try this code in the interactive window:

```csharp
for(int counter = 0; counter < 10; counter++)
{
    Console.WriteLine($"Hello World! The counter is {counter}");
}
```

This does the same work as the `while` loop and the `do` loop you've
already used. The `for` statement has three parts that control
how it works.

The first part is the **for initializer**: `for counter = 0;` declares
that `counter` is the loop variable, and sets its initial value to `0`.

The middle part is the **for condition**: `counter < 10` declares that this
`for` loop continues to execute as long as the value of counter is less than 10.

The final part is the **for iterator**: `counter++` specifies how to modify the loop
variable after executing the block following the `for` statement. Here, it specifies
that `counter` should be incremented by 1 each time the block executes.

Experiment with these yourself. Try each of the following:

- Change the initializer to start at a different value.
- Change the condition to stop at a different value.

When you're done, let's move on to write some code yourself to
use what you've learned.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).