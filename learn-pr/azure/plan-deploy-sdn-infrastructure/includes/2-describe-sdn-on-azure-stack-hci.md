Before you begin to evaluate the capabilities of Azure Stack HCI SDN, you want to review the core SDN concepts. You realize that these concepts form the foundational knowledge to help you understand the more complex aspects of network virtualization and virtualization-based services. Particularly, software load balancers, distributed firewalls, and remote access gateways.

## What is network virtualization?

To understand the purpose of network virtualization, it might be helpful to compare it to server virtualization, which makes it possible to concurrently run multiple operating system instances (virtual machines) on a single physical host, with each instance functioning independently from the others. Network virtualization provides a similar capability regarding virtual networks by facilitating their isolation within the same physical network infrastructure, without relying on VLANs or dedicated IP address management solutions. This flexibility makes it easier for customers to transition their workloads to private and public clouds. It also helps hosting providers and datacenter administrators with managing their network infrastructure.
Additionally, these benefits play a significant role in datacenter consolidation initiatives. With Azure Stack HCI, customers can share physical resources while operating within their own, isolated environments. DevOps teams have the ability to deploy their applications without service interruptions resulting from changing IP address assignments. For infrastructure owners, the added flexibility simplifies dynamic resource allocation by abstracting the correlation between compute, storage, and network.

## What is Software-Defined Networking (SDN)?

SDN provides a method to centrally configure and manage networks and network services such as switching, routing, and load balancing in your datacenter. SDN uses network function virtualization to implement *virtualized software functions*. These functions replace functionality that’s traditionally delegated to hardware-based network devices.

## What is network function virtualization?

In software-defined datacenters, virtual appliances take over the delivery of network functions that hardware devices traditionally implement. These virtualized functions can be grouped into several categories, such as security and edge services. Security appliances include firewalls while edge appliances include gateways, routers, switches, and load balancers.

Virtual appliances feature several benefits when compared with their physical counterparts, with the most prominent ones being:

- Seamless capacity expansion and workload mobility.
- Minimized operational complexity.
- Simplified provisioning and management.
- Increased mobility.
- Support for vertical and horizontal scaling.

## SDN in Azure Stack HCI

Azure Stack HCI solutions provide built-in virtualization of compute and storage resources. In addition, Azure Stack HCI supports virtualizing its network resources by implementing SDN. This functionality allows for implementing various networking scenarios, ranging from integration with an existing VLAN-based infrastructure to full isolation of Azure Stack HCI workloads.

SDN in Azure Stack HCI helps address challenges associated with traditional network infrastructures by increasing agility, improving security, and optimizing efficiency. It provides the following capabilities:

- Abstracting network services. You can deploy and manage software-defined network services, abstracted from the underlying physical network.
- Centralizing network policies. You can use network policies to centrally configure and control rules that govern traffic flow within and between virtual and physical networks. Implementing network policies enhances consistency and scalability as the volume of network services increases.
- Centralizing network management. You can manage the virtualized network infrastructure by using PowerShell, Windows Admin Center, and Microsoft System Center Virtual Machine Manager (VMM).

These capabilities of Azure Stack HCI SDN are implemented by using Network Controller. Network Controller is a server role that provides a management interface that’s accessible via the Representational State Transfer (REST) Application Programming Interface (API). The interface is used for the deployment, management, configuration, monitoring, and troubleshooting of SDN infrastructure and network function virtualization-based services.

The network function virtualization-based services include:

- Software Load Balancer (SLB), which facilitates the building of highly available and scalable solutions by distributing network traffic across virtual network resources. In addition, through network address translation (NAT), SLB provides inbound and outbound internet access to virtualized workloads. SLB policies can be applied to virtualized overlay networks and traditional VLAN networks.
- Remote Access Service (RAS) Gateways for SDN, which help extend network connectivity to external networks through Site-to-Site (S2S) IP Security (IPsec) virtual private networks (VPNs), Site-to-Site Generic Routing Encapsulation (GRE) tunnels, and Layer 3 forwarding.
- Datacenter Firewall, which helps protect virtual networks and their workloads from unauthorized traffic originating from the internet and intranet networks. It provides stateful filtering based on a combination of up to five parameters of network packets. Including, the packet's protocol, source and destination port numbers, and source and destination IP addresses. These policies can be applied to virtualized overlay networks and traditional VLAN networks.

    > [!NOTE]
    > The Datacenter Firewall is meant to complement existing physical appliances.

- Quality of Service (QoS) policies, which can be used to prevent one application or workload VM from using up the entire bandwidth of the HCI cluster nodes. These policies can be applied to virtualized networks and traditional VLAN networks.
- Third-party appliances, where customers can bring their own third-party virtual appliances such as firewalls, intrusion detection devices, and load balancers and attach them to SDN virtual networks for advanced services.

### Virtual networks and subnets

To implement the isolation of virtualized workloads, SDN uses Hyper-V Network Virtualization (HNV)-based virtual networks. These networks are composed of one or more virtual subnets and defined independently as an overlay on top of the underlying physical network. A virtual subnet emulates the Layer 3 IP subnet functionality for the virtual machines (VMs) connected to it. Each virtual network forms an isolation boundary within which VMs can only communicate with each other. To allow communication across virtual networks, you have the option of implementing virtual network peering.

Each network interface of a VM connected to a virtual network subnet is associated with two IP addresses:

- Customer Address. An IP address assigned to each VM by customers, based on their preferred IP addressing scheme. This address allows customers to preserve their existing network configuration when transitioning workloads to an SDN environment. The Customer Address is accessible to the operating system within the corresponding VM.
- Provider Address. An IP address assigned to Hyper-V hosts by Azure Stack HCI administrators, based on their physical network infrastructure. The Provider Address is noticeable on the physical network, but not to customer VMs.

### Logical networks and subnets

To implement network function virtualization and to allow VLAN-based segmentation, SDN relies on the concept of logical networks. Each logical network represents a logical partition of a physical network. A logical network comprises a collection of logical subnets that map to customer VLANs. These VLANs might host customer workloads, but there are also several logical networks that host critical SDN infrastructure components. For example, an Azure Stack HCI SDN implementation includes the Management and HNV Provider logical networks, with the latter serving as the Provider Address network for all virtual networks. All Hyper-V hosts that are part of that implementation must be connected to the Management logical network and the HNV Provider logical network.
