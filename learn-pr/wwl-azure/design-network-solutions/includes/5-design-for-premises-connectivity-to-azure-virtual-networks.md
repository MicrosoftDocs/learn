For a successful migration, it's critical to connect on-premises corporate networks to Azure. This method creates an always-on connection known as a _hybrid-cloud network_, where services are provided from the Azure cloud to corporate users.

Let's examine Azure services that provide connectivity between Azure resources, connectivity from an on-premises network to Azure resources, and branch to branch connectivity in Azure. We'll compare options for connecting an on-premises network to an Azure virtual network.

### Azure VPN Gateway

An [Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) connection is a type of virtual network gateway that sends encrypted traffic between an Azure virtual network and an on-premises location. The encrypted traffic goes over the public internet. There are different configurations available for VPN Gateway connections, such as, site-to-site, point-to-site, or virtual network-to-network.

**Reference architecture**: [Hybrid network with Azure VPN Gateway](/azure/architecture/reference-architectures/hybrid-networking/#vpn-connection)

### Azure ExpressRoute

[Azure ExpressRoute](/azure/expressroute/expressroute-introduction) uses a private, dedicated connection through a third-party connectivity provider. This connection is private. Traffic doesn't go over the internet. The private connection extends your on-premises network into Azure.

**Reference architecture**: [Hybrid network with Azure ExpressRoute](/azure/architecture/reference-architectures/hybrid-networking/expressroute)

### Azure ExpressRoute with VPN failover

Combine Azure ExpressRoute and Azure VPN Gateway to create a failover to a VPN connection if there's a loss of connectivity in the ExpressRoute circuit.

**Reference architecture**: [Hybrid network with Azure ExpressRoute and VPN failover](/azure/architecture/reference-architectures/hybrid-networking/expressroute-vpn-failover)

### Azure Virtual WAN and hub-spoke networks

A hub-spoke network topology is a way to isolate workloads while sharing services such as identity and security. The hub is a virtual network in Azure that acts as a central point of connectivity to your on-premises network. Spokes are virtual networks that peer with the hub. Shared services are deployed in the hub, while individual workloads are deployed as spokes.

A hub-spoke architecture can be achieved via a customer-managed hub infrastructure or a Microsoft-managed hub infrastructure. In both cases, spokes are connected to the hub by using virtual network peering. Traffic flows between the on-premises data center(s) and the hub through an ExpressRoute or VPN gateway connection. The main differentiator of this approach is the use of Azure Virtual WAN to replace hubs as a managed service.

Azure Virtual WAN is a networking service that provides optimized and automated branch connectivity to, and through, Azure. Azure regions serve as hubs that you can choose to connect your branches to. You can apply the Azure backbone to also connect branches and enjoy branch-to-VNet connectivity. Azure Virtual WAN brings together many Azure cloud connectivity services such as site-to-site VPN, ExpressRoute, point-to-site user VPN into a single operational interface. Connectivity to Azure VNets is established by using virtual network connections.

**Reference architecture**: [Hub-spoke topology with Azure Virtual WAN](/azure/architecture/networking/hub-spoke-vwan-architecture)

The Azure Virtual WAN architecture includes the benefits of standard hub-spoke network topology and introduces several advantages:
- Full meshed hub among Azure virtual networks
- Branch-to-Azure connectivity
- Branch-to-branch connectivity
- Mixed use of VPN Gateway and ExpressRoute connections
- Mixed use of user VPN to the site
- Virtual network-to-network connectivity

## Compare services

The following table compares the benefits and challenges of the network connectivity options. Review the scenarios, and think about which services can enhance the network solution for Tailwind Traders.

| Compare | Azure VPN Gateway | Azure ExpressRoute | ExpressRoute + VPN failover | Azure Virtual WAN + hub-spoke | 
| --- | --- | --- | --- | --- 
| **Benefits** | - Simple to configure <br> - High bandwidth available (up to 10 Gbps depending on VPN Gateway SKU) | - High bandwidth available (up to 10 Gbps depending on connectivity provider) <br> - Supports dynamic scaling of bandwidth to help reduce costs during periods of lower demand (not supported by all connectivity providers) <br> - Enables direct organizational access to national clouds (depends on connectivity provider) | - High availability if ExpressRoute circuit fails (fallback connection on lower bandwidth network | - Reduced operational overhead by replacing existing hubs with fully managed service <br> - Cost savings by using managed service, which removes need for NVA <br> - Improved security via centrally managed secured hubs with Azure Firewall and Virtual WAN <br> - Separates concerns between central IT (SecOps, InfraOps) and workloads (DevOps) |
| **Challenges** | - Requires on-premises VPN device | - Can be complex to set up <br> - Requires working with third-party connectivity provider <br> - Provider responsible for provisioning network connection <br> - Requires high-bandwidth routers on-premises | - Complex to configure <br> - Must set up both VPN connection and ExpressRoute circuit <br> - Requires redundant hardware (VPN appliances) <br> - Requires redundant Azure VPN Gateway connection for which you pay charges | **Note**: Azure Virtual WAN is designed to reduce previously listed connectivity challenges. |
| **Scenarios** | _Hybrid apps with light traffic between on-premises hardware and the cloud_ <br><br> _Able to trade slightly extended latency for flexibility and processing power of the cloud_ | _Hybrid apps running large-scale, mission-critical workloads that require high degree of scalability_ | _Hybrid apps that require higher bandwidth of ExpressRoute and highly available network connectivity_ | _Connectivity among workloads requires central control and access to shared services_ <br><br> _Enterprise requires central control over security aspects like a firewall and segregated management for workloads in each spoke_ |