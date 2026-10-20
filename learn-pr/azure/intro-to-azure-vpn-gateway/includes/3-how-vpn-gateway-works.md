You can deploy only one VPN gateway in each Azure virtual network. Even though you're limited to a single VPN gateway, you can configure this gateway to connect to multiple locations, including other Azure virtual networks or on-premises datacenters.

> [!NOTE]
> A virtual network gateway is composed of two or more special VMs that are deployed to a specific subnet called the *gateway subnet*. Virtual network gateway VMs host routing tables and run specific gateway services. When you create the virtual network gateway, it creates these VMs that constitute the gateway. Azure manages them automatically, and they don't require administrative attention.

## VPN gateway types

When you configure a virtual network gateway, you select a setting that specifies the gateway type. The gateway type determines how the virtual network gateway will be used and the actions that the gateway will take. The gateway type `Vpn` specifies that the type of virtual network gateway created is a `VPN gateway`. This distinguishes it from an ExpressRoute gateway, which uses a different gateway type. An Azure virtual network can have two virtual network gateways, one VPN gateway and one ExpressRoute gateway.

There are two types of Azure VPN gateways:

- Policy-based VPN gateway
- Route-based VPN gateway

## Policy-based VPN gateways

Policy-based VPN gateways require that you specify a fixed set of IP addresses of packets that should be encrypted through each tunnel. This type of device evaluates every data packet against those fixed sets of IP addresses, then chooses the tunnel through which it will send that traffic.

Key features of policy-based VPN gateways in Azure include:

- Support for IKEv1 only.
- Use of static routing.

The source and destination of the tunneled networks are declared in the VPN policy and don't need to be declared in routing tables. Use policy-based VPNs only in specific scenarios that require them, such as for compatibility with legacy on-premises VPN devices.

## Route-based VPN gateways

With route-based Azure VPN gateways, an IPsec tunnel functions as a network interface or virtual tunnel interface (VTI). IP routing (static routes or dynamic routing protocols) determines which tunnel interfaces will transmit each packet. Route-based VPNs are the preferred connection method for on-premises devices because they're more resilient to topology changes such as the creation of new subnets. A route-based VPN is far more suitable for Adatum, because it will allow connections to be made to Azure IaaS resources on virtual networks if new subnets are added without having to reconfigure the Azure VPN gateway.

Use a route-based VPN gateway if you need any of the following types of connectivity:

- Connections between virtual networks
- Point-to-site connections
- Multisite connections
- Coexistence with an Azure ExpressRoute gateway

Key features of route-based VPN gateways in Azure include:

- Supports IKEv2.
- Uses any-to-any (wildcard) traffic selectors.
- Can use dynamic routing protocols, where routing/forwarding tables direct traffic to different IPsec tunnels.

When configured to use dynamic routing, the source and destination networks aren't statically defined because they are in policy-based VPNs or even in route-based VPNs with static routing. Instead, data packets are encrypted based on network routing tables that are created dynamically using routing protocols such as Border Gateway Protocol (BGP).

Authentication depends on the connection type. Site-to-site connections use IPsec/IKE and can authenticate with a pre-shared key or, on supported non-Basic gateways, certificates. IKE negotiates the security associations that IPsec uses to protect the tunneled traffic. Point-to-site connections can use certificate, Microsoft Entra ID, or RADIUS authentication, subject to the selected VPN protocol and gateway SKU. Microsoft Entra ID authentication requires OpenVPN and the Azure VPN Client.

## Azure VPN gateway sizes

When you create a virtual network gateway, you need to specify a gateway SKU. You should select a SKU that satisfies your requirements based on the types of workloads, throughput, features, and SLAs.

| Gateway SKUs - Generation1 | Maximum site-to-site VPN tunnels | Aggregate throughput benchmark | BGP support |
|---|---|---|---|
| Basic | 10 (route-based); 1 (policy-based) | 100 Mbps | Not supported |
| VpnGw1AZ | 30 | 650 Mbps | Supported |
| VpnGw2AZ | 30 | 1 Gbps | Supported |
| VpnGw3AZ | 30 | 1.25 Gbps | Supported |

