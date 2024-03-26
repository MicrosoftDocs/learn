When a PowerShell command generates an error, that error might be one of two types, either a *terminating* error or a *non-terminating* error. A terminating error occurs when Windows PowerShell determines that it's not possible to continue processing after the error and the command stops. A non-terminating error occurs when Windows PowerShell determines that it's possible to continue processing after the error. When a non-terminating error occurs, the script running or pipeline running will continue. Non-terminating errors are more common than terminating errors.

Consider the following command:

```powershell
Get-WmiObject -Class Win32_BIOS -ComputerName LON-SVR1,LON-DC1
```

If you assume that the computer **LON-SVR1** isn't available on the network, **Get-WmiObject** generates an error when it tries to query that computer. However, the command could continue with the next computer, **LON-DC1**. The error is therefore a non-terminating error.

## $ErrorActionPreference

Windows PowerShell has a built-in, global variable named `$ErrorActionPreference`. When a command generates a non-terminating error, the command checks that variable to decide what it should do. The variable can have one of the following four possible values:

- **Continue** is the default, and it tells the command to display an error message and continue to run.
- **SilentlyContinue** tells the command to display no error message, but to continue running.
- **Inquire** tells the command to display a prompt asking the user what to do.
- **Stop** tells the command to treat the error as terminating and to stop running.

To set the `$ErrorActionPreference` variable, use the following syntax:

```powershell
$ErrorActionPreference = 'Inquire'
```

> [!NOTE]
> Be selective about using **SilentlyContinue** for `$ErrorActionPreference`. You might think that this makes your script better for users, but it could make troubleshooting difficult.

If you intend to trap an error within your script so that you can manage the error, commands must use the **Stop** action. You can trap and manage only terminating errors.

## -ErrorAction parameter

All Windows PowerShell commands have the *–ErrorAction* parameter. This parameter has the alias *–EA*. The parameter accepts the same values as `$ErrorActionPreference`, and the parameter overrides the variable for that command. If you expect an error to occur on a command, you use *–ErrorAction* to set that command’s error action to **Stop**. Doing this lets you trap and manage the error for that command but leaves all other commands to use the action in `$ErrorActionPreference`. An example is:

```powershell
Get-WmiObject -Class Win32_BIOS -ComputerName LON-SVR1,LON-DC1 -ErrorAction Stop
```

The only time that you'll modify `$ErrorActionPreference` is when you expect an error outside of a Windows PowerShell command, such as when you're running a method such as the following:

```powershell
Get-Process –Name Notepad | ForEach-Object { $PSItem.Kill() }
```

In this example, the **Kill()** method might generate an error. But because it's not a Windows PowerShell command, it doesn't have the *–ErrorAction* parameter. You would instead set `$ErrorActionPreference` to **Stop** before running the method, and then set the variable back to **Continue** after you run the method.

