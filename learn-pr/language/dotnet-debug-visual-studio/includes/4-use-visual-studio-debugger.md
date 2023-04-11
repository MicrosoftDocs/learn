It's time to put your newly acquired debugging knowledge into practice. It's your first day on the job, and it's time to put your .NET debugging skills to work by fixing a bug in the company's flagship product, a Fibonacci calculator.

## Create a sample .NET project for debugging

To set up Visual Studio for .NET debugging, we'll first need a .NET project. Visual Studio provides plenty of starter templates that make creating a new project easy.

1. In Visual Studio, select **File** > **New** > **Project**.

1. In the **Create a new Project** dialog, select **Console App** and choose **Next**.

1. Name the project *DotNetDebugging*, and choose the location where you'd like to save. Leave the other values at their defaults, then select **Next**.

1. Click **Create** on the final screen.

Visual Studio will create the Console project for us using the template we selected. Once the project loads, open **Program.cs** by selecting it.

## Add the Fibonacci program logic

Our current project writes a "Hello World" message to the console, which doesn't give us much to debug. Instead, you'll use a short .NET program to compute the *N*<sup>th</sup> number of the Fibonacci sequence.

The Fibonacci sequence is a suite of numbers that starts with the numbers 0 and 1, with every other following number being the sum of the two previous ones. The sequence continues as shown here:

```text
0, 1, 1, 2, 3, 5, 8, 13, 21...
```

The sample code below contains a bug, so let's use Visual Studio's debugging tools to diagnose and solve the issue.

1. Replace the contents of **Program.cs** with the following code:

```csharp
int result = Fibonacci(5);
Console.WriteLine(result);

static int Fibonacci(int n)
{
    int n1 = 0;
    int n2 = 1;
    int sum;

    for (int i = 2; i < n; i++)
    {
        sum = n1 + n2;
        n1 = n2;
        n2 = sum;
    }

    return n == 0 ? n1 : n2;
}
```

> [!NOTE]
> This code contains an error, which we'll debug later in this module. We don't recommend that you use it in any mission-critical Fibonacci applications until we get that bug fixed.

2. Save the file with **Ctrl+S** for Windows and Linux. Select **Cmd+S** for Mac.

1. Let's get a look at how the updated code works before we debug it. Run the program by pressing the green start button at the top of Visual Studio.

1. At the end of the debug console output, you'll see the program writes 3 to the console and then exits with code 0. Usually a program exit code of 0 indicates that the program ran and exited without crashing. However, there's a difference between crashing and returning the correct value. 

:::image type="content" source="../media/visual-studio-output.png" alt-text="Terminal window with modified program output.":::

In this case, we asked the program to calculate the fifth value of the Fibonacci sequence:

```text
0, 1, 1, 2, 3, 5, 8, 13, 21...
```

The fifth value in this list is 5, but our program returned 3. Let's use the debugger to diagnose and fix this error.

### Use breakpoints and step-by-step execution

1. Add a breakpoint by clicking in the left margin at line **1** on `int result = Fibonacci(5);`.

1. Start debugging again. The program begins to execute. It breaks (pauses execution) on line 1 because of the breakpoint you set. Use the debugger controls to step into the `Fibonacci()` function.

   :::image source="../media/visual-studio-analyze.png" alt-text="Screenshot of the Step into button.":::

### Check the variables state

Now, take some time to inspect the different variables' values by using the **Locals** window.

:::image source="../media/visual-studio-locals.png" alt-text="Screenshot of the Locals panel.":::

- What is the value shown for the `n` parameter?
- At the beginning of the function's execution, what are the values for the local variables `n1`, `n2`, and `sum`?

1. Next, we'll advance into the `for` loop by using the **Step Over** debugger control.

   :::image source="../media/visual-studio-stepover.png" alt-text="Screenshot of the Step over button.":::

1. Continue advancing until you hit the first line inside of the `for` loop, on the line that reads:

    ```csharp
    sum = n1 + n2;
    ```

> [!NOTE]
> You might have noticed that to move through the `for(...) {}` line requires multiple steps in commands. This situation occurs because there are multiple *statements* on this line. When you step, you move on to the next statement in your code. Usually, there's one statement per line. If that's not the case, you need multiple steps to move on to the next line.

## Think about the code

An important part of debugging is to stop and take some informed guesses about what you think portions of the code (both functions and blocks, such as loops) are trying to do. It's okay if you're not sure, that's part of the debugging process. But being actively engaged in the debugging process will help you locate bugs a lot more quickly.

Before we dig in further, let's remember that the Fibonacci sequence is a series of numbers that starts with the numbers 0 and 1, with every other following number being the sum of the two previous ones.

That means that:

```
Fibonacci(0) = 0
Fibonacci(1) = 1
Fibonacci(2) = 1 (0 + 1)
Fibonacci(3) = 2 (1 + 1)
Fibonacci(4) = 3 (1 + 2)
Fibonacci(5) = 5 (2 + 3)
```

