It's important to know that there are different configurations available for VPN gateway connections. You need to determine which configuration best fits your needs. In the sections below, you can view design information and topology diagrams about the following VPN gateway connections. Use the diagrams and descriptions to help select the connection topology to match your requirements. The diagrams show the main baseline topologies, but it's possible to build more complex configurations using the diagrams as guidelines.

## Site-to-site VPN

A Site-to-site (S2S) VPN gateway connection is a connection over IPsec/IKE (IKEv1 or IKEv2) VPN tunnel. S2S connections can be used for cross-premises and hybrid configurations. A S2S connection requires a VPN device located on-premises that has a public IP address assigned to it. For information about selecting a VPN device, see the VPN Gateway FAQ - VPN devices.

:::image type="content" source="../media/site-to-site-vpn-2350071a.png" alt-text="Diagram showing an example of a Site-to-site VPN.":::


VPN Gateway can be configured in active-standby mode using one public IP or in active-active mode using two public IPs. In active-standby mode, one IPsec tunnel is active and the other tunnel is in standby. In this setup, traffic flows through the active tunnel, and if some issue happens with this tunnel, the traffic switches over to the standby tunnel. Setting up VPN Gateway in active-active mode is recommended in which both the IPsec tunnels are simultaneously active, with data flowing through both tunnels at the same time. An additional advantage of active-active mode is that customers experience higher throughputs.

You can create more than one VPN connection from your virtual network gateway, typically connecting to multiple on-premises sites. When working with multiple connections, you must use a RouteBased VPN type (known as a dynamic gateway when working with classic VNets). Because each virtual network can only have one VPN gateway, all connections through the gateway share the available bandwidth. This type of connection is sometimes referred to as a "multi-site" connection.

:::image type="content" source="../media/ipsec-ikev2-s2s-9770600e.png" alt-text="Diagram showing how a VPN Gateway can be configured in active-standby mode using one public IP or in active-active mode using two public IPs.":::


## Point-to-site VPN

A point-to-site (P2S) VPN gateway connection lets you create a secure connection to your virtual network from an individual client computer. A P2S connection is established by starting it from the client computer. This solution is useful for telecommuters who want to connect to Azure VNets from a remote location, such as from home or a conference. P2S VPN is also a useful solution to use instead of S2S VPN when you have only a few clients that need to connect to a VNet.

Unlike S2S connections, P2S connections don't require an on-premises public-facing IP address or a VPN device. P2S connections can be used with S2S connections through the same VPN gateway, as long as all the configuration requirements for both connections are compatible.

:::image type="content" source="../media/point-to-site-vpn-8139481d.png" alt-text="Diagram showing an example of a Site-to-site VPN.":::
