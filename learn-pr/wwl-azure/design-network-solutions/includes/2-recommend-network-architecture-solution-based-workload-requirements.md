Azure offers several networking services with capabilities that can be used together or separately to support workload requirements. You can [**connect Azure resources and on-premises resources**](/azure/networking/fundamentals/networking-overview#connect), [**protect your applications**](/azure/networking/fundamentals/networking-overview#protect), and support [**application delivery in the Azure network**](/azure/networking/fundamentals/networking-overview#deliver).

Tailwind Traders is currently running its workloads on-premises in its datacenter. In your strategy for migrating some of the company workloads to Azure, you need to integrate the required networking components. Your solution must allow multiple Azure regions to host Tailwind Traders applications that have dependencies on infrastructure and data services in Azure.

### Things to know about workload requirements 

As you plan your networking solution strategy, there are several workload requirements you need to investigate. 

- Identify your resource names and establish naming conventions.
- Determine your Azure regions and resource deployment.
- Calculate how many subscriptions are required.
- Review segmentation options for your virtual networks and subnets.
- Design your application security and scheme for filtering network traffic.

### Name resources

All Azure resources have a name that's unique within a scope that can vary for each resource type. The resource name must be unique within a resource group, but it can be duplicated within a subscription or Azure region. 

### Select Azure regions

All Azure resources are created in an Azure region and subscription. A resource can only be created in a virtual network that exists in the same region and subscription as the resource. However, you can connect virtual networks that exist in different subscriptions and regions. 

### Determine Azure subscriptions

You can deploy as many virtual networks as required within each subscription, up to the limit. Some organizations have different subscriptions for different departments. 

### Segment virtual networks and subnets

You can create multiple virtual networks per subscription and per region. You can create multiple subnets within each virtual network. The following sections outline considerations that can help you determine how many virtual networks and subnets you need.

- **Virtual networks**: A virtual network is a virtual, isolated portion of the Azure public network. Each virtual network is dedicated to your subscription.
   
   - You can create one virtual network, or multiple virtual networks in a subscription.
   
   - Each virtual network uses network interfaces and private IP addresses. A network interface enables a virtual machine to communicate with other resources and has one or more private IP addresses assigned to it.
   
   - You can connect some virtual networks to other virtual networks or an on-premises network. Each virtual network that you connect to another virtual network, or on-premises network, must have a unique address space. Each virtual network has one or more public or private address ranges assigned to its address space. An address range is specified in classless internet domain routing (CIDR) format, such as 10.0.0.0/16.
   
   - When you deploy some Azure service resources into a virtual network, they create their own virtual network. 

- **Subnets**: A virtual network can be segmented into one or more subnets up to the limits.  
   
   - You can create one subnet, or multiple virtual networks in a subscription.
   
   - Each subnet must have a unique address range, specified in CIDR format, within the address space of the virtual network. The address range can't overlap with other subnets in the virtual network.
   
   - If you plan to deploy some Azure service resources into a virtual network, they might require, or create, their own subnet. There must be enough unallocated space for the service to complete these tasks. If you connect a virtual network to an on-premises network by using an Azure VPN Gateway, the virtual network must have a dedicated subnet for the gateway. 

   - Azure routes network traffic between all subnets in a virtual network, by default. You can override Azure's default routing to prevent Azure routing between subnets.

### Apply security and filter traffic

You can filter network traffic to and from resources in a virtual network by using network security groups and network virtual appliances. You can control how Azure routes traffic from subnets. You can also limit who in your organization can work with resources in virtual networks. The following sections outline considerations that can help you determine your network traffic scheme.

- **Traffic filtering**: Filter network traffic between resources in a virtual network by using a network security group, an NVA that filters network traffic, or both. When you use an NVA, you also create custom routes to route traffic from subnets to the NVA.

   - A network security group contains several default security rules that allow or deny traffic to or from resources. A network security group can be associated to a network interface, the subnet the network interface is in, or both. To simplify management of security rules, it's recommended that you associate a network security group to individual subnets, rather than individual network interfaces within the subnet, whenever possible.

   - If different virtual machines within a subnet need different security rules applied to them, you can associate the network interface in the virtual machines to one or more application security groups. A security rule can specify an application security group in its source, destination, or both. That rule then only applies to the network interfaces that are members of the application security group. 

   - Azure creates several default security rules within each network security group. One default rule allows all traffic to flow between all resources in a virtual network. To override this behavior, use network security groups, custom routing to route traffic to an NVA, or both.

   > [!Tip]
   > We recommend you familiarize yourself with all of Azure's default security rules It's important to understand how network security group rules are applied to resources.

- **Traffic routing**: Azure creates several default routes for outbound traffic from a subnet. You can override Azure's default routing by creating a route table and associating it to a subnet.

### Things to consider when defining workload requirements 

There are many considerations to review as you plan for how to define your network workload requirements for Tailwind Traders.

- **Consider naming conventions**. Define a naming convention that you can use consistently when naming resources to make it easier to manage several network resources over time. 

- **Consider multiple subscriptions**. Configure different subscriptions for different resources or departments to make it easier to manage your organization.

- **Consider location of your resource consumers**. Plan the deployment region(s) for your resources according to the physical locations of the consumers of your resources.
   
   - Consumers of resources typically want the lowest network latency to their resources. 
   
   - For data residency, sovereignty, compliance, or resiliency requirements, choosing the region that aligns to the requirements is critical. 
   
   - Do you require resiliency across Azure availability zones within the same Azure region for the resources you deploy? You can deploy resources, such as virtual machines to different availability zones within the same virtual network. Keep in mind that not all Azure regions support availability zones.

- **Consider segmentation options for your virtual networks and subnets**. Segment your virtual networks into one or more subnets. Review the following considerations and think about how many virtual networks and subnets you need.

   - **Create subnets by using CIDR notation**. The following table shows how to segment a virtual network with an address space of 10.245.16.0/20 into subnets for a planned migration.

      | Subnet | CIDR | Addresses | Usage |
      | --- | --- | --- | --- |
      | DEV-FE-EUS2  | 10.245.16.0/22 | 1019 | Front-end or web-tier virtual machines |
      | DEV-APP-EUS2 | 10.245.20.0/22 | 1019 | Application-tier virtual machines |
      | DEV-DB-EUS2  | 10.245.24.0/23 |  507 | Database virtual machines |

   - **Meet security requirements**. If you have organizational security requirements to isolate traffic into separate virtual networks, you can choose to connect virtual networks. Implement a network virtual appliance, such as a firewall, to control the flow of traffic between the virtual networks.

   - **Isolate networks**. If you have organizational requirements to isolate virtual networks, separate the networks into different subscriptions or regions. Create as many subscriptions as needed.

   - **Separate resources**. If you have organizational administration requirements that resources be in different virtual networks, you can separate resources into separate virtual networks. The separation enables you to simplify permission assignment to individuals in your organization or to assign different policies to different virtual networks.

   - **Calculate required interfaces and IP addresses**. Identify how many network interfaces and private IP addresses you require in your virtual network. There are limits to the number of network interfaces and private IP addresses that you can have within a virtual network.

   - **Limit access with service endpoints**. You can limit access to Azure resources such as an Azure storage account or Azure SQL Database, to specific subnets with a virtual network service endpoint. Further, you can deny access to the resources from the internet. You can create multiple subnets, and enable a service endpoint for some subnets, but not others. 

- **Consider network security groups**. You can associate zero or one network security group to each subnet in a virtual network. You can associate the same, or a different, network security group to each subnet. Each network security group contains rules, which allow or deny traffic to and from sources and destinations.

- **Consider network traffic routing**. Override Azure's default routing to prevent Azure routing between subnets, or to route traffic between subnets through a network virtual appliance. Create a route table and associate it to a subnet. If you require that traffic between resources in the same virtual network flow through a network virtual appliance (NVA), deploy the resources to different subnets. 

   - **Enable traffic between subnets**. Some developers override Azure's default routing to enable traffic between subnets to flow through a network virtual appliance. 

   - **Force all internet-bound traffic**. Some administrators override Azure's default routing to force all internet-bound traffic through an NVA, or on-premises through Azure VPN Gateway. The process of forcing internet traffic on-premises for inspection and logging is referred to as _forced tunneling_.

## Best practices

Review the following recommended best practices for working with virtual networks and subnets.

### Plan IP addressing for virtual networks

When you create virtual networks as part of your migration, plan out your virtual network IP address space. Virtual networks allow for the use of 65,536 IP addresses. 
- Assign an address space that isn't larger than a CIDR range of /16 for each virtual network. If you assign a smaller prefix than /16, such as a /15, which has 131,072 addresses, the excess IP addresses become unusable elsewhere. It's important not to waste IP addresses, even if they're in the private ranges defined by RFC 1918.
- Don't overlap the virtual network address space with on-premises network ranges. Overlapping addresses can cause networks that can't be connected, and routing that doesn't work properly.
- If networks overlap, you'll need to redesign the network. If you absolutely can't redesign the network, network address translation (NAT) can help, but should be avoided or limited as much as possible.

### Implement a hub and spoke network topology

A hub and spoke network topology isolates workloads while sharing services, such as identity and security. The hub is an Azure virtual network that acts as a central point of connectivity. The spokes are virtual networks that connect to the hub virtual network by using peering. Shared services are deployed in the hub, while individual workloads are deployed as spokes.
- Implement a hub and spoke topology in Azure to centralize common services, such as connections to on-premises networks, firewalls, and isolation between virtual networks. The hub virtual network provides a central point of connectivity to on-premises networks, and a place to host services used by workloads hosted in spoke virtual networks.
- Use spoke virtual networks to isolate workloads with each spoke managed separately from other spokes. Each workload can include multiple tiers, and multiple subnets that are connected with Azure load balancers.
- Configure hub and spoke virtual networks in different resource groups, and even in different subscriptions. When you peer virtual networks in different subscriptions, the subscriptions can be associated to the same, or different, Azure Active Directory (Azure AD) tenants. You gain decentralized management of each workload, while sharing services maintained in the hub network.