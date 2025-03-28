Azure Virtual Networks (VNets) are the fundamental building block of your private network in Azure. VNets enable you to build complex virtual networks that are similar to an on-premises network, with other benefits of Azure infrastructure such as scale, availability, and isolation.

Each VNet you create has its own CIDR block and can be linked to other VNets and on-premises networks as long as the CIDR blocks don't overlap. You also have control of DNS server settings for VNets, and segmentation of the virtual network into subnets.

## Capabilities of Azure Virtual Networks

Azure VNets enable resources in Azure to securely communicate with each other, the internet, and on-premises networks.

- **Communication with the internet.** All resources in a VNet can communicate outbound to the internet, by default. You can communicate inbound to a resource by assigning a public IP address or a public Load Balancer. You can also use public IP or public Load Balancer to manage your outbound connections.
- **Communication between Azure resources.** There are three key mechanisms through which Azure resource can communicate: VNets, VNet service endpoints, and VNet peering. Virtual Networks can connect not only VMs, but other Azure Resources, such as the App Service Environment, Azure Kubernetes Service, and Azure Virtual Machine Scale Sets. You can use service endpoints to connect to other Azure resource types, such as Azure SQL databases and storage accounts. When you create a VNet, your services and VMs within your VNet can communicate directly and securely with each other in the cloud.
- **Communication between on-premises resources.** Securely extend your data center. You can connect your on-premises computers and networks to a virtual network using any of the following options: Point-to-site virtual private network (VPN), Site-to-site VPN, Azure ExpressRoute.
- **Filtering network traffic.** You can filter network traffic between subnets using any combination of network security groups and network virtual appliances.  
- **Routing network traffic.** Azure routes traffic between subnets, connected virtual networks, on-premises networks, and the Internet, by default. You can implement route tables or border gateway protocol (BGP) routes to override the default routes Azure creates.

## Design considerations for Azure Virtual Networks

### Address space and subnets

You can create multiple virtual networks per region per subscription. You can create multiple subnets within each virtual network.

**Virtual Networks**

When you're creating a VNet, use address ranges enumerated in RFC 1918. These addresses are for private, nonroutable address spaces.

- 10.0.0.0 - 10.255.255.255 (10/8 prefix)
- 172.16.0.0 - 172.31.255.255 (172.16/12 prefix)
- 192.168.0.0 - 192.168.255.255 (192.168/16 prefix)

In addition, you can't add the following address ranges.

- 224.0.0.0/4 (Multicast)
- 255.255.255.255/32 (Broadcast)
- 127.0.0.0/8 (Loopback)
- 169.254.0.0/16 (Link-local)
- 168.63.129.16/32 (Internal DNS)

Azure assigns resources in a virtual network a private IP address from the address space that you provision. For example, if you deploy a VM in a VNet with subnet address space 192.168.1.0/24, the VM is assigned a private IP like 192.168.1.4. Azure reserves the first four and last IP address for a total of five IP addresses within each subnet. These addresses are x.x.x.0-x.x.x.3 and the last address of the subnet.

For example, the IP address range of 192.168.1.0/24 has the following reserved addresses:

- 192.168.1.0 
- 192.168.1.1 (Reserved by Azure for the default gateway.)
- 192.168.1.2, 192.168.1.3 (Reserved by Azure to map the Azure DNS IPs to the VNet space.)
- 192.168.1.255 (Network broadcast address.)

When planning to implement virtual networks, you need to consider:

- Ensure nonoverlapping address spaces. Make sure your VNet address space (CIDR block) doesn't overlap with your organization's other network ranges.
- Is any security isolation required?
- Do you need to mitigate any IP addressing limitations?
- Are there connections between Azure VNets and on-premises networks?
- Is there any isolation required for administrative purposes?
- Are you using any Azure services that create their own VNets?

**Subnets**

A subnet is a range of IP address in the VNet. You can segment VNets into different size subnets. You can then deploy Azure resources in a specific subnet. Just like in a traditional network, subnets allow you to segment your VNet address space into segments that are appropriate for the organization's internal network. The smallest supported IPv4 subnet is /29, and the largest is /2 (using CIDR subnet definitions). IPv6 subnets must be exactly /64 in size. When planning to implement subnets, consider:

- Each subnet must have a unique address range, specified in Classless Inter-Domain Routing (CIDR) format.
- Certain Azure services require their own subnet.
- Subnets can be used for traffic management. For example, you can create subnets to route traffic through a network virtual appliance.
- You can limit access to Azure resources to specific subnets with a virtual network service endpoint. You can create multiple subnets, and enable a service endpoint for some subnets, but not others.

### Fundamental IP addressing and subnetting (video)

This video reviews the basics of IP addressing and subnetting. The entire video is available in the [On Demand Instructor-led Training Series](/shows/on-demand-instructor-led-training-series/?terms=700).

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=3813e403-1608-4af1-9876-da95c1703230]

### Determine a naming convention

As part of your Azure network design, it's important to plan your naming convention for your resources. An effective naming convention composes resource names from important information about each resource. A well-chosen name helps you quickly identify the resource's type, its associated workload, its deployment environment, and the Azure region hosting it. For example, a public IP resource for a production SharePoint workload residing in the West US region might be pip-sharepoint-prod-westus-001

:::image type="content" source="../media/components-azure-resource-name-e0dedd6c.png" alt-text="Diagram of a resource naming example.":::

All Azure resource types have a scope that defines the level that resource names must be unique. A resource must have a unique name within its scope. There are four levels you can specify a scope: [management group](/azure/governance/management-groups/overview), subscription, [resource group](/azure/azure-resource-manager/management/overview), and resource. Scopes are hierarchical, with each level of hierarchy making the scope more specific.

For example, a virtual network has a resource group scope, which means that there can be only one network named vnet-prod-westus-001 in each resource group. Other resource groups could have their own virtual network named vnet-prod-westus-001. Subnets are scoped to virtual networks, so each subnet within a virtual network must have a distinct name.