Understanding that definition and looking at this `for` loop, we can deduce that:

  1. The loop counts from 2 to `n` (the Fibonacci sequence number we're looking for).
  1. If `n` is less than 2, the loop will never run. The `return` statement at the end of the function will return 0 if `n` is 0, and 1 if `n` is 1 or 2. These are the zero, first, and second values in the Fibonacci series, by definition.
  1. The more interesting case is when `n` is greater than 2. In those cases, the current value is defined as the sum of the previous two values. So for this loop, `n1` and `n2` are the previous two values, and `sum` is the value for the current iteration. Because of that, each time we figure out the sum of the previous two values and set it to `sum`, we update our `n1` and `n2` values.

Okay, we don't need to overthink it past that. We can lean on our debugger a bit. But it's worth thinking about the code to see if it does what we expect and be more informed when it doesn't.
  
## Locate the bug with breakpoints

Stepping through your code can be helpful but tedious. Especially when you're working with loops or other code that's called repeatedly. Rather than stepping through the loop over and over, we can set a new breakpoint on the first line of the loop.

It's important to be strategic about where we put our breakpoints. We're especially interested in the value of `sum`, since it represents the current maximum Fibonacci value. Because of that, let's put our breakpoint on the line *after* `sum` is set.

1. Add a second breakpoint on line 14.

   :::image source="../media/visual-studio-locate-bug.png" alt-text="Screenshot showing a second breakpoint being set.":::

   > [!NOTE]
   > If you notice that you keep running your code and then stepping a line or two, you can easily update your breakpoints to more efficient lines.

1. Now that we have a good breakpoint set in the loop, use the **Continue** debugger control to advance until the breakpoint is hit. Looking at our local variables, we see the following lines:

    ```text
    n [int]: 5
    n1 [int]: 0
    n2 [int]: 1
    sum [int]: 1
    i [int]: 2
    ```

    These lines all seem correct. The first time through the loop, the `sum` of the previous two values is 1. Rather than stepping through line by line, we can take advantage of our breakpoints to jump to the next time through the loop.

1. Select **Continue** to continue program flow until the next breakpoint is hit, which will be on the next pass through the loop.

    > [!NOTE]
    > Don't be too worried about skipping over the bug when you use **Continue**. You should expect that you'll often debug through the code several times to find the issue. It's often faster to run through it a few times as opposed to being too cautious when you step through.

    This time, we see the following values:

    ```text
    n [int]: 5
    n1 [int]: 1
    n2 [int]: 1
    sum [int]: 2
    i [int]: 3
    ```

    Do these values still make sense? It seems like they do. For the third Fibonacci number, we're expecting to see our `sum` equal to 2, and it is.

1. Select **Continue** to loop it again.

    ```text
    n [int]: 5
    n1 [int]: 1
    n2 [int]: 2
    sum [int]: 3
    i [int]: 4
    ```

    The result is correct. The fourth value in the series is expected to be 3.

1. At this point, you might start wondering if the code was correct all along and you imagined the bug! Let's keep with it for the last time through the loop. Select **Continue** one more time.

    The program finished running and printed out 3! That is incorrect.

    We now know that the code runs through the loop correctly until `i` equals 4, but then it exits out before computing the final value. We have narrowed down where the bug is.

1. Let's set one more breakpoint on line 18, which reads:

    ```csharp
    return n == 0 ? n1 : n2;
    ```

    This breakpoint will let us inspect the program state before the function exits. We've already learned all we can expect to from our previous breakpoints on lines 1 and 13, so we can clear them.

1. Remove our previous breakpoints on lines 1 and 13. Click the breakpoints in the margin next to the line numbers, or clear the breakpoint check boxes for lines 1 and 13 in the breakpoints pane in the lower left.

    :::image source="../media/visual-studio-breakpoints-clear.png" alt-text="Screenshot showing the breakpoints listed in the breakpoints pane.":::

    Now that we better understand what's going on and have set a breakpoint designed to catch our program in the act of misbehaving, we should be able to catch this bug!

1. Start the debugger one last time.

    ```text
    n [int]: 5
    n1 [int]: 2
    n2 [int]: 3
    sum [int]: 3
    ```

    We specifically asked for Fibonacci(5), and we got Fibonacci(4), which is incorrect. This function returns `n2`, and each loop iteration calculates the `sum` value and sets `n2` equal to `sum`.

    Based on this information, and our previous debug run, we can see that the loop exited when `i` was 4, not 5.

    Let's look at the first line of the `for` loop a little closer.

    ```csharp
    for (int i = 2; i < n; i++)
    ```

    This will exit as soon as the top of the for loop sees `i` equals as `n`. That means that the loop code won't run for the case where `i` equals `n`. It seems like what we wanted was to run until `i <= n`, instead:

    ```csharp
    for (int i = 2; i <= n; i++)
    ```

    So with that change, your updated program should look like this example:

    ```csharp
    int result = Fibonacci(5);
    Console.WriteLine(result);

    static int Fibonacci(int n)
    {
        int n1 = 0;
        int n2 = 1;
        int sum;

        for (int i = 2; i <= n; i++)
        {
            sum = n1 + n2;
            n1 = n2;
            n2 = sum;
        }

        return n == 0 ? n1 : n2;
    }
    ```

1. Stop the debugging session if you haven't already.

1. Make the preceding change to line 11, and leave your breakpoint on line 18.

1. Restart the debugger. This time, when we hit the breakpoint on line 18, we'll see the following values:

    ```text
    n [int]: 5
    n1 [int]: 3
    n2 [int]: 5
    sum [int]: 5
    ```

    Hey! It looks like we got it! Great job, you've saved the day for *Fibonacci, Inc.*!

1. Select **Continue** just to make sure the program returns the correct value.

    ```text
    5
    The program '[105260] DotNetDebugging.dll' has exited with code 0 (0x0).
    ```

    And that returns the correct output.

You did it! You've debugged some code you didn't write by using the .NET debugger in Visual Studio.

In the next unit, you'll learn how to make the code you write easier to debug by using the logging and tracing features that are built into .NET.
