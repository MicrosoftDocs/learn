The Remote Access server role in Windows Server provides multiple remote access options. Each option represents a unique technology that organizations like Contoso can use to access internal resources from offices in remote site locations or from the internet. The technology that Contoso IT decides to use depends on their specific business goals.

## Supported remote access features

Windows Server supports several remote access features.

### VPN

VPN connections enable users that are working offsite (for example, from home, a customer site, or a public wireless access point) to access apps and data on an organization’s private network by using the infrastructure that a public network, such as the internet, provides.

From the user’s perspective, the VPN is a point-to-point connection between a computer, the VPN client, and an organization’s server. The exact infrastructure of the shared or public network is irrelevant because it appears to the user as if the data is sent over a dedicated private link.

Windows Server supports a number of different configurations with VPNs, including site-to-site, and remote access, displayed in the following graphic.

:::image type="content" source="../media/m15-vpn-1.png" alt-text="A diagram displays a remote VPN client. The client has a secured connection through the internet a VPN server, and then onto the intranet. A number of server resources are displayed in the intranet." border="false":::

### Routing

Windows Server can function as a router or network address translation (NAT) device between two internal networks, or between the internet and the internal network. Routing works with routing tables and supports routing protocols including:

- Routing Information Protocol (RIP) version 2.
- Internet Group Management Protocol (IGMP).
- Dynamic Host Configuration Protocol (DHCP) Relay Agent.

> [!TIP]
> Although you can use Windows Server for these routing tasks, it's uncommon to do so, because most organizations have specialized hardware devices to perform these tasks.

### Web Application Proxy

Web Application Proxy provides reverse proxy functionality for users who must access their organization’s internal web applications from the internet. Web Application Proxy preauthenticates users by using the following options:

- Active Directory Federation Services (AD FS) technology, where Web Application Proxy acts as an AD FS proxy.
- Pass-through authentication, where the published application, not Web Application Proxy, performs authentication.

### DirectAccess

DirectAccess enables remote users to securely access corporate resources such as email servers, shared folders, and internal websites, without connecting to a virtual private network (VPN). DirectAccess also provides increased productivity for a mobile workforce by offering the same connectivity experience both inside and outside the office.

> [!IMPORTANT]
> Windows 10 Enterprise and Education editions support DirectAccess.

## Overview of remote application access

Remote application access is an important part of supporting mobile users and users in remote offices. How you provide remote access to apps varies depending on the architecture of the app. However, for all apps, you need to ensure that remote access to the app is secure.

### Remote access to data files

When you use a VPN or DirectAccess to access data files like Microsoft Word documents or Microsoft Excel spreadsheets, it can take longer to open and close files than when you're in the office, but performance is typically acceptable. The slower performance is primarily because of slower network speeds at remote locations and over the internet.

### Remote access to desktop apps

For apps that use shared data storage, such as a database, using a VPN or DirectAccess often causes slow performance. Most developers don't optimize their apps to run over slower connections with high latency. Thus, the apps have many communication calls with the backend data storage. The additional latency on each call adds up to very slow performance.

To support apps with shared data storage it is common to implement Remote Desktop Services (RDS). When you implement RDS, the app is installed on a Remote Desktop Session Host (RD Session Host) located on the internal network that is shared by multiple users. The app remains close to the data, so network latency doesn't cause performance issues.

> [!TIP]
> Users connect to the RD Session Host by using the Remote Desktop client which uses Remote Desktop Protocol (RDP).

### Remote access to web-based apps

Web-based apps have good performance on slower and higher latency networks. This is because the application logic is stored on a web server that is close to the application data. Only a limited amount of data to be displayed on screen is sent to the web browser. This means that web-based apps are well suited to use by mobile users and remote offices.

The HTTPS protocol which encrypts communication is typically used for web-based apps. This ensures that data can't be intercepted while in transit, but most companies also require the web-based app to be isolated from the internet by a reverse proxy. Remote users communicate with a reverse proxy in a perimeter network and the reverse proxy communicates with the web-based app on the internal network.

> [!IMPORTANT]
> Web Application Proxy functions as a reverse proxy for web-based apps.

## Manage remote access in Windows Server

After you install the Remote Access role on a server that is running Windows Server, you can manage the role by using the Remote Access Management console, and the Routing and Remote Access console, or Windows PowerShell.

### Remote Access Management console

The Remote Access Management console allows you to manage DirectAccess, virtual private networks (VPN), and Web Application Proxy. When you open this console for the first time, you'll use a wizard-based interface to configure remote access settings according to your business requirements.

After you configure the initial remote access settings, you can manage your remote access solution with the options described in the following table.

| Option               | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| Configuration        | You can edit the remote access settings by using wizards and by using the graphical representation of the current network configuration in the console. |
| Dashboard            | You can monitor the overall status of servers and clients that are part of your remote access solution. |
| Operations status    | You can access detailed information on the status of the servers that are part of your remote access solution. |
| Remote Client Status | You can access detailed information on the status of the clients that are connecting to your remote access solution. |
| Reporting            | You can generate historical reports on different parameters, such as remote access usage, access details, connection details, and server load statistics. |

:::image type="content" source="../media/m15-remote-access-management-console-1.png" alt-text="A screenshot of the Remote Access Management Console. The Dashboard is selected.":::

### Routing and Remote Access console

You can use the Routing and Remote Access console to configure a server running Windows Server as a NAT device, as a router for both IPv4 and IPv6 protocols, as a DHCP proxy, and as a VPN server. After you complete the configuration, you can manage the remote access solution by using the options described in the following table.

| Option                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Server Status                                                | You can monitor the status of the Remote Access server, the ports in use, and how long the server has been operational. |
| Remote Access Client, Ports, Remote Access Logging & Policies | You can monitor the client status, port status, and detailed logging information about clients that are connected to the Remote Access server. |
| IPv4                                                         | You can configure the IPv4 settings such as NAT, IPv4 routing with static routes, and these routing protocols: RIP version 2, IGMP, and the DHCP Relay Agent. |
| IPv6                                                         | You can configure IPv6 settings, such as IPv6 routing with static routes and the DHCP Relay Agent routing protocol. |

:::image type="content" source="../media/m15-remote-access-management-console-2.png" alt-text="A screenshot of the Routing and Remote Access console. SEA-ADM1 is setup as a VPN server.":::
