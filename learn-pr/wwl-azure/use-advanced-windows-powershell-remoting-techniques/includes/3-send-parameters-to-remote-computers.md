You've already learned that **Invoke-Command** cannot include variables in its script block or script file unless the remote computer can understand those variables. As such, it might seem more complicated to find a way to pass data from the initiating computer to the remote computer. However, **Invoke-Command** actually provides a specific mechanism for doing this task.

To review, the intent behind the following command is to display a list of the 10 most recent Security event log entries on each targeted computer. However, the command will not work as written:

```powershell
$Log = 'Security'
$Quantity = 10
Invoke-Command –Computer ONE,TWO –ScriptBlock {
  Get-EventLog –LogName $Log –Newest $Quantity
}
```

The problem is that the variables `$Log` and `$Quantity` have meanings only on the local computer, and those values are not inserted into the script block prior to those values being sent to the remote computers. Therefore, the remote computers don't know what they mean.

The correct syntax for this command is as follows:

```powershell
$Log = 'Security'
$Quantity = 10
Invoke-Command –Computer ONE,TWO –ScriptBlock {
  Param($x,$y) Get-EventLog –LogName $x –Newest $y
} –ArgumentList $Log,$Quantity
```

By using this syntax, the local variables are passed to the *ArgumentList* parameter of **Invoke-Command**. Within the script block, a **Param()** block is created, which contains the same number of variables as the *–ArgumentList* list of values, which, in this case, is two. Note that you can assign any names to the variables within the **Param()** block. They will receive data from the *ArgumentList* parameter based on order. In other words, because `$Log` was listed first on *ArgumentList*, its value will be passed to `$x` because that's the first entry in the **Param()** block. The variables in the **Param()** block can then be used inside the script block, as depicted in the example.

This syntax will work for Windows PowerShell 2.0 and newer. However, Windows PowerShell 3.0 introduced a simplified alternative approach. If you have a local variable `$variable`, and you want to include its contents in a command that will be run on a remote computer, you can run the following syntax:

```powershell
Invoke-Command –ScriptBlock { Do-Something $Using:variable } –ComputerName REMOTE
```

The `$Using:` prefix is properly processed by the local and remote computers, resulting in the `$Using:variable` being replaced with the contents of the local variable `$variable`.
