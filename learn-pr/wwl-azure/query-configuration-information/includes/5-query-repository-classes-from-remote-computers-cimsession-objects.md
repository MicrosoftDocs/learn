A Common Information Model (CIM) session is a persistent configuration object that's used when creating a connection to a remote computer. The connection uses WS-MAN by default, but you can specify the DCOM protocol. After a session is created, you can use it to process multiple queries for that computer. This simplifies connectivity because all of the configuration options are contained in the session. A CIM session also allows you to specify connectivity options that aren't available for an ad hoc connection.

## Creating session objects

When you create a session, you should store it in a variable to reference it later. The basic syntax to create a session and store it in a variable is:

```powershell
$s = New-CimSession -ComputerName LON-DC1
```

You can create multiple sessions at the same time:

```powershell
$sessions = New-CimSession -ComputerName LON-CL1,LON-DC1
```

When you create a session, PowerShell doesn't establish the connection immediately. When a cmdlet uses the CIM session, PowerShell connects to the specified computer, and then, when the cmdlet finishes, PowerShell terminates the connection.

> [!NOTE] 
> In some cases, it might be beneficial to use PowerShell remoting instead of CIM sessions for remote connectivity. PowerShell remoting opens a connection to the remote computer and keeps it open until explicitly closed. If you're running multiple queries against a computer, this might improve performance.

## Using sessions

After you've stored the session in a variable, you reference it with CIM cmdlets by using the *-CimSession* parameter. The following example uses a variable that contains multiple sessions:

```powershell
Get-CimInstance -CimSession $sessions -ClassName Win32_OperatingSystem
```

Remember that sessions are designed to work best in a domain environment, between computers in the same domain or in trusting domains. If you have to create a session to a nondomain computer or to a computer in an untrusted domain, you'll need to do additional configuration. You'll learn more about that configuration in Module 8, “Administering remote computers with Windows PowerShell.”

> [!NOTE] 
> The help information for some cmdlets such as **Get-SmbShare** states that they support a *-CimSession* parameter. Those commands use CIM internally. When you use those commands to query a remote computer, you can provide a CIM session object to the *-CimSession* parameter to connect by using an existing session.

## Configuring session options

A session option object allows you to specify many settings for a session. When you create a new session, you specify the session option object to configure the session. The following example creates a session by using DCOM instead of WS-MAN:

```powershell
$opt = New-CimSessionOption -Protocol Dcom
$DcomSession = New-CimSession -ComputerName LON-DC1 -SessionOption $opt
Get-CimInstance -ClassName Win32_BIOS -CimSession $DcomSession
```

The first line in the preceding code creates a session option object that specifies that the DCOM protocol should be used for connectivity. The second line creates a new session by using that session option object and stores it in a variable. The final line uses the session to query the remote computer defined in the session and return the requested information.

## Removing sessions

After you create a session, it remains in memory and available for use until the instance of PowerShell is closed. You can manually remove sessions by using the **Remove-CimSession** cmdlet. The following example removes one or more sessions contained in a variable:

```powershell
$sessions | Remove-CimSession
```

To remove the sessions for a specific remote computer, you can query the sessions for that computer and then remove them, as the following example depicts:

```powershell
Get-CimSession -ComputerName LON-DC1 | Remove-CimSession
```

To remove all sessions, run the following command:

```powershell
Get-CimSession | Remove-CimSession
```
