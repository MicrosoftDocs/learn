Your company plans to migrate the majority of its on-premises resources to Azure. However, a small datacenter must remain on-premises to be integrated into the Azure network. The architectural model needs to consider Azure network connectivity for several satellite offices. You want to use a hybrid network architecture that grants access to both your on-premises and cloud-based resources.

To handle the migration, you'll produce a network integration plan for Azure that includes a selection of the best hybrid network options available in Azure that meet the organization's requirements for hybrid connectivity.

In this unit, you'll explore on-premises connectivity in the Azure platform. You'll also get an overview of Azure Virtual Network, and see how to use VPN Gateway to secure traffic to an on-premises network.

## About Azure Virtual Network

The Microsoft Azure Virtual Network service has a specific set of tools and resources for building a cloud-based network architecture for your organization. Azure virtual networks provide a secure virtual communication channel for all permitted Azure resources within your subscription.

With an Azure virtual network, You'll:

- Connect virtual machines to the internet
- Provide secure communications between Azure resources hosted in different datacenters and regions
- Isolate and manage Azure resources
- Connect to on-premises computers
- Manage network traffic

By default, all Azure resources within a virtual network have outbound connectivity to the internet. External inbound communication must come through a public-facing endpoint. All internal resources use a private endpoint to access the virtual network.

A virtual network is composed of many elements including, but not limited to, network interfaces, load balancers, subnets, network security groups, and public IP addresses. These elements work together and enable secure, reliable network communication between your Azure resources, the internet, and on-premises networks.

  ![Image showing Azure virtual network component architecture](../media/2-azure-vnet-vm-arch.svg)

## Routing traffic on an Azure virtual network

Outbound traffic from a subnet is routed, based on the destination IP address. A routing table defines how the traffic routes and what happens next. A destination IP address can exist across multiple routing table prefix definitions; for example, 10.0.0.0/16 and 10.0.0.0/24. The router uses a sophisticated algorithm to find the longest prefix match. Traffic heading for a 10.0.0.6 address would resolve to the 10.0.0.0/24 prefix and route accordingly.

There are two principle routing tables: system and custom.

### System routing tables

Azure automatically creates a set of default routing tables for the virtual network and each subnet mask within the virtual network. These system routes are fixed and can't be overridden or deleted. However, you can override the default settings using a custom routing table.

A typical default routing table might look like this:

| Source | Address prefixes | Next hop type |
| ---- |---|---|
| Default | Unique to the virtual network | Virtual network |
| Default | 0.0.0.0/0 | Internet |
| Default | 10.0.0.0/8 | None |
| Default | 172.16.0.0/12 | None |
| Default | 192.168.0.0/16 | None |
| Default | 100.64.0.0/10 | None |

A routing table is made up of a source, an address prefix, and a next hop type. All traffic leaving the subnet uses the routing table to find out where it should go next; effectively, looking for the next hop in its journey.

A next hop defines what happens to the traffic flow next, based on the prefix. There are three types of next hop:

- **Virtual network**: traffic is routed according to the IP address within the virtual network
- **Internet**: routes the traffic to the internet
- **None**: drops the traffic

### Custom routing tables

Apart from system-defined routing tables, you can also create custom routing tables. These user-defined routing tables override the default system table. There are limitations on the number of routing items you can have in a custom table.

| Resource | Default/maximum |
| ---- | ---- |
| Virtual networks | 1,000 |
| Subnets per virtual network | 3,000 |
| Virtual network peerings per virtual network | 500 |
| Private IP addresses per virtual network | 65,536 |

The table above shows a few of the many limitations that apply to virtual networks.

> [!NOTE]
> The limits may have changed. Please check the Microsoft Docs website for the current virtual networking limits.

Much like the system routing table, custom routing tables also have a next hop type. These routings differ from the system routing table, and there are a few more options.

- **Virtual appliance**: is usually a virtual machine that runs a specific network application, such as a firewall
- **Virtual network gateway**: is used when you want to send traffic to a virtual network gateway. A virtual network gateway must be of a type VPN. It can't be of a type ExpressRoute, which requires setting a BGP
- **None**: drops the traffic rather than forwarding it
- **Virtual Network**: lets you override a default system routing
- **Internet**: enables you to specify that any prefix forwards to the internet

## Connecting Azure virtual networks

