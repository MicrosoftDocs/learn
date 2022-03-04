A major incentive for adopting cloud solutions such as Azure is to enable information technology departments to move server resources to the cloud. Moving resources can save money and simplify administrative operations. Moving resources removes the need to maintain expensive datacenters with uninterruptible power supplies, generators, multiple fail-safes, or clustered database servers. For small and medium-sized companies, which might not have the expertise to maintain their own robust infrastructure, moving to the cloud is particularly appealing.

Once the resources are moved to Azure, they require the same networking functionality as an on-premises deployment, and in specific scenarios require some level of network isolation. Azure networking components offer a range of functionalities and services.

:::image type="content" source="../media/network-components-66dff480.png" alt-text="Screenshot of the Networking page from the Products section of Azure Documentation. Shows all the main networking components of Azure Networking.":::


## Implementation

An Azure Virtual Network (VNet) is a representation of your own network in the cloud. It is a logical isolation of the Azure cloud dedicated to your subscription. You can use VNets to provision and manage virtual private networks (VPNs) in Azure and, optionally, link the VNets with other VNets in Azure, or with your on-premises IT infrastructure to create hybrid or cross-premises solutions. Each VNet you create has its own CIDR block and can be linked to other VNets and on-premises networks if the CIDR blocks do not overlap. You also have control of DNS server settings for VNets, and segmentation of the VNet into subnets.

:::image type="content" source="../media/virtual-networks-c016972b.png" alt-text="Diagram of a VNet with a subnet containing two virtual machines, pointing to a on-premises infrastructure and a separate virtual network, and showing connectivity with both.":::


Virtual networks can be used in many ways.

 -  **Create a dedicated private cloud-only VNet**. Sometimes you don't require a cross-premises configuration for your solution. When you create a VNet, your services and VMs within your VNet can communicate directly and securely with each other in the cloud. You can still configure endpoint connections for the VMs and services that require internet communication, as part of your solution.
 -  **Securely extend your data center With VNets**. You can build traditional site-to-site (S2S) VPNs to securely scale your datacenter capacity. S2S VPNs use IPSEC to provide a secure connection between your corporate VPN gateway and Azure.
 -  **Enable hybrid cloud scenarios**. VNets give you the flexibility to support a range of hybrid cloud scenarios. You can securely connect cloud-based applications to any type of on-premises system such as mainframes and Unix systems.
