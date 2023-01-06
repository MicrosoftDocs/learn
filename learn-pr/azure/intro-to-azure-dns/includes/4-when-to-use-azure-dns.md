Almost every organization that has an internet presence has one or more DNS domain names. When you set up Tailwind Trader's Microsoft 365 subscription, you used a domain registrar to acquire the tailwindtraders.com DNS zone. Since then, you've been managing DNS records in this zone using the domain registrar's tools. As your organization starts to deploy applications and services in Azure, you find the process of managing DNS records associated with those resources to become more administratively intensive.

Your options for managing the records in public DNS zones include:

- Use your DNS registrar's DNS management tools. Most DNS registrars provide basic DNS zone hosting and management functionality. You can use your DNS registrar's tools to manually create and manage records in your organizations publicly registered DNS zones. When using a DNS registrar's management functionality, it's difficult to automate changes in line with adding and modifying apps and services in Azure. DNS registrar tools are mostly aimed at organizations that need simple DNS services, not ones who are adding and modifying new services on a frequent basis.

- Manage your own DNS servers. Many organizations, especially ones with on-premises configurations involving Active Directory Domain Services already host their own DNS server infrastructure. Managing your own DNS servers is more administratively intensive. However, if your organization needs to replicate Active Directory integrated DNS zone data, zone transfer, or needs to support DNSSEC, managing your own DNS server might be a more appropriate solution. In our Tailwind Traders example, you don't need this extra functionality, so the extra administrative effort required to manage your own DNS server isn't justified.

Azure DNS provides an alternative to these commonly used options. You should use Azure DNS:

- When you want a highly resilient DNS server service to host your DNS zone data.

- You don't want to manage your own DNS servers or the underlying operating systems that host those services.

- You want DNS record management for your Azure resources integrated into your Azure management tools.

- You don't need access to features such as DNSSEC, Active Directory Integrated DNS Zones, or zone transfer.

Azure DNS provides you with a good solution because you don't currently require features such as DNSSEC and you don't want to manage a DNS server. Azure DNS also allows you to manage Azure and DNS resources using a single set of tools.

When your application developers deploy a multi-tier VM application in a private Azure virtual network for which DNS resource records shouldn't be publicly resolvable, you can implement Azure DNS private zones. You should use Azure DNS private zones:

- When you want to provide DNS zones only to hosts on specific Azure virtual networks.

- You want to automatically register hosts in a specific Azure virtual network.

- You want to allow private DNS zone data to be accessible across multiple virtual networks in your subscription.

- You want to use DNS in a split horizon configuration. A configuration where a limited number of DNS records are available to clients on the internet, but a full set of records is available to hosts in Azure virtual networks.

- You want to configure records in your DNS zone to point to Azure private endpoints such as Azure Storage, Azure Cosmos DB, or Azure SQL Database.
