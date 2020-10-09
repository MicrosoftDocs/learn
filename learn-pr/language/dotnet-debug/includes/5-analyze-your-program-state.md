In the previous section, you learned that a debugger helps you both control your program's execution and observe its state. In this section, you'll learn how to do both of those in Visual Studio Code.

Let's start by learning how to configure the Visual Studio Code debugger to use it with .NET.

## Creating a sample .NET project for debugging

In order to set up Visual Studio Code for .NET debugging, we'll need a .NET project. Visual Studio Code includes an integrated terminal, which makes creating a new project really easy.

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named `DotnetDebug` in the location of your choice, and then click **Select Folder**.

1. Open the integrated terminal from Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command.

    ```dotnetcli
    dotnet new console
    ```

    This command creates a **Program.cs** file in your folder with a basic "Hello World" program already written, along with a C# project file named **dotnet-debug.csproj**.

1. In the terminal window, copy and paste the following command to run the "Hello World" program.

    ```dotnetcli
    dotnet run
    ```

    The terminal window displays "Hello world!" as output.

:::image source="../media/new-dotnet-project.png" alt-text="Screenshot of Visual Studio Code with a new console application.":::

## Set up Visual Studio Code for .NET debugging

Open *Program.cs* by clicking on it.

The first time you open a C# file in Visual Studio Code, you will receive a prompt to install recommended extensions for C#. Click the **Install** button in the prompt.

:::image source="../media/install-recommended-extensions.png" alt-text="Screenshot of Visual Studio Code debug tab.":::

Visual Studio Code will install the **C#** extension, and will show an additional prompt to add required assets to build and debug your project. Click the **Yes** button. 

:::image source="../media/install-required-assets.png" alt-text="Screenshot of Visual Studio Code debug tab.":::

You can close the tab titled "Extension: C#" to focus on the code we'll be debugging.

## Enhance the app

Our current project just writes a "Hello World" message to the console, which doesn't give us much to debug. We'll add a little code to make it a little more interesting.

1. Open *Program.cs* by clicking on it.

