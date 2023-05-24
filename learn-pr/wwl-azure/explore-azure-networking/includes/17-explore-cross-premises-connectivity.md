

From the point of view of the location of SAP landscape, there are two basic high-level infrastructure designs to consider:

- **Cross-premises** \- a single or multiple Azure IaaS–hosted SAP workloads with the requirement of being fully integrated into the existing on-premises SAP environment
- **Cloud-only** \- the complete SAP landscape runs on Azure IaaS (typically with the customer's on-premises infrastructure extended into Azure).

It's important to note that in cross-premises scenarios between Azure and on-premises customers’ environments, SAP systems must reside entirely in either one of the two environments. In particular, the following deployments aren't supported in cross-premises scenarios:

- **Running different layers of SAP applications in different deployment methods**. For example, running the DBMS layer on-premises, but the SAP application layer in VMs deployed as Azure VMs or vice versa.
- **Some components of an SAP layer in Azure and some on-premises**. For example, splitting Instances of the SAP application layer between on-premises and Azure VMs.
- **Distribution of VMs running SAP instances of one system over multiple Azure regions isn't supported**.

The reason for these restrictions is the requirement for a low latency high-performance network within one SAP system, especially between the application instances and the DBMS layer of an SAP system.

Special planning of the systems and regions must occur when using multiple SAP systems that are highly integrated. Make sure to deploy these systems as close as possible to each other to minimize network latency. Examples of highly integrated SAP systems are:

- SAP BW reading data from SAP OLTP systems like ERP or CRM or SRM; or
- SAP SLT being used to replicate data between multiple SPA systems or even between SAP and non-SAP systems; or SAP S/4 connected to an SAP ERP system

When connecting Microsoft Azure Virtual Networks back to the enterprise, there are two high-level options:

- **Connect through public endpoints of Azure VMs**
- **Connect through a VPN or Azure ExpressRoute**

Site-to-site connectivity via VPN or ExpressRoute is necessary for production scenarios. This type of connection is also needed for non-production scenarios that feed into production scenarios where SAP software is being used.

When you have site-to-site connectivity into Azure via VPN or ExpressRoute, you must have at least one Azure virtual network that's connected through a Virtual Gateway to the VPN tunnel or ExpressRoute circuit. In simple deployments, the Virtual Gateway can be deployed in a subnet of the Azure virtual network (VNet) that hosts the SAP application and database instances as well. To install SAP workloads, create at least two additional subnets within the Azure virtual network. One subnet contains Azure VMs hosting SAP DMBS. The other subnet runs jumpbox or management Azure VMs to host SAP HANA Studio, other management software, or your application software.

For larger deployments, consider implementing the virtual datacenter network architecture in Azure. This architecture recommends deployment of the virtual gateway that connects to on-premises into a separate Azure VNet. This separate VNet should serve as the transit network for all the traffic between the SAP deployment and the on-premises environment or internet. This approach allows you to deploy software for auditing and logging traffic that enters the virtual datacenter in Azure in this separate hub VNet. Effectively, you have one VNet that hosts all the software and configurations that relate to incoming and outgoing traffic for your Azure deployment.

Traffic that flows between a hub VNet and spoke VNet using Azure VNet peering is subject to additional costs. Based on those costs, you might need to consider making compromises between running a strict hub and spoke network design and running multiple Azure ExpressRoute Gateways that you connect to 'spokes' in order to bypass VNet peering. However, Azure ExpressRoute Gateways introduce additional costs as well. You also may encounter additional costs for third-party software you use for network traffic logging, auditing, and monitoring. Dependent on the costs for data exchange through VNet peering on the one side and costs created by additional Azure ExpressRoute Gateways and additional software licenses, you may decide for micro-segmentation within one VNet by using subnets as isolation unit instead of VNets.

For SAP enterprise applications, there are few use cases where they can function in an isolated network environment (perhaps a training landscape or sandbox), however, the reality is that such applications require on-premises network connectivity for many reasons, including:

- SAPGUI / RFC traffic
- SAP transports
- SAP Solution Manager / OSS connectivity
- SAP System Interfaces
- Connectivity to other SAP solutions
- Printing
- Backups
- Monitoring

The fact that part of the SAP components is running on Azure shouldn't be perceivable to end users. Hence SAP Transport Correction System (STMS), RFC Communication, Printing, and Security (such as SSO) need to operate seamlessly when SAP systems reside in Azure.

Setting up your on-premises TCP/IP based network printers in an Azure VM is overall the same as in your corporate network, assuming you do have a VPN Site-To-Site tunnel or ExpressRoute connection established.

The SAP Change and Transport System (TMS) needs to be configured to export and import transport requests across systems in the landscape. However, in site-to-site connected cross-premises scenarios, the latency between on-premises and Azure still can be substantial. If we follow the sequence of transporting objects through development and test systems to production or think about applying transports or support packages to the different systems, you realize that, dependent on the location of the central transport directory, some of the systems will encounter high latency reading or writing data in the central transport directory. The situation is like SAP landscape configurations where the different systems are spread through different data centers with substantial distance between the data centers.

To work around such latency and have the systems work fast in reading or writing to or from the transport directory, you can set up two STMS transport domains (one for on-premises and one with the systems in Azure and link the transport domains).

For more information, see [Transport Management System - Concept](https://help.sap.com/saphelp_me60/helpdata/en/c4/6045377b52253de10000009b38f889/content.htm).

To facilitate RFC traffic between systems residing on-premises and in Azure, set up a connection call transaction SM59 in a source system where you need to define an RFC connection towards the target system. The configuration is like the standard setup of an RFC Connection.

We assume that in the cross-premises scenario, the VMs, which run SAP systems that need to communicate with each other are in the same domain. Therefore, the setup of an RFC connection between SAP systems doesn't differ from the setup steps and inputs in on-premises scenarios.

SAP instances located in Azure may need to access on-premises file shares. In addition, on-premises SAP instances may need to access file shares hosted in Azure. To enable cross-premises file sharing, you must configure the permissions and sharing options on the local system. In addition, you must make sure to open the relevant ports on the VPN or ExpressRoute connection between Azure and your datacenter.
