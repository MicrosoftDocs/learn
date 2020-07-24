


At Contoso, name resolution needs go beyond the capabilities of Azure DNS because the company uses an on-premises AD DS infrastructure. To support this environment, they need to implement DNS in Windows Server VMs.

There are a number of other scenarios in which you might also decide to implement DNS by using Windows Server IaaS. This might be in addition to, or in-place of Azure DNS. Scenarios might include:

- Configuring name resolution between VMs in different VNets.
- Configuring name resolution of Azure hostnames from on-premises computers.
- Implementing conditional forwarding.
- Implementing DNS zone transfers.

## Implement DNS in Windows Server

Windows Server DNS servers that are attached to a VNet can forward DNS queries to the recursive resolvers in Azure. This enables you to resolve host names within that VNet.

For example, if Contoso deployed a domain controller VM in Azure, the VM could respond to DNS queries for its on-premises domain. The VM could also forward all other queries to Azure. By forwarding queries, Contoso's VMs can access both their on-premises resources (via the domain controller) and Azure-provided hostnames (via the forwarder).

>[!NOTE] 
> Azure provides access to its recursive DNS resolvers by using the virtual IPv4 address 168.63.129.16.

You can use DNS forwarding to:

- Enable DNS resolution between VNets.
- Enable your on-premises machines to resolve Azure-provided hostnames.


To resolve a VM's host name, your DNS server VM must meet the following requirements:

- It must reside in the same VNet as the VM.
- It must be configured to forward host name queries to Azure.

Because the DNS suffix is different in each VNet, you use conditional forwarding rules to send DNS queries to the correct VNet for resolution.

> [!NOTE] 
> When you use your own DNS servers, Azure provides the ability to specify multiple DNS servers on each VNet.

The following image displays two VNets and an on-premises network doing DNS resolution between VNets, by using this method.

![A diagram demonstrates DNS resolution between VNets using this method. Two VNets labeled VNet1 and VNet2 are both configured with a DNS server. Queries for VNet1 and VNet2 from on-premises clients are forwarded to these DNS servers. Queries are forwarded between these two DNS servers, and also to Azure DNS.](../media/m7-internet-virtual-network-domain-name-system.png)


## Additional reading

You can learn more by reviewing the following document.

- [Name resolution for resources in Azure virtual networks](https://aka.ms/name-resolution-that-uses-your-own-dns-server?azure-portal=true).
