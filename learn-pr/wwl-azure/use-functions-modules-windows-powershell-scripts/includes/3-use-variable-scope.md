You might expect that the `$computer` variable you set inside a function is accessible in the script after the function completes. That's not the case. Variables have a specific scope that limits how they interact with other scopes.

The following table describes the three scopes and how they affect variable use.

*Table 1: Scopes*

| **Scope** | **Description**                                              |
| --------- | ------------------------------------------------------------ |
| Global    | Variables set at the PowerShell prompt are available to all scripts started from that prompt, but not to other prompts or ISE instances. |
| Script    | Variables set within a script are available to all functions in that script. If you create a script-scope variable with the same name as a global variable, PowerShell creates a new variable in the script scope, and the script-scope value takes precedence. |
| Function  | Variables set within a function aren't shared with other functions or the script. If you create a function-scope variable with the same name as a global or script variable, PowerShell creates a new variable in the function scope. |

> [!NOTE]
> The Windows PowerShell ISE is no longer in active feature development and only supports Windows PowerShell 5.1 and earlier. For new script development, **Visual Studio Code with the PowerShell extension** is the recommended scripting environment.

> [!NOTE]
> Avoid using the same variable name in different scopes.

In addition to reviewing a variable in a higher-level scope, you can also modify that variable by specifically referencing the scope of the variable when you modify it. To modify a script scope variable from a function, use the following syntax:

```powershell
$script:var = "Modified from function"
```

Avoid modifying variables between scopes, as it can create confusion. Instead, set the script scope variable equal to the output of the function. If the data in the function is in a variable, you can use **Return()** to pass it back to the script.

The following is an example of using **Return()** at the end of a function to pass a variable value back to the script scope:

```powershell
Return($users) 
```

> [!NOTE] 
> Using **Return()** in a function adds the specified data to the pipeline of data being returned, but doesn't replace existing data in the pipeline. As part of script development, you need to verify exactly which data is being returned by a function.
