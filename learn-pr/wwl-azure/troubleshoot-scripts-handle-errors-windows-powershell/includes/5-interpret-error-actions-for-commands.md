When a PowerShell command generates an error, that error is either a *terminating* error or a *non-terminating* error. A terminating error stops the command because Windows PowerShell can't continue processing. A non-terminating error allows processing to continue — the script or pipeline keeps running. Non-terminating errors are more common than terminating errors.

Consider the following command:

```powershell
Get-CimInstance -ClassName Win32_BIOS -ComputerName LON-SVR1,LON-DC1
```

If **LON-SVR1** isn't available on the network, **Get-CimInstance** generates an error when it tries to query that computer. However, the command could continue with the next computer, **LON-DC1**. The error is therefore a non-terminating error.

## $ErrorActionPreference

Windows PowerShell has a built-in, global variable named `$ErrorActionPreference`. When a command generates a non-terminating error, the command checks that variable to decide what it should do. The variable can have one of the following six possible values:

- **Continue** is the default, and it tells the command to display an error message and continue to run.
- **SilentlyContinue** tells the command to display no error message, but to continue running. The error is still recorded in `$Error`.
- **Ignore** suppresses the error message and does not record the error in `$Error`. Use this only when you're certain the error is expected and irrelevant.
- **Inquire** tells the command to display a prompt asking the user what to do.
- **Stop** tells the command to treat the error as terminating and to stop running.
- **Break** enters the PowerShell debugger when an error occurs, enabling interactive investigation of the script state at the point of failure.

To set the `$ErrorActionPreference` variable, use the following syntax:

```powershell
$ErrorActionPreference = 'Inquire'
```

> [!NOTE]
> Be selective about using **SilentlyContinue** for `$ErrorActionPreference`. You might think that this makes your script better for users, but it could make troubleshooting difficult.

If you intend to trap an error within your script so that you can manage the error, commands must use the **Stop** action. You can trap and manage only terminating errors.

## -ErrorAction parameter

All Windows PowerShell commands have the `-ErrorAction` parameter. This parameter has the alias `-EA`. The parameter accepts the same values as `$ErrorActionPreference` and overrides it for that command. If you expect an error on a command, use `-ErrorAction` to set that command's error action to **Stop**. Setting `-ErrorAction Stop` lets you trap and manage errors for that command while leaving all other commands to use `$ErrorActionPreference`. An example is:

```powershell
Get-CimInstance -ClassName Win32_BIOS -ComputerName LON-SVR1,LON-DC1 -ErrorAction Stop
```

Modify `$ErrorActionPreference` only when you expect an error outside of a Windows PowerShell command, such as when you're running a method like the following:

```powershell
Get-Process –Name Notepad | ForEach-Object { $PSItem.Kill() }
```

In this example, the **Kill()** method might generate an error. Because it's not a Windows PowerShell command, it doesn't have the `-ErrorAction` parameter. Instead, set `$ErrorActionPreference` to **Stop** before running the method, and set it back to **Continue** after.

