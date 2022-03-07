To delegate your domain to Azure DNS, you first need to know the name server names for your zone. Each time a DNS zone is created Azure DNS allocates name servers from a pool. Once the Name Servers are assigned, Azure DNS automatically creates authoritative NS records in your zone.

> [!NOTE]
> When you copy each name server address, make sure you copy the trailing period at the end of the address. The trailing period indicates the end of a fully qualified domain name.

The easiest way to locate the name servers assigned to your zone is through the Azure portal. In this example, the zone has been assigned four name servers: ‘ns1-02.azure-dns.com’, ‘ns2-02.azure-dns.net’, ‘ns3-02.azure-dns.org’, and ‘ns4-02.azure-dns.info’:

:::image type="content" source="../media/name-servers-cf7cec6a.png" alt-text="Screenshot from the Azure portal where in this example, the zone contoso.net has been assigned name servers ns1-01.azure-dns.com, ns2-01.azure-dns.net, ns3-01.azure-dns.org, and ns4-01.azure-dns.info":::


Once the DNS zone is created, and you have the name servers, you need to update the parent domain. Each registrar has their own DNS management tools to change the name server records for a domain. In the registrar’s DNS management page, edit the NS records and replace the NS records with the ones Azure DNS created.

> [!NOTE]
> The term *registrar* refers to the third party domain registrar. This is the company where you registered your domain.

> [!NOTE]
> When delegating a domain to Azure DNS, you must use the name server names provided by Azure DNS. You should always use all four name server names, regardless of the name of your domain.

## Child domains

If you want to set up a separate child zone, you can delegate a subdomain in Azure DNS. For example, after configuring contoso.com in Azure DNS, you could configure a separate child zone for partners.contoso.com.

Setting up a subdomain follows the same process as typical delegation. The only difference is that NS records must be created in the parent zone contoso.com in Azure DNS, rather than in the domain registrar.

> [!NOTE]
> The parent and child zones can be in the same or different resource group. Notice that the record set name in the parent zone matches the child zone name, in this case *partners*.
