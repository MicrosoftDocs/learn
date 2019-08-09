You've migrated your existing application and database servers for your ERP system to Azure as VMs. Now you're considering using some Azure platform as a service (PaaS) services to reduce your costs and administrative requirements. Storage services will hold certain large file assets, such as engineering diagrams. These engineering diagrams have proprietary information in them, and must remain secure from unauthorized access. These files must only be accessible from specific systems.

In this unit, you'll look at how to use virtual network service endpoints for securing supported Azure services.

## Virtual network service endpoints

Virtual network service endpoints are used to extend your private address space in Azure by providing a direct connection to your Azure services. Service endpoints let you secure your Azure resources to only your virtual network. Service traffic will remain on the Azure backbone and will not go out to the internet.

![Service endpoint on private network](../media/4-service-endpoint.svg)

By default, Azure services are all designed for direct internet access. All Azure resources have public IP addresses, this includes PaaS services such as Azure SQL Database and Azure Storage. Because these services are exposed to the internet, anyone can potentially access your Azure services.

Service endpoints can connect certain PaaS Services directly to your private address space in Azure, so they act like they’re on the same virtual network. You use your private address space to access the PaaS services directly. Adding service endpoints does not remove the public endpoint, it simply provides a redirection of traffic.

Azure service endpoints are available for many services, such as:

- Azure Storage
- Azure SQL Database
- Azure Cosmos DB
- Azure Key Vault
- Azure Service Bus
- Azure Data Lake

For a service like Azure SQL Database, which cannot be accessed until you add IP addresses to its firewall, service endpoints should still be considered. Using a service endpoint for Azure SQL Database restricts access to specific virtual networks, providing greater isolation and reducing the attack surface.

## How service endpoints work

To enable a service endpoint, you must do two things:

1. Turn off public access to the service.
1. Add the service endpoint to a virtual network.

When you enable a service endpoint, you restrict the flow of traffic, and allow your Azure VMs to access the service directly from your private address space. Devices cannot access the service from a public network. If you look at **Effective routes** on a deployed VM vNIC, you'll notice the service endpoint as the **Next Hop Type**.

This is an example route table, before enabling a service endpoint:

| SOURCE  | STATE   | ADDRESS PREFIXES | NEXT HOP TYPE |
|---------|---------|------------------|---------------|
| Default | Active  | 10.1.1.0/24      | VNet          |
| Default | Active  | 0.0.0.0./0       | Internet      |
| Default | Active  | 10.0.0.0/8       | None          |
| Default | Active  | 100.64.0.0./10   | None          |
| Default | Active  | 192.168.0.0/16   | None          |

Adding two service endpoints to the virtual network the routing table will look like this:

| SOURCE  | STATE  | ADDRESS PREFIXES         | NEXT HOP TYPE                 |
|---------|--------|--------------------------|-------------------------------|
| Default | Active | 10.1.1.0/24              | VNet                          |
| Default | Active | 0.0.0.0./0               | Internet                      |
| Default | Active | 10.0.0.0/8               | None                          |
| Default | Active | 100.64.0.0./10           | None                          |
| Default | Active | 192.168.0.0/16           | None                          |
| Default | Active | 20.38.106.0/23, 10 more  | VirtualNetworkServiceEndpoint |
| Default | Active | 20.150.2.0/23, 9 more    | VirtualNetworkServiceEndpoint |

All traffic for the service now is routed to the **VirtualNetworkServiceEndpoint**, and remains internal to Azure.

## Service endpoints and hybrid networks

Service resources that have been secured using virtual network service endpoints are not, by default, accessible from on-premises networks. To access resources from an on-premises network, you'll need to use NAT IPs. If you use ExpressRoute for connectivity from on-premises to Azure, you'll have to identify the NAT IP addresses that are used by ExpressRoute. By default, each circuit uses two NAT IP addresses to connect to the Azure backbone network. You'll then need to add these IP addresses into the IP firewall configuration of the Storage, SQL, or other Azure resource.

This diagram shows how you could use a service endpoint and firewall configuration to enable on-premises devices to access Azure Storage resources.

![Service endpoint for on-premises access to Azure resources](../media/4-service-endpoint-flow.svg)
