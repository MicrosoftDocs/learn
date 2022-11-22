Remoting uses an open-standard protocol called Web Services for Management (WS-Management or WS-MAN). As the name implies, this protocol is built on the same HTTP, or HTTPS, protocol that web browsers use to communicate with web servers. This makes the protocol easier to manage and to route through firewalls. Windows operating systems implement the protocol by using the Windows Remote Management (WinRM) service. PowerShell supports WMI, WS-Management, and Secure Shell (SSH) remoting. In PowerShell 6, Remote Procedure Calls (RPC)-based communication is not supported. In PowerShell 7 and newer, RPC is supported only in Windows.

You must enable remoting on the computers on which you want to receive incoming connections, although no configuration is necessary on computers that are initiating outgoing connections. PowerShell remoting is enabled by default for incoming connections on all currently supported versions of Windows Server. You can also enable it on any computer that's running Windows PowerShell 3.0 or newer.

> [!NOTE]
> While remoting is enabled by default on Windows Server operating systems, it's not enabled by default on client operating systems, including Windows 10 and Windows 11.

Windows PowerShell remoting uses WinRM, which can manage communications for other applications. For example, on a default Windows Server 2016 or newer installation, WinRM manages communications for 64-bit Windows PowerShell, 32-bit Windows PowerShell, and two Server Manager components.

## Remoting architecture

Remoting starts with the WinRM service. It registers one or more listeners, with each listener accepting incoming traffic through either HTTP or HTTPS. Each listener can be bound to a single local IP address or to multiple IP addresses. There is no dependency on Microsoft Internet Information Services (IIS), which means that IIS doesn't have to be installed for WinRM to function.

Incoming traffic includes a packet header that indicates the traffic’s intended destination, or *endpoint*. In Windows PowerShell, these endpoints are also known as *session configurations*. Each endpoint is associated with a specific application. When traffic is directed to an endpoint, WinRM starts the associated application, hands off the incoming traffic, and then waits for the application to complete its task. The application can pass data back to WinRM, and WinRM transmits the data back to the originating computer.

In a Windows PowerShell scenario, you would send commands to WinRM, which then runs the commands. The process is listed as **Wsmprovhost** in the remote computer’s process list. Windows PowerShell would then run those commands and convert the resulting objects (if there are any) into XML. The XML text stream is then handed back to WinRM, which transmits it to the originating computer. Windows PowerShell on the remote computer translates the XML back into static objects. This enables the command results to behave much like any other objects within the Windows PowerShell pipeline.

Windows PowerShell can register multiple endpoints or session configurations with WinRM. In fact, a 64-bit operating system will register an endpoint for both the 64-bit Windows PowerShell host and the 32-bit host, by default. You also can create your own custom endpoints that have highly precise permissions and capabilities assigned to them.

## Windows PowerShell remoting without configuration

Many Windows PowerShell cmdlets have the *ComputerName* parameter that enables you to collect data and change settings on one or more remote computers. These cmdlets use varying communication protocols and work on all Windows operating systems without any special configuration.

These cmdlets include:

- **Restart-Computer**
- **Test-Connection**
- **Clear-EventLog**
- **Get-EventLog**
- **Get-HotFix**
- **Get-Process**
- **Get-Service**
- **Set-Service**
- **Get-WinEvent**
- **Get-WmiObject**

Typically, cmdlets that support remoting without special configuration have the *ComputerName* parameter and don't have the *Session* parameter.

To find these cmdlets in your session, enter:

```powershell
Get-Command | where { $_.parameters.keys -contains "ComputerName" -and $_.parameters.keys -notcontains "Session"}
```

## PowerShell remoting over SSH

PowerShell remoting normally uses WinRM for connection negotiation and data transport. SSH is now available for Linux and Windows platforms and allows true multiplatform PowerShell remoting.

WinRM provides a robust hosting model for PowerShell remote sessions. SSH-based remoting doesn't currently support remote endpoint configuration and Just Enough Administration (JEA).

SSH remoting offers basic PowerShell session remoting between Windows and Linux computers. SSH remoting creates a PowerShell host process on the target computer as an SSH subsystem. Microsoft plans to eventually implement a general hosting model similar to WinRM to support endpoint configuration and JEA.

> [!NOTE]
> The **New-PSSession**, **Enter-PSSession**, and **Invoke-Command** cmdlets now have a new parameter set to support this new remoting connection.

To use PowerShell remoting over SSH, you must install PowerShell 6 or newer and SSH on all computers. Then, you must install both the SSH client (ssh.exe) and server (sshd.exe) executables so that you can remote to and from the computers. OpenSSH for Windows is available starting with Windows 10 build 1809 and Windows Server 2019. For Linux, install the version of SSH (including the sshd.exe server) that's appropriate for your platform. You also need to install the current version of PowerShell from GitHub to ensure that the SSH remoting feature is available. You should configure the SSH server to create an SSH subsystem to host a PowerShell process on the remote computer. You also need to enable either password or key-based authentication.
