Just as a traditional multisite on-premises network might need to connect multiple branch offices to a head office, hybrid-cloud networking involves using appropriate technologies to seamlessly interconnect on-premises users, applications, and data to applications and data hosted in the cloud.

From the perspective of the Tailwind Traders scenario, Tailwind Traders must be able to connect their on-premises locations in a secure manner to the resources that they’re running in Azure. They need to accomplish this so that, for Tailwind Traders staff, there’s no real difference between accessing a workload that’s running in a Tailwind Traders on-premises datacenter and one that’s running in Azure.

In this unit, you’ll learn about several different networking technologies that allow on-premises and cloud resources to be networked together into a single hybrid cloud.

# What is an Azure VPN?

An [Azure VPN gateway](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways) allows you to connect your on-premises network to Azure by using a secure VPN tunnel across the public internet. Azure VPN connections are like traditional VPN connections that might exist between a branch office and a head office location. Each virtual network can only have a single VPN gateway, but each VPN gateway supports multiple connections. Figure 1 indicates a connection between an on-premises network’s perimeter gateway device and a VPN gateway on an Azure virtual network. It depicts the connection between an Azure Stack device and a VPN gateway.

:::image type="content" source="../media/image1.png" alt-text="Diagram of a hybrid network spanning on-premises and Azure infrastructures." border="false":::

Figure 1. Connection between on-premises perimeter gateway device and VPN gateway on Azure Virtual Network.

When considering the Tailwind Traders example, Tailwind Traders might use Azure VPN gateways to allow connections from smaller branch sites that don’t need the type of dedicated link that an Azure ExpressRoute connection provides. The primary drawback of Azure VPN gateways is that they rely on the internet service provider’s (ISP’s) internet connection. If your ISP suffers an outage, then VPN connections can’t be established. Similarly, if your ISP suffers substantial congestion, the speed of the VPN connection between an on-premises location and Azure might be degraded. Organizations with existing VPN connections between branch sites already face challenges that dedicated VPN connections pose.

## What is Azure ExpressRoute?

[Microsoft Azure ExpressRoute](https://docs.microsoft.com/azure/expressroute/expressroute-introduction) allows an organization to have a dedicated private high-speed connection from their on-premises network to Azure. This connection doesn’t cross the public internet and is functionally a dedicated fiber optic line straight from an on-premises location to the nearest Azure datacenter. Unlike a VPN gateway, the equipment that provides this connection is managed by the ExpressRoute provider. Because the ExpressRoute provider manages all the equipment, they’re able to provide a service-level agreement (SLA) in terms of reliability and bandwidth that’s not available Azure VPN gateway connections users. Figure 2 indicates the ExpressRoute connection between the on-premises environment and workloads running in Azure, with the ExpressRoute circuit and local edge routers managed by the ExpressRoute provider.

:::image type="content" source="../media/image2.png" alt-text="Hybrid network architecture using Azure ExpressRoute" border="false":::

Figure 2. An ExpressRoute connection between an on-premises network and an Azure datacenter.

In addition to providing a dedicated bandwidth connection between the on-premises environment and Azure, ExpressRoute also allows an organization to ensure that sensitive traffic doesn’t pass across the public internet. This is important in some jurisdictions where governance requirements forbid the transmission of certain types of information across the internet.

In the example case study, Tailwind Traders might implement an ExpressRoute connection from larger offices such as Melbourne, Sydney, and Auckland where more people are present. The company might also need to use ExpressRoute if there are certain types of data that they handle that can’t be transferred across the internet because of compliance requirements.

## What is Hybrid DNS?

When implementing a hybrid cloud, it’s necessary to ensure that on-premises workloads can resolve cloud workloads’ addresses and that cloud workloads can resolve on-premises workloads’ addresses. Hybrid-cloud Domain Name System (DNS) deployments usually require DNS servers on-premises and in Azure. In addition, DNS zone transfers must be configured between on-premises and cloud. An alternative is to configure DNS forwarders configured if the on-premises DNS zone is separate from the DNS zone associated with workloads running in Azure. Figure 3 indicates DNS servers on-premises replicating DNS information to DNS servers running in Azure. At present, it’s necessary to deploy a virtual machine as a DNS server in Azure because Azure DNS doesn’t support zone replication.

:::image type="content" source="../media/image3.png" alt-text="Hybrid DNS architecture. On-premises DNS connects to hub subscription with DNS servers in virtual machines. Other Azure subscriptions connect to hub subscription." border="false":::

Figure 3. Hybrid DNS. \[Alt Text. Hybrid DNS architecture. On-premises DNS connects to hub subscription with DNS servers in virtual machines. Other Azure subscriptions connect to hub subscription.\]

For the Tailwind Traders hybrid-cloud deployment, it’s likely that a virtual machine (VM) will need to be deployed on a shared services subnet in Azure that hosts the DNS role. The DNS service on this VM could be configured to replicate DNS zone data with on-premises DNS servers. This would ensure that all Tailwind Traders workloads running in Azure can resolve the DNS names of hosts on the Tailwind Traders internal network and that all Tailwind Traders internal network hosts can resolve the DNS names of workloads running in the cloud.

## What is Azure Virtual WAN?

[Azure Virtual WAN](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-about) allows an organization to use Azure’s network in a hub-and-spoke architecture. Azure’s network functions as a hub for transitive connectivity between endpoints that function as spokes. Traditionally, you might have a network topology where each branch office has a VPN connection to the head office site. If traffic is to pass from one branch office to another, it would pass through the hub site to get there. If the head office and branch office sites are all connected to Azure, either by VPN or ExpressRoute, these connections can form the
spokes and Azure Virtual WAN can function as the routing hub for traffic between on-premises locations. Figure 4 indicates an Azure Virtual WAN topology.

:::image type="content" source="../media/image4.png" alt-text="Azure Virtual WAN topology with multiple sites connected to in a hub and spoke topology through Azure to each other." border="false":::

Figure 4. Azure Virtual WAN topology.

Azure Virtual WAN enables Tailwind Traders to move away from using VPN connections to connect branch offices and the datacenter locations in Sydney, Melbourne, and Auckland. It provides a topology where each
branch office and datacenter have a VPN or ExpressRoute connection to Azure and the Azure Virtual WAN service manages the routing of traffic between locations.
