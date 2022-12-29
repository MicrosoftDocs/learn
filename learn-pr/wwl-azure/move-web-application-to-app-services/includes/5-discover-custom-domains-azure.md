Azure DNS allows you to host and manage your domains by using a globally distributed name server infrastructure. It allows you to manage all of your domains by using your existing Azure credentials.

Azure DNS acts as the "start of authority" for the domain.

You can't use Azure DNS to register a domain name. You use a third-party domain registrar to register your domain.

## Why use Azure DNS to host your domain?

Azure DNS is built on the Azure Resource Manager service, which offers the following benefits:

* Improved security
* Ease of use
* Private DNS domains
* Alias record sets
* At this time, Azure DNS doesn't support Domain Name System Security Extensions. If you require this security extension, you should host those portions of your domain with a third-party provider.

## Security features

Azure DNS provides the following security features:

* Role-based access control, which gives you fine-grained control over users' access to Azure resources. You can monitor their usage and control the resources and services to which they have access.
* Activity logs, which let you track changes to a resource and pinpoint where faults occurred.
* Resource locking, which gives a greater level of control to restrict or remove access to resource groups, subscriptions, or any Azure resources.
* Ease of use
* Azure DNS can manage DNS records for your Azure services, and provide DNS for your external resources. Azure DNS uses the same Azure credentials, support contract, and billing as your other Azure services.

You can manage your domains and records by using the Azure portal, Azure PowerShell cmdlets, or the Azure CLI. Applications that require automated DNS management can integrate with the service by using the REST API and SDKs.

## Private domains

Azure DNS handles the translation of external domain names to an IP address. Azure DNS lets you create private zones. These provide name resolution for virtual machines (VMs) within a virtual network, and between virtual networks, without having to create a custom DNS solution. This allows you to use your own custom domain names rather than the Azure-provided names.

To publish a private DNS zone to your virtual network, you'll specify the list of virtual networks that are allowed to resolve records within the zone.

Private DNS zones have the following benefits:

- There's no need to invest in a DNS solution. DNS zones are supported as part of the Azure infrastructure.
- All DNS record types are supported: A, CNAME, TXT, MX, SOA, AAAA, PTR, and SRV.
- Host names for VMs in your virtual network are automatically maintained.
- Split-horizon DNS support allows the same domain name to exist in both private and public zones. It resolves to the correct one based on the originating request location.
