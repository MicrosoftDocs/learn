Tailwind Traders currently runs its workloads on-premises, in its datacenter. As the Tailwind Traders Enterprise IT team prepares to define the strategy to migrate some of company’s workloads to Azure, it must identify the required networking components and design a network infrastructure necessary to support them. Considering the global scope of its operations, Tailwind Traders will be using multiple Azure regions to host its applications. Most of these applications have dependencies on infrastructure and data services, which will also reside in Azure. Internal applications migrated to Azure must remain accessible to Tailwind Traders users. Internet-facing applications migrated to Azure must remain accessible to any external customer. 

In this module you will learn how the networking services in Azure provide a variety of networking capabilities that can be used together or separately to meet your requirements. Take note of which services you think Tailwind Traders will need for their production environment in Azure. 

- [**Connectivity services**](/azure/networking/fundamentals/networking-overview): Connect Azure resources and on-premises resources using any or a combination of these networking services in Azure - Virtual Network (VNet), Virtual WAN, ExpressRoute, VPN Gateway, Virtual network NAT Gateway, Azure DNS, Peering service, and Azure Bastion.

- [**Application protection services**](/azure/networking/fundamentals/networking-overview): Protect your applications using any or a combination of these networking services in Azure - Load Balancer, Private Link, DDoS protection, Firewall, Network Security Groups, Web Application Firewall, and Virtual Network Endpoints.

- [**Application delivery services**](/azure/networking/fundamentals/networking-overview): Deliver applications in the Azure network using any or a combination of these networking services in Azure - Content Delivery Network (CDN), Azure Front Door Service, Traffic Manager, Application Gateway, Internet Analyzer, and Load Balancer.

## Best practice: Plan IP addressing

When you create virtual networks as part of your migration, it's important to plan out your virtual network IP address space.

You should assign an address space that isn't larger than a CIDR range of /16 for each virtual network. Virtual networks allow for the use of 65,536 IP addresses. Assigning a smaller prefix than /16, such as a /15, which has 131,072 addresses, will result in the excess IP addresses becoming unusable elsewhere. It's important not to waste IP addresses, even if they're in the private ranges defined by RFC 1918.

Other tips for planning are:

- The virtual network address space shouldn't overlap with on-premises network ranges.

- Overlapping addresses can cause networks that can't be connected, and routing that doesn't work properly.

- If networks overlap, you'll need to redesign the network.

- If you absolutely can't redesign the network, network address translation (NAT) can help but should be avoided or limited as much as possible.

## Best practice: Implement a hub and spoke network topology

A hub and spoke network topology isolates workloads while sharing services, such as identity and security. The hub is an Azure virtual network that acts as a central point of connectivity. The spokes are virtual networks that connect to the hub virtual network by using peering. Shared services are deployed in the hub, while individual workloads are deployed as spokes.

Consider the following:

- Implementing a hub and spoke topology in Azure centralizes common services, such as connections to on-premises networks, firewalls, and isolation between virtual networks. The hub virtual network provides a central point of connectivity to on-premises networks, and a place to host services used by workloads hosted in spoke virtual networks.

- A hub and spoke configuration is typically used by larger enterprises. Smaller networks might consider a simpler design to save on costs and complexity.

- You can use spoke virtual networks to isolate workloads, with each spoke managed separately from other spokes. Each workload can include multiple tiers, and multiple subnets that are connected with Azure load balancers.

- You can implement hub and spoke virtual networks in different resource groups, and even in different subscriptions. When you peer virtual networks in different subscriptions, the subscriptions can be associated to the same, or different, Azure Active Directory (Azure AD) tenants. This allows for decentralized management of each workload, while sharing services maintained in the hub network.

## Best practice: Design subnets

To provide isolation within a virtual network, you segment it into one or more subnets, and allocate a portion of the virtual network's address space to each subnet.

- You can create multiple subnets within each virtual network.

- By default, Azure routes network traffic between all subnets in a virtual network.

- Your subnet decisions are based on your technical and organizational requirements.

- You create subnets by using CIDR notation.

When you're deciding on network range for subnets, be aware that Azure retains five IP addresses from each subnet that can't be used. For example, if you create the smallest available subnet of /29 (with eight IP addresses), Azure will retain five addresses. In this case, you only have three usable addresses that can be assigned to hosts on the subnet. For most cases, use /28 as the smallest subnet.

**Example:**

The table shows an example of a virtual network with an address space of 10.245.16.0/20 segmented into subnets, for a planned migration.

| **Subnet**| **CIDR**| **Addresses**| **Usage** |
| - | - | - | - |
| DEV-FE-EUS2| 10.245.16.0/22| 1019| Front-end or web-tier VMs |
| DEV-APP-EUS2| 10.245.20.0/22| 1019| Application-tier VMs |
| DEV-DB-EUS2| 10.245.24.0/23| 507| Database VMs |