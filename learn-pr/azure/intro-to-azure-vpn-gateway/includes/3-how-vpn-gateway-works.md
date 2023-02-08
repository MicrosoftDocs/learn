You can deploy only one VPN gateway in each Azure virtual network. Even though you're limited to a single VPN gateway, you can configure this gateway to connect to multiple locations, including other Azure virtual networks or on-premises datacenters.

> [!NOTE]
> A virtual network gateway is composed of two or more special VMs that are deployed to a specific subnet called the *gateway subnet*. Virtual network gateway VMs host routing tables and run specific gateway services. These VMs that constitute the gateway are created when you create the virtual network gateway and are managed automatically by Azure and do not require administrative attention.

## VPN gateway types

When you configure a virtual network gateway, you select a setting that specifies the gateway type. The gateway type determines how the virtual network gateway will be used and the actions that the gateway will take. The gateway type `Vpn` specifies that the type of virtual network gateway created is a `VPN gateway`. This distinguishes it from an ExpressRoute gateway, which uses a different gateway type. An Azure virtual network can have two virtual network gateways: one VPN gateway and one ExpressRoute gateway.

There are two types of Azure VPN gateways:

- Policy-based VPN gateway
- Route-based VPN gateway

## Policy-based VPN gateways

Policy-based VPN gateways require that you specify a fixed set of IP addresses of packets that should be encrypted through each tunnel. This type of device evaluates every data packet against those fixed sets of IP addresses, then chooses the tunnel through which it will send that traffic.

Key features of policy-based VPN gateways in Azure include:

- Support for IKEv1 only
- Use of static routing

The source and destination of the tunneled networks are declared in the VPN policy and don't need to be declared in routing tables. Use policy-based VPNs only in specific scenarios that require them, such as for compatibility with legacy on-premises VPN devices.

## Route-based VPN gateways

With route-based Azure VPN gateways, an IPsec tunnel functions as a network interface or virtual tunnel interface (VTI). IP routing (static routes or dynamic routing protocols) determines which tunnel interfaces will transmit each packet. Route-based VPNs are the preferred connection method for on-premises devices because they are more resilient to topology changes such as the creation of new subnets. A route-based VPN is far more suitable for Adatum, because it will allow connections to be made to Azure IaaS resources on virtual networks if new subnets are added without having to reconfigure the Azure VPN gateway.

Use a route-based VPN gateway if you need any of the following types of connectivity:

- Connections between virtual networks
- Point-to-site connections
- Multisite connections
- Coexistence with an Azure ExpressRoute gateway

Key features of route-based VPN gateways in Azure include:

- Supports IKEv2
- Uses any-to-any (wildcard) traffic selectors
- Can use dynamic routing protocols, where routing/forwarding tables direct traffic to different IPsec tunnels

When configured to use dynamic routing, the source and destination networks are not statically defined because they are in policy-based VPNs, or even in route-based VPNs with static routing. Instead, data packets are encrypted based on network routing tables that are created dynamically using routing protocols such as Border Gateway Protocol (BGP).

Azure VPN gateways only support the use pre-shared key method of authentication. Both route-based and policy-based types also rely on Internet Key Exchange (IKE) in either version 1 or version 2 and Internet Protocol Security (IPsec). IKE is used to set up a security association (an agreement of the encryption) between two endpoints. This association is then passed to the IPsec suite, which encrypts and decrypts data packets encapsulated in the VPN tunnel.

## Azure VPN gateway sizes

When you create a virtual network gateway, you need to specify a gateway SKU. You should select a SKU that satisfies your requirements based on the types of workloads, throughput, features, and SLAs.

| Gateway SKUs - Generation1 | Maximum site-to-site VPN tunnels | Aggregate throughput | BGP support |
|---|---|---|---|
| Basic  | 10 | 100 Mbps | Not supported |
| VpnGw1/Az | 30 | 650 Mbps | Supported |
| VpnGw2/Az | 30 | 1 Gbps | Supported |
| VpnGw3/Az  | 30 | 1.25 Gbps | Supported |

This table shows Generation1 SKUs. When working with Generation1 SKUs, you can migrate between the VpnGw1, VpnGw2, and VpnGw3 SKUs as necessary. You cannot migrate from the Basic SKU without removing and redeploying the VPN gateway. You can also create VPN gateways using Generation 2 SKUs. For the latest information about SKUs, throughput, and supported features, reference the links in the Summary section of this module.

## VPN gateway requirements

The following Azure resources need to be present before you can deploy an operational VPN gateway:

- **Virtual network**: An Azure virtual network with enough address space for the additional subnet that you'll need for the VPN gateway. The address space for this virtual network must not overlap with the on-premises network to which you'll be connecting.
- **GatewaySubnet**: A subnet called GatewaySubnet for the VPN gateway. Requires at least a /27 address mask. This subnet cannot be used for any other services.
- **Public IP address**: A Basic-SKU dynamic public IP address if using a non-zone-aware gateway. This address provides a public-routable IP address as the target for your on-premises VPN device. This IP address is dynamic, but it won't change unless you delete and re-create the VPN gateway.
- **Local network gateway**: Create a local network gateway to define the on-premises network's configuration: where the VPN gateway will connect and to what it will connect. This configuration includes the on-premises VPN device's public IPv4 address and the on-premises routable networks. This information is used by the VPN gateway to route packets that are destined for on-premises networks through the IPsec tunnel.

When these prerequisite components are present, you can create the virtual network gateway to route traffic between the virtual network and the on-premises datacenter or other virtual networks. After the virtual network gateway is deployed, you can then create a connection resource to create a logical connection between the VPN gateway and the local network gateway:

1. The connection is made to the on-premises VPN device's IPv4 address as defined by the local network gateway.
1. The connection is made from the virtual network gateway and its associated public IP address.

You can configure multiple connections, up to the limit defined by the SKU, for each Azure VPN gateway.

## High availability

Even though you only see one VPN gateway resource in Azure, VPN gateways are deployed as two instances of managed virtual machines in an active/standby configuration. When planned maintenance or unplanned disruption affects the active instance, the standby instance automatically assumes responsibility for connections without any user or administrator intervention. Connections are interrupted during this failover, but they're typically restored within a few seconds for planned maintenance and within 90 seconds for unplanned disruptions.

Azure VPN gateways support the BGP routing protocol, which allows you to also deploy VPN gateways in an active/active configuration. In this configuration, you assign a unique public IP address to each instance. You then create separate tunnels from the on-premises device to each IP address. You can extend the high availability by deploying another VPN device on-premises.

> [!NOTE]
> Many organizations that have ExpressRoute connections also have deployed site-to-site VPN connections for an additional layer of redundancy.