This table shows Generation1 SKUs. Generation2 SKUs are also available and can have different throughput benchmarks. Use an AZ SKU for new deployments; new non-AZ VpnGw1 through VpnGw5 gateways can no longer be created. For an existing non-AZ gateway, follow the [SKU migration guidance](/azure/vpn-gateway/gateway-sku-consolidation) rather than assuming that normal resizing is available. To resize a supported gateway, use the [documented SKU upgrade process](/azure/vpn-gateway/gateway-sku-upgrade). Changing a Basic gateway to another gateway SKU requires deleting and recreating the gateway and causes downtime. For current throughput and supported features, see [About gateway SKUs](/azure/vpn-gateway/about-gateway-skus).

## VPN gateway requirements

The following resources are used for a site-to-site (S2S) connection. To create the VPN gateway itself, first create the virtual network, GatewaySubnet, and public IP resource or resources. S2S connectivity also uses a local network gateway and a connection resource; these aren't prerequisites for creating the VPN gateway resource.

- **Virtual network**: An Azure virtual network with enough address space for the additional subnet that you'll need for the VPN gateway. The address space for this virtual network must not overlap with the on-premises network to which you'll be connecting.
- **GatewaySubnet**: A dedicated subnet named GatewaySubnet. All non-Basic gateway SKUs require a /27 or larger subnet, such as /26 or /25. Basic can use a subnet as small as /29, although /27 or larger provides room for future configurations. Don't deploy other services into this subnet.
- **Public IP address**: Create Standard SKU public IP resources with static allocation for a new VPN gateway. These provide the gateway's public connection endpoints. An active/standby gateway uses one public IP address. An active/active gateway uses one public IP address for each gateway instance; if P2S is enabled, it also requires a third public IP address for the P2S endpoint.
- **Local network gateway**: Create a local network gateway to define the on-premises network's configuration, where the VPN gateway will connect and to what it will connect. This configuration includes the on-premises VPN device's public IPv4 address and the on-premises routable networks. This information is used by the VPN gateway to route packets that are destined for on-premises networks through the IPsec tunnel.

Create the virtual network gateway after the virtual network, GatewaySubnet, and public IP resources are available. After the VPN gateway and local network gateway exist, create an S2S connection resource that links them. The connection uses the following endpoints:

- The connection is made to the on-premises VPN device's IPv4 address as defined by the local network gateway.
- The connection is made from the virtual network gateway and its associated public IP address.

You can configure multiple connections, up to the limit defined by the SKU, for each Azure VPN gateway.

> [!NOTE]
> These connection resources describe an S2S design. Direct P2S connections use client address-pool, protocol, and authentication settings on the VPN gateway; P2S itself doesn't require an on-premises VPN device or a local network gateway. A native VNet-to-VNet connection links the two virtual network gateways, and Azure manages its local-network-gateway information automatically. For the different resource models, see [VPN Gateway topology and design](/azure/vpn-gateway/design).

## High availability

Although Azure shows one VPN gateway resource, the gateway uses two managed virtual machine instances. In active/standby mode, the standby instance takes over automatically when planned maintenance or an unplanned disruption affects the active instance. S2S and VNet-to-VNet connections resume after a brief interruption. Microsoft documents expected recovery within 10 to 15 seconds for planned maintenance and about 1 to 3 minutes in the worst case for unplanned issues. P2S connections are disconnected during failover, and users need to reconnect from their client computers.

Route-based VPN gateways other than Basic can also use an active/active configuration. Each gateway instance has a unique public IP address, and you configure the on-premises VPN device with a separate tunnel to each instance. BGP is optional for this single-on-premises-device design. For dual redundancy, you can add a second on-premises VPN device; that design requires BGP, two local network gateways, and two connection resources. For the topology-specific requirements, see [Design highly available gateway connectivity](/azure/vpn-gateway/vpn-gateway-highlyavailable).

> [!NOTE]
> Many organizations that have ExpressRoute connections also have deployed site-to-site VPN connections for an additional layer of redundancy.
