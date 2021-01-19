Most of the Windows Server computers being deployed at Contoso are Server Core. Server Core has no GUI, so after the initial installation, you're presented with only a command prompt. 

## What is Sconfig?

Sconfig is a text-based tool that allows you to do the basic configuration of Server Core to prepare it for use in your production environment.

> [!NOTE]
> Sconfig is included in both Windows Server Desktop Experience and Server Core.

You typically use Sconfig to perform the initial configuration directly after the installation completes, but you can run it at any time to change the settings as required.

:::image type="content" source="../media/m3-sconfig1.png" alt-text="A screenshot of Sconfig in an elevated Command Prompt window. Available options are described in the following table.":::

Sconfig provides several options, which are described in the following table.

| Option                       | Description                                                  |
| - |  |
| Domain/Workgroup             | Join the domain or workgroup of choice                       |
| Computer Name                | Set the computer name                                        |
| Add Local Administrator      | Add users to the local Administrators group       |
| Configure Remote Management  | Remote management is enabled by default. This setting allows you to enable or disable remote management and configure the server to respond to a ping. |
| Windows Update Settings      | Configure the server to use automatic, download only or manual updates. |
| Download and Install Updates | Perform an immediate search for all updates or only recommended updates. |
| Network Settings             | Configure the IP address to be assigned automatically by a Dynamic Host Configuration Protocol (DHCP) Server or you can assign a static IP address manually. This option also allows you to configure Domain Name System (DNS) Server settings for the server. |
| Date and Time                | Brings up the GUI for changing the date, time, and time zone. It also has tabs to add clocks and choose an Internet time server to sync with. |
| Telemetry Settings           | Allows Windows to periodically collect and upload statistical information about the server and upload it to Microsoft. |
| Windows Activation           | Provides three options—Display license info, Activate Windows, and Install product key |
| Log Off User                 | Signs out the current user                                    |
| Restart Server               | Restarts the server                                          |
| Shut Down Server             | Shuts down the server                                        |
| Exit to Command Line         | Returns to the command prompt                                |

## Demonstration

The following video demonstrates how to implement complete post-installation configuration by using Sconfig. The main steps in the process are:

1. Run the Sconfig.exe command.
2. Review the available options.
3. Reconfigure the date and time.
4. Review the network settings.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4Mfs4]