There are many different ways to connect your virtual networks.  You can use VPN Gateway, ExpressRoute, or directly use the peering method.

### VPN Gateway on Azure

When working towards integrating your on-premises network with Azure, there needs to be a bridge between them. VPN Gateway is an Azure service that provides this functionality. A VPN gateway can send encrypted traffic between the two networks. VPN gateways support multiple connections that enable them to route VPN tunnels using any available bandwidth. A virtual network can only have one gateway assigned. VPN gateways make connections possible from virtual network to virtual network in Azure.

Implementing a VPN gateway requires two or more virtual machines deployed to the subnet you create when provisioning the virtual network. In this instance, the subnet is also known as the gateway subnet. Each virtual machine is assigned a default configuration for routing and gateway services, explicit to the provisioned gateway. You can configure these virtual machines directly.

When you create a gateway, several topologies are available. These topologies, also known as gateway types, determine what's configured and the expected connection type.

#### Site-to-site

You use a site-to-site connection for cross-premises and hybrid-network configurations. This connection topology requires an on-premises VPN device to have a publicly accessible IP address, and must not be behind a NAT. The connection uses a secret ASCII string of up to 128 characters, to authenticate between the gateway and the VPN device.

#### Multi-site

A multi-site connection is similar to site-to-site but has a slight variation. Multi-site supports multiple VPN connections to your on-premises VPN devices. This connection topology requires a RouteBased VPN known as a dynamic gateway. It's important to note that, with a multi-site configuration, all connections route through and share all available bandwidth.

#### Point-to-site

A point-to-site connection is suited to a remote individual client device that connects to your network. The client device must be authenticated either through Azure Active Directory or by using Azure Certificate Authentication. This model suits home working scenarios.

#### VNet-to-VNet

A virtual network to virtual network connection is used to create connections between multiple Azure virtual networks. This connection topology, unlike the others, doesn't require a public IP or VPN device. It can also be used in a multi-site configuration to establish combined cross-premises connections with inter-virtual network connectivity.

### ExpressRoute

ExpressRoute creates a direct connection between your on-premises network and the Azure virtual network that doesn't use the internet. You use ExpressRoute to seamlessly extend your local network across to the Azure virtual network space. The ExpressRoute service is offered by many third-party connectivity providers. There are three different ExpressRoute connection types:

- CloudExchange Colocation
- Point-to-point Ethernet Connection
- Any-to-Any (IPVPN) Connection

![Image showing an ExpressRoute connection](../media/2-expressroute-connection.svg)

### Peering

Virtual networks can peer across subscriptions and Azure regions. Once peered, resources in these networks communicate with each other as if they're in the same network. The traffic is routed between resources in a peered virtual network using only private IP addresses. Routing is achieved by routing traffic through the Azure network and keeping the connection private as part of the Azure backbone network. The backbone network provides low latency and high-bandwidth network connections.

## Site-to-site VPN gateway reference architecture

While there are many reference architectures available when designing a hybrid network, one popular architecture is the site-to-site configuration. The simplified reference architecture shown below illustrates how you'd connect an on-premises network to your Azure cloud. The internet connection uses an IPsec VPN tunnel.

![Image showing Azure vpn reference architecture](../media/2-vpn-architecture.svg)

The architecture is composed of several components:

- The **on-premises network** that represents your on-premises Active Directory and any data or resources
- The **gateway** is responsible for sending encrypted traffic to a virtual IP address when using a public connection
- The **Azure virtual network** holds all your cloud applications and any Azure VPN gateway components
- An **Azure VPN gateway** provides the encrypted link between the Azure virtual network and your on-premises network. An Azure VPN gateway is composed of these elements:
  - Virtual network gateway
  - Local network gateway
  - Connection
  - Gateway subnet
- **Cloud applications** are the ones you have made available through Azure
- An **internal load balancer**, located in the front end, which routes cloud traffic to the correct cloud-based application or resource

Some of the benefits of using this architecture are:

- The ease of configuration and maintenance
- Using a VPN gateway ensures that all data and traffic is encrypted between the on-premises gateway and the Azure gateway
- This architecture can be scaled and extended to meet your organization's networking needs

This architecture isn't applicable in all situations because it uses an existing internet connection as the link between the two gateway points. Bandwidth constraints can cause latency issues due to reusing the existing infrastructure.
