


Debuggers are used to help you to analyze your code and can be used to control your program's runtime execution. When you start the Visual Studio Code debugger, it immediately begins executing your code. Because your code executes in micro-seconds, effective code debugging depends on your ability to pause the program on any statement within your code. You'll use breakpoints to specify where code execution will be paused.

## Set breakpoints

Visual Studio Code provides several ways to configure breakpoints in your code. For example:

- Code Editor: You can set a breakpoint in the Visual Studio Code Editor by clicking in the column to the left of a line number.
- Run menu: You can toggle a breakpoint on/off from the **Run** menu. The current code line in the Editor specifies where the **Toggle Breakpoint** action is applied.

When a breakpoint is set, you'll see a red circle displayed to the left of the line number in the Editor. When you run your code in the debugger, execution will pause at the breakpoint.

![Screenshot showing a breakpoint added in the Visual Studio Code editor.](../media/breakpoint-set-1.png)

## Remove, disable, and enable breakpoints

After setting breakpoints in your application and using them to isolate an issue, you may want to remove or disable the breakpoints.

To remove a breakpoint, simply repeat the action used to set a breakpoint. For example, click the red circle to the left of the line number or use the toggle breakpoint option on the **Run** menu.

If you want to keep a breakpoint location, but you don't want it to trigger during your next debug session, you can "disable" a breakpoint rather than removing it altogether. To disable an active breakpoint, right-click the red dot to the left of the line number, and then select **Disable Breakpoint** from the context menu.

![Screenshot showing the option to disable a breakpoint in the Visual Studio Code editor.](../media/breakpoint-disable.png)

When you disable a breakpoint, the red dot to the left of the line number is changed to a grey dot.

> [!NOTE]
> The context menu that appears when you right-click a breakpoint also includes the options to **Remove Breakpoint (Delete)** and **Edit Breakpoint**. The **Edit Breakpoint** option is examined in the **Conditional breakpoints and Logpoints** section below.

In addition to managing individual breakpoints in the Editor, the **Run** menu provides options for performing bulk operations that act on all breakpoints:

- **Enable All Breakpoints**: Use this option to enable all disabled breakpoints.
- **Disable All Breakpoints**: Use this option to disable all breakpoints.  
- **Remove All Breakpoints**: Use this option to remove all breakpoints (both enabled and disabled breakpoints will be removed).

## Conditional breakpoints

A conditional breakpoint is a special type of breakpoint that only triggers when a specified condition is met. For example, you can create a conditional breakpoint that will pause execution when a variable named "numItems" is greater than 5.

You've already seen that right-clicking a breakpoint opens a context menu that includes the **Edit Breakpoint** option. Selecting **Edit Breakpoint** enables you to change a standard breakpoint into a conditional breakpoint.

![Screenshot showing the option to edit a breakpoint in the Visual Studio Code editor.](../media/breakpoint-edit-breakpoint.png)

In addition to editing an existing breakpoint, you can also set a conditional breakpoint directly. If you right-click (rather than left-click) to set a new breakpoint, you can choose to create a conditional breakpoint.

![Screenshot showing options for setting conditional breakpoints in the Visual Studio Code editor.](../media/breakpoint-conditional-breakpoint.png)

No mater which approach you use, when you create a conditional breakpoint you will need to specify an expression that represents the condition that must be met.  

When the debugger encounters the conditional breakpoint, it will will evaluate the expression. If the expression evaluates as `true`, the breakpoint will be triggered and execution will pause. If the expression evaluates as `false`, execution will continue as if there was no breakpoint.

For example, suppose you need to debug some code that's inside the code block of a `for` loop. You've noticed that the issue you're debugging only occurs after the loop has completed several iterations. You decide that you want the breakpoint to trigger once the loop's iteration control variable, `i`, is greater than three. You create a conditional breakpoint and specify the expression `i > 3`.

![Screenshot showing a conditional breakpoint expression in the Visual Studio Code editor.](../media/conditional-breakpoint-expression.png)

When you run your code in the debugger, it will skip over your breakpoint until the iteration when `i > 3` evaluates as `true`. When `i = 4`, execution will pause on your conditional breakpoint.

## Support for Hitcount breakpoints and Logpoints

The C# debugger for Visual Studio Code does not currently support Hitcount breakpoints or Logpoints.

If you configure either a Hitcount breakpoint or a Logpoint, the red marker to the left of the line number will be updated (after the debug session) to indicate the breakpoint is not supported. If you hover the mouse cursor over the red dot you will see the following message.

![Screenshot showing the breakpoint type not supported message.](../media/breakpoint-logpoint-hitcount-not-supported.png)

## Recap

Here are a few important things to remember from this unit:

- Visual Studio Code allows setting breakpoints in the code editor or from the Run menu, which are marked with a red circle.
- Breakpoints can be removed or disabled using the same options used to set them, and bulk operations for all breakpoints are also available in the Run menu.
- Conditional breakpoints can be set by right-clicking an existing breakpoint or by choosing the option when setting a new breakpoint, which allows the user to specify a condition for triggering the breakpoint.
- The C# debugger for Visual Studio Code does not currently support Hitcount breakpoints or Logpoints.