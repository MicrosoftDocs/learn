A function is a block of reusable code. Use functions to avoid repeating the same code throughout a script. For example, if your script performs multiple actions, create one logging function and call it each time an action runs. If you need to update the logging behavior later, you change it in one place.

When you call a function, you can pass data to it. You use the **Param()** block for a function in the same way as you do for a script. After the declaration for the function, insert the **Param()** block and the definitions for any variables that are expected to be passed to the function. The following example is a function that uses a **Param()** block to accept a computer name:

```powershell
Function Get-SecurityEvent {
   Param (
      [string]$ComputerName
   ) #end Param
   Get-EventLog -LogName Security -ComputerName $ComputerName -Newest 10
}
```

To call the function within a script, use the following syntax:

```powershell
Get-SecurityEvent -ComputerName LON-DC1
```

When you call the function, PowerShell passes the `-ComputerName` value to `$ComputerName` inside the function. **Get-EventLog** then queries the most recent 10 events from the security log of that computer and displays them on the screen. If you want those events placed in a variable and available for use in the remainder of the script, use the following syntax:

```powershell
$securityEvents = Get-SecurityEvent -ComputerName LON-DC1
```

> [!NOTE]
> `Get-EventLog` uses a deprecated Win32 API and is not available in PowerShell 7 or later. For new scripts targeting PowerShell 7+, use `Get-WinEvent -LogName Security -ComputerName $ComputerName -MaxEvents 10` instead.
