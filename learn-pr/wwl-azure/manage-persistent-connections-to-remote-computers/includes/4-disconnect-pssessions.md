You can disconnect from PSSessions when both the initiating computer and the remote computer are running Windows PowerShell 3.0 or later. Disconnecting is typically a manual process. Windows PowerShell can automatically place a connection in the **Disconnected** state if the connection is interrupted. However, if you close the Windows PowerShell host application, it closes the sessions rather than disconnecting from them.

Using disconnected sessions follows this process:

1. Use **New-PSSession** to create the new PSSession. Optionally, use the PSSession to run commands.
1. Run **Disconnect-PSSession** to disconnect from the PSSession. Pass the PSSession object you want to disconnect from to the `-Session` parameter.
1. Optionally, move to another computer and open Windows PowerShell.
1. Run **Get-PSSession** with the `-ComputerName` parameter to get a list of your PSSessions on the specified computer.
1. Use **Connect-PSSession** to reconnect to the desired PSSession.

> [!NOTE]
> By default, you can only see and reconnect to your own PSSessions. However, another user can reconnect to a disconnected PSSession if they provide the credentials used to create it.

## Retrieve results with Receive-PSSession

**Receive-PSSession** is an alternative to **Connect-PSSession** that combines reconnection and output retrieval in a single step. It reconnects to a disconnected session and immediately retrieves any buffered output from commands that ran while the session was disconnected.

Use **Receive-PSSession** when you want to retrieve results from a long-running command without re-entering an interactive session. Use **Connect-PSSession** when you want to reconnect and run more commands interactively.

The `-OutTarget` parameter controls how results are displayed. It accepts `Host` (the default, which displays results inline) or `Job` (which returns a background job object for further processing).

```powershell
Receive-PSSession -ComputerName Server01 -Name Session3
```

## Start a command and disconnect immediately

**Invoke-Command** with the `-InDisconnectedSession` parameter creates a session, starts the command, and disconnects immediately—all in one step. You don't need to create a persistent session first or manually disconnect after starting the command.

Use this approach when you want to start a long-running task and retrieve results later, without managing the session yourself. The manual workflow—creating a session with **New-PSSession**, running commands, then calling **Disconnect-PSSession**—gives you more control but requires more steps.

When you use `-InDisconnectedSession`, set `-IdleTimeoutSec` high enough for the command to complete before the session times out.

```powershell
Invoke-Command -ComputerName Server01 -InDisconnectedSession -ScriptBlock { Get-WinEvent -LogName System }
```

Results are retrieved later using **Receive-PSSession**.
