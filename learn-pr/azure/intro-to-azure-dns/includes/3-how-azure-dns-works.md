Azure DNS hosts DNS zones and provides a name resolution service using Microsoft's Azure infrastructure. Traditionally when a DNS service is hosted on a server running Windows Server or Linux and a DNS zone gets delegated to that server. A client making a DNS query for a host in that zone will have their query answered by that DNS server service. When a host on the internet queries for a DNS record in a DNS zone that has been delegated to Azure DNS, Azure DNS responds to that host with the result of that query.

DNS zones in Azure DNS are hosted across Azure's global network of DNS name servers. These servers use Anycast networking so that queries for DNS zone data will be answered by the DNS server closest to the querying client. For example, if a person in Australia is performing a DNS query against a DNS record in a DNS zone hosted in Azure DNS, a DNS server in an Australian Azure datacenter will respond to that query. The same query performed by someone in Europe will have a DNS server in a European Azure region respond to the query.

## Azure DNS public zones

Azure DNS public zones host domain name zone data for records that you intend to be resolved by any host on the internet. Azure DNS public zones support all common DNS record types including A, AAAA, CNAME, MX, PTR, SOA, SRV, and TXT records. Azure DNS supports alias record sets. You can use an alias record set to refer to an Azure resource, such as an Azure public IP address, an Azure Traffic Manager profile, or an Azure Content Delivery Network (CDN) endpoint. If the IP address of the underlying resource changes, the alias record set seamlessly updates itself during DNS resolution. The alias record set points to the service instance, and the service instance is associated with an IP address. You can create a DNS zone and manage the resources within that zone using the Azure portal, Azure CLI, Azure PowerShell, or through a Rest API.

## Azure DNS private zones

Many organizations use internal DNS names that are separate from public DNS names for hosts on their internal on-premises networks. Azure Private DNS zones allow you to replicate this functionality by configuring a private DNS zone namespace that can be used to map FQDNs with private Azure resources. For example, you might have several virtual networks that host virtual machines in your organization's Azure subscription that are inaccessible to the internet but accessible through a virtual private network. In the future, Tailwind Traders will deploy several multi-tier applications running across IaaS virtual machines. In this configuration, each virtual machine performs different application tasks including manipulation and processing of sales data. The application architects want each virtual machine to be able to access other resources on these private virtual networks using FQDNs. You also want to ensure that those FQDNs aren't resolvable to hosts outside on the Internet. This task can be accomplished using Azure DNS private zones. If you want to configure some records in the tailwindtraders.com DNS zone to be public whilst others remain private, you can also use Azure DNS private zones to accomplish this goal. Another term for this segmenting of public and private DNS records in a zone is split-horizon DNS.

Like Azure DNS public zones, Azure DNS private zones support all common DNS record types including A, AAAA, CNAME, MX, PTR, SOA, SRV, and TXT records.

Azure DNS private zones support the following features:

- **Automatic hostname record management.** Along with hosting your custom DNS records, Azure automatically maintains hostname records for the VMs in the specified virtual networks. In this scenario, you can optimize the domain names you use without needing to create custom DNS solutions or modify applications.

- **Hostname resolution between virtual networks.** Unlike Azure-provided host names, private DNS zones can be shared between virtual networks. This capability simplifies cross-network and service-discovery scenarios, such as virtual network peering.

- **Split-horizon DNS support.** With Azure DNS, you can create zones with the same name that resolve to different answers from within a virtual network and from the public internet. A typical scenario for split-horizon DNS is to provide a dedicated version of a service for use inside your virtual network.

- **Support for Azure Private Endpoint DNS.** Azure DNS private zones support FQDN records in a private DNS zone mapping to an Azure Private Endpoint. An Azure Private Endpoint is a network interface with a private IP address on a virtual network that maps to an Azure service such as Azure Storage, Azure Cosmos DB, Azure SQL Database or your own Azure Private Link Service.

A diagram shows the integration of the Azure DNS public zone tailwindtraders.com with the Azure DNS private zone tailwindtraders.com in split-horizon configuration.

:::image type="content" source="../media/dns.png" alt-text="Depiction of on-prem D N S server communicating with DNS resolver V M in Azure D N S Private Zone.":::
