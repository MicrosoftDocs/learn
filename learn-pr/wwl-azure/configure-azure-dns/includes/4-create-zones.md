Azure DNS provides a reliable, secure DNS service to manage and resolve domain names in a virtual network without needing to add a custom DNS solution.

An Azure **DNS zone** hosts the DNS records for a domain. To begin hosting your domain in Azure DNS, you need to create a DNS zone for your domain name. Each DNS record for your domain is then created inside your DNS zone.

### Things to know about DNS zones

You can add a DNS zone in the Azure portal, as shown in the following image. Several configuration settings are required to create a DNS zone. In the portal, you specify the DNS zone name, number of records, resource group, zone location, associated subscription, and DNS name servers.

:::image type="content" source="../media/create-zones-5c62cee1.png" alt-text="Screenshot that shows how to add a DNS zone in the Azure portal.":::

Take a moment to review some important characteristics about DNS zones.

- Within a resource group, the name of a DNS zone must be unique.

   By providing a unique name when you create a new DNS zone, Azure ensures that the DNS zone doesn't already exist in the resource group.

- Multiple DNS zones can have the same name, but the DNS zones must exist in different resource groups or in different Azure subscriptions.

- When multiple DNS zones share the same name, each DNS zone instance is assigned to a different DNS name server address.

- The Root/Parent domain is registered at the registrar and then pointed to Azure DNS.

- Child domains are registered directly in Azure DNS.

> [!Tip]
> You don't have to own a domain name to create a DNS zone with that domain name in Azure DNS. However, you do need to own the domain to configure the domain.