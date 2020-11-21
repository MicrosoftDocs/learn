# Software-defined networking

Software-defined networking (SDN) provides a method to centrally configure and manage physical and virtual network devices. These devices can include routers, switches, and gateways in your datacenter. SDN allows you to dynamically manage your datacenter network with an automated, centralized way to meet the requirements of your applications and workloads. SDN abstracts your network infrastructure, defines policies to control the network, and gives you the tools to manage the network as the following list describes:

- Network Abstraction. Virtualizing the network allows you to abstract your applications and workloads from the underlying physical network. Similar to server virtualization with Hyper-V, network abstraction provides a uniform interface for provisioning and managing physical network devices, such as switches and load balancers.
- Network Policies. Network policies let you centrally define and control policies that govern both physical and virtual networks, including traffic flow between these two network types. You define these policies in the management layer but apply them to the physical layer. Implementing network policies in a consistent manner facilitates scaling as you deploy new workloads or move workloads across virtual or physical networks.
- Network Management. The ability to efficiently manage virtualized network infrastructure is highly dependent on tools that facilitate configuring virtual network objects and policies. PowerShell offers the most versatility. However, Windows Admin Center, Microsoft System Center Virtual Machine Manager, and Microsoft System Center Operations Manager considerably simplify complexity inherent to scripting-based management.

## SDN benefits

SDN allows you to take advantage of a virtualized infrastructure to overcome challenges inherent to the traditional network infrastructure. SDN helps by increasing agility, improving security, and optimizing efficiency.

- Agility

  - Accelerate your DevOps cycle
  - Manage complex policies on demand
  - On-board large workloads quickly
  - Work seamlessly between your datacenter and the public cloud

- Security

  - Layered architecture for stronger protection and threat isolation
  - Full network control for instant reaction to threats
  - Granular firewall policies

- Efficiency

  - Minimized operation and infrastructure costs
  - Smart and flexible resource management

## SDN components

Microsoft implementation of SDN is based on a number of core components, including:

- Hyper-V Network Virtualization (HNV). Network virtualization isolates network traffic between different workloads running on the same physical infrastructure. In HNV, isolation relies on encapsulation protocols such as Virtual Extensible LAN (VxLAN) or Network Virtualization Generic Routing Encapsulation (NVGRE) to allow creation of overlay networks with potentially overlapping IP address ranges, required in multi-tenant scenarios.

   > **Note**: Windows Server 2019 SDN builds on and expands Hyper-V Network Virtualization version 2 (HNVv2) that Microsoft introduced along with HNVv1 in Windows Server 2016.

- Hyper-V virtual switch. Hyper-V virtual switch is a software-based Layer 2 Ethernet network switch. You can use the Hyper-V virtual switch to connect guest virtual machines (VMs) and the parent partition to virtual and physical networks. The Hyper-V Virtual Switch is fully extensible. It provides advanced features such as policy enforcement, tenant isolation, traffic shaping, and protection against malicious guest VMs. You can implement a significant number of SDN-based features by using the Azure Virtual Filtering Platform (VFP) forwarding extension in the Hyper-V virtual switch.
- Network Controller. Network Controller is a Windows Server role that you can use as a centralized and programmable point of automation for the virtual and physical network infrastructure. Network Controller facilitates deployment and configuration of network services by relying on network function virtualization. This involves provisioning of virtual appliances that deliver the same functionality as hardware-based network devices. These virtual appliances include Software Load Balancer and Network Address Translation (NAT), Datacenter Firewall, and Remote Access Service (RAS) Gateway for SDN. Network Controller manages virtual network policies and relies on host agents running on managed Hyper-V hosts to implement policy enforcements in VFP extensions of the Hyper-V virtual switch.
- Remote Direct Memory Access (RDMA) and RDMA over Converged Ethernet (RoCE). RDMA adapters minimize latency and operating system-level overhead involved in processing network traffic by delivering it directly to the memory of workloads running within that operating system, effectively bypassing traditional network data processing paths. RDMA can provide transfer rates of up to 40 Gbps. It also reduces latency.
- Switch-Embedded Teaming (SET). SET is a feature introduced in Windows Server 2016 that enables you to combine up to eight identical physical network adapters directly into the Hyper-V virtual switch. SET supports RDMA, including the ability to process RDMA and IP-based traffic converged over the same team.

   > **Note**: SET effectively replaces the legacy Load Balancing and Failover (LBFO), which is also known as NIC teaming, that HNVv1 uses. LBFO enables multiple network interfaces to work together as a team and prevents connectivity loss if one of the network interfaces in a team fails. It also provides bandwidth aggregation for the network interfaces in a team. You can add up to 32 network adapters from different vendors and support different network speeds in the same team. When you add two or more physical network adapters into a network adapter team, the operating system considers it as one or more virtual adapters, known also as team network adapters. LBFO is not compatible with RDMA.
