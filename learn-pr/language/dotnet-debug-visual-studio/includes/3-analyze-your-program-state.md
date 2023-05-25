In the previous unit, you learned that a debugger helps you control your program's execution and observe its state. In this section, you learn how to do both of those tasks in Visual Studio.

Let's start by learning how to use the Visual Studio debugger with .NET.

## Getting Started with the Visual Studio Debugger

Launch the application with the debugger attached using the **Start** button at the top of Visual Studio, which now includes our project name. Once the app is running, more debugging tools and features become available.

:::image source="../media/visual-studio-debugging-controls.png" alt-text="Screenshot of Visual Studio debugging controls.":::

1) Solution configuration specifies whether to run our app in Debug or Release mode
1) Platform configuration specifies a target CPU platform
1) Starts the app with the debugger attached
1) Starts the app without the debugger attached

### Controlling execution

Once the app is running, the debugging controls appear next to the **Start** button you clicked to launch the app.

:::image source="../media/visual-studio-steps.png" alt-text="Screenshot of Visual Studio debugger execution controls.":::

The controls are numbered as follows:

- **1) Continue or pause execution**. If execution is paused on a breakpoint, select this button to continue until the next breakpoint is hit. If your program is running, the button switches to a pause button that you can use to pause execution.
- **2) Hot reload controls**. This new feature of Visual Studio 2022 allows you to make changes and refresh our code without restarting the app.
- **3) Stop**. This button stops the running application, which also detaches the debugger.
- **4) Restart**. Stops and relaunches the app with the debugger attached.
- **5) Step into**. If the next statement is a function call, move down into the first code statement of this function (same as the `step` command).
- **6) Step over**. If the next statement is a function call, execute the code, but move on immediately to the next line of code in the current function.
- **7) Step out**. If you're inside a function, execute the remaining code of this function and jump back to the statement after the initial function call (same as the `out` command).

Breakpoints are one of the core features of debugging and integrate with these controls, so let's explore them in more detail.

## Breakpoints

As you learned in the previous unit, a debugger helps you analyze and control your program's execution. When you start your app with the Visual Studio debugger attached, your code immediately begins to execute. Because your code is executed quickly, you need to be able to pause the program on any statement. You use *breakpoints* to do that.

You can add a breakpoint in Visual Studio by clicking to the left side of the line number on the line you want to break. You should see a red circle after the breakpoint is enabled. To remove it, select the red circle again.

:::image source="../media/visual-studio-breakpoint.png" alt-text="Screenshot of a breakpoint added in the Visual Studio editor window.":::

If you right-click to add a breakpoint or on an existing breakpoint, you can also select **Add Conditional Breakpoint**. This special type of breakpoint allows you to define a *condition* or criteria for when the breakpoint is triggered. This menu also allows you to select **only Enable when following breakpoint is hit option** to create a chainable breakpoints execution, among other actions.

:::image source="../media/visual-studio-breakpoint-conditional.png" alt-text="Screenshot of setting a conditional breakpoint in Visual Studio.":::

You can also use a Temporary breakpoint if you want to break the code just one time. You can apply Temporary breakpoints by right-clicking in the breakpoint column and selecting **Insert temporary breakpoint**. The Temporary breakpoints will be removed after they're hit the first time.

You can also add Tracepoints by right-clicking in the breakpoint column. Tracepoints allow you to log information to the Output window under configurable conditions without modifying or stopping your code execution.  

Finally, in the **Breakpoints** window (**Debug** > **Windows** > **Breakpoints**), you can see and toggle all the breakpoints you placed in your code. You can also toggle options to break on caught or uncaught exceptions. You can use the **Breakpoints** panel to examine your program state and trace back the source of an exception by using the **Call stack** when one occurs.

:::image source="../media/visual-studio-breakpoints-window.png" alt-text="Screenshot of the Visual Studio Breakpoints window.":::

## Visual Studio debugging tools

After you've set up your breakpoints and started your app, new information windows and controls appear on the screen.

:::image source="../media/visual-studio-controls.png" alt-text="Screenshot of Visual Studio debugger overview.":::

1. Debugger launch controls
1. Current breakpoint and execution line
1. Watch window to monitor variable values
1. Breakpoints window to view all breakpoints

You can also access other helpful debugging windows by selecting **Debug** > **Windows** along the top navigation bar. For example, commonly used tools include:

1. **Call Stack window**: Allows you to view which methods have been called.
2. **Immediate window**: Allows you to write and expressions while debugging.
3. **Autos window**: Automatically adds watches to variables in the current context.
4. **Output window**: Shows the output of logging statements or code that writes to the console.

:::image source="../media/visual-studio-debugging-windows.png" alt-text="Screenshot of Visual Studio debugging window options.":::

### Watch and edit the state of variables

When you analyze the cause of a program defect, you can watch the state of your variables to look for unexpected changes. There are multiple watch window options in Visual Studio, which you can use in different debugging contexts to monitor the state of your variables.

1. **Watch window**: Allows you to track selected variables and expressions over time while debugging.
1. **Locals window**: Automatically displays variables in the current execution scope and context.
1. **Autos window**: Automatically displays any variable used on the currently executing or preceding line.
1. **Immediate window**: Allows you to evaluate expressions and variables live while debugging.

:::image source="../media/visual-studio-autos.png" alt-text="Screenshot of the Autos window in Visual Studio.":::

Most of these windows also allow you to double-click the value of a variable and change its value while debugging.

The **Watch** windows are useful for tracking variables during the execution of your code. You can right-click a variable in your editor and select **Add to watch**. That variable  now displays in the watch window and updates automatically as your app executes.

You can also right-click variables in the **Autos** or **Locals** windows to add a watch.

Another productive way to view and analyze the variable information during debugging is using DataTips. When you pause at the breakpoint, hover over any variable in the current scope. A DataTip appears, showing the name and current value of the variable properties. By hovering over a function parameter or a variable directly in the editor window, you can also peek at its value.

### Call stack

Every time your program enters a function, an entry is added to the call stack. When your application becomes complex and functions are called within other functions many times, the call stack represents the trail of those calls.

It's useful to find the source of an exception. If you have an unexpected crash in your program, you often see something in the console like the following example:

```text
Unhandled exception. System.IndexOutOfRangeException: Index was outside the bounds of the array.
   at OrderProcessor.OrderQueue.ProcessNewOrders(String[] orderIds) in C:\Users\Repos\OrderProcessor\OrderQueue.cs:line 12
   at OrderProcessor.Program.Main(String[] args) in C:\Users\Repos\OrderProcessor\Program.cs:line 9
```

The group of `at [...]` lines under the error message is called a *stack trace*. The stack trace gives the name and origin of every function that was called before ending up with the exception. However, it can be a bit difficult to decipher, because it also includes internal functions from the .NET runtime.

The Visual Studio **Call stack** window comes in handy here. It filters out unwanted information to show you only the relevant functions from your own code by default. You then can unwind this call stack to find out where the exception originated from.

:::image source="../media/visual-studio-callstack.png" alt-text="Screenshot of the Call Stack window.":::

In the next unit, you'll walk through an exercise using the debugger to fix the bug in the Fibonacci code we saw previously.

### Specify debugger settings

In Visual Studio, you can specify various settings for debugger behavior. Including, how variables are displayed, whether certain warnings are presented, how breakpoints are set, and how breaking affects running programs. You can also configure your project to build as a Debug or Release configuration.

To configure your debugger settings, use the **Tools** > **Options** > **Debugging** menu, which provides you with different categories of options. The most common options are in the **General** category.
