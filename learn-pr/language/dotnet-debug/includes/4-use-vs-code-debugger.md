It's time to put into practice your newly acquired debugging knowledge. In the previous section, we found that there's an error in your Fibonacci calculator. Embarassing! Let's use the Visual Studio Code debugger to fix that.

We'll be using the code from the previous section. If you don't have that available, you can create the sample application using the following steps:

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named `DotNetDebugging` in the location of your choice, and then click **Select Folder**.

1. Open the integrated terminal from Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command.

    ```dotnetcli
    dotnet new console
    ```

1. Open *Program.cs* by clicking on it.

1. Replace the contents of the *Program.cs* with the following code:

    ```csharp
    using System;
    
    namespace DotNetDebugging
    {
        class Program
        {
            static void Main(string[] args)
            {
                int result = Fibonacci(5);
                Console.WriteLine(result);
            }
            static int Fibonacci(int n)
            {
                int n1 = 0;
                int n2 = 1;
                int sum = 0;
    
                for (int i = 2; i < n; i++)
                {
                    sum = n1 + n2;
                    n1 = n2;
                    n2 = sum;
                }
    
                return n == 0 ? n1 : n2;
            }
    
        }
    }
    ```

> [!NOTE]
> As you saw in the previous section, the first time you open a ".cs" file in a new .NET project, Visual Studio Code will show you a prompt to install required assets to debug your application. You will need to select "Yes" on this prompt in order for the debugging profile to be correctly configured for your application.

Save the file by selecting **Ctrl+S** (Windows, Linux) or **Cmd+S** (Mac).

## Analyze the issues

Now start the program by selecting the **Run** tab and clicking the **Start debugging** button.

:::image source="../media/start-debugging.png" alt-text="Screenshot of the Start debugging button in Visual Studio Code.":::

You should see the program finish quickly. That's normal because you haven't added any breakpoints yet.

If you don't have the debug console displayed, bring it on by selecting **Ctrl+Shift+Y** (Windows, Linux) or **Cmd+Shift+Y** (Mac). You should see several lines of diagnostic information, followed by this at the end:

```text
...
Loaded 'C:\Program Files\dotnet\shared\Microsoft.NETCore.App\5.0.0-rc.2.20475.5\System.Threading.dll'. Skipped loading symbols. Module is optimized and the debugger option 'Just My Code' is enabled.
Loaded 'C:\Program Files\dotnet\shared\Microsoft.NETCore.App\5.0.0-rc.2.20475.5\System.Text.Encoding.Extensions.dll'. Skipped loading symbols. Module is optimized and the debugger option 'Just My Code' is enabled.
3
The program '[36536] DotnetDebugging.dll' has exited with code 0 (0x0).
```

The lines at the top tell you that the default debugging settings enable the "Just My Code" option. This means that the debugger will only debug your code, and will not step into the source code for .NET unless you disable this mode. This allows you to focus on debugging your code.

At the end of the Debug Console output, you'll see the program writes "3" to the console, then exists with code 0. Usually a program exit code 0 indicates that the program ran and exited without crashing. However, there's a difference between crashing and returning the correct value. In this case, we asked the program to calculate the 5<sup>th</sup> value of the Fibonacci sequence:

```text
0, 1, 1, 2, 3, 5, 8, 13, 21...
```
The 5<sup>th</sup> value in this list is 5, but our program returned 3. Let's use the debugger to diagnose and fix this.

### Use breakpoints and step-by-step execution

Add a breakpoint by clicking in the left margin at line **9**, on `int result = Fibonacci(5);`.

:::image source="../media/breakpoint.png" alt-text="Screenshot of the breakpoint location in the code.":::

Then start debugging again. The program will begin to execute, and will break (pause execution) on line 9, due to the breakpoint you set. Use the debugger controls to step into the `Fibonacci()` function.

:::image source="../media/step-into.png" alt-text="Screenshot of the Step into button.":::

### Check the variables state

Now take some time to inspect the different variables' values by using the **Variables** panel.

:::image source="../media/variables-panel.png" alt-text="Screenshot of the Variables panel.":::

- What is the value shown for the `n` parameter?
- At the beginning of the function's execution what are the values for the local variables `n1`, `n2`, and `sum`?

Next, we'll advance into the the `for` loop using the **Step Over** debugger control.

:::image source="../media/step-over.png" alt-text="Screenshot of the Step over button.":::

Continue advancing until you hit the first line inside of the `for` loop, on the line that reads:

```csharp
sum = n1 + n2;
```

> [!NOTE]
> You might have noticed that to move through the `for(...) {}` line requires multiple steps in commands. This situation occurs because there are multiple *statements* on this line. When you step, you move on to the next statement in your code. Usually, there's one statement per line. If that's not the case, you need multiple steps to move on to the next line.

## Thinking about the code

An important part of debugging is to stop and take some informed guesses about what you think portions of the code (both functions and blocks, such as loops) are trying to do. It's okay if you're not sure, that's part of the debugging process. But being actively engaged in the debugging process will help you locate bugs a lot more quickly.

