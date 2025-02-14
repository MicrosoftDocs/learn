RDP Shortpath establishes a direct UDP-based transport between a local device Windows App or the Remote Desktop app on supported platforms and session host in Azure Virtual Desktop.

By default, the Remote Desktop Protocol (RDP) tries to establish a remote session using UDP and uses a TCP-based reverse connect transport as a fallback connection mechanism. UDP-based transport offers better connection reliability and more consistent latency. TCP-based reverse connect transport provides the best compatibility with various networking configurations and has a high success rate for establishing RDP connections.

RDP Shortpath can be used in two ways:

 -  **Managed networks**, where direct connectivity is established between the client and the session host when using a private connection, such as a virtual private network (VPN). A connection using a managed network is established in one of the following ways:
    
    
     -  A *direct* UDP connection between the client device and session host, where you need to enable the RDP Shortpath listener and allow an inbound port on each session host to accept connections.
     -  A *direct* UDP connection between the client device and session host, using the Simple Traversal Underneath NAT (STUN) protocol between a client and session host. Inbound ports on the session host aren't required to be allowed.
 -  **Public networks**, where direct connectivity is established between the client and the session host when using a public connection. There are two connection types when using a public connection, which are listed here in order of preference:
    
    
     -  A *direct* UDP connection using the Simple Traversal Underneath NAT (STUN) protocol between a client and session host.
     -  An *indirect* UDP connection using the Traversal Using Relay NAT (TURN) protocol with a relay between a client and session host. This is in preview.

