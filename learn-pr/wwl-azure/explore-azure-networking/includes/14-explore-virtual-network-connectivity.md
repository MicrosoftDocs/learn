It is possible to establish direct connectivity to an Azure virtual network from a physical computer or virtual machine not hosted in Azure by using one of the following methods:

 -  **A point-to-site VPN**, which connects individual computers to an Azure virtual network via a Secure Socket Tunneling Protocol (SSTP) tunnel or OpenVPN over the internet.
 -  **A site-to-site VPN**, which connects an on-premises network to an Azure virtual network via an IPsec tunnel over the internet.
 -  **Azure ExpressRoute**, which connects an on-premises network via a private connection. ExpressRoute provides more predictable performance, with higher bandwidth and lower latency than VPN connections. ExpressRoute offers per-circuit throughput of up to 10 gigabits per second (Gbps), with the per-gateway throughput of up to 9000 megabits per second (Mbps). These capabilities make ExpressRoute the preferred choice for enterprise and mission-critical workloads. ExpressRoute also might be worth considering when implementing an Azure region as a disaster recovery site or as the backup destination for on-premises systems.
 -  **Azure Virtual WAN**, which provides optimized and automated branch-to-branch connectivity through Azure. Virtual WAN lets you connect and configure branch devices to communicate with Azure. Connectivity and configuration can be performed manually by customers or streamlined by using preferred provider devices through a Virtual WAN partner. Using preferred provider devices allows ease of use, simplification of connectivity, and configuration management.

To establish direct connectivity from another Azure virtual network, you can use one of the following methods:

 -  **VNet Peering** connects Azure virtual networks within the same Azure region or between Azure regions. The traffic between virtual networks flows directly over the Azure backbone network, without IPSec encryption.
 -  **VNet-to-VNet** connects Azure virtual networks in the same Azure region or in different Azure regions via a pair of virtual gateways that encrypt network traffic. Using VNet-to-VNet is like a site-to-site VPN. However, in this case, cross-region traffic doesn’t traverse the internet but is routed over the Azure backbone network.

## Optional demo:

 -  [Demonstration: Explore VNet to VNet connections](https://github.com/MicrosoftLearning/AZ-120-Planning-and-Administering-Microsoft-Azure-for-SAP-Workloads/blob/master/Demos/demo-explore-vnet-vnet-connections.md)
