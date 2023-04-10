Azure Virtual Networks (VNets) are the fundamental building block of your private network in Azure. VNets enable you to build complex virtual networks that are similar to an on-premises network, with additional benefits of Azure infrastructure such as scale, availability, and isolation. 

Each VNet you create has its own CIDR block and can be linked to other VNets and on-premises networks as long as the CIDR blocks don't overlap. You also have control of DNS server settings for VNets, and segmentation of the VNet into subnets.

## Capabilities of Azure Virtual Networks

Azure VNets enable resources in Azure to securely communicate with each other, the internet, and on-premises networks.

 -  **Communication with the internet.** All resources in a VNet can communicate outbound to the internet, by default. You can communicate inbound to a resource by assigning a public IP address or a public Load Balancer. You can also use public IP or public Load Balancer to manage your outbound connections.
 -  **Communication between Azure resources.** There are three key mechanisms through which Azure resource can communicate: VNets, VNet service endpoints and VNet peering. Virtual Networks can connect not only VMs, but other Azure Resources, such as the App Service Environment, Azure Kubernetes Service, and Azure Virtual Machine Scale Sets. You can use service endpoints to connect to other Azure resource types, such as Azure SQL databases and storage accounts. When you create a VNet, your services and VMs within your VNet can communicate directly and securely with each other in the cloud.
 -  **Communication between on-premises resources.** Securely extend your data center. You can connect your on-premises computers and networks to a virtual network using any of the following options: Point-to-site virtual private network (VPN), Site-to-site VPN, Azure ExpressRoute.
 -  **Filtering network traffic.** You can filter network traffic between subnets using any combination of network security groups and network virtual appliances like firewalls, gateways, proxies, and Network Address Translation (NAT) services.
 -  **Routing network traffic.** Azure routes traffic between subnets, connected virtual networks, on-premises networks, and the Internet, by default. You can implement route tables or border gateway protocol (BGP) routes to override the default routes Azure creates.

## Design considerations for Azure Virtual Networks

### Address space and subnets

You can create multiple virtual networks per region per subscription. You can create multiple subnets within each virtual network.

**Virtual Networks**

When creating a VNet, it's recommended that you use the address ranges enumerated in RFC 1918, which have been set aside by the IETF for private, non-routable address spaces:

 -  10.0.0.0 - 10.255.255.255 (10/8 prefix)
 -  172.16.0.0 - 172.31.255.255 (172.16/12 prefix)
 -  192.168.0.0 - 192.168.255.255 (192.168/16 prefix)

In addition, you can't add the following address ranges:

 -  224.0.0.0/4 (Multicast)
 -  255.255.255.255/32 (Broadcast)
 -  127.0.0.0/8 (Loopback)
 -  169.254.0.0/16 (Link-local)
 -  168.63.129.16/32 (Internal DNS)

Azure assigns resources in a virtual network a private IP address from the address space that you provision. For example, if you deploy a VM in a VNet with subnet address space 192.168.1.0/24, the VM will be assigned a private IP like 192.168.1.4. Azure reserves the first four and last IP address for a total of 5 IP addresses within each subnet. These are x.x.x.0-x.x.x.3 and the last address of the subnet.

For example, the IP address range of 192.168.1.0/24 has the following reserved addresses:

- 192.168.1.0 : Network address
- 192.168.1.1 : Reserved by Azure for the default gateway
- 192.168.1.2, 192.168.1.3 : Reserved by Azure to map the Azure DNS IPs to the VNet space
- 192.168.1.255 : Network broadcast address.

When planning to implement virtual networks, you need to consider the following:

 -  Ensure non-overlapping address spaces. Make sure your VNet address space (CIDR block) doesn't overlap with your organization's other network ranges.
 -  Is any security isolation required?
 -  Do you need to mitigate any IP addressing limitations?
 -  Will there be connections between Azure VNets and on-premises networks?
 -  Is there any isolation required for administrative purposes?
 -  Are you using any Azure services that create their own VNets?

**Subnets**

A subnet is a range of IP address in the VNet. You can segment VNets into different size subnets, creating as many subnets as you require for organization and security within the subscription limit. You can then deploy Azure resources in a specific subnet. Just like in a traditional network, subnets allow you to segment your VNet address space into segments that are appropriate for the organization's internal network. This also improves address allocation efficiency. The smallest supported IPv4 subnet is /29, and the largest is /2 (using CIDR subnet definitions). IPv6 subnets must be exactly /64 in size. When planning to implement subnets, you need to consider the following:

 -  Each subnet must have a unique address range, specified in Classless Inter-Domain Routing (CIDR) format.
 -  Certain Azure services require their own subnet.
 -  Subnets can be used for traffic management. For example, you can create subnets to route traffic through a network virtual appliance.
 -  You can limit access to Azure resources to specific subnets with a virtual network service endpoint. You can create multiple subnets, and enable a service endpoint for some subnets, but not others.


### Determine a naming convention

As part of your Azure network design, it's important to plan your naming convention for your resources. An effective naming convention composes resource names from important information about each resource. A well-chosen name helps you quickly identify the resource's type, its associated workload, its deployment environment, and the Azure region hosting it. For example, a public IP resource for a production SharePoint workload residing in the West US region might be pip-sharepoint-prod-westus-001

:::image type="content" source="../media/components-azure-resource-name-e0dedd6c.png" alt-text="Azure resource naming example.":::


All Azure resource types have a scope that defines the level that resource names must be unique. A resource must have a unique name within its scope. There are four levels you can specify a scope: [management group](/azure/governance/management-groups/overview), subscription, [resource group](/azure/azure-resource-manager/management/overview), and resource. Scopes are hierarchical, with each level of hierarchy making the scope more specific.

For example, a virtual network has a resource group scope, which means that there can be only one network named vnet-prod-westus-001 in each resource group. Other resource groups could have their own virtual network named vnet-prod-westus-001. Subnets are scoped to virtual networks, so each subnet within a virtual network must have a distinct name.

### Understand Regions and Subscriptions

All Azure resources are created in an Azure region and subscription. A resource can only be created in a virtual network that exists in the same region and subscription as the resource. You can, however, connect virtual networks that exist in different subscriptions and regions. Azure regions are important to consider as you design your Azure network in relation to your infrastructure, data, applications, and end users.

You can deploy as many virtual networks as you need within each subscription, up to the subscription limit. Some larger organizations with global deployments have multiple virtual networks that are connected between regions, for example.

:::image type="content" source="../media/microsoft-global-wan-b9362e87.png" alt-text="Screen capture of a World map showing Azure global network.":::


### Azure Availability Zones

An Azure Availability Zone enables you to define unique physical locations within a region. Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking. Designed to ensure high-availability of your Azure services, the physical separation of Availability Zones within a region protects applications and data from datacenter failures.

:::image type="content" source="../media/availability-zone-83abddc4.png" alt-text="Azure region showing three availability zones.":::


You should consider availability zones when designing your Azure network, and plan for services that support availability zones.

Azure services that support Availability Zones fall into three categories:

 -  Zonal services: Resources can be pinned to a specific zone. For example, virtual machines, managed disks, or standard IP addresses can be pinned to a specific zone, which allows for increased resilience by having one or more instances of resources spread across zones.
 -  Zone-redundant services: Resources are replicated or distributed across zones automatically. Azure replicates the data across three zones so that a zone failure doesn't impact its availability.
 -  Non-regional services: Services are always available from Azure geographies and are resilient to zone-wide outages as well as region-wide outages.

