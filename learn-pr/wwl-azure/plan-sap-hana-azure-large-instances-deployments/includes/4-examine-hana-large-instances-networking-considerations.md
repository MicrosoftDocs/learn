This architecture uses both virtual and physical networks. The virtual network is part of Azure IaaS and connects to a discrete HANA Large Instances physical network through ExpressRoute circuits. A cross-premises gateway connects your workloads in the Azure virtual network to your on-premises sites.

HANA Large Instances networks are isolated from each other for security. By default, instances residing in different regions do not communicate with each other, except for the dedicated storage replication. However, to use HSR, inter-region communications are required. ExpressRoute Global Reach, IP routing tables, or proxies can be used to enable cross-region HSR.

All Azure virtual networks that connect to HANA Large Instances in one region can be cross-connected via ExpressRoute to HANA Large Instances in a secondary region.

ExpressRoute for HANA Large Instances is included by default during provisioning. For setup, a specific network layout is needed, including required CIDR address ranges and domain routing.

The architecture of Azure network services is a key component of the successful deployment of SAP applications on HANA Large Instance. Typically, SAP HANA on Azure (Large Instances) deployments have a larger SAP landscape with several different SAP solutions with varying sizes of databases, CPU resource consumption, and memory utilization. It's likely that not all IT systems are in Azure already. Your SAP landscape is often hybrid as well from a DBMS point and SAP application point of view using a mixture of NetWeaver, and S/4HANA, SAP HANA, and another DBMS. Azure offers different services that allow you to run the different DBMS, NetWeaver, and S/4HANA systems in Azure. Azure also offers you network technology to make Azure look like a virtual data center to your on-premises software deployments.

The Azure network functionality involves the use of the following components:

 -  Azure virtual networks connected to the ExpressRoute circuit that, in turn, connects to your on-premises network assets.
 -  An ExpressRoute circuit that connects on-premises to Azure, with bandwidth of 1 Gbps or higher. The available bandwidth must allow for transfer of data between on-premises systems and systems that run on Azure VMs and must facilitate performant connectivity to Azure VMs from on-premises users. This ExpressRoute circuit is fully paid by you as a customer.
 -  All SAP systems in Azure set up in virtual networks to communicate with each other.
 -  Active Directory and DNS hosted on-premises extended into Azure through ExpressRoute from on-premises or running entirely in Azure.
 -  An ExpressRoute circuit that connects SAP HANA Large Instances into the Azure data center network fabric. This circuit is deployed and handled by Microsoft. All you need to do is provide IP address ranges after the deployment of your assets in HANA Large Instance connect the ExpressRoute circuit to the virtual networks. There is no additional fee for you as a customer for the connectivity between the Azure data center network fabric and HANA Large Instance units.
 -  An Azure ExpressRoute gateway that connects a virtual network to ExpressRoute circuits. An Azure ExpressRoute gateway is used with ExpressRoute to an infrastructure outside of Azure or to an Azure Large Instance stamp. You can connect the Azure ExpressRoute gateway to a maximum of four different ExpressRoute circuits if those connections come from different Microsoft enterprise edge routers.
 -  Networking within the HANA Large Instance stamp, which is mostly transparent for you.

The maximum throughput you can achieve with an ExpressRoute gateway is 10 Gbps. Copying files between a VM that resides in a virtual network and a system on-premises (as a single copy stream) doesn't achieve the full throughput of the different gateway SKUs. To leverage the complete bandwidth of the ExpressRoute gateway, use multiple streams.

There are some unique networking considerations applicable to SAP HANA on Azure (Large Instances):

 -  The HANA Large Instance units of your customer tenant are connected through another ExpressRoute circuit into your virtual networks. To separate load conditions, the on-premises to Azure virtual network ExpressRoute circuits and the circuits between Azure virtual networks and HANA Large Instances don't share the same routers.
 -  The workload profile between the SAP application layer and the HANA Large Instance consists typically of small requests and burst data transfers (result sets) from SAP HANA into the application layer.
 -  The SAP application architecture is more sensitive to network latency than typical scenarios where data is exchanged between on-premises and Azure.
 -  The Azure ExpressRoute gateway has at least two ExpressRoute circuits: one circuit that is connected from on-premises and one that is connected from HANA Large Instances. This leaves only room for another two additional circuits from different MSEEs to connect to on ExpressRoute Gateway. All the connected circuits share the maximum bandwidth for incoming data of the ExpressRoute gateway.

The network latency experienced between VMs and HANA Large Instance units can be higher than a typical VM-to-VM network round-trip latency. Depending on the Azure region, the values measured can exceed the 0.7-ms round-trip latency classified as below average in [SAP Note \#1100926](https://launchpad.support.sap.com/#/notes/1100926). Depending on Azure Region and tool to measure network round-trip latency between an Azure VM and HANA Large Instance unit, the measured latency can be up to and around 2 milliseconds. Make sure you test your business processes thoroughly in Azure HANA Large Instance.

To provide deterministic network latency between VMs and HANA Large Instance, the choice of the ExpressRoute gateway SKU is essential. Unlike the traffic patterns between on-premises and VMs, the traffic pattern between VMs and HANA Large Instance can include bursts of requests and data volumes.

Given the overall network traffic between the SAP application and database layers, only the HighPerformance or UltraPerformance gateway SKUs are supported for connecting to SAP HANA on Azure (Large Instances). For HANA Large Instance Type II SKUs, only the UltraPerformance gateway SKU is supported as an ExpressRoute gateway. Exceptions apply when using ExpressRoute FastPath.
