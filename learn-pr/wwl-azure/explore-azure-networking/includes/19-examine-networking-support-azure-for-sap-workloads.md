

General network considerations for deployment of SAP workloads on Azure are outlined in [SAP Note #2015553](https://launchpad.support.sap.com/#/notes/2015553) and deal with the following aspects of networking:

## Network security

- “For any SAP production system installed on Azure, it is required that you operate in Virtual Private Networks that are connected to your datacenters with Azure site-to-site or ExpressRoute connectivity. End-user access to the application should be routed through your company's intranet and the Azure site-to-site or ExpressRoute connections to the applications hosted in Azure Virtual Machine Services. This way, the network, and other security policies defined for on-premises applications are extended to the application in the Azure Virtual Machines.
- A design that is NOT supported is the segregation of the SAP application layer and the DBMS layer into different Azure virtual networks that are not peered with each other. Segregate the SAP application layer and DBMS layer using subnets within an Azure virtual network instead of using different Azure virtual networks. If you decide not to follow the recommendation and instead segregate the two layers into different virtual networks, the two virtual networks need to be peered. Network traffic between two peered Azure virtual networks is subject to transfer costs. With the huge data volume, in many Terabytes, exchanged between the SAP application layer and DBMS layer substantial costs can be accumulated if the SAP application layer and DBMS layer is segregated between two peered Azure virtual networks.”

## Network performance

- “It is NOT supported at all to run an SAP Application Server layer and DBMS layer split between on-premises and Azure. Both layers need to completely reside either on-premises or in Azure. It is also NOT at all supported to have SAP instances split between on-premises and Azure. Per individual SAP system, the DBMS and all SAP application instance(s) must be in the same location, either Azure or on-premise.
- The location of the Azure data center or region relative to the own datacenter can impact the latency experienced between on-premises and Azure hosted SAP systems. To minimize latency between on-premises and Azure, it is advisable to select Azure Regions that are close to the own location.
- Out of functionality, but more important out of performance reasons, it is not supported to configure Network Virtual Appliances (NVA) on Azure in the communication path between the SAP application and the DBMS layer of an SAP NetWeaver, Hybris, or S/4HANA based SAP system. The communication between the SAP application layer and the DBMS layer needs to be a direct one. For more information check [SAP Note \#2731110](https://launchpad.support.sap.com/#/notes/2731110). The restriction does not include Azure Security Group (ASG) and Network Security Group (NSG) rules if those ASG and NSG rules allow direct communication. Further scenarios where NVAs are not supported are in communication paths between Azure VMs that represent Linux Pacemaker cluster nodes and SBD devices or in communication paths between Azure VMs and Windows Server SOFS set.”

## Network reliability

- “Customers should use a good quality (low latency, sufficient bandwidth, no packet loss) connection between their datacenter and Azure. Customers also should verify and monitor that the bandwidth between on-premises and Azure is sufficient to handle the communication workload.”

Azure VMs can benefit from the use of Accelerated Networking and Proximity Placement Groups.
