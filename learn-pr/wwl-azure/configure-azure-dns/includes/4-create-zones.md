Azure DNS provides a reliable, secure DNS service to manage and resolve domain names in a virtual network without needing to add a custom DNS solution.

A DNS zone hosts the DNS records for a domain. So, to start hosting your domain in Azure DNS, you need to create a DNS zone for that domain name. Each DNS record for your domain is then created inside this DNS zone.

From the Azure portal, you can easily add a DNS zone. Information for the DNS zone includes name, number of records, resource group, location, subscription, and name servers.

:::image type="content" source="../media/create-zones-5c62cee1.png" alt-text="Screenshot of Add a DNS Zone in the Azure portal.":::


## Considerations

 -  The name of the zone must be unique within the resource group, and the zone must not exist already.
 -  The same zone name can be reused in a different resource group or a different Azure subscription.
 -  Where multiple zones share the same name, each instance is assigned different name server addresses.
 -  Root/Parent domain is registered at the registrar and pointed to Azure NS.
 -  Child domains are registered in AzureDNS directly.

> [!NOTE]
> You do not have to own a domain name to create a DNS zone with that domain name in Azure DNS. However, you do need to own the domain to configure the domain.
