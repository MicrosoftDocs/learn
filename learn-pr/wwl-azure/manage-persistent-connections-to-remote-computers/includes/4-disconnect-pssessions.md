As you've learned, you can disconnect from PSSessions when both the initiating computer and the remote computer are running Windows PowerShell 3.0 and later. Disconnecting is typically a manual process. In some scenarios, Windows PowerShell can automatically place a connection into the **Disconnected** state if the connection is interrupted. However, if you manually close the Windows PowerShell host application it won't disconnect from the sessions, it will just close them.

Using disconnected sessions is similar to the following process:

1. Use **New-PSSession** to create the new PSSession. Optionally, use the PSSession to run commands.
1. Run **Disconnect-PSSession** to disconnect from the PSSession. Pass the PSSession object that you want to disconnect from to the command’s *–Session* parameter.
1. Optionally, move to another computer and open Windows PowerShell.
1. Run **Get-PSSession** with the *–ComputerName* parameter to obtain a list of your PSSessions running on the specified computer.
1. Use **Connect-PSSession** to reconnect to the desired PSSession.

> [!NOTE]
> You cannot review or reconnect to another user’s PSSessions on a computer.
