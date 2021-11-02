For a successful migration, it's critical to connect on-premises corporate networks to Azure. This creates an always-on connection known as a hybrid-cloud network, where services are provided from the Azure cloud to corporate users.

This section describes services that provide connectivity between Azure resources, connectivity from an on-premises network to Azure resources, and branch to branch connectivity in Azure - Virtual Network (VNet), ExpressRoute, VPN Gateway, Virtual WAN, Virtual network NAT Gateway, Azure DNS, Azure Peering service, and Azure Bastion.

Let's compare the options for connecting an on-premises network to an Azure Virtual Network (VNet). For each option, a more detailed reference architecture is available. 

## VPN connection

A [VPN gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) is a type of virtual network gateway that sends encrypted traffic between an Azure virtual network and an on-premises location. The encrypted traffic goes over the public Internet. There are different configurations available for VPN Gateway connections, such as, site-to-site, point-to-site, or VNet-to-VNet.

This architecture is suitable for hybrid applications where the traffic between on-premises hardware and the cloud is likely to be light, or you are willing to trade slightly extended latency for the flexibility and processing power of the cloud.

### Benefits

- Simple to configure.

- Much higher bandwidth available; up to 10 Gbps depending on the VPN Gateway SKU.

### Challenges

- Requires an on-premises VPN device.


### Reference architecture

[Hybrid network with VPN gateway](/azure/architecture/reference-architectures/hybrid-networking/vpn)

:::image type="content" source="../media/virtual-private-network.png" alt-text="Hybrid network with VPN gateway":::


## Azure ExpressRoute connection

[ExpressRoute](/azure/expressroute/) connections use a private, dedicated connection through a third-party connectivity provider. This connection is private. Traffic does not go over the internet. The private connection extends your on-premises network into Azure.

This architecture is suitable for hybrid applications running large-scale, mission-critical workloads that require a high degree of scalability.

### Benefits

- Much higher bandwidth available; up to 10 Gbps depending on the connectivity provider.

- Supports dynamic scaling of bandwidth to help reduce costs during periods of lower demand. However, not all connectivity providers have this option.

- May allow your organization direct access to national clouds, depending on the connectivity provider.


### Challenges

- Can be complex to set up. Creating an ExpressRoute connection requires working with a third-party connectivity provider. The provider is responsible for provisioning the network connection.

- Requires high-bandwidth routers on-premises.

### Reference architecture

- [Hybrid network with ExpressRoute](/azure/architecture/reference-architectures/hybrid-networking/expressroute)

:::image type="content" source="../media/express-route.png" alt-text="Hybrid network with ExpressRoute.":::


## ExpressRoute with VPN failover

This options combines the previous two, using ExpressRoute in normal conditions, but failing over to a VPN connection if there is a loss of connectivity in the ExpressRoute circuit.

This architecture is suitable for hybrid applications that need the higher bandwidth of ExpressRoute, and also require highly available network connectivity.

### Benefits

- High availability if the ExpressRoute circuit fails, although the fallback connection is on a lower bandwidth network.

### Challenges

- Complex to configure. You need to set up both a VPN connection and an ExpressRoute circuit.

- Requires redundant hardware (VPN appliances), and a redundant Azure VPN Gateway connection for which you pay charges.

### Reference architecture

- [Hybrid network with ExpressRoute and VPN failover](/azure/architecture/reference-architectures/hybrid-networking/expressroute-vpn-failover)

:::image type="content" source="../media/express-route-failover.png" alt-text="Hybrid network with ExpressRoute and VPN failover.":::


## Hub-spoke network topology

A hub-spoke network topology is a way to isolate workloads while sharing services such as identity and security. The hub is a virtual network (VNet) in Azure that acts as a central point of connectivity to your on-premises network. The spokes are VNets that peer with the hub. Shared services are deployed in the hub, while individual workloads are deployed as spokes.

### Reference architectures

- [Hub-spoke topology](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke)

 

## Hub-spoke network topology with Azure Virtual WAN

A hub-spoke architecture can be achieved two ways: a customer-managed hub infrastructure, or a Microsoft-managed hub infrastructure. In either case, spokes are connected to the hub using virtual network peering.

The hub is a virtual network in Azure that acts as a central point of connectivity to your on-premises network. The spokes are virtual networks that peer with the hub and can be used to isolate workloads. Traffic flows between the on-premises data center(s) and the hub through an ExpressRoute or VPN gateway connection. The main differentiator of this approach is the use of Azure Virtual WAN (VWAN) to replace hubs as a managed service.

Azure Virtual WAN is a networking service that provides optimized and automated branch connectivity to, and through, Azure. Azure regions serve as hubs that you can choose to connect your branches to. You can leverage the Azure backbone to also connect branches and enjoy branch-to-VNet connectivity. Azure Virtual WAN brings together many Azure cloud connectivity services such as site-to-site VPN, ExpressRoute, point-to-site user VPN into a single operational interface. Connectivity to Azure VNets is established by using virtual network connections.

This architecture includes the benefits of standard hub-spoke network topology and introduces new benefits:

- **Less operational overhead** by replacing existing hubs with a fully managed VWAN service.

- **Cost savings** by using a managed service and removing the necessity of network virtual appliance.

- **Improved security** by introducing centrally managed secured Hubs with Azure Firewall and VWAN to minimize security risks related to misconfiguration.

- **Separation of concerns** between central IT (SecOps, InfraOps) and workloads (DevOps).

Typical uses for this architecture include cases in which:

- Connectivity among workloads requires central control and access to shared services.

- An enterprise requires central control over security aspects, such as a firewall, and requires segregated management for the workloads in each spoke.

### Advantages

:::image type="content" source="../media/hub-spoke-architecture.png" alt-text="Hub and spoke VWAN architecture.":::


This diagram illustrates a few of the advantages that this architecture can provide:

- A full meshed hubs among Azure Virtual Networks

- Branch to Azure connectivity

- Branch to Branch connectivity

- Mixed use of VPN and Express Route

- Mixed use of user VPN to the site

- VNET to VNET connectivity