
Segmentation is about dividing something into smaller pieces. An organization, for example, typically consists of smaller business groups such as human resources, sales, customer service, and more. In an office environment, it's common to see each business group have their own dedicated office space, while members of the same group share an office. This enables members of the same business group to collaborate, while maintaining separation from other groups to address the confidentiality requirements of each business.

The same concept applies with corporate IT networks. The main reasons for network segmentation are:

- The ability to group related assets that are a part of (or support) workload operations.
- Isolation of resources.
- Governance policies set by the organization.

Network segmentation also supports the Zero Trust model and a layered approach to security that is part of a defense in depth strategy.

Assume breach is a principle of the Zero Trust model so the ability to contain an attacker is vital in protecting information systems. When workloads (or parts of a given workload) are placed into separate segments, you can control traffic from/to those segments to secure communication paths. If one segment is compromised, you can better contain the impact and prevent it from spreading laterally through the rest of your network.

Network segmentation can secure interactions between perimeters. This approach can strengthen an organization's security posture, contain risks in a breach, and stop attackers from gaining access to an entire workload.

### Azure Virtual Network
Azure Virtual Network (VNet) is the fundamental building block for your organization's private network in Azure. A virtual network is similar to a traditional network that you'd operate in your own data center, but brings with it additional benefits of Azure's infrastructure such as scale, availability, and isolation.

Azure virtual network enables organizations to segment their network. Organizations can create multiple virtual networks per region per subscription, and multiple smaller networks (subnets) can be created within each virtual network.

VNets provide network-level containment of resources with no traffic allowed across VNets or inbound to the virtual network by default. Communication needs to be explicitly provisioned. This enables more control over how Azure resources in a virtual network communicate with other Azure resources, the internet, and on-premises networks.

:::image type="content" source="../media/azure-virtual-networks.png" alt-text="Diagram depicting network segmentation using Azure Virtual Networks." lightbox="../media/azure-virtual-networks.png":::

### VNet capabilities

Azure virtual networks support a range of networking capabilities that help you build a secure and well-segmented environment:

- **Communicate with the internet**: Resources in a virtual network can communicate outbound to the internet by default. You control inbound access using public IP addresses or load balancers.
- **Communicate between Azure resources**: Resources in the same virtual network can communicate securely with each other without going over the public internet.
- **Connect to on-premises networks**: Azure virtual networks support connections to on-premises environments through site-to-site VPN, point-to-site VPN, or Azure ExpressRoute, allowing you to extend your private network into Azure.
- **Filter network traffic**: You can use network security groups (NSGs) and Azure Firewall to filter traffic between subnets, controlling what traffic is allowed in and out of different parts of your network.
- **Route network traffic**: Azure automatically routes traffic between subnets and connected networks. You can define custom routing rules to control how traffic flows through your environment.

### Subnets

Within a virtual network, you can create smaller network segments called subnets. Subnets let you divide a virtual network into segments with different security requirements or functions. For example, you might place web servers in one subnet and database servers in another, with access controls that define which traffic can flow between them. Each subnet can have its own controls, making it easier to isolate workloads and contain the impact of a potential breach.

### VNet peering

Virtual network peering connects two virtual networks so that resources in either network can communicate with each other as if they were in the same virtual network. VNet peering works across Azure regions (called global virtual network peering), meaning you can connect virtual networks in different geographic locations. Traffic between peered virtual networks uses the Azure backbone network—not the public internet—keeping the traffic private and low-latency.

Network segmentation through virtual networks, subnets, and peering aligns directly with the Zero Trust principle of assume breach. If one segment is compromised, you can contain the impact and prevent it from spreading laterally through the rest of your network. Each boundary between segments is an opportunity to inspect, filter, and control traffic.
