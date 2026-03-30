Azure DNS is a hosting service for DNS domains that provides name resolution by using Microsoft Azure infrastructure. By hosting your domains in Azure, you can manage your DNS records using the same credentials, APIs, tools, and billing as your other Azure services.

## Benefits of Azure DNS

Azure DNS uses the scope and scale of Microsoft Azure to provide numerous benefits, including:

 -  Reliability and performance
 -  Security
 -  Ease of use
 -  Customizable virtual networks
 -  Alias records

### Reliability and performance

DNS domains in Azure DNS are hosted on Azure's global network of DNS name servers, providing resiliency and high availability. Azure DNS uses anycast networking, so the closest available DNS server answers each DNS query, providing fast performance and high availability for your domain.

:::image type="content" source="../media/anycast-resolution.png" alt-text="Diagram showing a DNS query routed to the closest Azure DNS server through anycast networking across multiple regions.":::

### Security

Azure DNS is based on Azure Resource Manager, which provides features such as Azure role-based access control (Azure RBAC), activity logs, and resource locks to help protect DNS resources and records.

### Ease of use

Azure DNS can manage DNS records for your Azure services and provide DNS for your external resources as well. Azure DNS is integrated in the Azure portal and uses the same credentials, support contract, and billing as your other Azure services.

Because Azure DNS runs on Azure, you can manage your domains and records with the Azure portal, Azure PowerShell cmdlets, and the cross-platform Azure CLI. Applications that require automated DNS management can integrate with the service by using the REST API and SDKs.

### Customizable virtual networks with private domains

Azure DNS also supports private DNS domains. This feature lets you use your own custom domain names in your private virtual networks instead of the Azure-provided names.

### Alias records

Azure DNS also supports alias record sets. You can use an alias record set to refer to an Azure resource, such as an Azure public IP address, an Azure Traffic Manager profile, or an Azure Content Delivery Network (CDN) endpoint. If the IP address of the underlying resource changes, the alias record set seamlessly updates itself during DNS resolution. The alias record set points to the service instance, and the service instance is associated with an IP address.

:::image type="content" source="../media/alias-records.png" alt-text="Diagram showing an alias record set tracking the IP address of an Azure resource as it changes for correct DNS resolution.":::

> [!IMPORTANT]
> You can't use Azure DNS to buy a domain name. For an annual fee, you can buy a domain name by using App Service domains or a third-party domain name registrar. Once purchased, your domains can be hosted in Azure DNS for record management.

