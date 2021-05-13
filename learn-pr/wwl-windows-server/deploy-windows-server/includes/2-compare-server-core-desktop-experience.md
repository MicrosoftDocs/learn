When you install Windows Server 2019, you must choose between installing the server with or without the Desktop Experience. 

> [!IMPORTANT]
> This is a critical decision because you can't add or remove the Desktop Experience after you install the server.

Server Core is an installation of Windows Server without the Desktop Experience. Server Core is available for both Standard and Datacenter editions, but it isn't available for Windows Server 2019 Essentials, and the free version of Hyper-V server is only available as a Server Core installation.

You can administer and configure Server Core on the server itself through PowerShell, the command line, or through the text-based tool called Sconfig.

:::image type="content" source="../media/m4-sconfig-1.png" alt-text="A screenshot of Sconfig in an elevated Command Prompt window.":::

Remote administration is the normal method of managing the server by using several tools such as PowerShell Remoting, the Remote Server Administration Tool (RSAT), and the Windows Admin Center. The following table describes the available tools locally.

| Tool | Function |
| ---- | -------- |
|Cmd.exe| Allows you to run traditional command-line tools, such as ping.exe, ipconfig.exe, and netsh.exe.|
|PowerShell.exe| Launches a Windows PowerShell session on the Server Core deployment. You can run PowerShell cmdlets in a Windows PowerShell session. |
|Regedt32.exe| Provides access to the graphical editing tool for registry access within the Server Core environment. |
|Msinfo32.exe| The System Information tool enables you to observe system information about the Server Core deployment. |
|Sconfig.cmd| Serves as a command-line, menu-driven tool to perform common server administration tasks.|
|Taskmgr.exe| Launches Task Manager.|
|Notepad.exe| Opens a graphical text editor.|
|Timedate.cpl| Opens the Date and Time item from Control Panel.|

Server Core has advantages over Windows Server with Desktop Experience and is the recommended installation for most scenarios, but it might not be suitable in every case. The following table lists the major advantages and disadvantages.

| Advantages                                                   | Disadvantages                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Small footprint which uses fewer server resources and less disk space, as little as 5 GB for a basic installation | You can't install several applications on Server Core. The applications include System Center VM Manager 2019, System Center Data Protection Manager 2019, SharePoint Server 2019, Project Server 2019, and Exchange versions prior to Exchange 2019. |
| Because Server Core installs fewer components, there are fewer software updates. This reduces the number of monthly restarts required and the time required for you to service Server Core. | Several roles and role services are not available, including Remote Desktop Services Session Host, Web Access, and Gateway service; Fax Server; SMTP Server; and Windows PowerShell ISE. |
| The small attack surface makes Server Core much less vulnerable to exploits | You can't install many vendor lines of business applications on Server Core. However, the App Compatibility Feature on Demand can help mitigate that in some cases. |

## Available server roles

Although some server roles are not available, the following server roles are available on Server Core deployments:

- Active Directory Certificate Services
- AD DS
- DHCP Server
- DNS Server
- File Services (including File Server Resource Manager)
- Active Directory Lightweight Directory Services (AD LDS)
- Hyper‑V
- Print and Document Services
- Streaming Media Services
- Web Server (including a subset of `ASP.NET`)
- Windows Server Update Server
- Active Directory Rights Management Server
- Remote Access Server

## Post-installation configuration

After you have installed Windows Server, you typically should complete the following:

- Configure the IP address.
- Set the computer name.
- Join an Active Directory domain.
- Configure the time zone.
- Enable automatic updates.
- Add roles and features.
- Enable the Remote Desktop feature.
- Configure Windows Defender Firewall settings.

You can perform this post-installation configuration using Sconfig. You can also use tools such as Windows Admin Center and PowerShell remoting to complete these tasks on Server Core.

> [!NOTE]
> Although you can enable Remote Desktop on Server Core, it only enables RDP connectivity to the to the command line interface.