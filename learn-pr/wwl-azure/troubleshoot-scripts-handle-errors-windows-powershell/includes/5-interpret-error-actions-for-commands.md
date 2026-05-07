When a PowerShell command generates an error, that error is either a *terminating* error or a *non-terminating* error. A terminating error stops the command because Windows PowerShell can't continue processing. A non-terminating error allows processing to continue — the script or pipeline keeps running. Non-terminating errors are more common than terminating errors.

Consider the following command:

```powershell
Get-CimInstance -ClassName Win32_BIOS -ComputerName LON-SVR1,LON-DC1
```

If **LON-SVR1** isn't available on the network, **Get-CimInstance** generates an error when it tries to query that computer. However, the command continues with the next computer, **LON-DC1**. That makes this a non-terminating error.

## $ErrorActionPreference

`$ErrorActionPreference` is a built-in global variable. When a non-terminating error occurs, PowerShell checks this variable to determine how to proceed. The variable accepts six values:

- **Continue** is the default. PowerShell displays an error message and continues running.
- **SilentlyContinue** suppresses the error message but continues running. The error is still recorded in `$Error`.
- **Ignore** suppresses the error message and doesn't record the error in `$Error`. Use this only when you're certain the error is expected and irrelevant.
- **Inquire** displays a prompt asking the user what to do.
- **Stop** treats the error as terminating and stops running.
- **Break** enters the PowerShell debugger when an error occurs, enabling interactive investigation of the script state at the point of failure.

To set the `$ErrorActionPreference` variable, use the following syntax:

```powershell
$ErrorActionPreference = 'Inquire'
```

> [!NOTE]
> Be selective about using **SilentlyContinue** for `$ErrorActionPreference`. You might think that this makes your script better for users, but it could make troubleshooting difficult.

To trap and manage errors in your script, commands must use the **Stop** action. You can trap and manage only terminating errors.

## -ErrorAction parameter

All Windows PowerShell commands have the `-ErrorAction` parameter. This parameter has the alias `-EA`. The parameter accepts the same values as `$ErrorActionPreference` and overrides it for that command. If you expect an error on a command, use `-ErrorAction` to set that command's error action to **Stop**. Setting `-ErrorAction Stop` lets you trap and manage errors for that command while leaving all other commands to use `$ErrorActionPreference`. For example:

```powershell
Get-CimInstance -ClassName Win32_BIOS -ComputerName LON-SVR1,LON-DC1 -ErrorAction Stop
```

Modify `$ErrorActionPreference` only when you expect an error outside of a Windows PowerShell command, such as when you're running a method like the following:

```powershell
Get-Process –Name Notepad | ForEach-Object { $PSItem.Kill() }
```

In this example, the **Kill()** method might generate an error. Because it's not a Windows PowerShell command, it doesn't have the `-ErrorAction` parameter. Instead, set `$ErrorActionPreference` to **Stop** before running the method, and set it back to **Continue** after.

