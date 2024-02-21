Based on your research, you chose to implement a hub-spoke network architecture for your company's migration to Azure. As a lead architect on the project, you're managing the production of a virtual networking design by using Azure ExpressRoute for your headquarters' connectivity. You also must decide how to connect your company's satellite offices to the new hub-spoke network.


In this unit, you explore virtual networking in the Azure platform, design considerations, and how to implement ExpressRoute for connectivity to on-premises networks.

![Architectural diagram showing hub and spokes connecting to the on-premises resources.](../media/3-plannning-hub.svg)

## Introduction to Azure virtual networking

Virtual networks provide networking services in Azure and enable you to extend your existing on-premises infrastructure. An Azure virtual network can represent your private IT infrastructure within the cloud, logically isolating dedicated resources in your subscriptions. Virtual networks enable:

- External connections to the internet.
- Communication between different internal Azure resources.
- Isolation of those resources.
- Connections to on-premises computers.
- Network traffic management.

Two important elements of virtual networks are subnets and network security groups.

![Image showing Azure Virtual Network component architecture.](../media/3-azure-VNet-arch.png)

- **Subnets**: Each virtual network can include many subnets. Each subnet has its own unique properties.
- **Network security groups**: These NSGs allow you to filter the inbound and outbound traffic through your virtual network or subnet. You can also use NSGs to filter traffic by source and destination IP address, port, or protocol.

## Planning and design considerations for virtual networks

Any network, whether on-premises or in the cloud, requires a method for managing the flow, direction, and type of traffic through it. There are several considerations for virtual networks:

- **Segmentation**: It's important to consider potential isolation of traffic into different subnets or virtual networks, or into separate subscriptions.
- **Security**: Use NSGs and network virtual appliances to filter network traffic to and from resources in a virtual network.
- **Connectivity**: You can connect a virtual network to other virtual networks by using virtual network peering, or to your on-premises networks by using ExpressRoute or an Azure VPN Gateway.
- **Routing**: Azure virtual networks automatically create routing tables within each subnet, and add default system routes to the tables. Custom routes allow you to override these default system routes. With custom routes, you can direct traffic through network virtual appliances to provide enhanced security and filtering capabilities.

## Connect your on-premises network

When working towards integrating your on-premises network with Azure, you need to bridge between the two networks. Azure VPN Gateway provides this functionality. A VPN Gateway sends encrypted traffic between the two networks over the internet. Gateways support multiple connections that route the VPN tunnels through the available bandwidth, although a virtual network can only have one gateway assigned. You can also use a VPN gateway for network-to-network connections in Azure.

Azure ExpressRoute is another option to consider for bridging. ExpressRoute allows you to extend your on-premises networks over a private connection to Azure. This connection is facilitated by a connectivity or cloud exchange provider. ExpressRoute extends wider than just Azure resources, and allows you to establish connections to other Microsoft cloud services like Office 365.

Implementation of ExpressRoute does take some time. You have to work through a connectivity provider, and might require a physical network device implementation. To provide connectivity while this implementation is ongoing, you can use site-to-site VPN to add a connection between your on-premises resources and your Azure virtual networks. You then migrate to your new ExpressRoute connection when the service provider confirms that the setup is complete.

## Use ExpressRoute in a hub-spoke topology

Using ExpressRoute in a hub-spoke topology is no different than other architectural patterns. ExpressRoute, which underpins the connectivity between the hub and the on-premises network, works best when there's high data throughput both incoming and outgoing.

You use circuits to manage and route traffic, linking ExpressRoute into a virtual network in Azure. The circuits to be connected to the virtual network might be in different regions or subscriptions. There are limits to the number of virtual networks per ExpressRoute circuit. For the standard tier, the limit is currently 10 networks. If you use the premium add-on, the limit is increased based on the circuit size. The lowest number is 20 virtual networks on a 50-Mbps circuit, up to 100 for circuits that are 10 Gbps or greater.
