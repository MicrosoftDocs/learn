Anytime that you manually type a parameter for a command, you override any pipeline input that the parameter might have accepted. You don't force Windows PowerShell to select another parameter for pipeline parameter binding. Consider the following example:

```powershell
Get-Process -Name Notepad | Stop-Process –Name Notepad
```

In this example, **Get-Process** gets a process object that has the **Name** property and passes that object to Stop-Process. However, in this example, the **–Name** parameter was already used manually. That stops pipeline parameter binding. Windows PowerShell won't look for another parameter to bind the input even though there are parameters that accept other properties. In the example above, a parameter that Windows PowerShell wanted to use is taken, so the process is over.

In this case, and in most cases, you'll receive an error even though the property value matches the value you specified for the parameter. For the above command, you receive the following error:

```powershell
Stop-Process : The input object cannot be bound to any parameters for the command either because the command does not take pipeline input or the input and its properties do not match any of the parameters that take pipeline input.
```

The error is misleading. It says, “… the command doesn't take pipeline input.” However, the command does take pipeline input. In this example, you've disabled the command’s ability to accept the pipeline input because you manually specified the parameter that Windows PowerShell wanted to use.

