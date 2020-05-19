
The network bandwidth allocated to each virtual machine is metered on egress (outbound) traffic from the virtual machine. All network traffic leaving the virtual machine is counted toward the allocated limit, regardless of destination. 

For example, if a virtual machine has a 1,000-Mbps limit, that limit applies whether the outbound traffic is destined for another virtual machine in the same virtual network, or outside of Azure. Ingress is not metered or limited directly. 

However, there are other factors, such as CPU and storage limits, which can impact a virtual machine’s ability to process incoming data.

Expected outbound throughput and the maximum number of network interfaces depends on the VM size. The throughput limit applies to the virtual machine. Throughput is unaffected by the following factors:

* **Number of network interfaces**: The bandwidth limit is cumulative of all outbound traffic from the virtual machine.

* **Accelerated networking**: Though the feature can be helpful in achieving the published limit, it does not change the limit.

* **Traffic destination**: All destinations count toward the outbound limit.

* **Protocol**: All outbound traffic over all protocols counts towards the limit.

## Network security
Below are general network considerations for deploying of SAP workloads on Azure:

* For any SAP production system installed on Azure, it is required that users operate within a Virtual Private Network, which is connected to the datacenter using Azure site-to-site or ExpressRoute connectivity. End-user access to the application should be routed through the organizations intranet and the Azure site-to-site or ExpressRoute connections to the applications hosted in Azure Virtual Machine Services. As a result, the network and other security policies defined for on-premises applications are extended to the application in the Azure Virtual Machines.

* A design is unsupported where the segregation of the SAP application layer and the DBMS layer into different Azure virtual networks that are not peered with each other. The recommendation is to segregate the SAP application layer and DBMS layer using subnets within an Azure virtual network instead of using different Azure virtual networks. If there is a reason to segregate the two layers into a different virtual network, the two virtual networks need to be peered. Network traffic between two peered Azure virtual networks is subject to transfer costs. With the huge data volume and many Terabytes exchanged between the SAP application layer and DBMS layer, substantial costs can be accumulated if the SAP application layer and DBMS layer is segregated between two peered Azure virtual networks.

## Network performance

Running an SAP Application Server layer and DBMS layer split between on-premises and Azure is not supported. Both layers need to completely reside either on-premises or in Azure. Also, having SAP instances split between on-premises and Azure is not supported. As determined by the individual SAP system, the DBMS and all SAP application instance(s) must be in the same location, either Azure or on-premise.

The location of the Azure data center or region relative to the own datacenter can impact the latency experienced between on-premises and Azure hosted SAP systems. To minimize latency between on-premises and Azure, it is advisable to select Azure Regions, which are close to the own location.


## Network reliability

It is good practice to use a good quality (low latency, sufficient bandwidth, no packet loss) connection between a datacenter and Azure. Users should verify and monitor that the bandwidth between on-premises and Azure is sufficient to handle the communication workload.

Azure VMs and SAP HANA on Azure (Large Instances) can benefit from the use of Accelerated Networking and Proximity Placement Groups. 
