You might need to account for additional network requirements as part of a deployment of Azure VMs or large instances of SAP HANA on Azure.

## Azure VMs

For instructions about changes to virtual network configuration, refer to [Create, change, or delete a virtual network](/azure/virtual-network/manage-virtual-network).

## Forced tunneling

You can advertise default routes (0.0.0.0/0) to route all traffic through the cross-premises connection (such as an ExpressRoute circuit or Site-to-Site VPN tunnel). This routing will force traffic to Azure PaaS services (such as Azure Storage) back to your on-premises environment. You'll have to configure your routers to return traffic to Azure through the Microsoft peering path (for ExpressRoute) or over the Internet. Frequently, such routing might not be desired for performance reasons. To remediate these undesirable performance issues, you can use service endpoints.

Virtual Network (VNet) service endpoints extend your virtual network private address space and the identity of your VNet to the Azure services, over a direct connection. Endpoints allow you to secure your critical Azure service resources to only your virtual networks. Traffic from your VNet to the Azure service always remains on the Microsoft Azure backbone network. Service endpoints are available for many PaaS services (including Azure Storage). If you've enabled a service endpoint for the service, the traffic to the service isn't forced to your premises. Instead, the traffic remains within the Azure backbone network.
