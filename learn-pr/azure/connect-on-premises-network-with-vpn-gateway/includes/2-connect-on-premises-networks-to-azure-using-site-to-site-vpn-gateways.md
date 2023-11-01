A virtual private network (VPN) is a type of private interconnected network. VPNs use an encrypted tunnel within another network. They're typically deployed to connect two or more trusted private networks to one another over an untrusted network (typically the public Internet). Traffic is encrypted while traveling over the untrusted network to prevent eavesdropping or other attacks.

For the healthcare provider in our scenario, VPNs can enable health professionals to share sensitive information between locations. For example, say a patient requires surgery at a specialist facility. The surgical team needs to be able to see the details of the patient's medical history. This medical data is stored on a system in Azure. A VPN that connects the facility to Azure allows the surgical team to securely access this information.

## Azure VPN gateways

A VPN gateway is a type of Virtual Network Gateway. VPN gateways are deployed in Azure virtual networks and enable the following connectivity:

- Connect on-premises datacenters to Azure virtual networks through a *site-to-site* connection.
- Connect individual devices to Azure virtual networks through a *point-to-site* connection.
- Connect Azure virtual networks to other Azure virtual networks through a *network-to-network* connection.

![Visualization of a VPN connection to Azure.](../media/2-vpngateway-site-to-site-connection-diagram.svg)

All transferred data is encrypted in a private tunnel as it crosses the internet. You can deploy only one VPN gateway in each virtual network, but you can use one gateway to connect to multiple locations, including other Azure virtual networks or on-premises datacenters.

When you deploy a VPN gateway, you specify the VPN type: either policy-based or route-based. The main difference between these two types of VPN is how the encrypted traffic is specified.

### Policy-based VPNs

Policy-based VPN gateways specify statically the IP address of packets that should be encrypted through each tunnel. This type of device evaluates every data packet against those sets of IP addresses to choose the tunnel where that packet is going to be sent through. Policy-based VPN gateways are limited in the features and connections that can be supported. Key features of policy-based VPN gateways in Azure include:

- Support for IKEv1 only.
- Use of *static routing*, where combinations of address prefixes from both networks control how traffic is encrypted and decrypted through the VPN tunnel. The source and destination of the tunneled networks are declared in the policy and don't need to be declared in routing tables.
- Policy-based VPNs must be used in specific scenarios that require them, such as for compatibility with legacy on-premises VPN devices.

### Route-based VPNs

If defining which IP addresses are behind each tunnel is too cumbersome for your situation. Or, you need features and connections that policy-based gateways don't support. Route-based gateways should be used. With route-based gateways, IPSec tunnels are modeled as a network interface or VTI (virtual tunnel interface). IP routing (static routes or dynamic routing protocols) determines which of the tunnel interfaces to send each packet across. Route-based VPNs are the preferred connection method for on-premises devices, since they're more resilient to topology changes such as the creation of new subnets, for example. Use a route-based VPN gateway if you need any of the following types of connectivity:

- Connections between virtual networks
- Point-to-site connections
- Multisite connections
- Coexistence with an Azure ExpressRoute gateway

Key features of route-based VPN gateways in Azure include:

- Supports IKEv2.
- Uses any-to-any (wildcard) traffic selectors.
- Can use *dynamic routing protocols*, where routing/forwarding tables direct traffic to different IPSec tunnels. In this case, the source and destination networks aren't statically defined as they are in policy-based VPNs or even in route-based VPNs with static routing. Instead, data packets are encrypted, based on network routing tables that are created dynamically using routing protocols such as BGP (Border Gateway Protocol).

Both types of VPN gateways (route-based and policy-based) in Azure use preshared key as the only method of authentication. Both types also rely on Internet Key Exchange (IKE) in either version 1 or version 2 and Internet Protocol Security (IPSec). IKE is used to set up a security association (an agreement of the encryption) between two endpoints. This association is then passed to the IPSec suite, which encrypts and decrypts data packets encapsulated in the VPN tunnel.

## VPN gateway sizes

