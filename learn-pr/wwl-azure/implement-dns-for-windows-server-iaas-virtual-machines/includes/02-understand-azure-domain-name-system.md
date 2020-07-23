


*Azure DNS* is an Azure service that provides name resolution for your Azure resources. Currently, Contoso uses Windows Server VMs in their on-premises datacenter to implement DNS. You must consider whether you can implement Azure DNS to replace the functionality of these on-premises workloads. It's also important to determine if there are currently any limitations in Azure DNS that you might need to manage around.

## Overview

You can host your DNS zones in Azure DNS. Specifically, Azure DNS provides authoritative DNS services for its zones. In order for DNS queries for resources in your organization's domain to reach Azure DNS, you must delegate that domain to Azure DNS from the parent domain.

DNS zones that you migrate to Azure DNS are hosted in a global network of DNS name servers in Azure. Because Azure DNS uses anycast communications, a DNS query from your organization is directed to the nearest Azure DNS server helping to provide good performance and high availability of this critical infrastructure service.

> [!NOTE] 
> Azure Traffic Manager is a DNS-based network traffic load-balancing solution. You can use Azure Traffic Manager to distribute network traffic to your Azure resources across all Azure regions.

You can use role-based access control (RBAC) to select which of your users can manage your Azure DNS domains. You can use the Azure portal, Azure Command-Line Interface (Azure CLI), and Azure PowerShell to manage your DNS domains in Azure DNS.

### Limitations and considerations of Azure DNS

Azure DNS is an evolving platform and new features and capabilities are being added all the time. Currently, however, there are some limitations:

- You can only link a specific virtual network (VNet) to one private zone. (Private zones are discussed later in this unit.)
- Reverse (sometimes called *inverse*) DNS works only for the private IP address space in the linked VNet.
- Conditional forwarding is not currently supported.
- Azure DNS does not currently support Domain Name System Security Extensions (DNSSEC).

> [!NOTE] 
> DNSSEC enables a DNS zone and all records in the zone to be signed cryptographically so that client computers can validate the DNS response. DNS is often subject to various attacks, such as spoofing and cache tampering. DNSSEC helps protect against these threats and provides a more secure DNS infrastructure. If you need to implement DNSSEC, you must implement at least part of your DNS solution using Windows Server DNS.

- Azure DNS does not support zone transfers.
- When using public DNS zones, there are a number of limits that relate to the number of zones and also the number of records per subscription.

## Azure private DNS

Azure DNS provides support for both public and private DNS, described in the following table.

|DNS service|Description|
|----|----|
|Azure public DNS|Provides name resolution for internet-facing DNS domains. You use Azure public DNS to host your organization's DNS domains.|
|Azure private DNS|Provides name resolution for VMs within a VNet and between VNets. Enables you to configure zones names with a split-horizon display, which enables a private and a public DNS zone to share the same zone name.|

To resolve the records of a private DNS zone from your VNet, you must link the VNet with the zone. Linked VNets have full access and can resolve all DNS records published in the private zone. Additionally, you can also enable autoregistration on a VNet link which registers the DNS records for the VMs on that VNet in the private zone. When autoregistration is enabled, Azure DNS also updates the zone records whenever a VM is created, changes its IP address, or is deleted.

The following table describes the features of  Azure private DNS.

|Feature|Description|
|----|----|
|Automatic registration of VMs from a VNet that you link to a private zone|Your VMs are registered with your private zone as host (A) records that resolve to the VMs' private IP addresses. After you enable autoregistration, when you delete a VM in a VNet link, Azure DNS removes the corresponding DNS record from the linked private zone automatically.|
|Forward DNS resolution across VNets that you link to your private zone|When you implement cross-VNet DNS name resolution, there are no explicit requirement for you to peer your VNets. You might still want to peer VNets for other reasons, unrelated to DNS.|
|Reverse DNS lookup within the VNet scope|Reverse DNS lookup for a private IP address within a VNet that you assign to a private zone returns the host's fully qualified domain name (FQDN) that includes the host/record name and the zone name as the suffix.|

## Additional reading
You can learn more by reviewing the following documents.

- [Delegation of DNS zones with Azure DNS](https://aka.ms/dns-domain-delegation?azure-portal=true).
- [What is Traffic Manager?](https://aka.ms/traffic-manager-overview?azure-portal=true)
- [Azure DNS FAQ](https://aka.ms/usage-limits-for-azure-dns?azure-portal=true).