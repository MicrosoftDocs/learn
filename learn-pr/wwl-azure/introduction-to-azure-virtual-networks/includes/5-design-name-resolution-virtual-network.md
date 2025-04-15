

Azure provides both public and private DNS services.  

:::image type="content" source="../media/create-private-dns-zone-48970f32.png" alt-text="Screenshot of the portal DNS selection page.":::




## Public DNS services

[Azure public DNS](/azure/dns/public-dns-overview) is a hosting service for DNS domains that provides name resolution by using Microsoft Azure infrastructure. DNS domains in Azure DNS are hosted on Azure's global network of DNS name servers. Each DNS query is directed to the closest available DNS server. Azure DNS provides a reliable, secure DNS service to manage and resolve domain names in a virtual network without needing to add a custom DNS solution.

### Configuration considerations

- The name of the DNS zone must be unique within the resource group, and the zone must not exist already.
- The same zone name can be reused in a different resource group or a different Azure subscription.
- Where multiple zones share the same name, each instance is assigned different name server addresses.
- The root/parent zone is registered at the registrar and pointed to Azure NS name servers.

### Delegate DNS Domains

Azure DNS allows you to host a DNS zone and manage the DNS records for a domain in Azure. In order for DNS queries for a domain to reach Azure DNS, the domain has to be delegated to Azure DNS from the parent domain. Keep in mind Azure DNS isn't the domain registrar.

To delegate your domain to Azure DNS, you first need to know the name server names for your zone. Each time a DNS zone is created Azure DNS allocates name servers from a pool. Once the Name Servers are assigned, Azure DNS automatically creates authoritative NS records in your zone.

Once the DNS zone is created, and you have the name servers, you need to update the parent domain. Each registrar has their own DNS management tools to change the name server records for a domain. In the registrar’s DNS management page, edit the NS records and replace the NS records with the ones Azure DNS created.

> [!NOTE]
>
> When delegating a domain to Azure DNS, you must use the name server names provided by Azure DNS. You should always use all four name server names, regardless of the name of your domain.

### Child Domains

If you want to set up a separate child zone, you can delegate a subdomain in Azure DNS. For example, after configuring contoso.com in Azure DNS, you could configure a separate child zone for partners.contoso.com.

Setting up a subdomain follows the same process as typical delegation. The only difference is that NS records must be created in the parent zone contoso.com in Azure DNS, rather than in the domain registrar.

> [!NOTE]
>
> The parent and child zones can be in the same or different resource group. 

## Private DNS services

[Private DNS services](/azure/dns/private-dns-overview) provides a reliable and secure DNS service for your virtual networks. Azure Private DNS manages and resolves domain names in the virtual network without the need to configure a custom DNS solution. By using private DNS zones, you can use your own custom domain name instead of the Azure-provided names during deployment. Using a custom domain name helps you tailor your virtual network architecture to best suit your organization's needs. It provides a naming resolution for virtual machines (VMs) within a virtual network and connected virtual networks.

### Considerations

- Removes the need for creating custom DNS solutions. 
- Hosts your custom DNS records, including hostname records. 
- Provides hostname resolution between virtual networks.
- Private DNS zones can be shared between virtual networks. This capability simplifies cross-network and service-discovery scenarios, such as virtual network peering.
- The Azure DNS private zones feature is available in all Azure regions in the Azure public cloud.

### Azure Private DNS Zones

Private DNS zones in Azure are available for internal resources only. They're global in scope, so you can access them from any region, any subscription, any VNet, and any tenant. If you have permission to read the zone, you can use it for name resolution. Private DNS zones are highly resilient, being replicated to regions all throughout the world. They aren't available to resources on the internet.

For scenarios which require more flexibility than internal DNS allows, you can create your own private DNS zones. These zones enable you to:

- Configure a specific DNS name for a zone.
- Create records manually when necessary.
- Resolve names and IP addresses across different zones.
- Resolve names and IP addresses across different VNets.

> [!TIP]
> Learn more about Azure DNS in the [Host your domain on Azure DNS](/training/modules/host-domain-azure-dns/) module. 


Choose the best response for each question.