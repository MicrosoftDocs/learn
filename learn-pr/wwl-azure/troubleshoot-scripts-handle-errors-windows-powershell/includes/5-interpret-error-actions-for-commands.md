PowerShell errors are either *terminating* or *non-terminating*. A terminating error stops the command immediately — PowerShell can't recover and continue. With a non-terminating error, the script or pipeline keeps running. Non-terminating errors are far more common.

For example:

```powershell
Get-CimInstance -ClassName Win32_BIOS -ComputerName LON-SVR1,LON-DC1
```

If **LON-SVR1** isn't available on the network, **Get-CimInstance** generates an error. However, the command continues with the next computer, **LON-DC1**. That makes this a non-terminating error.

## $ErrorActionPreference

`$ErrorActionPreference` is a built-in global variable. When a non-terminating error occurs, PowerShell checks this variable to determine how to proceed. The variable accepts six values:

- **Continue** is the default. PowerShell displays an error message and continues running.
- **SilentlyContinue** suppresses the error message but continues running. The error is still recorded in `$Error`.
- **Ignore** suppresses the error message and doesn't record the error in `$Error`. Use this only when you're certain the error is expected and irrelevant.
- **Inquire** displays a prompt asking the user what to do.
- **Stop** treats the error as terminating and stops running.
- **Break** enters the PowerShell debugger when an error occurs, enabling interactive investigation of the script state at the point of failure.

To set `$ErrorActionPreference`:

```powershell
$ErrorActionPreference = 'Inquire'
```

> [!NOTE]
> Be selective about using **SilentlyContinue** for `$ErrorActionPreference`. This might seem to make your script friendlier, but it makes troubleshooting much harder.

To trap and manage errors in your script, commands must use the **Stop** action. You can trap and manage only terminating errors.

## -ErrorAction parameter

All PowerShell commands have the `-ErrorAction` parameter (alias: `-EA`). It accepts the same values as `$ErrorActionPreference` and overrides it for that command. If you expect an error, set `-ErrorAction Stop` on that command. This lets you trap and manage errors there while all other commands continue to use `$ErrorActionPreference`. For example:

```powershell
Get-CimInstance -ClassName Win32_BIOS -ComputerName LON-SVR1,LON-DC1 -ErrorAction Stop
```

Use `$ErrorActionPreference` only when you expect an error outside of a PowerShell command — for example, when calling a method:

```powershell
Get-Process –Name Notepad | ForEach-Object { $PSItem.Kill() }
```

The **Kill()** method might generate an error. Because it's not a PowerShell command, it doesn't have the `-ErrorAction` parameter. Instead, set `$ErrorActionPreference` to **Stop** before running the method, and reset it to **Continue** after.

