There are occasions when it is necessary to account for additional network requirements as part of a deployment of Azure VMs and large instances of SAP HANA on Azure.

## Azure VMs

For information on the most recent updates to virtual network configuration, see [https://docs.microsoft.com/azure/virtual-network/manage-virtual-network](https://docs.microsoft.com/azure/virtual-network/manage-virtual-network) 

## Forced Tunneling

It is possible to advertise default routes (0.0.0.0/0) for routing all outbound traffic through a cross-premises connection (such as an ExpressRoute circuit or Site-to-Site VPN tunnel). 
> [!NOTE]
> This will force traffic to Azure PaaS services, such as Azure Storage, back to the on-premises environment. You will have to configure your routers to return traffic to Azure through the Microsoft peering path for ExpressRoute, or across the Internet. 

Virtual Network (VNet) service endpoints extend your virtual network private address space and the identity of your VNet to the Azure services, over a direct connection. Endpoints allow you to secure your critical Azure service resources to  your virtual networks. Traffic from your VNet to the Azure service always remains on the Microsoft Azure backbone network. Service endpoints are available for several PaaS services, including Azure Storage. If you have enabled a service endpoint for the service, the traffic to the service is not forced to your premises. Instead the traffic remains within the Azure backbone network.

