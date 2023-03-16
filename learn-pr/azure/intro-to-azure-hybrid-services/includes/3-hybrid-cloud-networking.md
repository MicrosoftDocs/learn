A traditional multisite on-premises network might need to connect multiple branch offices to a head office. Similarly, hybrid cloud networking involves using appropriate technologies to seamlessly interconnect on-premises users, applications, and data to applications and data hosted in the cloud.

In our scenario, Tailwind Traders must be able to connect its on-premises locations in a secure manner to the resources that it's running in Azure. Tailwind Traders needs to accomplish this so that, for its staff, there's no real difference between accessing a workload that's running in a Tailwind Traders on-premises datacenter and one that's running in Azure.

In this unit, you'll learn about networking technologies that allow on-premises and cloud resources to be networked together into a single hybrid cloud.

## What is an Azure VPN?

An Azure VPN gateway allows you to connect your on-premises network to Azure by using a secure VPN tunnel across the public internet. Azure VPN connections are like traditional VPN connections that might exist between a branch office and a head office location. Each virtual network can have only a single VPN gateway, but each VPN gateway supports multiple connections. 

The following image shows a connection between an on-premises network's perimeter gateway device and a VPN gateway on an Azure virtual network. It depicts the connection between an Azure Stack device and a VPN gateway.

:::image type="content" source="../media/3-vpn-gateway-virtual-network-diagram.png" alt-text="Diagram of a hybrid network that spans on-premises and Azure infrastructures." border="false" lightbox="../media/3-vpn-gateway-virtual-network-diagram.png":::

In the Tailwind Traders example, the company might use Azure VPN gateways to allow connections from smaller branch sites that don't need the type of dedicated link that an Azure ExpressRoute connection provides. The primary drawback of Azure VPN gateways is that they rely on the internet service provider's (ISP's) internet connection. If your ISP has an outage, then VPN connections can't be established. Similarly, if your ISP has substantial congestion, the speed of the VPN connection between an on-premises location and Azure might be degraded. 

Organizations with existing VPN connections between branch sites already face challenges that dedicated VPN connections pose.

## What is Azure ExpressRoute?

Microsoft Azure ExpressRoute allows an organization to have a dedicated, private high-speed connection from its on-premises network to Azure. This connection doesn't cross the public internet. Functionally, it's a dedicated fiber-optic line straight from an on-premises location to the nearest Azure datacenter. 

Unlike a VPN gateway, the equipment that provides this connection is managed by the ExpressRoute provider. Because the ExpressRoute provider manages all the equipment, it can provide a service-level agreement (SLA) in terms of reliability and bandwidth that's not available to users of Azure VPN gateway connections. 

The following image shows the ExpressRoute connection between the on-premises environment and workloads running in Azure. The ExpressRoute provider manages the ExpressRoute circuit and local edge routers.

:::image type="content" source="../media/3-azure-expressroute-connection-diagram.png" alt-text="Diagram of a hybrid network architecture using Azure ExpressRoute." border="false" lightbox="../media/3-expressroute-connection-diagram.png":::

In addition to providing a dedicated bandwidth connection between the on-premises environment and Azure, ExpressRoute allows an organization to ensure that sensitive traffic doesn't pass across the public internet. This is important in jurisdictions where governance requirements forbid the transmission of certain types of information across the internet.

In the example case study, Tailwind Traders might implement an ExpressRoute connection from larger offices such as Melbourne, Sydney, and Auckland, where more people are present. The company might also need to use ExpressRoute if certain types of data that it handles can't be transferred across the internet because of compliance requirements.

## What is Hybrid DNS?

When you're implementing a hybrid cloud, it's necessary to ensure that on-premises workloads can resolve cloud workloads' addresses and that cloud workloads can resolve on-premises workloads' addresses. Domain Name System (DNS) deployments in a hybrid cloud usually require DNS servers on-premises and in Azure. In addition, DNS zone transfers must be configured between on-premises and cloud. An alternative is to configure DNS forwarders if the on-premises DNS zone is separate from the DNS zone associated with workloads running in Azure. 

The following image shows DNS servers on-premises replicating DNS information to DNS servers running in Azure. In this scenario, a virtual machine (VM) is deployed as a DNS server in Azure. In the image, on-premises DNS connects to a hub subscription with DNS servers in VMs. Other Azure subscriptions connect to the hub subscription.

:::image type="content" source="../media/3-hybrid-dns-architecture.png" alt-text="Diagram that shows a hybrid DNS architecture." border="false" lightbox="../media/3-hybrid-dns-architecture.png":::

Alternatively, Azure DNS Private Resolver is a service that enables you to query Azure DNS private zones from an on-premises environment and vice versa without deploying VM based DNS servers. The private resolver service is fully managed and has built-in high availability features.

Tailwind Traders can use Azure DNS Private Resolver to ensure that all their workloads running in Azure can resolve the DNS names of hosts on the Tailwind Traders internal network. It would also ensure that all Tailwind Traders internal network hosts can resolve the DNS names of workloads running in the cloud.

## What is Azure Virtual WAN?

Azure Virtual WAN allows an organization to use the Azure network in a hub-and-spoke architecture. The Azure network functions as a hub for transitive connectivity between endpoints that function as spokes. 

Traditionally, you might have a network topology where each branch office has a VPN connection to the head office site. If traffic passes from one branch office to another, it passes through the hub site to get there. If the head office and branch office sites are all connected to Azure, either by VPN or by ExpressRoute, these connections can form the spokes. Azure Virtual WAN can function as the routing hub for traffic between on-premises locations. 

The following image shows an Azure Virtual WAN topology.

:::image type="content" source="../media/3-virtual-wan-topology.png" alt-text="Diagram the shows Azure Virtual WAN topology with multiple sites connected to each other in a hub and spoke topology through Azure." border="false" lightbox="../media/3-virtual-wan-topology.png":::

Azure Virtual WAN enables Tailwind Traders to move away from using VPN connections to connect branch offices and the datacenter locations in Sydney, Melbourne, and Auckland. It provides a topology where each branch office and datacenter have a VPN or ExpressRoute connection to Azure. The Azure Virtual WAN service manages the routing of traffic between locations.
