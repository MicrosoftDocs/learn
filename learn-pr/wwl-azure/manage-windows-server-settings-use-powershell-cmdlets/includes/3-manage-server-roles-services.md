The **ServerManager** module for PowerShell contains cmdlets for managing server features, roles, and services. These cmdlets are the equivalent of the **Server Manager** user interface. The **Server Manager** cmdlet names include the noun “WindowsFeature.”

> [!NOTE]
> The **ServerManager** module cmdlets can only be targeted against and run on Windows Server operating systems. If you try to use these cmdlets on a Windows client-based operating system, you'll receive an error message.

The following table lists the server management cmdlets.

*Table 1: Server management cmdlets*

| **Cmdlet**                   | **Description**                                                                                                                          |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **Get-WindowsFeature**       | Obtains and displays information about Windows Server roles, services, and features that are installed or are available for installation |
| **Install-WindowsFeature**   | Installs one or more roles, services, or features                                                                                        |
| **Uninstall-WindowsFeature** | Uninstalls one or more roles, services, or features                                                                                      |

The following command installs network load balancing on the local server:

```powershell
Install-WindowsFeature "nlb"

```
