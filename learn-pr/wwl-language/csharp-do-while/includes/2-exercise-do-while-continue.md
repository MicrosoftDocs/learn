On the surface, the `do-while` and `while` statements are yet *more* iteration statements that allow you to iterate through a code block, and thereby change the flow of execution of your code. However, once we examine how each works, we can better identify the nuances of each iteration statement and when to use them.

## What is the do-while statement?

The `do` statement executes a statement or a block of statements while a specified Boolean expression evaluates to `true`. Because that expression is evaluated after each execution of the loop, a `do-while` loop executes one or more times.

```csharp
do
{
    // This code executes at least one time
} while (true)
```

The flow of execution starts inside of the curly braces. The code executes at least once, then the Boolean expression next to the `while` keyword is evaluated. If the Boolean expression returns `true`, the code block is executed again.

By hard-coding the Boolean expression to `true`, we've created an infinite loop; a loop that will never end, at least not as it's currently written. We'd need a way to break out of the loop inside of the code block. We'll discuss this more in a bit.

### Step 1 - Write a do-while statement to break when a certain random number is generated

Let's write code that will keep generating random numbers between 1 and 10 until it generates the number 7. This could take one iteration, or could possibly take dozens of iterations.

Add the following code to the .NET Editor:

```csharp-interactive
Random random = new Random();
int current = 0;

do
{
    current = random.Next(1, 11);
    Console.WriteLine(current);
} while (current != 7);

```

Run the code. You'll likely get different results; however, the value `7` will be the last to be printed as the Boolean expression will evaluate to `true` and the flow of execution will exit the code.

```output
2
5
8
2
7
```

The key idea in this step of the exercise is that the code in the code block will execute at least once.

It's also important to notice that the code inside of the code block is influencing whether to continue iterating through the code block or not. That's a key distinguishing characteristic of the `do-while` and `while` statements. Both the `foreach` and `for` rely on factors external to the code block to determine whether the flow of execution should continue executing the code block.

### Step 2 - Write a while statement that iterates only while a random number is greater than some value

Update the code in the .NET Editor to match the following code example that uses the `while` statement without the `do` keyword:

```csharp-interactive
Random random = new Random();
int current = random.Next(1, 11);

/*
do
{
    current = random.Next(1, 11);
    Console.WriteLine(current);
} while (current != 7);
*/

while (current >= 3)
{
    Console.WriteLine(current);
    current = random.Next(1, 11);
}
Console.WriteLine($"Last number: {current}");
```

In this case, we positioned the `while` keyword and the Boolean expression before the code block. This changes the meaning of the code, and acts as a "gate" to only allow the flow of execution to enter if the Boolean expression evaluates to true.

Run the code. You'll likely get different results; however, if the `current` variable is initialized to a value less than `3`, then the Boolean expression next to the `while` statement will return false, and the code block will never execute. If the `current` variable is initialized to a value greater or equal to `3`, then the flow of execution will enter the code block. Inside the code block, the value of `current` is updated with a new random value, and the Boolean expression will be evaluated repeatedly. Once the Boolean expression returns false, the flow of execution will break from the code block and will print the last value of `current`.

```output
9
7
5
Last number: 1
```

### Step 3 - Use the continue statement to step directly to the Boolean expression

In certain cases, we want to short-circuit the remainder of the code in the code block and continue to the next iteration. We can do that using the `continue` statement.

Update the code in the .NET Editor with the following code:

```csharp-interactive
Random random = new Random();
int current = random.Next(1, 11);

do
{
    current = random.Next(1, 11);

    if (current >= 8) continue;

    Console.WriteLine(current);
} while (current != 7);

/*
while (current >= 3)
{
    Console.WriteLine(current);
    current = random.Next(1, 11);
}
Console.WriteLine($"Last number: {current}");
*/
```

The key to this step of the exercise is the following line of code:

```csharp
if (current >= 8) continue;
```

If the value of `current` is set to a random value greater or equal to `8`, then we'll skip the next line of code, which prints the value to the output window.

Run the code. Again, you'll likely get different results than what is displayed below. However, you will not get any values of `8` or greater in the output window before the code's execution ends with the value `7`.

```output
5
1
6
7
```

You'll notice in the preceding example that `continue` will skip executing the current iteration so that nothing greater than 7 is printed.

This is in contrast to the `break` keyword we learned about previously. The `break` keyword stops executing the `while` loop entirely, and the execution path moves on with the remainder of the code logic.

## Recap

There are a few important ideas you should take away from this unit:

- The `do-while` statement iterates through a code block at least once, and may continue to iterate based on a Boolean expression. The evaluation of the Boolean expression usually depends on some value generated or retrieved inside of the code block.
- The `while` statement evaluates a Boolean expression first, and continues to iterate through the code block as long as the Boolean expression evaluates to `true`.
- The `continue` keyword to step immediately to the Boolean expression.
