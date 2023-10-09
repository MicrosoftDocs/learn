

You might need to account for additional network requirements as part of a deployment of Azure Virtual Machines (VMs) or large instances of SAP HANA on Azure.

## Azure Virtual Machines

For instructions about changes to virtual network configuration, refer to [Create, change, or delete a virtual network](/azure/virtual-network/manage-virtual-network).

## Forced tunneling

You can advertise default routes (0.0.0.0/0) to route all traffic through the cross-premises connection (such as an ExpressRoute circuit or Site-to-Site VPN tunnel). This routing will force traffic to Azure PaaS services (such as Azure Storage) back to your on-premises environment. You'll have to configure your routers to return traffic to Azure through the Microsoft peering path (for ExpressRoute) or over the Internet. Frequently, such routing might not be desired for performance reasons. To remediate these undesirable performance issues, you can use service endpoints.

### Virtual Network (VNet) service endpoints

Virtual Network (VNet) service endpoints extend your virtual network private address space and the identity of your VNet to the Azure services, over a direct connection. Endpoints allow you to secure your critical Azure service resources to only your virtual networks. Traffic from your VNet to the Azure service always remains on the Microsoft Azure backbone network. Service endpoints are available for many PaaS services (including Azure Storage). If you've enabled a service endpoint for the service, the traffic to the service isn't forced to your premises. Instead, the traffic remains within the Azure backbone network. Adding Service Endpoints doesn't remove the public endpoint. It simply provides a redirection of traffic.

To enable a Service Endpoint, you must do the following two things:

- Turn off public access to the service.
- Add the Service Endpoint to a virtual network.

When you enable a Service Endpoint, you restrict the flow of traffic, and enable your Azure VMs to access the service directly from your private address space. Devices can't access the service from a public network. On a deployed virtual machine vNIC, if you look at Effective routes, you'll notice the Service Endpoint as the Next Hop Type.

### Azure Private Endpoints

An Azure Private Endpoint is a network interface that enables a private and secure connection between your virtual network and an Azure service. In other words, Private Endpoint is the network interface that replaces the resource's public endpoint. This network interface connects you privately and securely to a service that's powered by Azure Private Link. By enabling a private endpoint, you're bringing the service into your virtual network.

The service could be an Azure service such as:

- Azure Storage
- Azure Cosmos DB
- Azure SQL Database
- Your own service, using Private Link service.
