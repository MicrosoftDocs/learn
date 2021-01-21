As an alternative to using Windows Admin Center, Contoso IT administrators want to use a standard, built-in console to manage groups of server computers. You decide to investigate Server Manager. Server Manager is the built-in management console that most server administrators are familiar with. 

## Overview

You can use the current version of Server Manager to manage the local server and remotely manage up to 100 additional servers.

> [!NOTE]
> This number will depend on the amount of data that you request from managed servers and the hardware and network resources available to the system running Server Manager.

In the Server Manager console, you must manually add remote servers that you want to manage. IT administrators often use Server Manager to remotely manage server core installations.

> [!NOTE]
> Server Manager is included  with RSAT for Windows 10. However, you can only use it to manage remote servers. You can't use Server Manager to manage client operating systems.

Server Manager initially opens to a dashboard which provides quick access to:

- Configuring the local server.
- Adding roles and features.
- Adding other servers to manage.
- Creating a server group.
- Connecting this server to cloud services.

:::image type="content" source="../media/m2-server-manager.png" alt-text="A screenshot of the Server Manager dashboard.":::

> [!NOTE]
> The dashboard provides links to web-based articles about new features in Server Manager and links to learn more about Microsoft solutions.

Server Manager has a section for properties of the local server. From the Local Server node, you can perform different types of initial configuration that are similar to those you can configure with the Sconfig tool, including:

- Computer name and domain membership
- Windows Firewall settings
- Remote Desktop
- Network settings
- Windows Update settings
- Time zone
- Windows activation

:::image type="content" source="../media/m2-server-manager-2.png" alt-text="A screenshot of the Server Manager Local Server pane. Displayed are the options discussed in the preceding text.":::

This section also provides basic information about the hardware, such as:

- Operating system version
- Processor information
- Amount of memory
- Total disk space

There are also sections for:

- Querying specific event logs for various event severity levels over a specific time period.
- Monitoring the status of services and stopping and starting services.
- Best practices analysis to determine if the roles are functioning properly on your servers.
- A display of Performance Monitor that allows you to set alert thresholds on CPU and memory.
- Listing the installed roles and features with the ability to add and remove them.

The navigation pane provides a link to other roles installed on the server, which will provide information about specific roles such as events relating to that role. In some cases, you will observe a sub-menu that allows you to configure aspects about the role, such as File and Storage Services and Remote Desktop Services.