1. Replace the contents of the `Main` method in *Program.cs*, which is the line that calls `Console.WriteLine`, with the following code:

    ```csharp
    Console.WriteLine("\nWhat is your name? ");
    var name = Console.ReadLine();
    var date = DateTime.Now;
    Console.WriteLine($"\nHello, {name}, on {date:d} at {date:t}!");
    Console.Write("\nPress any key to exit...");
    Console.ReadKey(true);
    ```

   This code displays a prompt in the console window and waits until the user enters a string followed by the <kbd>Enter</kbd> key. It stores this string in a variable named `name`. It also retrieves the value of the [System.DateTime.Now](https://docs.microsoft.com/dotnet/api/system.datetime.now#System_DateTime_Now) property, which contains the current local time, and assigns it to a variable named `date`. And it displays these values in the console window. Finally, it displays a prompt in the console window and calls the [System.Console.ReadKey(System.Boolean)](https://docs.microsoft.com/dotnet/api/system.console.readkey#System_Console_ReadKey_System_Boolean_) method to wait for user input.

   The `\n` represents a newline character.

   The dollar sign (`$`) in front of a string lets you put expressions such as variable names in curly braces in the string. The expression value is inserted into the string in place of the expression. This syntax is referred to as [interpolated strings](../../csharp/language-reference/tokens/interpolated.md).

1. Save your changes.

1. Let's get a look at how the updated code works before debugging it. Run the program by typing the following in the Terminal:

   ```dotnetcli
   dotnet run
   ```

1. Respond to the prompt by entering a name and pressing the <kbd>Enter</kbd> key.

   :::image type="content" source="..media/run-modified-program.png" alt-text="Terminal window with modified program output":::

1. Press any key to exit the program.

### Add breakpoints

In Visual Studio Code, select the **Run** tab to access the debugger tool.

:::image source="../media/run-tab.png" alt-text="Screenshot of Visual Studio Code debug tab.":::

When you start the Visual Studio Code debugger, it immediately begins executing your code. If your program ends quickly, you might not even have the chance to interact with the debugger. That's why you might want to add some breakpoints before you start it.

To add a breakpoint in your code, open your `Program.cs` file and then select the left side of the line number, on the line you want to break. You should see a red circle after the breakpoint is enabled. To remove it, select the red circle again.

:::image source="../media/breakpoint.png" alt-text="Screenshot of a breakpoint added in the Visual Studio Code editor window.":::

If you right-click to add a breakpoint, you can also choose **Add Conditional Breakpoint**. This is a special kind of breakpoint that allows you to enter a *condition* for breaking execution. This breakpoint will only be active when the specified condition is met.

:::image source="../media/conditional-breakpoint.png" alt-text="Screenshot of setting a conditional breakpoint in Visual Studio Code.":::

## Visual Studio Code debugger overview

After you've set up your breakpoints and started your app, new information panels and controls appear on the screen.

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
1. Edit the `launch.json` file. Create it if you need to.
1. Open the debug terminal.

### View and edit your variables state

When you analyze the cause of a program defect, watch your variables state to look for unexpected changes. You can use the **Variables** panel to do that.

Your variables are shown organized by scope:

- **Local variables** are accessible in the current scope, usually the current function.
- **Global variables** are accessible from everywhere in your program. System objects from the JavaScript runtime are also included, so don't be surprised if you see a lot of stuff in there.
- **Closure variables** are accessible from the current closure, if any. A closure combines the local scope of a function with the scope from the outer function it belongs to.

You can unfold scopes and variables by selecting the arrow. When you unfold objects, you can see all the properties defined in this object.

It's possible to change the value of a variable on the fly by double-clicking on the variable.

By hovering a function parameter or a variable directly in the editor window, you can also peek at its value:

:::image source="../media/variable-hover.png" alt-text="Screenshot of variable hover during debugging.":::

### Watch variables

If you want to track a variable state across time or different functions, it can be tedious to search for it every time. That's where the **Watch** panel comes in handy.

You can select the **plus** button to enter a variable name or an expression to watch. As an alternative, you can right-click on a variable in the **Variables** panel and select **Add to watch**.

All expressions inside the watch panel will be updated automatically as your code runs.

### Call stack

Every time your program enters a function, an entry is added to the call stack. When your application becomes complex and you have functions called within functions many times, the call stack represents the trail of functions calls.

It's useful to find the source of an exception. If you have an unexpected crash in your program, you'll often see something like this in the console:

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

The group of `at [...]` lines under the error message is called a *stack trace*. The stack trace gives the name and origin of every function that was called before ending up with the exception. It can be a bit difficult to decipher though, because it also includes internal functions from the .NET runtime.

That's where the Visual Studio Code **Call stack** panel comes in handy. It filters out unwanted information to show you only the relevant functions from your own code by default. You then can unwind this call stack to find out where the exception originated from.

To help you even more, you can select the **Restart frame** button that appears when you hover a function name in the stack. It will "rewind" the execution back to the beginning of that function by actually restarting your program up to that point.

:::image source="../media/restart-frame.png" alt-text="Screenshot of the Restart frame button in the Visual Studio Code call stack panel.":::

### View loaded script files

This panel displays all the JavaScript files that have been loaded so far. In large projects, sometimes it can be useful to check which file the current code is executing from.

### Breakpoints

In the **Breakpoints** panel, you can see and toggle all the breakpoints you placed in your code. You can also toggle options to break on caught or uncaught exceptions. You can use the **Breakpoints** panel to examine your program state and trace back the source of an exception by using the **Call stack** when one occurs.

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

The debug console can be shown or hidden by selecting **Ctrl+Shift+Y** (Windows, Linux) or **Cmd+Shift+Y** (Mac). It can be used to visualize your application console logs and to evaluate expressions or execute code in the current execution content, like the `exec` command in the built-in .NET debugger.

You can enter a JavaScript expression in the input field at the bottom of the debug console. Then select **Enter** to evaluate it. The result displays directly in the console.

This way, you can quickly check a variable value, test a function with different values, or alter the current state.

#### Add logpoints

If you want to follow the execution of your program by using logs, there's an alternative to using `console.log` to do that. You can use *logpoints*.

By right-clicking in the same area that you used to add a breakpoint, you can select **Add logpoint**.

:::image source="../media/logpoint.png" alt-text="Screenshot of adding a logpoint in Visual Studio Code.":::

Enter a message to display at that point in your code. It's even possible to print expressions by enclosing them in brackets by using `{<EXPRESSION>}`.

Like breakpoints, logpoints don't alter your code in any way and are used only during debugging. You don't have an excuse anymore to let that forgotten `console.log('here')` slip to production.
