

A very important part of Windows Defender is a firewall. You can access firewall settings from Windows Security center or you can find these options in Control Panel, in the Network and Sharing Center and System and Security items. In System and Security, you can configure basic Windows Defender Firewall settings and access the Action Center to view notifications for firewall alerts. In the Network and Sharing Center, you can configure all types of network connections, such as changing the network location profile. You also can configure basic Windows Defender Firewall settings in the Windows Security Center.

You cannot configure all Windows Defender Firewall settings in the Windows Security Center. Some links in the Windows Security Center open the Windows Defender Firewall page in Control Panel.

For Windows computers enrolled in Intune or joined to Azure AD, you can use Microsoft Intune to manage settings for Windows Firewall. These settings are part of the Endpoint protection device configuration profile. When you choose to create a new device configuration profile in Intune and select Endpoint protection, you will be presented with settings available for Windows Firewall. You can manage all features discussed later in this unit by using Microsoft Intune. For computers in Azure AD, this is the recommended way to manage firewall settings.

:::image type="content" source="../media/intune-defender-firewall-38526165.png" alt-text="Screenshot of Windows Defender Firewall.":::


### Firewall exceptions

When you add a program to the list of allowed programs, or open a firewall port, you are allowing that program to send information to or from your computer. Allowing a program to communicate through a firewall is like making an opening in the firewall. Each time that you create another opening, the computer becomes less secure.

Generally, it’s safer to add a program to the list of allowed programs than to open a port in the firewall. If you open a port without scoping the port to a specific app, the opening in the firewall stays open until you close the port, regardless of whether a program is using it. If you add a program to the list of allowed programs, you are allowing the app itself to create an opening in the firewall, but only when necessary. The openings are available for communication only when required by an allowed program or computer.

To add, change, or remove allowed programs and ports, you should perform the following steps:

1.  In Control Panel, on the Windows Defender Firewall page, in the navigation pane, select **Allow an app or feature through Windows Defender Firewall**.
2.  Select **Change settings**.

For example, to view performance counters from a remote computer, you must enable the Performance Logs and Alerts firewall exception on the remote computer.

To help decrease security risks when you open communications:

 -  Only allow a program or open a port when necessary.
 -  Remove programs from the list of allowed programs, or close ports when you do not require them.
 -  Never allow a program that you do not recognize to communicate through the firewall.

#### Multiple active firewall profiles

Windows includes multiple active firewall policies. These firewall policies enable computers to obtain and apply a domain firewall profile, regardless of the networks that are active on the computers. Information technology (IT) professionals can maintain a single set of rules for remote clients and those that physically connect to an organization’s network. To configure or modify profile settings for a network location, select **Change advanced sharing settings** in the navigation pane of the Network and Sharing Center.

:::image type="content" source="../media/windows-defender-settings-console-bf927211.png" alt-text="Screenshot of Windows Defender Security Center, Firewall and network protection.":::


The first time that you connect a computer to a network, you must select whether you trust the network, which sets appropriate firewall and security settings automatically. When you connect to networks in different locations, you can ensure that your computer is always set to an appropriate security level by choosing a network location.

Windows uses network location awareness to identify networks uniquely to which a computer is connected. Network location awareness collects information from networks, including IP addresses and address data for media access control (MAC) address data from important network components, like routers and gateways, to identify a specific network. If network location awareness recognizes the network as one to which the device has connected previously, network location awareness selects the appropriate network location profile. Otherwise, the user might be prompted to select the network location profile to which to connect the device.

There are three types of network location profiles:

 -  **Domain networks**. These typically are workplace networks that attach to a domain. A Windows device automatically appears in this network location if it can communicate with a domain controller for the domain to which it is joined. Network discovery is on by default, and you cannot create or join a HomeGroup.
 -  **Private networks**. These are networks at home or work where you know and trust the people and devices on the network. When you select Home or work (private) networks, this turns on network discovery. Computers on a home network can belong to a HomeGroup.
 -  **Guest or public networks**. These are networks in public places. This location keeps the computer from being visible to other computers. When you select the Public place network location, Windows turns off network discovery.

You can modify the firewall settings for each type of network location from the main Windows Defender Firewall page. Select **Turn Windows Defender Firewall on or off**, select the network location, and then make your selection. You also can modify the following options:

 -  Block all incoming connections, including those in the list of allowed programs.
 -  Notify me when Windows Defender Firewall blocks a new program.

The Public network location blocks certain programs and services from running, which protects a computer from unauthorized access. If you connect to a Public network, and Windows Defender Firewall is on, some programs or services might ask you to allow them to communicate through the firewall so that they can work properly.

### Windows Defender Firewall notifications

You also can display firewall notifications in the taskbar by performing the following steps. In Control Panel, on the Windows Defender Firewall page, in the navigation pane, select **Change notification settings**, and then for each network location, select or clear the **Notify me when Windows Defender Firewall blocks a new app** check box.
