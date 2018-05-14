Another important concept to create larger programs is **loops**. You'll use loops to repeat statements that you want executed more than once. Try this code in the interactive window:

```csharp
int counter = 0;
while (counter < 10)
{
Console.WriteLine($"Hello World! The counter is {counter}");
counter++;
}
```

The `while` statement checks a condition and executes the statement following the `while`. It will repeat checking the condition and executing those statements until the condition is false.

There's one other new operator in this example. The `++` after the `counter` variable is the **increment** operator. It adds 1 to the value of counter, and stores that value in the counter variable.

> [!IMPORTANT] 
> Make sure that the `while` loop condition does switch to false as you execute the code. Otherwise, you create an **infinite loop** where your program never ends. Let's not demonstrate that, because the engine that runs your code will time out and you'll see no output from your program.

The `while` loop tests the condition before executing the code following the `while`. The `do` ... `while` loop executes the code first, and then checks the condition. It looks like this:

```csharp
int counter = 0;
do
{
Console.WriteLine($"Hello World! The counter is {counter}");
counter++;
} while (counter < 10);
```

This `do` loop and the earlier `while` loop work the same.

Let's move on to one last loop statement.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).
