IT administration staff at Contoso are increasingly focused on performing administrative tasks remotely from the object they're managing. One area of particular interest is the ability to leverage Windows PowerShell to remotely administer and manage Contoso's IT infrastructure. You can use Windows PowerShell remoting to achieve this. 

##  Requirements for remoting

Remoting requires that you have Windows PowerShell on your local computer, and Windows Remote Management enabled on any remote computers to which you want to connect. You also must enable Windows PowerShell remoting.

> [!NOTE]
> Windows PowerShell remoting is enabled by default in Windows Server, but you must enable it on Windows 10.

To enable Windows PowerShell remoting, use one of the following procedures. At an elevated command prompt (or Windows PowerShell (Admin) prompt), run the following command:

```
Winrm quickconfig
```

Alternatively, to enable remoting, you can use the following Windows PowerShell cmdlet:

```PowerShell
Enable-PSremoting -force
```

> [!IMPORTANT]
> Windows Remote Management communicates via HTTP. By default, Windows Remote Management and Windows PowerShell remoting use TCP port 5985 for incoming unencrypted connections, and TCP port 5986 for incoming encrypted connections.

> [!NOTE]
> Applications that use Windows Remote Management—such as Windows PowerShell—can also apply their own encryption to the data that is passed to the Windows Remote Management service.

Any files and other resources that are necessary to run a particular command must be on the remote computer because the remoting commands do not copy any resources. However, you can run local scripts. This is because the script’s contents are sent to the remote computer, rather than the script file itself. 

To perform remote administration, administrators must have permission to:

- Connect to the remote computer
- Run Windows PowerShell
- Access data stores and the registry on the remote computer

> [!CAUTION]
> Enabling remoting on computers with a network interface card (NIC) assigned to the Public network location profile generates an error. You can use `Enable-PSremoting -force` to bypass this restriction, and force remoting on a device with a public NIC.

## Run cmdlets against remote computers

Several cmdlets have a *ComputerName* parameter that enables you to retrieve objects from remote computers. These cmdlets do not use Windows PowerShell remoting to communicate, so you can use the ComputerName parameter in these cmdlets on any computer that runs Windows PowerShell. You do not have to configure the computers for Windows PowerShell remoting, or fulfill system requirements for remoting.

The following table provides more information about the ComputerName parameter.

|**Command**|**Description**|
|--|--|
|`Get-Command –ParameterName ComputerName`|Finds cmdlets that use the ComputerName parameter.|
|`Get-Help <cmdlet-name> -parameter ComputerName` | Determine whether the ComputerName parameter requires Windows PowerShell remoting.|

### Processing remote commands

When you connect to a remote computer and send it a remote command, the command transmits across the network to a Windows PowerShell instance on the remote computer, and then runs on it. The command results are sent back to the local computer and display in the Windows PowerShell session on the local computer.

All of the local input to a remote command is collected before any of it is sent to the remote computer. However, the output is returned to the local computer as it is generated. When you connect to a remote computer, the system uses the user name and password credentials on the local computer to authenticate you to the remote computer.

> [!NOTE]
> By default, the Kerberos version 5 (V5) authentication protocol is used to perform the authorization and authentication. Therefore, an AD DS domain is required.

> [!TIP]
> In situations where the remote computer is not in a domain or is in an untrusted domain, you can allow a client computer to connect by defining the remote computers as trusted hosts.

The following cmdlets support remoting.

- `Invoke-Command`
- `Enter-PSSession`
- `Exit-PSSession`
- `Disconnect-PSSession`
- `Receive-PSSession`
- `Connect-PSSession`

> [!TIP]
> You can create remote tabs using Windows PowerShell ISE. To perform this task, use the **New Remote PowerShell** tab option from the **File** menu in Windows PowerShell ISE.

When you implement remoting, you can connect to the remote machines using a temporary session, or you can create a persistent session.

#### Create a temporary session

For a temporary session, you start the session, run the commands, and then end the session. This is an efficient method for running a single command or several unrelated commands, even on a large number of remote computers.

> [!NOTE]
> Variables or functions defined within commands are no longer available after you close the connection.

To create a temporary connection, use the `Invoke-Command` cmdlet with the *–ComputerName* parameter to specify the remote computers. Then, use the *–ScriptBlock* parameter to specify the command. For example, the following command runs `Get-EventLog` on the SEA-DC1 computer:

```PowerShell
Invoke-Command –ComputerName SEA-DC1 –ScriptBlock {Get-EventLog –log system}
```

#### Create a persistent session

To create a persistent connection with another computer, use the `New-PSSession` cmdlet. For example, the following command creates a session on a remote computer, and saves the session in the $s variable:

```PowerShell
$s = New-PSSession –ComputerName SEA-DC1
```

Use the `Enter-PSSession` cmdlet to connect to and start an interactive session. For example, after you open a new session on SEA-DC1, the following command starts an interactive session with the computer:

```PowerShell
Enter-PSSession $s
```

Once you enter a session, the Windows PowerShell command prompt on your local computer changes to indicate the connection.

:::image type="content" source="../media/m2-remoting.png" alt-text="A screenshot of the Administrator: Windows PowerShell dialog box. The administrator has connected remotely to SEA-DC1.":::

The interactive session remains open until you close it. This enables you to run as many commands as needed. To end the interactive session, enter the following command:

```PowerShell
Exit-PSSession
```

#### Run remote commands on multiple computers

For temporary sessions, the `Invoke-Command` cmdlet accepts multiple computer names. For persistent connections, the *Session* parameter accepts multiple Windows PowerShell sessions. To run a remote command on multiple computers, include all computer names in the *ComputerName* parameter with the `Invoke-Command` cmdlet, and separate the names with commas as demonstrated in the following example:

```PowerShell
Invoke-Command -ComputerName SEA-DC1, SEA-SVR1, SEA-SVR2 -ScriptBlock {Get-Culture}
```

For persistent sessions, you also can run a command in multiple Windows PowerShell sessions. The following commands create Windows PowerShell sessions on SEA-DC1, SEA-SVR1, and SEA-SVR2, and then run a `Get-Culture` command in each Windows PowerShell session:

```PowerShell
$s = New-PSSession -ComputerName SEA-DC1, SEA-SVR1, SEA-SVR2

Invoke-Command -Session $s -ScriptBlock {Get-Culture}
```

> [!TIP]
> To include the local computer in the list of computers, enter the name of the local computer, or a period (**.**), or **localhost**.

### How to run a script on remote computers

To run a local script on remote computers, use the *FilePath* parameter with `Invoke-Command`. The following command runs the Sample.ps1 script on the SEA-DC1 and SEA-SVR1 computers:

```PowerShell
Invoke-Command -ComputerName SEA-DC1, SEA-SVR1 –FilePath C:\Test\Sample.ps1
```

The results of the script are returned to the local computer. By using the *FilePath* parameter, you do not need to copy any files to the remote computers.

## Demonstration

The following video demonstrates how to manage a remote Windows Server by using Windows PowerShell. The main steps in the process are:

1. Launch an elevated PowerShell prompt.
2. Create a PowerShell remoting session by running the following command:

   ```PowerShell
   Enter-PSSession -ComputerName SEA-DC1
   ```

3. Retrieve information about the server, such as name and IP address, using standard Windows PowerShell cmdlets.
4. Check status of IIS service and restart that service using the following command:

   ```PowerShell
   Get-Service -Name IISAdmin | Restart-Service
   ```

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4Mfs3]