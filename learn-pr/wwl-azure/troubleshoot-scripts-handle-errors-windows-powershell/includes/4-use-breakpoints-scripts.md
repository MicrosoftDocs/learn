A *breakpoint* pauses a script and provides an interactive prompt. At the interactive prompt, you can query or modify variable values and then continue the script. You use breakpoints to troubleshoot scripts when they aren't behaving as expected.

At a Windows PowerShell prompt, you can set breakpoints by using the **Set-PSBreakPoint** cmdlet. Breakpoints can be set based on the line of the script, a specific command being used, or a specific variable being used. This example sets a breakpoint at a specific line of a script:

```powershell
Set-PSBreakPoint -Script "MyScript.ps1" -Line 23
```

When you set a breakpoint based on a line, be careful when editing the script. Adding or removing lines can shift the breakpoint away from the code you initially intended.

This example sets a breakpoint for a specific command:

```powershell
Set-PSBreakPoint -Command "Set-ADUser" -Script "MyScript.ps1"
```

When you set a breakpoint based on a command, you can include wildcards. For example, you could use the value ***-ADUser** to trigger a breakpoint for **Get-ADUser**, **Set-ADUser**, **New-ADUser**, and **Remove-ADUser**.

To set a breakpoint for a specific variable, do the following:

```powershell
Set-PSBreakPoint -Variable "computer" -Script "MyScript.ps1" -Mode ReadWrite
```

You can use the `-Mode` parameter for variables to identify whether you want to break when the variable value is read, written, or both. Valid values are **Read**, **Write**, and **ReadWrite**.

The default action for **Set-PSBreakPoint** is **break**, which provides the interactive prompt. However, you can use the `-Action` parameter to specify code that runs instead. With `-Action`, you can evaluate variable values and break only when a value falls outside a specific range.

> [!NOTE]
> Breakpoints are stored in memory rather than as part of the script. Breakpoints aren't shared between multiple Windows PowerShell prompts and are removed when the prompt is closed.

> [!NOTE]
> The Windows PowerShell ISE is no longer in active feature development and only supports Windows PowerShell 5.1 and earlier. For new script development, **Visual Studio Code with the PowerShell extension** is the recommended editor.

## PowerShell ISE

In the Windows PowerShell Integrated Scripting Environment (ISE), you can set breakpoints based on the line. Options related to breakpoints are in the **Debug** menu. Lines that you configure as breakpoints are highlighted, making it easy to identify them. In the Windows PowerShell ISE, as you add or remove lines, the breakpoints update automatically with the correct line number.

## Visual Studio Code

Microsoft Visual Studio Code allows you to set and use breakpoints with more advanced options than the PowerShell ISE. You can configure conditional breakpoints that are triggered when variables are outside of a range or match a specific value.

Visual Studio Code also makes variable contents easier to inspect. When a breakpoint triggers, the debugger shows a **variables** section that displays each variable's contents.

