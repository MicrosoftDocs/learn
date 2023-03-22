Azure Stack HCI also relies heavily on SDN to implement its features. Similar to software-defined storage, SDN isn't an individual server role or a feature. Instead, it's a collection of different technologies that enable a wide range of network virtualization scenarios. These technologies include Hyper-V Network Virtualization, Hyper-V virtual switch, Switch-Embedded Teaming (SET), and Network Controller. While Network Controller is optional in Azure Stack HCI, you might consider testing it in your proof-of-concept environment.

> [!NOTE]
> This is not a comprehensive list but is sufficient to gain a basic understanding of the core SDN functionality in Azure Stack HCI.

# What is SDN?

SDN provides a method to centrally configure and manage physical and virtual network devices. These devices can include routers, switches, and gateways in your datacenter.

### Reasons for using SDN

You can use SDN to dynamically manage your datacenter network with an automated, centralized way to meet the requirements of your applications and workloads. SDN abstracts your network infrastructure, defines policies to control the network, and gives you the tools to manage the network:

- Network Abstraction. Virtualizing the network allows you to abstract your applications and workloads from the underlying physical network. Similar to server virtualization with Hyper-V, network abstraction provides a uniform interface for provisioning and managing physical network devices, such as switches and load balancers.
- Network Policies. Network policies let you centrally define and control policies that govern both physical and virtual networks, including traffic flow between these two network types. You define these policies in the management layer but apply them to the physical layer. Implementing network policies in a consistent manner facilitates scaling as you deploy new workloads or move workloads across virtual or physical networks.
- Network Management. The ability to efficiently manage virtualized network infrastructure is highly dependent on tools that facilitate configuring virtual network objects and policies. PowerShell offers the most versatility. However, Windows Admin Center and Microsoft System Center Virtual Machine Manager simplify the complexity that is inherent to scripting-based management.

## Primary components of the Microsoft implementation of SDN

The Microsoft implementation of SDN includes the following components:

- Hyper-V Network Virtualization (HNV). HNV isolates network traffic between different workloads running on the same physical infrastructure. In HNV, isolation relies on encapsulation protocols such as Virtual Extensible LAN (VxLAN) or Network Virtualization Generic Routing Encapsulation (NVGRE) to allow creation of overlay networks with potentially overlapping IP address ranges, required in multi-tenant scenarios.
- Hyper-V virtual switch. A Hyper-V virtual switch is a software-based Layer 2 Ethernet network switch. You can use this switch to connect guest VMs and their Hyper-V hosts to virtual and physical networks. The Hyper-V Virtual Switch is fully extensible. It provides advanced features such as policy enforcement, tenant isolation, traffic shaping, and protection against malicious guest VMs.
- SET. SET enables you to combine up to eight identical physical network adapters directly into the Hyper-V virtual switch. SET provides load balancing and bandwidth aggregation functionality, resulting in higher network throughput for virtualized workloads. In addition, SET enhances fault tolerance, automatically adjusting traffic distribution if one or more of individual network adapters fail.
- Network Controller. Network Controller is a Windows Server and Azure Stack HCI role. It serves as the centralized and programmable point of automation for the virtual and physical network infrastructure in Windows Server-based SDN. Network Controller manages deployment and configuration of network services, including support for the provisioning of virtual appliances that deliver the same functionality as hardware-based network devices. These virtual appliances include Software Load Balancer and Network Address Translation (NAT), Datacenter Firewall, and Remote Access Service (RAS) Gateway for SDN. Network Controller manages virtual network policies and relies on host agents running on managed Hyper-V hosts to implement policy enforcements in Hyper-V virtual switch.

> [!NOTE]
> An Azure Stack HCI cluster provides you the option to virtualize its network resources by implementing SDN. Because such SDN implementation is optional, you have the choice of integrating Azure Stack HCI into an existing virtual local area network (VLAN)-based infrastructure or isolating its workloads by making use of SDN-based network virtualization.
