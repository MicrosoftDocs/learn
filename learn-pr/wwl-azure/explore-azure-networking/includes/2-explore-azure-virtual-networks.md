Azure virtual networks provide direct, private IP based connectivity between network-attached resources, such as Azure Virtual Machines. You have the option of connecting different virtual networks together if you intend to provide direct, private IP connectivity between them. It's also possible to connect virtual networks to your on-premises networks, effectively making Azure an extension of your own datacenter.

Azure virtual networks support Transmission Control Protocol (TCP), User Datagram Protocol (UDP), and Internet Control Message Protocol (ICMP). At the time of authoring, there's no support for broadcasts, multicasts, IP-in-IP encapsulated packets, and Generic Route Encapsulation (GRE) packets.

A virtual network typically contains one or more subnets. Subnets facilitate segmentation of networks, providing a means of controlling communication between network resources. Each subnet contains a range of IP addresses that constitute a subset of the virtual network address space.

Virtual machines use a virtual network adapter to attach to a subnet to communicate with other virtual machines and other networked resources, such as load balancers or gateways. Virtual machines can have more than one network adapter, typically to facilitate network isolation scenarios. The maximum number of network adapters that you can attach to a virtual machine depends on its size.

## Optional demo

- [Demonstration: Connect to Linux virtual machines](https://go.microsoft.com/fwlink/?linkid=2261009&clcid=0x409)
