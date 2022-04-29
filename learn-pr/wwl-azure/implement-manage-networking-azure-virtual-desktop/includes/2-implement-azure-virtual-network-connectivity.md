Azure Virtual Network (VNet) is basis for a private network in Azure. VNet enables many types of Azure resources, such as Azure Virtual Machines (VM), to securely communicate with each other, the internet, and on-premises networks.

:::image type="content" source="../media/virtual-desktop-combined-971d0db0.png" alt-text="Diagram of Azure Virtual Desktop Connections.":::


Azure virtual network enables Azure resources to securely communicate with each other, the internet, and on-premises networks.

Key scenarios that you can accomplish using a virtual network include:

 -  Communication of Azure resources with the internet
 -  Communication between Azure resources
 -  Communication with on-premises resources
 -  Filtering network traffic
 -  Routing network traffic
 -  Integration with Azure services

### Communicate with the internet

Resources in a VNet can communicate outbound to the internet, by default. You can communicate inbound to a resource by assigning a public IP address or a public Load Balancer. You can also use public IP or public Load Balancer to manage outbound connections.

When using only an internal Standard Load Balancer, outbound connectivity is not available until you define how you want outbound connections to work with an instance-level public IP or a public Load Balancer.

### Communicate between Azure resources

Azure resources communicate securely with each other in one of the following ways:

 -  **Through a virtual network**: You can deploy VMs, and several other types of Azure resources to a virtual network, such as Azure App Service Environments, the Azure Kubernetes Service (AKS), and Azure Virtual Machine Scale Sets.
 -  **Through a virtual network service endpoint**: Extend your virtual network private address space and the identity of your virtual network to Azure service resources, such as Azure Storage accounts and Azure SQL Database, over a direct connection. Service endpoints allow you to secure your critical Azure service resources to only a virtual network.
 -  **Through VNet Peering**: You can connect virtual networks to each other, enabling resources in either virtual network to communicate with each other, using virtual network peering. The virtual networks you connect can be in the same, or different, Azure regions.
