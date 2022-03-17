In the previous unit, you learned that a debugger helps you control your program's execution and observe its state. In this section, you'll learn how to do both of those tasks in Visual Studio.

Let's start by learning how to use the Visual Studio debugger with .NET.

## Getting Started with the Visual Studio Debugger

Launch the application with the debugger attached using the **Start** button at the top of Visual Studio, which will include our project name. Once the app is running, a variety of additional debugging tools and features will become available.

:::image source="../media/visual-studio-debugging-controls.png" alt-text="Screenshot of Visual Studio prompt to install the C# extension.":::

1) Solution configuration specifies whether to run our app in Debug or Release mode
1) Platform configuration specifies a target CPU platform
1) Starts the app with the debugger attached
1) Starts the app without the debugger attached

### Controlling execution

Once the app is running, the debugging controls will appear next to the **Start** button we clicked to launch the app.

:::image source="../media/visual-studio-steps.png" alt-text="Screenshot of Visual Studio debugger execution controls.":::

The controls are numbered as follows:

- **1) Continue or pause execution**. If execution is paused on a breakpoint, click to continue until the next breakpoint is hit. If your program is running, the button switches to a pause button that you can use to pause execution.
- **2) Hot reload controls**. This new feature of Visual Studio 2022 allows us to make changes and refresh our code without restarting the app.
- **3) Stop**. This button stops the running application, which will also detach the debugger.
- **4) Restart**. Stops and relaunches the app with the debugger attached.
- **5) Step into**. If the next statement is a function call, move down into the first code statement of this function (same as the `step` command).
- **5) Step over**. If the next statement is a function call, execute the code, but move on immediately to the next line of code in the current function.
- **Step out**. If you're inside a function, execute the remaining code of this function and jump back to the statement after the initial function call (same as the `out` command).

Breakpoints are one of the core features of debugging and integrate with these controls, so let's explore them in more detail.

## Breakpoints

As you learned in the previous unit, a debugger helps you analyze and control your program's execution. When you start your app with the Visual Studio debugger attached, your code immediately begins to execute. Because your code is executed quickly, you need to be able to pause the program on any statement. You'll use *breakpoints* to do that.

You can add a breakpoint in Visual Studio by clicking to the left side of the line number, on the line you want to break. You should see a red circle after the breakpoint is enabled. To remove it, select the red circle again.

:::image source="../media/visual-studio-breakpoint.png" alt-text="Screenshot of a breakpoint added in the Visual Studio editor window.":::

If you right-click to add a breakpoint, you can also select **Add Conditional Breakpoint**. This special kind of breakpoint allows you to enter a *condition* for breaking execution. This breakpoint will only be active when the specified condition is met. You can also modify an existing breakpoint by right-clicking it and selecting **Edit Breakpoint**.

:::image source="../media/visual-studio-breakpoint-conditional.png" alt-text="Screenshot of setting a conditional breakpoint in Visual Studio.":::

In the **Breakpoints** window (Debug -> Windows -> Breakpoints), you can see and toggle all the breakpoints you placed in your code. You can also toggle options to break on caught or uncaught exceptions. You can use the **Breakpoints** panel to examine your program state and trace back the source of an exception by using the **Call stack** when one occurs.

:::image source="../media/visual-studio-breakpoints-window.png" alt-text="Screenshot of setting a conditional breakpoint in Visual Studio.":::

## Visual Studio debugging tools

After you've set up your breakpoints and started your app, new information windows and controls appear on the screen.

:::image source="../media/visual-studio-controls.png" alt-text="Screenshot of Visual Studio debugger overview.":::

1. Debugger launch controls
1. Current breakpoint and execution line
1. Watch window to monitor variable values
1. Break point window to view all breakpoints

We can also access other helpful debugging windows by clicking **Debug -> Windows** along the top navigation bar. For example, commonly used tools include the following:

1. **Call Stack Window** - allows us to view which methods have been called.
1. **Immediate Window** - allows us to write and expressions while debugging.
1. **Autos Window** - automatically adds watches to variables in the current context.
1. **Output Window** - shows the output of logging statements or code that writes to the console.

:::image source="../media/visual-studio-debugging-windows.png" alt-text="Screenshot of Visual Studio debugger overview.":::

### View and edit your variables state

When you analyze the cause of a program defect, watch the state of your variables to look for unexpected changes. You can use the **Autos** window to do that.

The **Autos** window will automatically populate variables in the current scope and context, along with their values. This is a simple and easy choice for seeing a general overview of the state of your running code.

:::image source="../media/visual-studio-autos.png" alt-text="Screenshot of variable hover during debugging.":::

It's possible to change the value of a variable on the fly by double-clicking the variable value.

By hovering over a function parameter or a variable directly in the editor window, you can also peek at its value.

### Watch variables

If you want to track a specific variable state across time or different functions, it can be tedious to search for it every time. That's where the **Watch** panel comes in handy.

You can right-click a variable in your editor and select **Add to watch**. That variable will now display in the watch window and update as your app executes.

You can also right-click on variables in the **Autos** window to add a watch.

All expressions inside the watch panel will be updated automatically as your code runs.

### Call stack

Every time your program enters a function, an entry is added to the call stack. When your application becomes complex and functions are called within other functions many times, the call stack represents the trail of those calls.

It's useful to find the source of an exception. If you have an unexpected crash in your program, you'll often see something in the console like the following example:

```text
Unhandled exception. System.IndexOutOfRangeException: Index was outside the bounds of the array.
   at OrderProcessor.OrderQueue.ProcessNewOrders(String[] orderIds) in C:\Users\Repos\OrderProcessor\OrderQueue.cs:line 12
   at OrderProcessor.Program.Main(String[] args) in C:\Users\Repos\OrderProcessor\Program.cs:line 9
```

The group of `at [...]` lines under the error message is called a *stack trace*. The stack trace gives the name and origin of every function that was called before ending up with the exception. It can be a bit difficult to decipher though, because it also includes internal functions from the .NET runtime.

That's where the Visual Studio **Call stack** window comes in handy. It filters out unwanted information to show you only the relevant functions from your own code by default. You then can unwind this call stack to find out where the exception originated from.

:::image source="../media/visual-studio-callstack.png" alt-text="Screenshot of variable hover during debugging.":::

In the next unit, you'll walk through an exercise using the debugger to fix the bug in the Fibonacci code we saw previously.
