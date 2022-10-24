You use the **New-PSSession** command to create a persistent connection. The command contains many of the same parameters as **Invoke-Command**, including *-Credential*, *–Port*, and *–UseSSL*. This is because you're creating a connection that is identical to the one **Invoke-Command** creates. However, instead of closing this connection immediately, you're leaving it running.

PowerShell sessions do have an idle timeout, after which the remote computer will close them automatically. A closed PowerShell session differs from a disconnected PowerShell session, because closed PowerShell sessions can't be reconnected. In this case, you can only remove the PowerShell session, and then recreate it.

**New-PSSession** can accept multiple computer names, which causes it to create multiple PowerShell session objects. When you run the **New-PSSession** command, it outputs objects representing the newly created PowerShell sessions. You can assign these PowerShell sessions to a variable to make them easier to refer to, and to use in the future.

You can use a PowerShell session as soon as you create it. Both the **Invoke-Command** and **Enter-PSSession** commands can accept a PowerShell session object instead of a computer name. **Invoke-Command** can accept multiple PowerShell session objects. You use the commands’ *–Session* parameter for this purpose. When you use this parameter, the commands use the existing PowerShell session instead of creating a new connection. When your command finishes running or you exit the PowerShell session, the PowerShell session remains running and connected, and ready for future use.

For example, you can use the following commands to enter a PowerShell session on **LON-CL1** and then close it:

```powershell
$client = New-PSSession –ComputerName LON-CL1
Enter-PSSession –Session $client
Exit-PSSession
```

Alternatively, you could use the following commands to achieve the same results:

```powershell
$computers = New-PSSession –ComputerName LON-CL1,LON-DC1
Invoke-Command –Session $computers –ScriptBlock { Get-Process }
```

For example, the following command can use the `$dc` variable to open a PowerShell session to **LON-DC1** within a script or code block:

```powershell
$dc = New-PSSession –ComputerName LON-DC1
```

The following command creates remote sessions on **Server01** and **Server02**, and the session objects are stored in the `$s` variable:

```powershell
$s = New-PSSession -ComputerName Server01, Server02
```

Now that the sessions are established, you can run any command in them. And because the sessions are persistent, you can collect data from one command and use it in another command.

For example, the following command runs a **Get-HotFix** command in the sessions in the `$s` variable, and it saves the results in the `$h` variable:

```powershell
Invoke-Command -Session $s {$h = Get-HotFix}
```

The `$h` variable is created in each of the sessions in `$s`, but it doesn't exist in the local session. Now you can use the data in the `$h` variable with other commands in the same session, and the results are displayed on the local computer. For example:

```powershell
Invoke-Command -Session $s {$h | where {$_.InstalledBy -ne "NTAUTHORITY\SYSTEM"}}
```
