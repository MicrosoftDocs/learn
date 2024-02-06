A major incentive for adopting cloud solutions like Azure is to enable information technology departments to transition server resources to the cloud. Moving resources to the cloud can save money and simplify administrative operations. Relocating resources removes the need to maintain expensive datacenters with uninterruptible power supplies, generators, multiple fail-safes, or clustered database servers. For small and medium-sized companies, which might not have the expertise to maintain their own robust infrastructure, moving to the cloud is particularly appealing.

After resources are moved to Azure, they require the same networking functionality as an on-premises deployment. In specific scenarios, the resources require some level of network isolation. Azure network services offer a range of components with functionalities and capabilities, as shown in the following image:

:::image type="content" source="../media/network-components-66dff480.png" alt-text="Screenshot that shows the main components of Azure network services." border="false":::

### Things to know about Azure virtual networks

You can implement Azure Virtual Network to create a virtual representation of your network in the cloud. Let's examine some characteristics of virtual networks in Azure.

- An Azure virtual network is a logical isolation of the Azure cloud resources.

- You can use virtual networks to provision and manage virtual private networks (VPNs) in Azure.

- Each virtual network has its own Classless Inter-Domain Routing (CIDR) block and can be linked to other virtual networks and on-premises networks.

- You can link virtual networks with an on-premises IT infrastructure to create hybrid or cross-premises solutions, when the CIDR blocks of the connecting networks don't overlap.

- You control the DNS server settings for virtual networks, and segmentation of the virtual network into subnets.

The following illustration depicts a virtual network that has a subnet containing two virtual machines. The virtual network has connections to an on-premises infrastructure and a separate virtual network.

:::image type="content" source="../media/virtual-networks-c016972b.png" alt-text="Diagram of a virtual network with a subnet of two virtual machines. The network connects to an on-premises infrastructure and separate virtual network." border="false":::

### Things to consider when using virtual networks

Virtual networks can be used in many ways. As you think about the configuration plan for your virtual networks and subnets, consider the following scenarios.

| Scenario | Description |
| --- | --- |
| _Create a dedicated private cloud-only virtual network_ | Sometimes you don't require a cross-premises configuration for your solution. When you create a virtual network, your services and virtual machines within your virtual network can communicate directly and securely with each other in the cloud. You can still configure endpoint connections for the virtual machines and services that require internet communication, as part of your solution. |
| _Securely extend your data center with virtual networks_ | You can build traditional site-to-site VPNs to securely scale your datacenter capacity. Site-to-site VPNs use IPSEC to provide a secure connection between your corporate VPN gateway and Azure. |
| _Enable hybrid cloud scenarios_ | Virtual networks give you the flexibility to support a range of hybrid cloud scenarios. You can securely connect cloud-based applications to any type of on-premises system, such as mainframes and Unix systems. |