The transport used for RDP Shortpath is based on the [Universal Rate Control Protocol (URCP)](https://www.microsoft.com/research/publication/urcp-universal-rate-control-protocol-for-real-time-communication-applications/). URCP enhances UDP with active monitoring of the network conditions and provides fair and full link utilization. URCP operates at low delay and loss levels as needed.

 -  During the preview, TURN is only available for connections to session hosts in a validation host pool. To configure your host pool as a validation environment, see [Define your host pool as a validation environment](/azure/virtual-desktop/create-validation-host-pool#define-your-host-pool-as-a-validation-host-pool).
 -  RDP Shortpath for public networks with TURN is only available in the Azure public cloud.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=b5402507-68cd-4b22-a714-2a6688904e59]

## Key benefits

Using RDP Shortpath has the following key benefits:

 -  Using URCP to enhance UDP achieves the best performance by dynamically learning network parameters and providing the protocol with a rate control mechanism.
 -  The removal of extra relay points reduces round-trip time, which improves connection reliability and user experience with latency-sensitive applications and input methods.
 -  In addition, for managed networks:
    
    
     -  RDP Shortpath brings support for configuring Quality of Service (QoS) priority for RDP connections through Differentiated Services Code Point (DSCP) marks.
     -  The RDP Shortpath transport allows limiting outbound network traffic by specifying a throttle rate for each session.

## How RDP Shortpath works for managed networks

You can achieve the direct line of sight connectivity required to use RDP Shortpath with managed networks using the following methods.<br>

 -  [ExpressRoute private peering](/azure/expressroute/expressroute-circuit-peerings)
 -  Site-to-site or Point-to-site VPN (IPsec), such as [Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways)

Having direct line of sight connectivity means that the client can connect directly to the session host without being blocked by firewalls.

> [!NOTE]
> If you're using other VPN types to connect to Azure, we recommend using a UDP-based VPN. While most TCP-based VPN solutions support nested UDP, they add inherited overhead of TCP congestion control, which slows down RDP performance.

To use RDP Shortpath for managed networks, you must enable a UDP listener on your session hosts. By default, port **3390** is used, although you can use a different port.

The diagram gives a high-level overview of the network connections when using RDP Shortpath for managed networks and session hosts joined to an Active Directory domain. :::image type="content" source="../media/rdp-shortpath-managed-networks-59cc7da5.png" alt-text="Diagram of a high-level overview of network connections using RDP Shortpath.":::


### Connection sequence

All connections begin by establishing a TCP-based [reverse connect transport](/azure/virtual-desktop/network-connectivity) over the Azure Virtual Desktop Gateway. Then, the client and session host establish the initial RDP transport, and start exchanging their capabilities. These capabilities are negotiated using the following process:

1.  The session host sends the list of its IPv4 and IPv6 addresses to the client.
2.  The client starts the background thread to establish a parallel UDP-based transport directly to one of the session host's IP addresses.
3.  While the client is probing the provided IP addresses, it continues to establish the initial connection over the reverse connect transport to ensure there's no delay in the user connection.
4.  If the client has a direct connection to the session host, the client establishes a secure connection using TLS over reliable UDP.
5.  After establishing the RDP Shortpath transport, all Dynamic Virtual Channels (DVCs), including remote graphics, input, and device redirection, are moved to the new transport. However, if a firewall or network topology prevents the client from establishing direct UDP connectivity, RDP continues with a reverse connect transport.

If your users have both RDP Shortpath for managed network and public networks available to them, then the first-found algorithm will be used. The user will use whichever connection gets established first for that session.

## How RDP Shortpath works for public networks

To provide the best chance of a UDP connection being successful when using a public connection, there are the *direct* and *indirect* connection types:

 -  **Direct connection**: STUN is used to establish a direct UDP connection between a client and session host. To establish this connection, the client and session host must be able to connect to each other through a public IP address and negotiated port. However, most clients don't know their own public IP address as they sit behind a [Network Address Translation (NAT)](/azure/virtual-desktop/rdp-shortpath?tabs=public-networks#network-address-translation-and-firewalls) gateway device. STUN is a protocol for the self-discovery of a public IP address from behind a NAT gateway device and the client to determine its own public-facing IP address.
    
    For a client to use STUN, its network must allow UDP traffic. Assuming both the client and session host can route to the other's discovered IP address and port directly, communication is established with direct UDP over the WebSocket protocol. If firewalls or other network devices block direct connections, an indirect UDP connection will be tried.
 -  **Indirect connection**: TURN is used to establish an indirect connection, relaying traffic through an intermediate server between a client and session host when a direct connection isn't possible. TURN is an extension of STUN. Using TURN means the public IP address and port is known in advance, which can be allowed through firewalls and other network devices.
    
    TURN typically authorizes access to the server via username/password and its preferred mode of operation is to use UDP sockets. If firewalls or other network devices block UDP traffic, the connection will fall back to a TCP-based reverse connect transport.

When a connection is being established, Interactive Connectivity Establishment (ICE) coordinates the management of STUN and TURN to optimize the likelihood of a connection being established, and ensure that precedence is given to preferred network communication protocols.

Each RDP session uses a dynamically assigned UDP port from an ephemeral port range (**49152** to **65535** by default) that accepts the RDP Shortpath traffic. Port 65330 is ignored from this range as it is reserved for use internally by Azure. You can also use a smaller, predictable port range. For more information, see [Limit the port range used by clients for public networks](/azure/virtual-desktop/configure-rdp-shortpath-limit-ports-public-networks).

The diagram gives a high-level overview of the network connections when using RDP Shortpath for public networks where session hosts joined to Microsoft Entra ID.

:::image type="content" source="../media/rdp-shortpath-public-networks-b4a0af14.png" alt-text="Diagram of network connections when using RDP Shortpath for public networks.":::


### Network Address Translation and firewalls

Most Azure Virtual Desktop clients run on computers on the private network. Internet access is provided through a Network Address Translation (NAT) gateway device. Therefore, the NAT gateway modifies all network requests from the private network and destined to the Internet. Such modification intends to share a single public IP address across all of the computers on the private network.

Because of IP packet modification, the recipient of the traffic will see the public IP address of the NAT gateway instead of the actual sender. When traffic comes back to the NAT gateway, it will take care to forward it to the intended recipient without the sender's knowledge. In most scenarios, the devices hidden behind such a NAT aren't aware translation is happening and don't know the network address of the NAT gateway.

NAT is applicable to the Azure Virtual Networks where all session hosts reside. When a session host tries to reach the network address on the Internet, the NAT Gateway (either your own or default provided by Azure), or Azure Load Balancer performs the address translation.

Most networks typically include firewalls that inspect traffic and block it based on rules. Most customers configure their firewalls to prevent incoming connections (that is, unsolicited packets from the Internet sent without a request). Firewalls employ different techniques to track data flow to distinguish between solicited and unsolicited traffic. In the context of TCP, the firewall tracks SYN and ACK packets, and the process is straightforward. UDP firewalls usually use heuristics based on packet addresses to associate traffic with UDP flows and allow or block it.

### Connection sequence

All connections begin by establishing a TCP-based [reverse connect transport](/azure/virtual-desktop/network-connectivity) over the Azure Virtual Desktop Gateway. Then, the client and session host establish the initial RDP transport, and start exchanging their capabilities. If RDP Shortpath for public networks is enabled on the session host, the session host then initiates a process called *candidate gathering*:

1.  The session host enumerates all network interfaces assigned to a session host, including virtual interfaces like VPN and Teredo.
2.  The Windows service *Remote Desktop Services* (TermService) allocates UDP sockets on each interface and stores the *IP:Port* pair in the candidate table as a *local candidate*.
3.  The Remote Desktop Services service uses each UDP socket allocated in the previous step to try reaching the Azure Virtual Desktop STUN Server on the public internet. Communication is done by sending a small UDP packet to port **3478**.
4.  If the packet reaches the STUN server, the STUN server responds with the public IP and port. This information is stored in the candidate table as a *reflexive candidate*.
5.  After the session host gathers all the candidates, the session host uses the established reverse connect transport to pass the candidate list to the client.
6.  When the client receives the list of candidates from the session host, the client also performs candidate gathering on its side. Then the client sends its candidate list to the session host.
7.  After the session host and client exchange their candidate lists, both parties attempt to connect with each other using all the gathered candidates. This connection attempt is simultaneous on both sides. Many NAT gateways are configured to allow the incoming traffic to the socket as soon as the outbound data transfer initializes it. This behavior of NAT gateways is the reason the simultaneous connection is essential. If STUN fails because it's blocked, an indirect connection attempt is made using TURN.
8.  After the initial packet exchange, the client and session host may establish one or many data flows. From these data flows, RDP chooses the fastest network path. The client then establishes a secure connection using TLS over reliable UDP with the session host and initiates RDP Shortpath transport.
9.  After RDP establishes the RDP Shortpath transport, all Dynamic Virtual Channels (DVCs), including remote graphics, input, and device redirection move to the new transport.
