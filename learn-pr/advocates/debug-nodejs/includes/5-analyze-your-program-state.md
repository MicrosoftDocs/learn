In addition to being able to run your code step by step, you saw in the previous exercise that knowing about your program state is also essential. With the built-in debugger, you have some options for that end like the `exec` command, but it's still rather limited. Using a debugger with a more complete visual interface is useful for that purpose, and it will help you a lot while working on the Tailwind Traders application.
Let's discover how you can configure Visual Studio Code debugger to use it with Node.js.

## Set up Visual Studio Code for Node.js debugging

In VS Code, if you click on the **Run** tab you can access the debugger tool.

:::image source="../media/run-tab.png" alt-text="Screenshot of VS Code debug tab":::

If you have a Node.js project open, you have three different ways to activate the debugger:

- If you have a `.js` file open in the editor window, you can click on the **Run and debug**, then select **Node.js** to directly debug this JavaScript file.

    :::image source="../media/select-environment.png" alt-text="Screenshot of Node.js environment selection dropdown in VS Code":::

- You can also choose to open a **Node.js debug terminal**. Clicking on this button opens a special terminal window, that you can use to run your program from the command line. For example, you can type in `node myscript.js` and your app will start with the debugger enabled automatically, without having to use the `--inspect` option.

    :::image source="../media/terminal.png" alt-text="Screenshot of debug terminal window in VS Code":::

- You can click on **create a launch.json file** to customize further your run configuration and share it with your coworkers. We'll see more about that later.

### Add breakpoints

As opposed to the built-in Node.js command line debugger, the VS Code debugger will immediately start executing your code. If your program ends quickly, you may not even have the chance to interact with the debugger. That's why you may want to add some breakpoints before starting it.

To add a breakpoint in your code, open your `.js` program then click on the left side of the line number, on the line you want to break. You should see a red circle once the breakpoint is enabled. To remove it, just click on the red circle again.

:::image source="../media/breakpoint.png" alt-text="Screenshot of breakpoint added in VS Code editor window":::

If you use right-click to add a breakpoint, you can also choose **Add Conditional Breakpoint**. This is a special kind of breakpoint that allows you to enter a *condition* for breaking execution. This breakpoint will only be active when the specified condition is met.

:::image source="../media/conditional-breakpoint.png" alt-text="Screenshot of setting a conditional breakpoint in VS Code":::

## Visual Studio Code debugger overview

After you've set up your breakpoints and started your app, you'll see new information panels and controls appear on the screen.

:::image source="../media/debugger-overview.png" alt-text="Screenshot of VS Code debugger overview":::

1. Debugger launch controls.
1. Variables state.
1. Watched variables state.
1. Current call stack.
1. Loaded script files.
1. Call stack.
1. Execution controls.
1. Current execution step.
1. Debug console.

### Debugger launch controls

At the top of the side bar, you can find the launch controls:

:::image source="../media/sidebar-controls.png" alt-text="Screenshot of VS Code debug side bar controls":::

1. Start debugging.
1. Select active launch configuration.
1. Edit `launch.json` file, creating it if needed.
1. Open debug terminal.

### View and edit your variables state

When analyzing the cause of a program defect, one of the most important things is to keep an eye on your variables state to look for unexpected changes. You can use the **Variables** panel to do that.

Your variables are show organized by scope:

- *Local variables* are the ones accessible in the current scope, usually the current function.
- *Global variables* are the ones accessible from everywhere in your program. It also includes the system objects from the JavaScript runtime, so don't get surprised if you see a lot of stuff in there.
- *Closure variables* are the ones accessible from the current closure, if any. A closure combines the local scope of a function with the scope from of the outer function it belongs to.

You can unfold scopes and variables by clicking the arrow. When unfolding objects, you can see all the properties defined in this object.

It is possible to change the value of a variable on the fly by double-clicking on the variable.

By hovering a function parameter or a variable directly in the editor window, you can also peek at its value:

:::image source="../media/variable-hover.png" alt-text="Screenshot of variable hover during debugging":::

### Watch variables

If you want to track a variable state across time or different functions, it can become tedious to search for it every time. That's where the **Watch** panel becomes handy.

You can click on the **plus** button to enter a variable name or an expression to watch. As an alternative, you can right-click on a variable in the **Variables** panel and select **Add to watch**.

All expressions inside the watch panel will be updated automatically as your code runs.

### Call stack

Every time your program enters a function, an entry is added to the call stack. When your application becomes complex and you have functions called within functions many times, it represents the trail of functions calls.

It's useful to find the source of an exception. If you have an unexpected crash in your program, you will often see something like this in the console:

```text
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

The group of `at [...]` lines below the error message is called a *stack trace*. It gives the name and origin of every function that was called before ending up with the exception. It can be a bit difficult to decipher though, as it also includes internal functions from the Node.js runtime.

That's where the VS Code **Call stack** panel comes handy. It filters out unwanted information to show you only the relevant functions from your own code by default. You then can unwind this call stack to find out where the exception originated from.

To help you even more, you can click on the **Restart frame** button that appears when hovering a function name in the stack. It will "rewind" execution back to the beginning of that function, by actually restarting your program up to that point.

:::image source="../media/restart-frame.png" alt-text="Screenshot of restart frame button in VS Code call stack panel":::

### View loaded script files

This panel will present you all the JavaScript files that have been loaded so far. In large projects, it can be sometimes useful to check from which file is the current code is executing.

### Breakpoints

In the Breakpoints panel, you see and toggle all the breakpoints you placed in your code. In addition, you can toggle options to break on caught or uncaught exceptions. It allows you to examine your program state and trace back the source of an exception using the **Call stack** when one occurs.

### Control execution

You can control the execution flow of your program using these controls.

:::image source="../media/debugger-controls.png" alt-text="Screenshot of VS Code debugger execution controls":::

From left to right, the controls go like that:

- **Continue or pause execution**. If execution is paused, it will continue until the next breakpoint is hit. If your program is running, the button switches to a pause button that you can use to pause execution.
- **Step over**. Executes the next code statement in the current context (same as the `next` command in built-in debugger).
- **Step into**. Like *Step into*, but if the next statement is a function call, move on to the first code statement of this function (same as `step` command).
- **Step out**. If you're inside a function, execute the remaining code of this function and jump back to the statement after the initial function call (same as `out` command).
- **Restart**. Restart your program from the beginning.
- **Stop**. End execution and leave the debugger.

### Use debug console

The debug console can be shown or hidden using `Ctrl+Shift+Y` (Windows, Linux) or `Cmd+Shift+Y` (Mac). It can be used to visualize your application console logs, and to evaluate expressions or execute code in the current execution content, like the `exec` command in built-in Node.js debugger.

You can enter a JavaScript expression in the input field at the bottom of the debug console, then press `Enter` to evaluate it. The result will be displayed directly in the console.

This way, you can quickly check a variable value, test a function with different values, or alter the current state.

#### Add logpoints

In case you want to follow the execution of your program using logs, there is actually an alternative to using `console.log` to do just that: **logpoints**.

By right-clicking in the same area used to add breakpoint, you can select **Add logpoint**:

:::image source="../media/logpoint.png" alt-text="Screenshot of adding a logpoint in VS Code":::

You can enter a message to display at that point in your code. It's even possible to print expressions by enclosing them in brackets, using `{<EXPRESSION>}`.

Like breakpoints, logpoints do not alter your code in any way, and will only be used during debugging. So you don't have an excuse anymore to let that forgotten `console.log('here')` slip to production.
