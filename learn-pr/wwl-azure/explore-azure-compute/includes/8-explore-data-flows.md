Like bandwidth, the number of network connections present on a virtual machine at any given time can affect its network performance. The Azure networking stack maintains state for each direction of a TCP/UDP connection in data structures called 'flows.'

A typical TCP/UDP connection has two flows created, one for the inbound and another for the outbound direction. Data transfer between endpoints requires creation of several flows in addition to the flows that perform the data transfer. Some examples are flows created for Domain Name System (DNS) resolution and flows created for load balancer health probes.

Connection recommendations depend on the VM's vCPU count and networking hardware. A connection and a directional flow aren't interchangeable: a typical TCP/UDP connection uses an inbound flow and an outbound flow. The current recommended connection limits for VMs other than Network Optimized sizes are:

| VM vCPUs | Azure Boost VMs with MANA | Other VM sizes |
| --- | --- | --- |
| 2-7 | 100,000 | 100,000 |
| 8-15 | 500,000 | 500,000 |
| 16-31 | 700,000 | 700,000 |
| 32-63 | 800,000 | 800,000 |
| 64 or more | 2,000,000 | 1,000,000 |

MANA is the Microsoft Azure Network Adapter. Network Optimized VM sizes have separate connection recommendations. These values are recommendations, not performance guarantees. Above the recommended limit, connections can be dropped or experience reduced performance. Benchmark the workload's expected traffic patterns, including connection creation and termination rates, and monitor the VM's inbound and outbound flow metrics.

Network virtual appliances (NVAs), such as gateways, proxies, and firewalls, consume additional flows when forwarding traffic. Use half the applicable recommended connection limit for forwarding workloads because they consume twice the flows of typical client-server communication. For the maintained tables and Network Optimized guidance, see [Virtual machine network bandwidth](/azure/virtual-network/virtual-machine-network-throughput#flow-limits-and-active-connections-recommendations).

Azure Virtual Machines are more agile than on-premises virtual machines. You can deploy and scale Azure Virtual Machines vertically on an as-needed basis, without investing in dedicated hardware. Thus, Azure Virtual Machines suitable for scenarios that must accommodate dynamically changing workloads. Also, the ease of provisioning and deprovisioning makes Azure Virtual Machines ideal for proof-of-concept or development scenarios, where the need for compute resources is temporary.

In each of these scenarios, you also benefit from the pricing model applicable to Azure Virtual Machines. When you run Azure Virtual Machines, you pay for the compute time on a per-second basis. The price for virtual machines is calculated based on their size, the operating system, and any licensed software installed on the virtual machine. A running virtual machine requires allocation of Azure compute resources. Therefore, to avoid the corresponding charges whenever you're not using it, you should change its state to **Stopped (Deallocated)**.

:::image border="false" type="content" source="../media/data-flows-between-2-vms-network-appliance-fa603621.png" alt-text="Diagram showing data flows between two virtual machines and a network appliance.":::
