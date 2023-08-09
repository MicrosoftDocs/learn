

Azure virtual networks provide direct, private IP based connectivity between network-attached resources, such as Azure VMs. You have the option of connecting different virtual networks together if you intend to provide direct, private IP connectivity between them. It's also possible to connect virtual networks to your on-premises networks, effectively making Azure an extension of your own datacenter.

Azure virtual networks support Transmission Control Protocol (TCP), User Datagram Protocol (UDP), and Internet Control Message Protocol (ICMP). At the time of authoring, there's no support for broadcasts, multicasts, IP-in-IP encapsulated packets, and Generic Route Encapsulation (GRE) packets.

A virtual network typically contains one or more subnets. Subnets facilitate segmentation of networks, providing a means of controlling communication between network resources. Each subnet contains a range of IP addresses that constitute a subset of the virtual network address space.

VMs use a virtual network adapter to attach to a subnet to communicate with other VMs and other networked resources, such as load balancers or gateways. VMs can have more than one network adapter, typically to facilitate network isolation scenarios. The maximum number of network adapters that you can attach to a VM depends on its size.

## Optional demo

- [Demonstration: Connect to Linux virtual machines](https://github.com/MicrosoftLearning/AZ-120-Planning-and-Administering-Microsoft-Azure-for-SAP-Workloads/blob/master/Demos/demo-connect-linux-virtual-machines.md)
