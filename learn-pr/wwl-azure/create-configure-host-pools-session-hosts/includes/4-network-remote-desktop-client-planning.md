## Network

There are several network requirements you need to meet to successfully deploy Azure Virtual Desktop. This lets users connect to their desktops and applications while also giving them the best possible user experience.

Users connecting to Azure Virtual Desktop securely establish a reverse connection to the service, which means you don't need to open any inbound ports. Transmission Control Protocol (TCP) on port 443 is used by default, however RDP Shortpath can be used for [managed networks](/azure/virtual-desktop/shortpath) and [public networks](/azure/virtual-desktop/shortpath-public) that establish a direct User Datagram Protocol (UDP)-based transport.

To successfully deploy Azure Virtual Desktop, you need to meet the following network requirements:

 -  You need a virtual network and subnet for your session hosts. If you create your session hosts at the same time as a host pool, you must create this virtual network in advance for it to appear in the drop-down list. Your virtual network must be in the same Azure region as the session host.
 -  Make sure this virtual network can connect to your domain controllers and relevant DNS servers if you're using AD DS or Microsoft Entra Domain Services, since you need to join session hosts to the domain.
 -  Your session hosts and users need to be able to connect to the Azure Virtual Desktop service. These connections also use TCP on port 443 to a specific list of URLs. For more information, see [Required URL list](/azure/virtual-desktop/safe-url-list). You must make sure these URLs aren't blocked by network filtering or a firewall in order for your deployment to work properly and be supported. If your users need to access Microsoft 365, make sure your session hosts can connect to [Microsoft 365 endpoints](/microsoft-365/enterprise/microsoft-365-endpoints).

Also consider the following:

 -  Your users might need access to applications and data that is hosted on different networks, so make sure your session hosts can connect to them.
 -  Round-trip time (RTT) latency from the client's network to the Azure region that contains the host pools should be less than 150 ms. To see which locations have the best latency, look up your desired location in [Azure network round-trip latency statistics](/azure/networking/azure-network-latency). To optimize for network performance, we recommend you create session hosts in the Azure region closest to your users.
 -  Use [Azure Firewall for Azure Virtual Desktop deployments](/azure/firewall/protect-azure-virtual-desktop) to help you lock down your environment and filter outbound traffic.
 -  To help secure your Azure Virtual Desktop environment in Azure, we recommend you don't open inbound port 3389 on your session hosts. Azure Virtual Desktop doesn't require an open inbound port to be open. If you must open port 3389 for troubleshooting purposes, we recommend you use [just-in-time VM access](/azure/security-center/security-center-just-in-time). We also recommend you don't assign a public IP address to your session hosts.

> [!NOTE]
> To keep Azure Virtual Desktop reliable and scalable, we aggregate traffic patterns and usage to check the health and performance of the infrastructure control plane. We aggregate this information from all locations where the service infrastructure is, then send it to the US region. The data sent to the US region includes scrubbed data, but not customer data. For more information, see [Data locations for Azure Virtual Desktop](/azure/virtual-desktop/data-locations).

## Session host management

Consider the following points when managing session hosts:

 -  Don't enable any policies or configurations that disable *Windows Installer*. If you disable Windows Installer, the service can't install agent updates on your session hosts, and your session hosts won't function properly.
 -  If you're joining session hosts to an AD DS domain and you want to manage them using [Intune](/mem/intune/fundamentals/what-is-intune), you need to configure [Microsoft Entra Connect](/azure/active-directory/hybrid/whatis-azure-ad-connect) to enable [Microsoft Entra hybrid join](/azure/active-directory/devices/hybrid-join-plan).
 -  If you're joining session hosts to a Microsoft Entra Domain Services domain, you can't manage them using [Intune](/mem/intune/fundamentals/what-is-intune).
 -  If you're using Microsoft Entra join with Windows Server for your session hosts, you can't enroll them in Intune as Windows Server isn't supported with Intune. You need to use Microsoft Entra hybrid join and Group Policy from an Active Directory domain, or local Group Policy on each session host.

## Remote Desktop clients

Your users need a [Remote Desktop client](/windows-server/remote/remote-desktop-services/clients/remote-desktop-clients) to connect to desktops and applications. The following clients support Azure Virtual Desktop:

 -  [Windows Desktop client](/azure/virtual-desktop/users/connect-windows)
 -  [Azure Virtual Desktop Store app for Windows](/azure/virtual-desktop/users/connect-windows-azure-virtual-desktop-app)
 -  [Web client](/azure/virtual-desktop/users/connect-web)
 -  [macOS client](/azure/virtual-desktop/users/connect-macos)
 -  [iOS and iPadOS client](/azure/virtual-desktop/users/connect-ios-ipados)
 -  [Android and Chrome OS client](/azure/virtual-desktop/users/connect-android-chrome-os)
 -  [Remote Desktop app for Windows](/azure/virtual-desktop/users/connect-microsoft-store)

> [!IMPORTANT]
> Azure Virtual Desktop doesn't support connections from the RemoteApp and Desktop Connections (RADC) client or the Remote Desktop Connection (MSTSC) client.

To learn which URLs clients use to connect and that you must allow through firewalls and internet filters, see the [Required URL list](/azure/virtual-desktop/safe-url-list).