Before digging in further, let's remember that the Fibonacci sequence is a series of numbers that starts with the number 0 and 1, with every other following number being the sum of the two previous ones.

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
  1. If `n` is less than 2, the loop will never run. The `return` statement at the end of the function will return 0 if `n` is 0, and 1 if `n` is 1 or 2. These are the 0<sup>th</sup>, 1<sup>st</sup>, and 2<sup>nd</sup> values in the Fibonacci series, by definition.
  1. The more interesting case is when `n` is greater than 2. In those cases, the current value is defined as the sum of the previous two values. So for this loop, `n1` and `n2` are the previous two values, and `sum` is the value for the current iteration. Because of that, each time we figure out the new of the previous two values and set it to `sum`, then update our `n1` and `n2` values.
  1. Because of the way the loop works, it looks like we should expect `sum` to be the right value for `n-1`; so when 

Okay, we don't need to overthink it past that; we can lean on our debugger a bit. But it's worth thinking about the code a bit to see if it does what we expect and be more informed when it doesn't.
  
## Locate the bug with breakpoints

While stepping through your code can be helpful, it can be tedious - especially when you are working with loops or other code that is called repeatedly. Rather than stepping through the loop over and over, we can set a new breakpoint on the first line of the loop.

When we're doing this, it's important to be strategic about where we put our breakpoints. We're especially interested in the value of `sum`, since it represents the current max Fibonacci value. Because of that, let's put our breakpoint on the line *after* `sum` is set, on line 21.

:::image source="../media/breakpoint-in-loop.png" alt-text="Screenshot showing a second breakpoint being set.":::

> [!NOTE]
> If you notice that you keep running your code and then stepping a line or two, you can easily update your breakpoints to more efficient lines.

Now that we have a good breakpoint set in the loop, use the **Continue** debugger control to advance until the breakpoint is hit. Looking at our local variables, we see the following:

```text
n [int]: 5
n1 [int]: 0
n2 [int]: 1
sum [int]: 1
i [int]: 2
``` 

This all seems correct. The first time through the loop, the `sum` of the previous two values is 1. Rather than stepping through line by line, we can hit **Continue** to jump to the next time through the loop.

> [!NOTE]
> Don't be too worried about skipping over the bug when you use **Continue**. You should expect that you'll often debug through the code several times to find the issue, and it's often faster to just run through it a few time as opposed to being to cautious when you step through.

This time, we see the following values:

```text
n [int]: 5
n1 [int]: 1
n2 [int]: 1
sum [int]: 2
i [int]: 3
``` 

Let's think about it: do these values still make sense? It seems like it. For the third Fibonacci number, we're expecting to see our `sum` equal to 3.

Okay, let's hit **Continue** to loop it again!

```text
n [int]: 5
n1 [int]: 1
n2 [int]: 2
sum [int]: 3
i [int]: 4
```
 
Again, things are looking good. The 4<sup>th</sup> value in the series is expected to be 3. 

At this point, you may start wondering if the code was actually right all along and you imagined the bug! Let's keep with it for the last time through the loop. Let's hit **Continue** one more time...

Wait a minute! The program finished running and printed out 3! That's not right.

Okay, not to worry. We haven't failed, we've learned. We now know that the code runs through the loop correctly until `i` equals 4, but then it exits out before computing the final value. I'm starting to get some ideas about where the bug is... are you?

Let's set one more breakpoint on line 25, which reads:

```csharp
return n == 0 ? n1 : n2;
```

This will let us inspect the program state before the function exits. We've already learned all we can inspect to from our previous breakpoints on lines 9 and 21, so we can clear them. You can do that by clicking on them in the margin next to the line numbers, or by unchecking the breakpoints for lines 9 and 21 in the breakpoints pane in the lower left.

:::image source="../media/clearing-breakpoints.png" alt-text="Screenshot showing the breakpoints listed in the breakpoints pane.":::

Now that we understand what's going on a lot better and have set a breakpoint designed to catch our program in the act of misbehaving, start the debugger one last time (hopefully!).

```text
n [int]: 5
n1 [int]: 2
n2 [int]: 3
sum [int]: 3
```

Well, that's not right. We specifically asked for Fibonaccci(5), and we got Fibonacci(4). This function returns `n2`, and each loop iteration  calculates the `sum` value and sets `n2` equal to `sum`.

Based on this information, and our previous debug run, we can see that the loop exited when `i` was 4, not 5.

Let's look at the first line of the `for` loop a little closer:

```csharp
for (int i = 2; i < n; i++)
```

Okay, wait a minute! That means that it will exit as soon the top of the for loop sees `i` equals as `n`; that means that the loop code won't run for the case where `i` equals `n`. It seems like what we wanted was to run until `i <= n`, instead:

```csharp
for (int i = 2; i <= n; i++)
```

Stop the debugging session if you haven't already. Then, make the above change to line 18, leave our breakpoint on line 25, and re-start the debugger. This time, when we hit the breakpoint on line 25, we'll see the following values:

```text
n [int]: 5
n1 [int]: 3
n2 [int]: 5
sum [int]: 5
```

Hey! It looks like we got it! We're a good team. Let's hit **Continue**, just to make sure the program returns the correct value.

```text
5
The program '[105260] DotnetDebugging.dll' has exited with code 0 (0x0).
```

And that returns the correct output. You did it! You've debugged some code you didn't write, using the .NET debugger in Visual Studio Code.

In the next section, you'll learn how to make the code you write easier to debug, using the loging and tracing features that are built into .NET.