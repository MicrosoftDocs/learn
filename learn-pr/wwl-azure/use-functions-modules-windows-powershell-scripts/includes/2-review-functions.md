A function is a block of reusable code. You can use functions to perform repetitive actions within a script rather than putting the same code in the script multiple times. For example, if you have a large script that can perform multiple actions, rather than putting code that logs data to disk with each action, you can have one function that logs data to disk. Then the logging function is called each time an action is performed. Later, if you want to change that logging function, it only needs to be changed in one place.

When you call a function, you can pass data to it. You use the **Param()** block for a function in the same way as you do for a script. After the declaration for the function, insert the **Param()** block and the definitions for any variables that are expected to be passed to the function. The following example is a function that uses a **Param()** block to accept a computer name:

```powershell
Function Get-SecurityEvent {
   Param (
      [string]$ComputerName
   ) #end Param
   Get-EventLog -LogName Security -ComputerName -$ComputerName -Newest 10
}
```

To call the function within a script, use the following syntax:

```powershell
Get-SecurityEvent -ComputerName LON-DC1
```

In the previous example, the value for the *-Computer* parameter is passed to the `$ComputerName` variable in the function. **Get-EventLog** then queries the most recent 10 events from the security log of that computer and displays them on the screen. If you want those events placed in a variable and available for use in the remainder of the script, use the following syntax:

```powershell
$securityEvents = Get-SecurityEvent -ComputerName LON-DC1
```
