In the previous exercise, you learned the importance of being able to run your code step by step. The debug `s` command helps to identify issues in your code and is essential for determining program state. The built-in debugger provides a few other features like the `exec` command, but the feature options are limited. A debugger that offers a complete visual interface can be more useful. For your work on the Tailwind Traders application, you'll need a more comprehensive debugging environment.

Let's discover how you can configure the Visual Studio Code debugger to use it with Node.js.

## Set up Visual Studio Code for Node.js debugging

In Visual Studio Code, select the **Run** tab to access the debugger tool.

:::image source="../media/run-tab.png" alt-text="Screenshot of Visual Studio Code debug tab.":::

You have three different ways to activate the debugger:

- If you have a `.js` file open in the editor window, select **Run and Debug**. Then, select **Node.js** to directly debug this JavaScript file.

    :::image source="../media/select-environment.png" alt-text="Screenshot of Node.js environment selection drop-down list in Visual Studio Code.":::

- You can also choose to open a **Node.js debug terminal**. Selecting this button opens a special terminal window where you can run your program from the command line. For example, you can enter the command `node myscript.js` in the terminal, and your app will start with the debugger enabled automatically. You won't have to use the `--inspect` option.

    :::image source="../media/terminal.png" alt-text="Screenshot of debug terminal window in Visual Studio Code.":::

- You can select **create a launch.json file** to further customize your run configuration, and share it with your coworkers. We'll review this option later.

### Add breakpoints

Unlike the built-in Node.js command-line debugger, the Visual Studio Code debugger immediately starts executing your code. If your program ends quickly, you might not have the chance to interact with the debugger. That's why you might want to add breakpoints before you run the code.

To add a breakpoint in your code, find the line of code in your JavaScript (`.js`) file where you want to add a break. Next to the line number for the code statement, click in the left margin. When the breakpoint is added, you'll see a red circle next to the line number. To remove the breakpoint, click the red circle.

:::image source="../media/breakpoint.png" alt-text="Screenshot of a breakpoint added in the Visual Studio Code editor window.":::

You can also use the right-click context menu to add a breakpoint. The content menu includes the **Add Conditional Breakpoint** option, where you enter a *condition* for breaking the code execution. A conditional breakpoint is only active when the specified condition is met.

:::image source="../media/conditional-breakpoint.png" alt-text="Screenshot of setting a conditional breakpoint in Visual Studio Code.":::

## Visual Studio Code debugger overview

After you set up your breakpoints and start your app, new information panels and controls appear on the screen.

:::image source="../media/debugger-overview.png" alt-text="Screenshot of Visual Studio Code debugger overview.":::

1. Debugger launch controls
1. Variables state
1. Watched variables state
1. Current call stack
1. Loaded script files
1. Call stack
1. Execution controls
1. Current execution step
1. Debug console

### Debugger launch controls

At the top of the sidebar, you can find the launch controls:

:::image source="../media/sidebar-controls.png" alt-text="Screenshot of Visual Studio Code debug sidebar controls.":::

1. Start debugging.
1. Select the active launch configuration.
1. Edit the `launch.json` file. Create the json file if you need to.
1. Open the **Debug Console**, and toggle visibility of the **Variables**, **Watch**, **Call Stack**, and **Breakpoints** panels.

### View and edit your variables state

When you analyze the cause of a program defect, watch your variables state to look for unexpected changes. You can use the **Variables** panel to do that.

Your variables are shown organized by scope:

- **Local variables** are accessible in the current scope, usually the current function.
- **Global variables** are accessible from everywhere in your program. System objects from the JavaScript runtime are also included, so don't be surprised if you see a lot of stuff in there.
- **Closure variables** are accessible from the current closure, if any. A closure combines the local scope of a function with the scope from the outer function it belongs to.

You can unfold scopes and variables by selecting the arrow. When you unfold objects, you can see all the properties defined in this object.

It's possible to change the value of a variable on the fly by double-clicking the variable.

By hovering over a function parameter or a variable directly in the editor window, you can also peek at its value:

:::image source="../media/variable-hover.png" alt-text="Screenshot of variable hover during debugging.":::

### Watch variables

If you want to track a variable state across time or different functions, it can be tedious to search for it every time. That's where the **Watch** panel comes in handy.

