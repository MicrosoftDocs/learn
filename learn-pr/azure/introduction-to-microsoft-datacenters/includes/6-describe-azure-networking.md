Next, you want to learn about Microsoft Cloud networking. You find there are two major categories:

- Infrastructure: The physical network that spans the globe and connects Microsoft Cloud offerings and customers.

- Services and product offerings: Services and products, which customers can purchase and configure, are built on top of the infrastructure. 

## Infrastructure

Microsoft supports one of the largest network backbones in the world. The network infrastructure includes over 175 thousand miles of fiber optic and subsea cables and more than 190 network access points across the globe. Contoso can use that infrastructure to communicate between cloud datacenters. Your employees, partners, and customers can connect via the global network access points to use cloud services - or even hybrid and on-premises applications - from anywhere in the world. Because Contoso has a large traveling sales force and worldwide partners, you begin to see some surprising benefits. You consider, for example, how to consolidate your network vendors using the Microsoft global network (WAN), while gaining lower latency and better application response time.

 To ensure optimal performance and integrity, any traffic between datacenters is routed within the global network. Whether its traffic within Microsoft Azure or between Microsoft services such as Virtual Machines, Microsoft 365, Xbox, SQL Database, Storage, and virtual networks, the traffic is never routed over the public internet.

![Graphic illustration showing datacenters, edges, and networks.](../media/cloud-networking.png)

## Networking services and product offerings

Microsoft offers an extensive range of networking products and services. Because Contoso already has a global network that delivers applications around the globe, Azure networking capabilities are important to you. Some of them might enable entirely new models of application delivery, with higher security and better monitoring than you currently have.

Azure networking services and products break into four major categories:

- [Connectivity services](/azure/networking/fundamentals/networking-overview#connect): Enable hybrid solutions and connect Azure resources and on-premises resources. Azure services used for connectivity include Azure Virtual Network, Azure Virtual WAN, Azure ExpressRoute, VPN Gateway, and Azure DNS (Domain Name System).

- [Application protection services](/azure/networking/fundamentals/networking-overview#protect): Protect your applications with services. Azure services used for application protection include Azure Load Balancer, Azure Private Link, Azure DDoS Protection, Azure Firewall, and Azure Web Application Firewall.

- [Application delivery services](/azure/networking/fundamentals/networking-overview#deliver): Deliver applications effectively in the Azure network. Azure services used for delivery include Azure Content Delivery Network, Azure Front Door, Azure Traffic Manager, Azure Application Gateway, and Azure Internet Analyzer.

- [Network monitoring](/azure/networking/fundamentals/networking-overview#monitor): Monitor and analyze your network resources and performance. Azure services used for monitoring include Azure Network Watcher, Azure ExpressRoute Monitor, Azure Monitor, or Virtual Network terminal access point (TAP).

Organizations typically deploy Azure networking services to help optimize performance and security for PaaS and IaaS models. With SaaS offerings, including Microsoft 365, Microsoft offers guidance and tools to help you implement and optimize a secure and efficient network architecture. 

Contoso's network architecture for its Microsoft 365 apps is already in place. If you're planning to host applications in Azure that work with your Microsoft 365 solution, you might want to choose Azure regions and services that are closer to your Microsoft 365 regions. The Azure regions you select can help you optimize app performance and reduce latency.