The SKU or size that you deploy, determines the capabilities of your VPN gateway. This table shows an example of gateway SKUs. The numbers do change. For the latest information, see [Gateway SKUs](/azure/vpn-gateway/vpn-gateway-about-vpngateways#benchmark.md) in the Azure VPN Gateway documentation.

|**VPN<br>Gateway<br>Generation** |**SKU**   | **S2S/VNet-to-VNet<br>Tunnels** |  **Aggregate<br>Throughput Benchmark** | **BGP** | **Zone-redundant** |
|---            |---         | ---       | ---       | ---          | ---|
|**Generation1**|**Basic**   | Max. 10   |  100 Mbps | Not Supported| No |
|**Generation1**|**VpnGw1**  | Max. 30   | 650 Mbps  | Supported    | No |
|**Generation1**|**VpnGw2**  | Max. 30   | 1 Gbps    | Supported    | No |
|**Generation1**|**VpnGw3**  | Max. 30   | 1.25 Gbps | Supported    | No |
|**Generation1**|**VpnGw1AZ**| Max. 30   |  650 Mbps | Supported    | Yes |
|**Generation1**|**VpnGw2AZ**| Max. 30   |  1 Gbps   | Supported    | Yes |
|**Generation1**|**VpnGw3AZ**| Max. 30   | 1.25 Gbps | Supported    | Yes |
|               |            |           |           |              |     |
|**Generation2**|**VpnGw2**  | Max. 30   | 1.25 Gbps | Supported    | No  |
|**Generation2**|**VpnGw3**  | Max. 30   | 2.5 Gbps  | Supported    | No  |
|**Generation2**|**VpnGw4**  | Max. 100* | 5 Gbps    | Supported    | No  |
|**Generation2**|**VpnGw5**  | Max. 100* | 10 Gbps   | Supported    | No  |
|**Generation2**|**VpnGw2AZ**| Max. 30   | 1.25 Gbps | Supported    | Yes |
|**Generation2**|**VpnGw3AZ**| Max. 30   | 2.5 Gbps  | Supported    | Yes |
|**Generation2**|**VpnGw4AZ**| Max. 100* | 5 Gbps    | Supported    | Yes |
|**Generation2**|**VpnGw5AZ**| Max. 100* | 10 Gbps   | Supported    | Yes |

The Basic gateway SKU should only be used for Dev/Test workloads. In addition, it's unsupported to migrate from Basic to any VpnGw#/Az sku at a later time without having to remove the gateway and redeploy.

## Deploy VPN gateways

Before you can deploy a VPN gateway, you need some Azure and on-premises resources.

### Required Azure resources

You need these Azure resources before you can deploy an operational VPN gateway:

- **Virtual network**. Deploy an Azure virtual network with enough address space for the extra subnet that you need for the VPN gateway. The address space for this virtual network must not overlap with the on-premises network that you're connecting to. Remember that you can deploy only one VPN gateway within a virtual network.
- **GatewaySubnet**. Deploy a subnet called `GatewaySubnet` for the VPN gateway. Use at least a **/27** address mask to make sure you have enough IP addresses in the subnet for future growth. You can't use this subnet for any other services.
- **Public IP address**. Create a Basic-SKU dynamic public IP address if using a non-zone-aware gateway. This address provides a public-routable IP address as the target for your on-premises VPN device. This IP address is dynamic, but it doesn't change unless you delete and re-create the VPN gateway.
- **Local network gateway**. Create a local network gateway to define the on-premises network's configuration. Specifically, where the VPN gateway connects and what it connects to. This configuration includes the on-premises VPN device's public IPv4 address and the on-premises routable networks. This information is used by the VPN gateway to route packets that are destined for on-premises networks through the IPSec tunnel.
- **Virtual network gateway**. Create the virtual network gateway to route traffic between the virtual network and the on-premises datacenter or other virtual networks. The virtual network gateway can be either configured as a VPN gateway or an ExpressRoute gateway, but this module deals only with VPN virtual network gateways.
- **Connection**. Create a Connection resource to create a logical connection between the VPN gateway and the local network gateway. You can create multiple connections to the same gateway.
  - The connection is made to the on-premises VPN device's IPv4 address as defined by the local network gateway.
  - The connection is made from the virtual network gateway and its associated public IP address.

The following diagram shows this combination of resources and their relationships to help you better understand what's required to deploy a VPN gateway:

![Resource requirements for a VPN gateway.](../media/2-resource-requirements-for-vpn-gateway.svg)

### Required on-premises resources

To connect your datacenter to a VPN gateway, you need these on-premises resources:

- A VPN device that supports policy-based or route-based VPN gateways
- A public-facing (internet-routable) IPv4 address

## High availability scenarios

There are several ways to ensure you have a fault-tolerant configuration.

### Active/standby

By default, VPN gateways are deployed as two instances in an *active/standby* configuration, even if you only see one VPN gateway resource in Azure. When planned maintenance or unplanned disruption affects the active instance, the standby instance automatically assumes responsibility for connections without any user intervention. Connections are interrupted during this failover, but they're typically restored within a few seconds for planned maintenance and within 90 seconds for unplanned disruptions.

![Active/standby virtual network gateway.](../media/2-active-standby.svg)

### Active/active

With the introduction of support for the BGP routing protocol, you can also deploy VPN gateways in an *active/active* configuration. In this configuration, you assign a unique public IP address to each instance. You then create separate tunnels from the on-premises device to each IP address. You can extend the high availability by deploying another VPN device on-premises.

![Active/active virtual network Gateway.](../media/2-dual-redundancy.svg)

### ExpressRoute failover

Another high availability option is to configure a VPN gateway as a secure failover path for ExpressRoute connections. ExpressRoute circuits have resiliency built in but aren't immune to physical problems that affect the cables delivering connectivity or outages affecting the complete ExpressRoute location. In high availability scenarios, where there's risk associated with an outage of an ExpressRoute circuit, you can also configure a VPN gateway that uses the internet as an alternative method of connectivity, thus ensuring there's always a connection to the Azure virtual networks.

### Zone-redundant gateways

In regions that support availability zones, VPN and ExpressRoute gateways can be deployed in a zone-redundant configuration. This configuration brings resiliency, scalability, and higher availability to virtual network gateways. Deploying gateways in Azure Availability Zones physically and logically separates gateways within a region, while protecting your on-premises network connectivity to Azure from zone-level failures. These require different gateway SKUs and use Standard public IP addresses instead of Basic public IP addresses.
