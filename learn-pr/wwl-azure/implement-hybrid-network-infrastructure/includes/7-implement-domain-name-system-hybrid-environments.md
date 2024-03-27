Currently, Contoso uses Windows Server VMs in its on-premises datacenter to implement DNS. As lead system engineer, you must decide whether to implement Azure DNS to replace the functionality of these on-premises workloads, or to implement DNS in Windows Server VMs.

There are a number of scenarios in which Contoso might decide to implement DNS by using Windows Server IaaS, either in addition to Azure DNS, or in-place of Azure DNS. These scenarios might include:

- Configuring name resolution between VMs in different VNets.
- Configuring name resolution of Azure hostnames from on-premises computers.
- Implementing conditional forwarding.
- Implementing DNS zone transfers.

## Overview of Azure DNS

You can host your DNS zones in Azure DNS. Specifically, Azure DNS provides authoritative DNS services for its zones. For DNS queries for resources in your organization's domain to reach Azure DNS, you must delegate that domain to Azure DNS from the parent domain.

DNS zones that you migrate to Azure DNS are hosted in a global network of DNS name servers in Azure. Because Azure DNS uses anycast communications, a DNS query from your organization is directed to the nearest Azure DNS server, which helps to provide good performance and high availability of this critical infrastructure service. You can use role-based access control (RBAC) to select which of your users can manage your Azure DNS domains.

### Limitations and considerations of Azure DNS

Azure DNS is an evolving platform, and new features and capabilities are being added all the time. At present, however, Azure DNS has some limitations.

- You can only link a specific VNet to one private DNS zone.
- Reverse (sometimes called *inverse*) DNS works only for the private IP address space in the linked VNet.
- Conditional forwarding is not currently supported.
- Azure DNS doesn't currently support Domain Name System Security Extensions (DNSSEC).
- Azure DNS does not support zone transfers.
- There are a number of limits when using public DNS zones that relate to the number of zone and records per subscription.

### Azure Private DNS

Azure DNS provides support for both public DNS and private DNS, as described in the following table.

|DNS service|Description|
|-----------------|------------------------------------------------------------|
|Azure public DNS|Provides name resolution for internet-facing DNS domains. You use Azure public DNS to host your organization's DNS domains.|
|Azure private DNS|Provides name resolution for VMs within a VNet and between VNets. Enables you to configure zone names with a split-horizon view; this enables a private and a public DNS zone to share the same zone name.|

To resolve private DNS zone's records from your VNet, you must link the VNet with the zone. Linked VNets have full access and can resolve all DNS records published in the private zone. Additionally, you can also enable autoregistration on a VNet link. If you enable autoregistration, the DNS records for the VMs on that VNet are registered in the private zone. When autoregistration is enabled, Azure DNS also updates the zone records whenever a VM is created, changes its IP address, or is deleted.

The following table describes the Azure Private DNS features.

|Feature|Description|
|------------------------------------------------------------|------------------------------------------------------------|
|Enables automatic registration of VMs from a VNet that you link to a private zone|Your VMs are registered with your private zone as host (A) records that resolve to the VMs' private IP addresses. After you enable autoregistration, when you delete a VM in a VNet, Azure DNS removes the corresponding DNS record from the linked private zone automatically.|
|Azure supports forward DNS resolution across VNets that you link to your private zone|When you implement cross-VNet DNS name resolution, there's no explicit requirement for you to peer your VNets. You might still want to peer VNets for other reasons unrelated to DNS.|
|Azure supports reverse DNS lookup within the VNet scope|Reverse DNS lookup for a private IP address within a VNet that you assign to a private zone returns the host's fully qualified domain name (FQDN) that includes the host/record name and the zone name as the suffix.|

## Implement DNS with Azure IaaS VMs

Windows Server DNS servers attached to a VNet can forward DNS queries to the recursive resolvers in Azure. This enables you to resolve host names within that VNet.

For example, the Contoso IT team deploys a domain controller VM that also runs the DNS server role to Azure. In this case, the VM could respond to DNS queries for its on-premises domain. The VM could also forward all other queries to Azure. By forwarding queries, this allows Contoso's VMs to locate both their on-premises resources (via the domain controller) and Azure-provided host names (via the forwarder).

> [!NOTE]
> Azure provides access to its recursive DNS resolvers by using the following virtual IPv4 address: 168.63.129.16.

You can use DNS forwarding to:

- Enable DNS resolution between VNets.
- Enable your on-premises machines to resolve Azure-provided host names.

> [!TIP]
> To resolve a VM's host name, you must configure your DNS server to forward host name queries to Azure.

Because the DNS suffix is different in each VNet, you use conditional forwarding rules to send DNS queries to the correct VNet for resolution.

> [!NOTE]
> When you use your own DNS servers, Azure provides the ability to specify multiple DNS servers on each VNet.

The following diagram has two VNets and an on-premises network performing DNS resolution between VNets using forwarding.

![A diagram has an on-premises network and two VNets, each configured with its own DNS server. Queries for VNet1 and VNet2 from on-premises clients are forwarded to these DNS servers. Queries are then forwarded between these two DNS servers, and also to Azure DNS.](../media/m13-internet-vnet-domain-name-system.png)

## Additional reading

You can learn more by reviewing the following documents:

- [Delegation of DNS zones with Azure DNS](https://aka.ms/dns-domain-delegation?azure-portal=true).
- [What are the usage limits for Azure DNS?](https://aka.ms/usage-limits-for-azure-dns?azure-portal=true)
