As you've learned, you can disconnect from PSSessions when both the initiating computer and the remote computer are running Windows PowerShell 3.0 and later. Disconnecting is typically a manual process. In some scenarios, Windows PowerShell can automatically place a connection into the **Disconnected** state if the connection is interrupted. However, if you manually close the Windows PowerShell host application it won't disconnect from the sessions, it will just close them.

Using disconnected sessions is similar to the following process:

1. Use **New-PSSession** to create the new PSSession. Optionally, use the PSSession to run commands.
1. Run **Disconnect-PSSession** to disconnect from the PSSession. Pass the PSSession object that you want to disconnect from to the command’s *–Session* parameter.
1. Optionally, move to another computer and open Windows PowerShell.
1. Run **Get-PSSession** with the *–ComputerName* parameter to obtain a list of your PSSessions running on the specified computer.
1. Use **Connect-PSSession** to reconnect to the desired PSSession.

> [!NOTE]
> By default, you can only see and reconnect to your own PSSessions. However, another user can reconnect to a disconnected PSSession if they supply the credentials that were used to create it.

## Retrieve results with Receive-PSSession

**Receive-PSSession** provides an alternative to **Connect-PSSession** that combines reconnection and output retrieval in a single step. When you use `Receive-PSSession`, you reconnect to a disconnected session and immediately retrieve any buffered output from commands that ran while the session was disconnected.

Use `Receive-PSSession` when you want to retrieve results from a long-running command without re-entering an interactive session. Use `Connect-PSSession` when you want to reconnect and run additional commands interactively.

The `-OutTarget` parameter controls how results are displayed. It accepts `Host` (the default, which displays results inline) or `Job` (which returns a background job object for further processing).

```powershell
Receive-PSSession -ComputerName Server01 -Name Session3
```

## Start a command and disconnect immediately

**Invoke-Command** with the `-InDisconnectedSession` parameter provides a fire-and-forget pattern for remote commands. It creates a session, starts the command, and disconnects immediately — all in one step. You don't need to create a persistent session first or manually disconnect after starting the command.

This approach is ideal when you want to start a long-running task and retrieve results later, without managing the session lifecycle yourself. In contrast, the manual workflow (using **New-PSSession** to create a session, running commands, then using **Disconnect-PSSession**) gives you more control but requires more steps.

When using `-InDisconnectedSession`, set the `-IdleTimeoutSec` parameter high enough for the command to complete before the session times out.

```powershell
Invoke-Command -ComputerName Server01 -InDisconnectedSession -ScriptBlock { Get-WinEvent -LogName System }
```

Results are retrieved later using `Receive-PSSession`.
