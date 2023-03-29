In a hybrid environment, when name resolution for Azure is required from on-premises to Azure services hosted privately using private endpoint and private DNS zones, the Azure DNS Private Resolver managed service is the right tool for you.

For example, you might have a hybrid environment where users in on-premises locations need to resolve and to connect to the SQL database running in Azure SQL with private endpoint enabled. The Azure private resolver enables you to query the name of Azure SQL private endpoint in private DNS from your on-premises network. The resolver also enables your Azure infrastructure (using Azure DNS) to perform name resolution for services running on-premises without the need to deploy VM based DNS servers.

For more information about using the Azure DNS Private Resolver in a hybrid environment, see [Resolve Azure and on-premises domains](/azure/dns/private-resolver-hybrid-dns).

Azure DNS private resolver also provides a way for you to centralize or distribute DNS resolution across your Azure network. If you have a hub-and-spoke virtual network design within Azure, virtual network links from a DNS forwarding ruleset to spoke networks provide a way to distribute and fine-tune DNS resolution across your infrastructure. 

You can also configure the private resolver inbound endpoint IP address as custom DNS in a virtual network, sending all DNS queries to the hub VNet in a centralized design. For more information about using the Azure DNS Private Resolver with an Azure hub-and-spoke design, see [Private resolver architecture](/azure/dns/private-resolver-architecture).
