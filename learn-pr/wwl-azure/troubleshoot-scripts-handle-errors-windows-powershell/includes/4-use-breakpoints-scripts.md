A *breakpoint* pauses a script and provides an interactive prompt. At the interactive prompt, you can query or modify variable values and then continue the script. You use breakpoints to troubleshoot scripts when they aren't behaving as expected.

At a Windows PowerShell prompt, you can set breakpoints by using the **Set-PSBreakPoint** cmdlet. Breakpoints can be set based on the line of the script, a specific command being used, or a specific variable being used. The following example depicts how to set a breakpoint at a specific line of a script:

```powershell
Set-PSBreakPoint -Script "MyScript.ps1" -Line 23
```

When you set a breakpoint based on a line, you need to be careful when you edit the script. As you edit the script, you might add or remove lines, and the breakpoint won't affect the same code that you initially intended.

The following example depicts how to set a breakpoint for a specific command:

```powershell
Set-PSBreakPoint -Command "Set-ADUser" -Script "MyScript.ps1"
```

When you set a breakpoint based on a command, you can include wildcards. For example, you could use the value ***-ADUser** to trigger a breakpoint for **Get-ADUser**, **Set-ADUser**, **New-ADUser**, and **Remove-ADUser**.

To set a breakpoint for a specific variable, do the following:

```powershell
Set-PSBreakPoint -Variable "computer" -Script "MyScript.ps1" -Mode ReadWrite
```

You can use the *-Mode* parameter for variables to identify whether you want to break when the variable value is read, written, or both. Valid values are **Read**, **Write**, and **ReadWrite**.

The default action for **Set-PSBreakPoint** is **break**, which provides the interactive prompt. However, you can use the *-Action* parameter to specify code that runs instead. This allows you to perform complex operations such as evaluating variable values and only breaking if the value is outside a specific range.

> [!NOTE]
> Breakpoints are stored in memory rather than as part of the script. Breakpoints aren't shared between multiple Windows PowerShell prompts and are removed when the prompt is closed.

## PowerShell ISE

In the Windows PowerShell Integrated Scripting Environment (ISE), you can set breakpoints based on the line. Options related to breakpoints are in the **Debug** menu. Lines that you configure as breakpoints are highlighted, making it easy to identify them. Also, in the Windows PowerShell ISE, as you add or remove lines to your script, the breakpoints are updated automatically with the correct line number.

## Visual Studio Code

Microsoft Visual Studio Code allows you to set and use breakpoints with more advanced options than the PowerShell ISE. You can configure conditional breakpoints that are triggered when variables are outside of a range or match a specific value.

Information about variable contents is also easier to find in Visual Studio Code. After a breakpoint is triggered and you're in the debugger, there's a **variables** section that displays the contents of variable so that you don't need to interrogate them.

