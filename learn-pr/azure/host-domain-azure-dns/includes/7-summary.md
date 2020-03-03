Your company recently bought the custom domain name wideworldimporters.com from a third-party domain name registrar. The domain name is for a new website your organization plans to launch. You need a hosting service for DNS domains. This hosting service would resolve the wideworldimporters.com domain to the IP address of your Azure-based web server.

Your company wanted to manage all their infrastructure and related domain name information in one place. You've seen how easy it was to manage DNS information by using an Azure DNS zone. The first thing we did was create an Azure DNS zone, then we updated the NS records at your domain registrar to point at it. You learned the uses of the different record sets, A, AAAA, CNAME, NS, and SOA.  You also learned how you could use Azure aliases to override the static A/AAAA/CNAME record to provide a dynamic reference to your resources. Using an Azure DNS zone improved your companies administration of resources, with your staff only needing one place to manage DNS-related tasks.

While the Azure DNS zone allows better control and integration with your Azure resources, you could achieve some of the more basic record set functions using the domain registrar's management console. However, linking to any of your Azure resources becomes difficult or impossible without a high degree of complex redirection.

By using an Azure DNS zone to host your domain, your organization benefits by having all the resources managed through a single common interface. This brings with it better integration with existing Azure resources, improved security, and monitoring tools.

<!-- Cleanup sandbox -->
[!include[](../../../includes/azure-sandbox-cleanup.md)]