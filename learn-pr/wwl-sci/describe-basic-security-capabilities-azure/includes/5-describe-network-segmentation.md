
Segmentation is about dividing something into smaller pieces. An organization, for example, will typically consist of smaller business groups such as human resources, sales, customer service, and more. In an office environment, it's common to see each business group have their own dedicated office space, while members of the same group share an office.  This ensures members of the same group work together productively while also maintaining separation from other groups to address the security, confidentiality, and privacy requirements associated with sensitive information.

The same concept applies with corporate IT networks.  The main reasons for network segmentation are:

- The ability to group related assets that are a part of (or support) workload operations.
- Isolation of resources.
- Governance policies set by the organization.

Network segmentation also supports the Zero Trust model and a layered approach to security that is part of a defense in depth strategy.

Assume breach is a principle of the Zero Trust model so the ability to contain an attacker is vital in protecting information systems. When workloads (or parts of a given workload) are placed into separate segments, you can control traffic from/to those segments to secure communication paths. If one segment is compromised, you'll be able to better contain the impact and prevent it from laterally spreading through the rest of your network.

Network segmentation can secure interactions between perimeters. This approach can strengthen an organization's security posture, contain risks in a breach, and stop attackers from gaining access to an entire workload.

### Azure Virtual Network
Azure Virtual Network (VNet) is the fundamental building block for your organization's private network in Azure. VNet is similar to a traditional network that you'd operate in your own data center, but brings with it additional benefits of Azure's infrastructure such as scale, availability, and isolation.

Azure VNet enables organizations to segment their network. Organizations can create multiple VNets per region per subscription, and multiple smaller networks (subnets) can be created within each VNet.

VNets provide network level containment of resources with no traffic allowed across VNets or inbound to the VNet, by default.   Communication needs to be explicitly provisioned. This enables more control over how Azure resources in a VNet communicate with other Azure resources, the internet, and on-premises networks.

#### Communication between Azure resources
Azure resources communicate securely with each other in one of the following ways:

- VNet: Resources deployed within a VNet can communicates securely with each other.
- Service endpoint: An Azure VNet can extend its identity to Azure services, such as Azure Storage accounts, making it a virtual service endpoint to the VNet.
- VNet Peering: VNet Peering enables connection between VNets allowing resources in either VNet to communicate with each other.

#### Communication with on-premises resources
Communication between on-premises resources and VNets is supported through any combination of Site-to-Site virtual private network (VPN), point-to-site VPN, or ExpressRoute, which is a private connection provisioned through a connectivity provider.

#### Communication with the internet
All resources in a VNet can communicate outbound to the internet, by default. Inbound communication to a resource is enabled by assigning a public IP address or a public Load Balancer.
