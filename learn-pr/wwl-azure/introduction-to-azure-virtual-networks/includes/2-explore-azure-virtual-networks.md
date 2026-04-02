


[Azure Virtual Networks (VNets)](/azure/virtual-network/virtual-networks-overview) are the fundamental building block of your private network in Azure. VNets enable you to build complex virtual networks that are similar to an on-premises network, with other benefits of Azure infrastructure such as scale, availability, and isolation.

This video reviews the basics of IP addressing and subnetting. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=3813e403-1608-4af1-9876-da95c1703230]

## Capabilities of Azure Virtual Networks

Azure VNets enable resources in Azure to securely communicate with each other, the internet, and on-premises networks.

- **Communication with the internet.** Resources in a VNet can communicate outbound to the internet using a NAT gateway, public IP address, or public load balancer. 
- **Communication between Azure resources.** There are four key mechanisms through which Azure resource can communicate: VNets, VNet service endpoints, VNet private endpoints and VNet peering. 
- **Communication between on-premises resources.** You can connect your on-premises computers and networks to a virtual network using any of the following options: Point-to-site virtual private network (VPN), Site-to-site VPN, and Azure ExpressRoute.
- **Filtering network traffic.** You can filter network traffic between subnets using any combination of network security groups and network virtual appliances.  
- **Routing network traffic.** Azure routes traffic between subnets, connected virtual networks, and on-premises networks. You can implement route tables or border gateway protocol (BGP) routes to override the default routes Azure creates.

## Design considerations for Azure Virtual Networks

### Address space and subnets

You can create multiple virtual networks per region per subscription. You can create multiple subnets within each virtual network.

**Virtual Networks**

When you're creating a VNet, use address ranges enumerated in RFC 1918. These addresses are for private, nonroutable address spaces.

- 10.0.0.0 - 10.255.255.255 (10/8 prefix)
- 172.16.0.0 - 172.31.255.255 (172.16/12 prefix)
- 192.168.0.0 - 192.168.255.255 (192.168/16 prefix)

In addition, these address ranges are reserved.

- 224.0.0.0/4 (Multicast)
- 255.255.255.255/32 (Broadcast)
- 127.0.0.0/8 (Loopback)
- 169.254.0.0/16 (Link-local)
- 168.63.129.16/32 (Internal DNS)

**Subnets**

A subnet is a range of IP address in the VNet. You segment VNets into different size subnets. You then deploy Azure resources in a specific subnet. Just like in a traditional network, subnets allow you to segment your VNet address space into segments that are appropriate for the organization's internal network. The smallest supported IPv4 subnet is /29, and the largest is /2 (using CIDR subnet definitions). IPv6 subnets must be exactly /64 in size. When planning to implement subnets, consider:

- Each subnet must have a unique address range, specified in Classless Inter-Domain Routing (CIDR) format.
- Certain Azure services require their own subnet.
- Subnets can be used for traffic management. For example, you can create subnets to route traffic through a network virtual appliance.
- You can limit access to Azure resources to specific subnets with a virtual network service endpoint. You can create multiple subnets, and enable a service endpoint for some subnets, but not others.

**Considerations for virtual networks**

When planning to implement virtual networks, you need to consider:

- Ensure nonoverlapping address spaces. Make sure your VNet address space (CIDR block) doesn't overlap with your organization's other network ranges.
- Is any security isolation required?
- Do you need to mitigate any IP addressing limitations?
- Are there connections between Azure VNets and on-premises networks?
- Is there any isolation required for administrative purposes?
- Are you using any Azure services that create their own VNets?



Choose the best response for each question.
