
Segmentation is about dividing something into smaller pieces. An organization, for example, will typically consist of smaller business groups such as human resources, sales, customer service, and more. In an office environment, it's common to see each business group have their own dedicated office space, while members of the same group share an office.  This enables members of the same business group to collaborate, while maintaining separation from other groups to address the confidentiality requirements of each business.

The same concept applies with corporate IT networks.  The main reasons for network segmentation are:

- The ability to group related assets that are a part of (or support) workload operations.
- Isolation of resources.
- Governance policies set by the organization.

Network segmentation also supports the Zero Trust model and a layered approach to security that is part of a defense in depth strategy.

Assume breach is a principle of the Zero Trust model so the ability to contain an attacker is vital in protecting information systems. When workloads (or parts of a given workload) are placed into separate segments, you can control traffic from/to those segments to secure communication paths. If one segment is compromised, you'll be able to better contain the impact and prevent it from laterally spreading through the rest of your network.

Network segmentation can secure interactions between perimeters. This approach can strengthen an organization's security posture, contain risks in a breach, and stop attackers from gaining access to an entire workload.

### Azure Virtual Network
Azure Virtual Network (VNet) is the fundamental building block for your organization's private network in Azure. A virtual network is similar to a traditional network that you'd operate in your own data center, but brings with it additional benefits of Azure's infrastructure such as scale, availability, and isolation.

Azure virtual network enables organizations to segment their network. Organizations can create multiple virtual networks per region per subscription, and multiple smaller networks (subnets) can be created within each virtual network.

VNets provide network level containment of resources with no traffic allowed across VNets or inbound to the virtual network, by default.   Communication needs to be explicitly provisioned. This enables more control over how Azure resources in a virtual network communicate with other Azure resources, the internet, and on-premises networks.

:::image type="content" source="../media/azure-virtual-networks.png" alt-text="Diagram depicting network segmentation using Azure Virtual Networks.":::
