


Name resolution is a critical part of any network infrastructure. Contoso currently maintains an on-premises DNS solution to manage internal name resolution. Internet-facing DNS servers are deployed in the Contoso perimeter network to resolve internet name queries. It's important that any Azure networking components can provide the necessary name resolution elements.

When Contoso IT staff deploys resources in Azure on VNets, these resources need to resolve FQDNs to private, internal IP addresses. There are three possible methods they could use:

- Azure DNS private zones.
- Azure-provided name resolution.
- Their own DNS server for name resolution.

Which type of name resolution they choose depends on how their Azure resources need to communicate. The following table describes a number of name resolution and DNS scenarios, and the suggested name resolution solutions that they could implement to support those scenarios.

|Scenario|Solution|DNS suffix|
|------------------------------------------------------------|------------------------------------------------------------|----------------|
| Name resolution between VMs located in the same VNet, or Azure Cloud Services role instances in the same cloud service|You can use either Azure DNS private zones or Azure-provided name resolution.|Hostname or FQDN|
| Name resolution between VMs in different VNets or role instances in different cloud services|You can use either Azure DNS private zones or your own DNS servers forwarding queries between VNets for resolution by Azure.|FQDN only|
| Name resolution from an Azure App Service using VNet integration to role instances or VMs in the same VNet|You can use your own DNS servers forwarding queries between VNets for resolution by Azure.|FQDN only|
| Name resolution from Azure App Service to VMs in the same VNet|You can use your own DNS servers forwarding queries between VNets for resolution by Azure.|FQDN only|
| Name resolution from Azure App Service in one VNet to VMs in a different VNet|You can use your own DNS servers forwarding queries between VNets for resolution by Azure.|FQDN only|
| Resolution of on-premises computer and service names from VMs or role instances in Azure|You can use your own DNS servers.|FQDN only|
| Resolution of Azure hostnames from on-premises computers|You must configure DNS forwarding to your own DNS proxy server in the corresponding VNet. The proxy server then forwards queries to Azure for resolution.|FQDN only|
| Reverse DNS for internal IPs|You can implement either Azure DNS private zones or use Azure-provided name resolution. You can also implement name resolution using your own DNS servers.|Not applicable|
| Name resolution between VMs or role instances located in different cloud services, not in a VNet|This scenario is currently not supported because connectivity between VMs and role instances in different cloud services is not supported outside a VNet.|Not applicable|

In this module, you learned how to implement DNS in Azure, and how to select and implement an Azure DNS solution. You also learned how to troubleshoot that solution.

## Learn more

You can learn more by reviewing the following documents. 

- [What is Azure DNS?](https://aka.ms/dns-overview?azure-portal=true)
- [What is Azure Private DNS?](https://aka.ms/private-dns-overview?azure-portal=true)
- [Azure DNS FAQ](https://aka.ms/dns-faq?azure-portal=true)
- [Administer DNS and create conditional forwarders in an Azure Active Directory Domain Services managed domain](https://aka.ms/manage-dns?azure-portal=true)
- [Name resolution for resources in Azure virtual networks](https://aka.ms/azure-provided-name-resolution?azure-portal=true)