You can select the **plus** button to enter a variable name or an expression to watch. As an alternative, you can right-click a variable in the **Variables** pane, and select **Add to watch**.

All expressions inside the watch pane will be updated automatically as your code runs.

### Call stack

Every time your program enters a function, an entry is added to the call stack. When your application becomes complex, and you have functions called within functions many times, the call stack represents the trail of functions calls.

It's useful to find the source of an exception. If you have an unexpected crash in your program, you'll often see something like this in the console:

```console
/Users/learn/nodejs/index.js:22
  return value.toFixed(2);
               ^
TypeError: Cannot read property 'toFixed' of undefined
    at formatValueForDisplay (/Users/learn/nodejs/index.js:22:16)
    at printForeignValues (/Users/learn/nodejs/index.js:31:28)
    at Object.<anonymous> (/Users/learn/nodejs/index.js:39:1)
    at Module._compile (internal/modules/cjs/loader.js:956:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:973:10)
    at Module.load (internal/modules/cjs/loader.js:812:32)
    at Function.Module._load (internal/modules/cjs/loader.js:724:14)
    at Function.Module.runMain (internal/modules/cjs/loader.js:1025:10)
    at internal/main/run_main_module.js:17:11
```

The group of `at [...]` lines under the error message is called a *stack trace*. The stack trace gives the name and origin of every function that was called before ending up with the exception. It can be a bit difficult to decipher though, because it also includes internal functions from the Node.js runtime.

That's where the Visual Studio Code **Call stack** panel comes in handy. It filters out unwanted information to show you only the relevant functions from your own code by default. You then can unwind this call stack to find out where the exception originated from.

To help you even more, you can select the **Restart frame** button that appears when you hover a function name in the stack. It will *rewind* the execution back to the beginning of that function by actually restarting your program up to that point.

:::image source="../media/restart-frame.png" alt-text="Screenshot of the Restart frame button in the Visual Studio Code call stack panel.":::

### View loaded script files

This panel displays all the JavaScript files that have been loaded so far. In large projects, sometimes it can be useful to check which file the current code is executing from.

### Breakpoints

In the **Breakpoints** panel, you can see and toggle all the breakpoints you placed in your code. You can also toggle options to break on caught or uncaught exceptions. You can use the **Breakpoints** pane to examine your program state and trace back the source of an exception by using the **Call stack** when one occurs.

### Control execution

You can control the execution flow of your program by using these controls.

:::image source="../media/debugger-controls.png" alt-text="Screenshot of Visual Studio Code debugger execution controls.":::

From left to right, the controls are:

- **Continue or pause execution**. If execution is paused, it will continue until the next breakpoint is hit. If your program is running, the button switches to a pause button that you can use to pause execution.
- **Step over**. Executes the next code statement in the current context (same as the `next` command in the built-in debugger).
- **Step into**. Like **Step over**, but if the next statement is a function call, move on to the first code statement of this function (same as the `step` command).
- **Step out**. If you're inside a function, execute the remaining code of this function and jump back to the statement after the initial function call (same as the `out` command).
- **Restart**. Restart your program from the beginning.
- **Stop**. End the execution and leave the debugger.

### Use the debug console

The debug console can be shown or hidden by pressing <kbd>Ctrl+Shift+Y</kbd> (Windows, Linux) or <kbd>Cmd+Shift+Y</kbd> (Mac). It can be used to visualize your application console logs, and to evaluate expressions or execute code in the current execution content, like the `exec` command in the built-in Node.js debugger.

You can enter a JavaScript expression in the input field at the bottom of the debug console. Then, press <kbd>Enter</kbd> to evaluate it. The result displays directly in the console.

This way, you can quickly check a variable value, test a function with different values, or alter the current state.

#### Add logpoints

If you want to follow the execution of your program by using logs, there's an alternative to using `console.log` to do that. You can use *logpoints*.

By right-clicking in the same area that you used to add a breakpoint, you can select **Add logpoint**.

:::image source="../media/logpoint.png" alt-text="Screenshot of adding a logpoint in Visual Studio Code.":::

Enter a message to display at that point in your code. It's even possible to print expressions by enclosing them in brackets by using `{<EXPRESSION>}`.

Like breakpoints, logpoints don't alter your code in any way, and are used only during debugging. You don't have an excuse anymore to let that forgotten `console.log('here')` slip to production.
