**Invoke-Command** can't include variables in its script block or script file unless the remote computer can resolve them. Fortunately, **Invoke-Command** provides a built-in way to pass data from the local computer to the remote computers.

The following command is intended to display the 10 most recent Security event log entries on each targeted computer, but it won't work as written:

```powershell
$Log = 'Security'
$Quantity = 10
Invoke-Command –Computer ONE,TWO –ScriptBlock {
  Get-WinEvent –LogName $Log –MaxEvents $Quantity
}
```

The variables `$Log` and `$Quantity` exist only on the local computer. Their values aren't inserted into the script block before it's sent to the remote computers, so the remote computers can't resolve them.

## Pass variables with ArgumentList

The correct syntax for this command is as follows:

```powershell
$Log = 'Security'
$Quantity = 10
Invoke-Command –Computer ONE,TWO –ScriptBlock {
  Param($x,$y) Get-WinEvent –LogName $x –MaxEvents $y
} –ArgumentList $Log,$Quantity
```

> [!NOTE]
> These examples use **Get-WinEvent**, the modern replacement for the deprecated **Get-EventLog** cmdlet. **Get-WinEvent** uses `-MaxEvents` instead of `-Newest` to limit results.

The local variables are passed to the `-ArgumentList` parameter of **Invoke-Command**. Inside the script block, a **Param()** block declares the same number of variables as values in `-ArgumentList`—in this case, two. You can assign any names to the variables in the **Param()** block. They receive values from `-ArgumentList` in order, so because `$Log` is listed first, its value goes to `$x`, which is the first entry in **Param()**. The **Param()** block variables are then available throughout the script block.

## Use the $Using: prefix

This syntax works for Windows PowerShell 2.0 and later. Windows PowerShell 3.0 introduced a simpler alternative. If you have a local variable `$variable` and want to use its value in a command that runs on a remote computer, use the `$Using:` prefix:

```powershell
Invoke-Command –ScriptBlock { Do-Something $Using:variable } –ComputerName REMOTE
```

Both the local and remote computers process the `$Using:` prefix correctly, replacing `$Using:variable` with the value of the local `$variable`.
