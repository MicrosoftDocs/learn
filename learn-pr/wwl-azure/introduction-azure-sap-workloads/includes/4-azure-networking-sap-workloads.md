Azure virtual networks provide direct, private IP-based connectivity between network-attached resources, such as Azure VMs. You have the option of connecting different virtual networks together, if your intention is to provide direct, private IP connectivity between them. It is also possible to connect virtual networks to your on-premises networks, effectively making Azure an extension of your own datacenter.

Azure virtual networks support Transmission Control Protocol (TCP), User Datagram Protocol (UDP), and Internet Control Message Protocol (ICMP). At the time of authoring this course, there is no support for broadcasts, multicasts, IP-in-IP encapsulated packets, and Generic Route Encapsulation (GRE) packets.

A virtual network typically contains one or more subnets. Subnets facilitate segmentation of networks, providing a means of controlling communication between network resources. Each subnet contains a range of IP addresses that constitute a subset of the virtual network address space. 

VMs use a virtual network adapter to attach to a subnet to communicate with other VMs and other networked resources, such as load balancers or gateways. VMs can have more than one network adapter, typically to facilitate network isolation scenarios. The maximum number of network adapters that you can attach to a VM depends on its size.

## Azure Virtual Network connectivity
It is possible to establish direct connectivity to an Azure virtual network from a physical computer or virtual machine not hosted in Azure by using one of the following methods:

* **A point-to-site VPN**, which connects individual computers to an Azure virtual network via a Secure Socket Tunneling Protocol (SSTP) tunnel or OpenVPN over the internet.

* **A site-to-site VPN**, which connects an on-premises network to an Azure virtual network via an IPsec tunnel over the internet. 

* **Azure ExpressRoute**, which connects an on-premises network via a private connection. ExpressRoute provides more predictable performance, with higher bandwidth and lower latency than VPN connections. ExpressRoute offers per-circuit throughput of up to 10 gigabits per second (Gbps), with the per-gateway throughput of up to 9000 megabits per second (Mbps). These capabilities make ExpressRoute the preferred choice for enterprise and mission-critical workloads. ExpressRoute also might be worth considering when implementing an Azure region as a disaster recovery site or as the backup destination for on-premises systems. 

* **Azure Virtual WAN**, which provides optimized and automated branch-to-branch connectivity through Azure. Virtual WAN lets you connect and configure branch devices to communicate with Azure. Connectivity and configuration can be performed manually by customers or streamlined by using preferred provider devices through a Virtual WAN partner. Using preferred provider devices allows ease of use, simplification of connectivity, and configuration management.

To establish direct connectivity from another Azure virtual network, you can use one of the following methods: 

* **VNet Peering** connects Azure virtual networks within the same Azure region or between Azure regions. The traffic between virtual networks flows directly over the Azure backbone network, without IPSec encryption.

* **VNet-to-VNet** connects Azure virtual networks in the same Azure region or in different Azure regions via a pair of virtual gateways that encrypt network traffic. Using VNet-to-VNet is like a site-to-site VPN. However, in this case, cross-region traffic doesn’t traverse the internet but is routed over the Azure backbone network.

It is possible to establish direct connectivity to an Azure virtual network from a physical computer or virtual machine not hosted in Azure by using one of the following methods:

* **A point-to-site VPN**, which connects individual computers to an Azure virtual network via a Secure Socket Tunneling Protocol (SSTP) tunnel or OpenVPN over the internet.

* **A site-to-site VPN**, which connects an on-premises network to an Azure virtual network via an IPsec tunnel over the internet. 

* **Azure ExpressRoute**, which connects an on-premises network via a private connection. ExpressRoute provides more predictable performance, with higher bandwidth and lower latency than VPN connections. ExpressRoute offers per-circuit throughput of up to 10 gigabits per second (Gbps), with the per-gateway throughput of up to 9000 megabits per second (Mbps). These capabilities make ExpressRoute the preferred choice for enterprise and mission-critical workloads. ExpressRoute also might be worth considering when implementing an Azure region as a disaster recovery site or as the backup destination for on-premises systems. 

* **Azure Virtual WAN**, which provides optimized and automated branch-to-branch connectivity through Azure. Virtual WAN lets you connect and configure branch devices to communicate with Azure. Connectivity and configuration can be performed manually by customers or streamlined by using preferred provider devices through a Virtual WAN partner. Using preferred provider devices allows ease of use, simplification of connectivity, and configuration management.

To establish direct connectivity from another Azure virtual network, you can use one of the following methods: 

* **VNet Peering** connects Azure virtual networks within the same Azure region or between Azure regions. The traffic between virtual networks flows directly over the Azure backbone network, without IPSec encryption.

* **VNet-to-VNet** connects Azure virtual networks in the same Azure region or in different Azure regions via a pair of virtual gateways that encrypt network traffic. Using VNet-to-VNet is like a site-to-site VPN. However, in this case, cross-region traffic doesn’t traverse the internet but is routed over the Azure backbone network.

## Networking support for SAP on Azure
General network considerations regarding deployment of SAP workloads on Azure are outlined in the SAP Note #2015553 and covers the following aspects of networking:

**Network security**: 

For any SAP production system installed on Azure, it is required that you operate in Virtual Private Networks which are connected to your datacenters with Azure site-to-site or ExpressRoute connectivity. End-user access to the application should be routed through your company's intranet and the Azure site-to-site or ExpressRoute connections to the applications hosted in Azure Virtual Machine Services. This way, the network and other security policies defined for on-premises applications are extended to the application in the Azure Virtual Machines.


**Network reliability**:

* You should use a good quality (low latency, sufficient bandwidth, no packet loss) connection between their datacenter and Azure. You should also  verify and monitor that the bandwidth between on-premises and Azure is sufficient to handle the communication workload.

