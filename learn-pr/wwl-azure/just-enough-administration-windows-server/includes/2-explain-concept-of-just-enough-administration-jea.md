Just Enough Administration (JEA) provides Windows Server and Windows client operating systems with RBAC functionality built on Windows PowerShell remoting. Windows PowerShell remoting is when a Windows PowerShell remote session is started on one computer and the tasks are performed on another computer.

When you configure JEA, an authorized user connects to a specially configured endpoint and uses a specific set of Windows PowerShell cmdlets, parameters, and parameter values. You can also configure a JEA endpoint to allow certain scripts and commands to be run, providing these commands run from within a Windows PowerShell session. For example, you can configure a JEA endpoint to allow an authorized user to only restart specific services, such as the Domain Name System (DNS) service. The user cannot restart any other service or perform any other tasks on the system on which the endpoint is configured. You can also configure a JEA endpoint to enable an authorized user to run a command such as whoami.exe to determine which account is being used with the session.

When connected to the endpoint, JEA uses a special, privileged, virtual account rather than the user’s account to perform tasks. The advantages of this approach include:

- The user’s credentials are not stored on the remote system. If the remote system is compromised, the user’s credentials are not subject to credential theft and cannot be used to traverse the network and gain access to other hosts.

- The user account that's used to connect to the endpoint doesn't need to be privileged. You simply need to configure the endpoint to allow connections from specified user accounts.

- The virtual account is limited to the system on which it is hosted. The virtual account cannot be used to connect to remote systems. This means that attackers cannot use a compromised virtual account to access other protected servers.

- The virtual account has local administrator privileges but is limited to performing only the activities defined by JEA. You can configure the virtual account with membership of a group other than the local Administrators group to further reduce privileges.

## JEA limitations

Configuring JEA can be a complicated process. The person who's configuring JEA role capabilities must understand which cmdlets, parameters, aliases, and values they need to perform administrative tasks. Therefore JEA is most suited for routine configuration tasks such as restarting a service or deploying a container or virtual machine (VM).

JEA is not suitable for tasks where the problem and solution are not clearly defined, and therefore you don’t know which tools you might need to solve the problem. If you don’t know which tools are needed, you can’t configure JEA with the necessary tools.

Also, JEA only works with Windows PowerShell sessions. While you can configure scripts and executable commands to be available in a JEA session, JEA requires that administrative tasks be performed from the Windows PowerShell command line. This will be challenging to staff who primarily use graphical user interface (GUI) tools.

JEA works on the following operating systems directly:

- Windows Server 2016 or later

- Windows 10 or later

