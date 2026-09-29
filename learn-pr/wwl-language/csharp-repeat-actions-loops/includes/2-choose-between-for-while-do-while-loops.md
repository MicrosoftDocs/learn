Programs become more useful when they can automate repetitive tasks. Instead of writing the same code over and over, you can use a **loop** to repeat a block of code automatically.

C# provides three loop types: `for` loops, `while` loops, and `do-while` loops. Choosing the right one depends on whether you know how many times to repeat ahead of time, and whether the loop body must run at least once.

## The for loop (known number of repetitions)

Use a `for` loop when you want to repeat an action a **known number of times**.

A `for` loop has three parts, separated by semicolons: a starting value, a condition, and an update step.

```csharp
for (int i = 0; i < 5; i++)
{
    Console.WriteLine(i);
}
```

Output:

```output
0
1
2
3
4
```

The loop starts with `i` set to 0. Before each pass, C# checks whether `i < 5`. If it's true, the loop body runs, then `i++` increases `i` by 1. Once `i` reaches 5, the condition becomes false, and the loop stops. This loop runs exactly 5 times.

## The while loop

Use a `while` loop when you want to repeat something **as long as a condition remains true**. Choose this loop when you don't know how many times you'll need to repeat the action ahead of time.

```csharp
int health = 3;

while (health > 0)
{
    Console.WriteLine($"Player is alive. Health: {health}");
    health--;
}
```

Output:

```output
Player is alive. Health: 3
Player is alive. Health: 2
Player is alive. Health: 1
```

### Avoid infinite loops

A `while` loop checks its condition before each iteration. If the condition is always true, the loop never stops. This behavior is called an **infinite loop**, and it freezes your program.

Always make sure your code updates the condition so it eventually becomes false. In the example above, `health--` subtracts 1 from `health` each time through the loop. When `health` reaches 0, the condition becomes false, and the loop stops.

## The do-while loop

Use a `do-while` loop when you need the loop body to run **at least once**, no matter what the condition is. Unlike `for` and `while`, a `do-while` loop checks its condition **after** the body runs.

```csharp
int attempts = 0;

do
{
    attempts++;
    Console.WriteLine($"Attempt number {attempts}");
}
while (attempts < 3);
```

Output:

```output
Attempt number 1
Attempt number 2
Attempt number 3
```

This pattern is useful for menus and retry prompts, where you need to show something to the user at least once before deciding whether to repeat it.

> [!TIP]
> Choose descriptive loop variable names when they represent something meaningful, like `attempts` or `health`. Reserve short names like `i` for simple counters where the meaning is obvious from context.

## Choosing the right loop

Choose a `for` loop when:

-   You know how many times you want to repeat the action.
-   You want an automatic exit after a certain number of repetitions.
-   You want a counter variable to track how many times the loop has run.

Choose a `while` loop when:

-   The total number of repetitions depends on a variable's state.
-   You're waiting for something specific to happen before stopping the loop, such as user input.
-   The loop might not need to run at all if the condition starts out false.

Choose a `do-while` loop when:

-   You need the loop body to run at least once, regardless of the condition.
-   You're validating user input and want to prompt the user at least one time before checking whether to repeat.
