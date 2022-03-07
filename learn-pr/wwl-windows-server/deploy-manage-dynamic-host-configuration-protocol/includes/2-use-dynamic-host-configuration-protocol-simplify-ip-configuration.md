DHCP automatically configures network devices with IP address configuration information. This can help IT support staff at Contoso by simplifying and centralizing the allocation of IP configurations. If Contoso choose not to use DHCP, each time they add a client to their network, they'll need to configure its network interface with information about the network they're connecting it to.

> [!TIP]
> The information that you must configure includes the IP address, the network’s subnet mask, client DNS settings for name resolution, and the default gateway for access to other networks.

## Benefits of DHCP

The main benefit of using DHCP is reducing the maintenance required to configure IP address information on network devices. Many organizations manage thousands of computer devices, including printers, scanners, smartphones, desktop computers, and laptops. Because of this, performing manual management of the network IP configurations for organizations of this size isn't practical.

Because DHCP is an automated process, it's more accurate than manually configuring IP address information. This is particularly important for users that wouldn't know or understand the configuration process.

DHCP makes it easier to update IP address configuration information. As an administrator, when you make a network service change, such as providing a new Domain Name System (DNS) server, you only make a single update on the DHCP servers, and that change is received by all of the DHCP clients. For example, a mobile user with a laptop using DHCP automatically gets new IP address configuration information when they connect to a new network.

> [!NOTE]
> By default, all Windows operating systems automatically retrieve an IP address after the initial installation of the operating system (OS).

## How DHCP works

The DHCP Client service runs on all Windows computers that have their TCP/IP properties set to automatically obtain an IP Address. The DHCP client communicates with a DHCP Server to obtain IP configuration information. Clients can use the assigned DHCP address for a certain period, known as a *lease*. The DHCP server is configured with an address pool and configuration options. This information determines what IP address configuration information is handed out to clients.
The following graphic presents the four-step communication process.

:::image type="content" source="../media/m11-dynamic-host-configuration-protocol-server-communication.png" alt-text="Diagram depicting the communication process between a DHCP server and DHCP client. It consists of DHCPDISCOVER, DHCPOFFER, DHCPREQUEST, and a DHCPACK." border="false":::

Communication for DHCP lease generation uses IP broadcasts. Because IP broadcasts aren't routed, you need to configure a DHCP server on each subnet or configure a DHCP relay. Many routers include DHCP relay functionality.

The four steps in lease generation are:

1. The DHCP client broadcasts a DHCPDISCOVER packet. The only computers that respond are computers that have the DHCP Server role, or computers or routers that are running a DHCP relay agent. In the last case, the DHCP relay agent forwards the message to the DHCP server that you have configured to relay requests.
1. A DHCP Server responds with a DHCPOFFER packet, which contains a potential address for the client. If multiple DHCP servers receive the DHCPDISCOVER packet, then multiple DHCP servers can respond.
1. The client receives the DHCPOFFER packet. If the client receives multiple DHCPOFFER packets, it selects the first response. The client then sends a DHCPREQUEST packet that contains a server identifier. This informs the DHCP servers that receive the broadcast which server’s DHCPOFFER the client has chosen to accept.
1. The DHCP servers receive the DHCPREQUEST. Servers that the client hasn't accepted use this message as the notification that the client has declined that server’s offer. The chosen server stores the IP address-client information in the DHCP database and responds with a DHCPACK message. If the DHCP server can't provide the address that was offered in the initial DHCPOFFER, the DHCP server sends a DHCPNAK message.

## DHCP lease renewal

When the DHCP lease reaches 50 percent of the lease time, the client automatically attempts to renew the lease. This process occurs in the background. It's possible for a computer to have the same DHCP-assigned IP address for a long time. This is because the computer renews the lease multiple times.

To attempt to renew the IP address lease, the client sends a unicast DHCPREQUEST message. The server that originally leased the IP address sends a DHCPACK message back to the client. This message contains any new parameters that have changed since the original lease was created. Note that these packets do not broadcast, because at this point the client has an IP address that it can use for unicast communications.

> [!NOTE]
> When you update DHCP configuration options, clients might not get the updated options until 50 percent of the lease time is complete. For example, if you configure a six-day lease time, clients might not get updated options for three days.

If the DHCP client cannot contact the DHCP server, then the client waits until 87.5 percent of the lease time expires. At this point, the client sends a DHCPREQUEST broadcast (rather than a unicast) to obtain a renewal, and the request goes to all DHCP servers, not just the server that provided the original lease. However, this broadcast request is for a renewal, not a new lease.

Because client computers might be moved while they are turned off (for example, a laptop computer that is plugged into a new subnet), client computers also attempt renewal during the startup process, or when the computer detects a network change. If renewal is successful, the lease period resets.

## DHCP version 6

DHCP version 6 (DHCPv6) supports stateful and stateless configurations for configuring clients in an IPv6 environment. Stateful configuration occurs when the DHCPv6 server assigns the IPv6 address to the client, along with additional DHCP data. Stateless configuration occurs when the router assigns the IPv6 address automatically, and the DHCPv6 server only assigns other IPv6 configuration settings.
