---
title: Virtual Networks
---

+----------------------------------------------------------------------------------------------------------------------------------------+
| # Learning Objectives                                                                                                                  |
+========================================================================================================================================+
| Recall key design considerations for data-center networks and describe the need for network virtualization to support multiple tenants |
+----------------------------------------------------------------------------------------------------------------------------------------+

Large data centers are part of the core infrastructure that supports cloud services. To be cost-effective, these data centers must have networks that are agile and easy to configure and update. In addition, these networks must lend themselves to the concept of *network virtualization*, in which virtual networks are created on top of physical networks in much the way that virtual machines are created on physical servers. While a complete treatment of data-center networking and the technologies that underly it are beyond the scope of this course, it is important to understand the motivation for network virtualization within cloud data centers, and of some of the challenges it entails.

# Challenges in Designing Cloud Data Centers

Computer networks are collections of nodes and links. A node can be any network appliance such as a switch, router, or server. A link is a physical or logical connection between two nodes in the network. Networks also comprise identification resources (addresses) and labeling tags. Often, a mechanism for identifying devices (IP address and MAC address), links (flow ID), and networks (VLAN ID and VPN ID) is needed for the management and monitoring of a virtualized infrastructure. High-level organizational structures such as network topologies can be created by assembling these resources.

Designers of large data-center networks must contend with several (sometimes contradictory) requirements^ ^[^1]. They must:

1.  Ensure that the topology used is scalable to cope with future demand

2.  Maximize throughput while minimizing hardware cost

3.  Ensure that their design guarantees availability and integrity of the system despite failures

4.  Have power-saving features to reduce operating costs (and be environment-friendly)

An important consideration in designing the network for a large data center is selecting the right network fabric. Choices include Ethernet, InfiniBand, and other high-speed fabrics such as Myrinet. Each has different cost, latency, bandwidth, and communication criteria and must be chosen carefully. A physical comparison of these fabrics is not within our scope. What interests us more is the topology and addressing scheme selected to interconnect these resources. For instance, if we choose to use an Ethernet-addressed network (where endpoints are identified based on a flat 6-byte MAC address), it is likely that such a network will be flat, where each interface is assigned a MAC address that does not depend upon its location. This makes routing difficult and forwarding tables large, since all addresses must be stored.

For this reason, we mostly rely on hierarchical routing to build scalable networks. Addressing and routing is often based on IP-based routing, where each endpoint is assigned an IP address based on its location in the hierarchy. However, this limits the mobility of virtual machines: migrating a VM from one host to another must be handled using a different policy. Also, it is often problematic to allocate IP addresses deterministically in a public cloud environment, as doing so reveals information about where VMs are physically hosted. The selection of data center network topologies is an active area of research, with the focus on both fixed and flexible topologies which could be tree-based or recursive.

Apart from the topology and addressing scheme, it is important to decide on the routing mechanism. Routing may be centralized, where a single central controller creates lookup tables which determine the forwarding action. This is theoretically optimal, since the central controller has complete visibility of the data center network and makes it easier to configure and to understand the impact of faults. However, the controller introduces a bottleneck and single point of failure, and results in a substantial overhead in propagating forwarding tables. Instead of centralized routing, distributed approaches may be used where decisions are based upon local information at each router and switch.

Traffic within large data centers may be carefully engineered to minimize congestion and latency. To do this, groups of packets are categorized as "flows" if they are sequentially or logically related. The routing protocols perform load balancing by distributing these as a flow between two nodes among multiple parallel paths. The design of a data center must be optimized for the specific flow patterns within it, which is why the ability to analyze traffic is important for a data center designer. Routing protocols must be state-aware, so that idle routes are favored over busy ones, and flows are dispersed over multiple parallel paths.

Finally, data center networks must be designed for fault tolerance. Such networks often use *gossip protocols*, where neighbors talk to each other to disseminate information about failures quickly. It is important to design such mechanisms so that they do not consume large amounts of bandwidth. There must also be mechanisms to recover from failure and reincorporate failed components within the network.

# Network Virtualization

By now, it should be clear that implementing a large data center network is extremely complex and needs a higher-level abstraction to be easy to design and configure. However, the situation is even more complex for cloud data centers, largely due to multi-tenancy requirements. The cloud computing paradigm is only relevant if it can ensure isolation amongst multiple tenants. A cloud service provider must ensure traffic isolation so that one tenant's traffic is not visible to another. For example, packets transmitted to or from a banking application hosted in one tenant must not be visible to a gaming application in another tenant. The address space must also be isolated so that each tenant has access to their own private address space.

