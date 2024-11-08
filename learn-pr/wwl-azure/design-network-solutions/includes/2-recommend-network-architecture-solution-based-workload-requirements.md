Azure offers several networking services with capabilities that can be used together or separately to support workload requirements. You can [**connect Azure resources and on-premises resources**](/azure/networking/fundamentals/networking-overview#connect), [**protect your applications**](/azure/networking/fundamentals/networking-overview#protect), and [**deliver your applications**](/azure/networking/fundamentals/networking-overview#deliver).

Tailwind Traders is currently running its workloads on-premises in its datacenter. In your strategy for migrating some of the company workloads to Azure, you need to make networking design decisions to properly support the workloads and services. In order to recommend a network architecture, you need to consider how workload requirements translate to network requirements. 

### Things to know about network requirements 

As you plan your networking solution, there are several requirements you need to consider. 

- **Naming**: Define a naming convention that you can use consistently when naming resources to make it easier to manage several network resources over time. 

- **Regions**: Determine the Azure regions for your resources according to the physical locations of the consumers of your resources. A virtual network is scoped to a single region/location. However, multiple virtual networks from different regions can be connected together by using Virtual Network peering.

- **Subscriptions**: Plan out how many Azure subscriptions are required to meet your workload requirements, considering you can implement multiple virtual networks within each Azure subscription and Azure region.

- **IP addresses**: Specify a custom private IP address space by using public and private (RFC 1918) addresses. Azure assigns resources in a virtual network a private IP address from the address space that you assign. 

- **Segmentation**: Segment your virtual networks with subnets based on workload and security requirements.

- **Filtering**: Define your network security and traffic filtering strategy for your workloads.

### Things to consider when defining workload requirements 

There are many considerations to review as you plan your network according to the workload requirements for Tailwind Traders.

- **Consider segmentation options for your virtual networks**. Each subnet must have a unique address range, specified in CIDR format, within the address space of the virtual network. The address range can't overlap with other subnets in the virtual network.
   
   - **Subnets segmented based on application layer**. The following table shows how to segment a virtual network with an address space of 10.245.16.0/20 into subnets based on a three-tiered application.

      | Subnet | CIDR | Addresses | Usage |
      | --- | --- | --- | --- |
      | DEV-FE-EUS2  | 10.245.16.0/22 | 1019 | Front-end or web-tier virtual machines |
      | DEV-APP-EUS2 | 10.245.20.0/22 | 1019 | Application-tier virtual machines |
      | DEV-DB-EUS2  | 10.245.24.0/23 |  507 | Database virtual machines |

- **Consider required interfaces and IP addresses**. Identify how many network interfaces and private IP addresses you require in your virtual network. There are limits to the number of network interfaces and private IP addresses that you can have within a virtual network.

- **Consider network security groups**. You can filter network traffic to and from resources in a virtual network by using network security groups and network virtual appliances. You can control how Azure routes traffic from subnets.

- **Consider network traffic routing**. Azure routes network traffic between all subnets in a virtual network, by default. You can override some of Azure's system routes with custom routes. 

## Best practices

Review the following recommended best practices for working with virtual networks and subnets.

### Plan IP addressing for virtual networks

When you create virtual networks as part of your migration, plan out your virtual network IP address space. Virtual networks allow for the use of 65,536 IP addresses. 

- Assign an address space that isn't larger than a CIDR range of /16 for each virtual network. If you assign a smaller prefix than /16, such as a /15, which has 131,072 addresses, the excess IP addresses become unusable elsewhere. It's important not to waste IP addresses, even if they're in the private ranges defined by RFC 1918.

- Don't overlap the virtual network address space with on-premises network ranges. Overlapping addresses can cause networks that can't be connected, and routing that doesn't work properly.

- If networks overlap, you'll need to redesign the network. If you absolutely can't redesign the network, network address translation (NAT) can help, but should be avoided or limited as much as possible.

### Implement hub-spoke network topology

A hub and spoke network topology isolates workloads while sharing services, such as identity and security. The hub is an Azure virtual network that acts as a central point of connectivity. The spokes are virtual networks that connect to the hub virtual network by using peering. Shared services are deployed in the hub, while individual workloads are deployed as spokes.

- Implement a hub-spoke topology in Azure to centralize common services, such as connections to on-premises networks, firewalls, and isolation between virtual networks. The hub virtual network provides a central point of connectivity to on-premises networks, and a place to host services used by workloads hosted in spoke virtual networks.

- Use spoke virtual networks to isolate workloads with each spoke managed separately from other spokes. Each workload can include multiple tiers, and multiple subnets that are connected with Azure load balancers.

- Configure hub and spoke virtual networks in different resource groups, and even in different subscriptions. When you peer virtual networks in different subscriptions, the subscriptions can be associated to the same, or different, Microsoft Entra tenants. You gain decentralized management of each workload, while sharing services maintained in the hub network.
