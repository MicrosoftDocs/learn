In addition to being able to run your code step by step, you saw in the previous exercise that knowing about your program state is also essential. With the built-in debugger, you have some options for that end like the `exec` command, but it's still rather limited. Using a debugger with a more complete visual interface is useful for that purpose. So let's discover how you can configure Visual Studio Code debugger to use it with Node.js.

## Visual Studio Code debugger for Node.js

In VS Code, if you click on the **Run** tab you can access the debugger tool.

:::image source="../media/vscode-run-tab.png" alt-text="Screenshot of VS Code debug tab":::

If you have a Node.js project open, you have three different ways to activate the debugger:

- If you have a `.js` file open in the editor window, you can click on the **Run and debug**, then select **Node.js** to directly debug this JavaScript file.

    :::image source="../media/vscode-debug-select-environment.png" alt-text="Select Node.js in environment selection dropdown in VS Code":::

- You can also choose to open a **Node.js debug terminal**. Clicking on this button opens a special terminal window, that you can use to run your program from the command line. For example, you can type in `node myscript.js` and your app will start with the debugger enabled automatically, without having to use the `--inspect` option.

    :::image source="../media/vscode-debug-terminal.png" alt-text="Debug terminal window in VS Code":::

- You can click on **create a launch.json file** to customize further your run configuration and share it with your coworkers. We'll see more about that later.

As opposed to the built-in Node.js command line debugger, the VS Code debugger will immediately start executing your code. If your program ends quickly, you may not even have the chance to interact with the debugger. That's why you may want to add some breakpoints before starting it.

To add a breakpoint in your code, open your `.js` program then click on the left side of the line number, on the line you want to break. You should see a red circle once the breakpoint is enabled. To remove it, just click on the red circle again.

:::image source="../media/vscode-breakpoint.png" alt-text="Breakpoint added in VS Code editor window":::

### Execution controls

After you've set up your breakpoints and started your app, you'll see the execution controls appear at the top:

:::image source="../media/vscode-debugger-controls.png" alt-text="VS Code debugger execution controls":::

From left to right, the controls go like that:

- **Continue or pause execution**. If execution is paused, it will continue until the next breakpoint is hit. If your program is running, the button switches to a pause button that you can use to pause execution.
- **Step over**. Executes the next code statement in the current context (same as the `next` command in built-in debugger).
- **Step into**. Like *Step into*, but if the next statement is a function call, move on to the first code statement of this function (same as `step` command).
- **Step out**. If you're inside a function, execute the remaining code of this function and jump back to the statement after the initial function call (same as `out` command).
- **Restart**. Restart your program from the beginning.
- **Stop**. End execution and leave the debugger.

## Create a launch configuration

Once you're more familiar with the debugger controls, you may want to create a launch configuration for your app. Click on **create a launch.json file** in the debugger tab while the debugger is inactive, then select **Node.js**.

This will create the file `.vscode/launch.json` in your project. You can then edit this file to further customize how your program should be started for debugging. By default, it creates a launch configuration to execute an `index.js` file in your project's root.

:::image source="../media/vscode-launch-configuration.png" alt-text="VS Code debugger execution controls":::

You can edit the path and name of your application entry point if needed. You can also click on **Add Configuration** if you want to create different launch configurations for your project.

Once you have finished preparing your configurations, you can select one using the dropdown at the top of the side bar then click on the run button to start debugging.

:::image source="../media/vscode-debug-sidebar-controls.png" alt-text="VS Code debug side bar controls":::

Note that you can also have buttons to edit the launch configurations and start the Node.js debug terminal if needed.

## Analyze your program state

### View your variables state

### Watch variables

### Use debug console

### Add logpoints