Both traffic and address-space isolation are achieved by building *virtual networks* for each tenant, with traffic between these networks restricted to a few strictly defined channels. These virtual networks are generally built as "overlays" on top of physical networks. An *overlay network* is a virtual network in which the separation of tenants is hidden from the underlying physical infrastructure, such that the underlying transport network does not need to know about the different tenants to correctly forward traffic. We refer to network virtualization as the process of provisioning these overlays, associating them with the tenant's network interfaces, and maintaining the lifecycle of this network as VM instances are launched, stopped, and terminated[^2].

One of the important benefits of virtualizing the network is that it allows VM migration between hosts while retaining its network state (IP and MAC addresses). Changes in MAC addresses can cause many unexpected disruptions -- for example, by invalidating software licenses. Thus, physical hosts can be assigned IP addresses hierarchically, whereas a VM can have an IP address that is within a pool of valid addresses for that subnet.

Another driver for network virtualization is the increased complexity in maintaining forwarding tables. Rather than maintain a single MAC address per physical server, cloud data centers must maintain a MAC address for each and every VM, which leads to significant demand on the forwarding node's capacity.

Virtualization also helps provide individual tenants with control over the addresses they use within their view of the network. Thus, the overlay network must provide tenants with the ability to use any address that they want, without having to check the networks of all of the neighboring tenants. These addresses should also be independent of the addresses used by the cloud service provider's infrastructure. Virtual networks use this address separation to limit the scope of packets that are sent on it. Packets are allowed to cross network boundaries only through controlled exit points.

Finally, the presence of multiple tenants and the overcommitting of the shared network bandwidth leads to a traffic and flow management challenge. CSPs must ensure a quality of service (QoS) in line with the guaranteed SLAs and must shape traffic from each tenant according to the peak utilization provisioned.

In summary, network virtualization is simply a sharing mechanism that allows multiple isolated virtual networks to use the same physical network infrastructure. This allows virtual networks to be dynamically allocated and deployed on-demand precisely like virtual machines^ ^[^3]. On a practical level, consumers of cloud services must be able to deploy virtual networks that support all the features of physical networks, including subnets, Classless Inter-Domain Routine (CIDR) addressing, firewalls, and peering for cloud computing to be a viable computing paradigm. This is precisely what cloud service providers such as Amazon, Microsoft, and Google allow you to do.

# Case Study: Virtual Networks in Azure

All major cloud service providers support virtual networks, albeit sometimes using different terminology and abstractions. Azure, for example, doesn't offer virtual firewalls per se, but it does support *network security groups* (NSGs), which are an abstraction of firewalls. Figure 4.10 shows an Azure virtual network (VNet) set up to serve content to customers from virtual web servers fronted by a virtual load balancer that's assigned a virtual public IP address. The load balancer and the web-server VMs are located in one subnet, while back-end databases and other resources are isolated in an entirely different subnet. Each subnet is in a different NSG, with different firewall rules applied to each. For example, the public-facing subnet opens ports 80 and 443 to the outside world to support HTTP and HTTPS traffic, while the private subnet is accessible only from the other subnet and opens only those ports required for the web servers to connect to the databases. Not shown in the diagram are other virtual network resources such as the virtual network interface cards (NICs) that connect the VMs to the network.

![Image result for azure virtual network](media/image1.png){width="4.349273840769904in" height="4.989583333333333in"}

Figure 4.10: Virtual network in Azure.

This mirrors the topology you might design for a physical network to support security and scalability. And it merely scratches the surface of what savvy cloud administrators can accomplish with virtual networks. Azure, for example, supports VNet peering, enabling two or more virtual networks to be connected, even if the networks are located in different Azure regions. It also supports point-to-site and site-to-site virtual private networks (VPNs), which enable on-premises devices and network appliances to securely connect to virtual networks, and Azure ExpressRoute, which provides secure, dedicated, and high-bandwidth connectivity between on-premises networks and virtual networks. AWS and Google do the same through services such as Virtual Private Cloud (AWS and Google), AWS Direct Connect, and Google Cloud interconnect.

In summary, virtual networking is as mature a technology as virtual machines, and it is no less vital in the context of cloud computing. While the details are largely hidden from end users, data centers and the networks that comprise them are expertly and purposefully designed to support virtual networking and everything that entails.

\[Activity M3-P4-A, M4-P4-B\]

[^1]: Liu, Yang and Muppala, Jogesh K and Veeraraghavan, Malathi and Lin, Dong and Hamdi, Mounir (2013). \"Data Center Networks: Topologies, Architectures and Fault-Tolerance Characteristics.\" Springer Science and Business Media.

[^2]: Liu, Yang and Muppala, Jogesh K and Veeraraghavan, Malathi and Lin, Dong and Hamdi, Mounir (2014). \"Problem statement: Overlays for network virtualization.\" RFC 7364.

[^3]: Wen, Heming and Tiwary, Prabhat Kumar and Le-Ngoc, Tho (2013). \"Wireless virtualization.\" Springer.
