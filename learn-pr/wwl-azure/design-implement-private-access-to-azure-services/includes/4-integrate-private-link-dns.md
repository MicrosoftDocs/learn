Private DNS zones are typically hosted centrally in the same Azure subscription where the hub VNet is deployed. This central hosting practice is driven by cross-premises DNS name resolution and other needs for central DNS resolution such as Active Directory. In most cases, only networking/identity admins have permissions to manage DNS records in these zones.

## Azure Private Endpoint DNS configuration

The following diagram shows a typical high-level architecture for enterprise environments with central DNS resolution and where name resolution for Private Link resources is done via Azure Private DNS:

:::image type="content" source="../media/private-link-example-central-dns-73e26cad.png" alt-text="Diagram of high-level workflow of enterprise environments with central DNS resolution and where name resolution for Private Link resources is done via Azure Private DNS.":::

From the previous diagram, it is important to highlight that:

 -  On-premises DNS servers have conditional forwarders configured for each Private Endpoint public DNS zone forwarder pointing to the DNS forwarders (10.100.2.4 and 10.100.2.5) hosted in the hub VNet.
 -  The DNS servers 10.100.2.4 and 10.100.2.5 hosted in the hub VNet use the Azure-provided DNS resolver (168.63.129.16) as a forwarder.
 -  All Azure VNets have the DNS forwarders (10.100.2.4 and 10.100.2.5) configured as the primary and secondary DNS servers.
 -  There are two conditions that must be true to allow application teams the freedom to create any required Azure PaaS resources in their subscription:
 -  Central networking and/or central platform team must ensure that application teams can only deploy and access Azure PaaS services via Private Endpoints.
 -  Central networking and/or central platform teams must ensure that whenever Private Endpoints are created, the corresponding records are automatically created in the centralized private DNS zone that matches the service created.
 -  DNS record needs to follow the lifecycle of the Private Endpoint and automatically remove the DNS record when the Private Endpoint is deleted.

## Significance of IP address 168.63.129.16

IP address 168.63.129.16 is a virtual public IP address that is used to facilitate a communication channel to Azure platform resources. Customers can define any address space for their private virtual network in Azure. The Azure platform resources must be presented as a unique public IP address. This virtual public IP address facilitates the following things:

- Enables the VM Agent to communicate with the Azure platform to signal that it is in a "Ready" state
- Enables communication with the DNS virtual server to provide filtered name resolution to the resources (such as VM) that do not have a custom DNS server. This filtering makes sure that customers can resolve only the hostnames of their resources
- Enables health probes from Azure load balancer to determine the health state of VMs
- Enables the VM to obtain a dynamic IP address from the DHCP service in Azure
- Enables Guest Agent heartbeat messages for the PaaS role


## Azure services Private DNS zone configuration examples

Azure creates a canonical name DNS record (CNAME) on the public DNS. The CNAME record redirects the resolution to the private domain name. You can override the resolution with the private IP address of your Private Endpoints.

Your applications don't need to change the connection URL. When resolving to a public DNS service, the DNS server will resolve to your Private Endpoints. The process doesn't affect your existing applications.

Private networks already using the private DNS zone for a given type, can only connect to public resources if they don't have any Private Endpoint connections, otherwise a corresponding DNS configuration is required on the private DNS zone in order to complete the DNS resolution sequence.

For Azure services, use the [recommended zone names](/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration) found in the documentation. 


## DNS configuration scenarios

The FQDN of the services resolves automatically to a public IP address. To resolve to the private IP address of the Private Endpoint, change your DNS configuration.

DNS is a critical component to make the application work correctly by successfully resolving the Private Endpoint IP address.

Based on your preferences, the following scenarios are available with DNS resolution integrated:

 -  [Virtual network workloads without custom DNS server](/azure/private-link/private-endpoint-dns#virtual-network-workloads-without-custom-dns-server)
 -  [On-premises workloads using a DNS forwarder](/azure/private-link/private-endpoint-dns#on-premises-workloads-using-a-dns-forwarder)
 -  [Virtual network and on-premises workloads using a DNS forwarder](/azure/private-link/private-endpoint-dns#virtual-network-and-on-premises-workloads-using-a-dns-forwarder)
 -  [Private DNS zone group](/azure/private-link/private-endpoint-dns#private-dns-zone-group)


### On-premises workloads using a DNS forwarder

For on-premises workloads to resolve the FQDN of a Private Endpoint, use a DNS forwarder to resolve the Azure service public DNS zone in Azure. A DNS forwarder is a Virtual Machine running on the Virtual Network linked to the Private DNS Zone that can proxy DNS queries coming from other Virtual Networks or from on-premises. This is required as the query must be originated from the Virtual Network to Azure DNS. A few options for DNS proxies are: Windows running DNS services, Linux running DNS services, Azure Firewall.

The following scenario is for an on-premises network that has a DNS forwarder in Azure. This forwarder resolves DNS queries via a server-level forwarder to the Azure provided DNS 168.63.129.16.

This scenario uses the Azure SQL Database-recommended private DNS zone. For other services, you can adjust the model using the following reference: Azure services DNS zone configuration.

To configure properly, you need the following resources:

 -  On-premises network
 -  Virtual network connected to on-premises
 -  DNS forwarder deployed in Azure
 -  Private DNS zones privatelink.database.windows.net with type A record
 -  Private Endpoint information (FQDN record name and private IP address)

The following diagram illustrates the DNS resolution sequence from an on-premises network. The configuration uses a DNS forwarder deployed in Azure. The resolution is made by a private DNS zone linked to a virtual network:

:::image type="content" source="../media/on-premises-using-azure-dns-ccdbeaf1.png" alt-text="Diagram illustrating the DNS resolution sequence from an on-premises network using a DNS forwarder deployed in Azure.":::


### Virtual network and on-premises workloads using Azure DNS Private Resolver

When you use DNS Private Resolver, you don't need a DNS forwarder VM, and Azure DNS is able to resolve on-premises domain names.

The following diagram uses DNS Private Resolver in a hub-spoke network topology. As a best practice, the Azure landing zone design pattern recommends using this type of topology. A hybrid network connection is established by using Azure ExpressRoute and Azure Firewall. This setup provides a secure hybrid network. DNS Private Resolver is deployed in the hub network.

:::image type="content" source="../media/private-resolver.png" alt-text="Diagram illustrating on-premises workloads using Azure DNS Private Resolver.":::

- Review the [DNS Private Resolver solution components](/azure/architecture/example-scenario/networking/azure-dns-private-resolver#dns-private-resolver-solution-components)
- Review the [traffic flow for an on-premises DNS query](/azure/architecture/example-scenario/networking/azure-dns-private-resolver#traffic-flow-for-an-on-premises-dns-query)
- Review the [traffic flow for a VM DNS query](/azure/architecture/example-scenario/networking/azure-dns-private-resolver#traffic-flow-for-a-vm-dns-query)
- Review the [traffic flow for a VM DNS query via DNS Private Resolver](/azure/architecture/example-scenario/networking/azure-dns-private-resolver#traffic-flow-for-a-vm-dns-query-via-dns-private-resolver)
- Review the [traffic flow for a VM DNS query via an on-premises DNS server](/azure/architecture/example-scenario/networking/azure-dns-private-resolver#traffic-flow-for-a-vm-dns-query-via-an-on-premises-dns-server)