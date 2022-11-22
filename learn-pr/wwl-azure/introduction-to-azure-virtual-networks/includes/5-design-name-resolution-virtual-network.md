Depending on how you use Azure to host IaaS, PaaS, and hybrid solutions, you might need to allow the virtual machines (VMs), and other resources deployed in a virtual network to communicate with each other. Although you can enable communication by using IP addresses, it is much simpler to use names that can be easily remembered, and do not change.

DNS is split into two areas: Public, and Private DNS for resources accessible from your own internal networks.

## Public DNS services

Public DNS services resolve names and IP addresses for resources and services accessible over the internet such as web servers. Azure DNS is a hosting service for DNS domain that provides name resolution by using Microsoft Azure infrastructure. DNS domains in Azure DNS are hosted on Azure's global network of DNS name servers. Azure DNS uses anycast networking. Each DNS query is answered by the closest available DNS server to provide fast performance and high availability for your domain.

In Azure DNS, you can create address records manually within relevant zones. The records most frequently used will be:

 -  Host records: A/AAAA (IPv4/IPv6)
 -  Alias records: CNAME

Azure DNS provides a reliable, secure DNS service to manage and resolve domain names in a virtual network without needing to add a custom DNS solution.

A DNS zone hosts the DNS records for a domain. So, to start hosting your domain in Azure DNS, you need to create a DNS zone for that domain name. Each DNS record for your domain is then created inside this DNS zone.

## Considerations

 -  The name of the zone must be unique within the resource group, and the zone must not exist already.
 -  The same zone name can be reused in a different resource group or a different Azure subscription.
 -  Where multiple zones share the same name, each instance is assigned different name server addresses.
 -  Root/Parent domain is registered at the registrar and pointed to Azure NS.
 -  Child domains are registered in AzureDNS directly.

> [!NOTE]
> 
> You do not have to own a domain name to create a DNS zone with that domain name in Azure DNS. However, you do need to own the domain to configure the domain.

## Delegate DNS Domains

To delegate your domain to Azure DNS, you first need to know the name server names for your zone. Each time a DNS zone is created Azure DNS allocates name servers from a pool. Once the Name Servers are assigned, Azure DNS automatically creates authoritative NS records in your zone.

Once the DNS zone is created, and you have the name servers, you need to update the parent domain. Each registrar has their own DNS management tools to change the name server records for a domain. In the registrar’s DNS management page, edit the NS records and replace the NS records with the ones Azure DNS created.

> [!NOTE]
> 
> When delegating a domain to Azure DNS, you must use the name server names provided by Azure DNS. You should always use all four name server names, regardless of the name of your domain.

## Child Domains

If you want to set up a separate child zone, you can delegate a subdomain in Azure DNS. For example, after configuring contoso.com in Azure DNS, you could configure a separate child zone for partners.contoso.com.

Setting up a subdomain follows the same process as typical delegation. The only difference is that NS records must be created in the parent zone contoso.com in Azure DNS, rather than in the domain registrar.

> [!NOTE]
> 
> The parent and child zones can be in the same or different resource group. Notice that the record set name in the parent zone matches the child zone name, in this case *partners*.

It's important to understand the difference between DNS record sets and individual DNS records. A record set is a collection of records in a zone that have the same name and are the same type.

:::image type="content" source="../media/dns-record-set-1-1f2861b3.png" alt-text="Screenshot of the Add a record set page.":::


A record set cannot contain two identical records. Empty record sets (with zero records) can be created, but do not appear on the Azure DNS name servers. Record sets of type CNAME can contain one record at most.

The **Add record set** page will change depending on the type of record you select. For an A record, you will need the TTL (Time to Live) and IP address. The time to live, or TTL, specifies how long each record is cached by clients before being requeried.

:::image type="content" source="../media/dns-record-set-2-dbd92ba6.png" alt-text="Screenshot of the Add a record page.":::


## Private DNS services

Private DNS services resolve names and IP addresses for resources and services

When resources deployed in virtual networks need to resolve domain names to internal IP addresses, they can use one the three methods:

 -  Azure DNS Private Zones
 -  Azure-provided name resolution
 -  Name resolution that uses your own DNS server

The type of name resolution you use depends on how your resources need to communicate with each other.

Your name resolution needs might go beyond the features provided by Azure. For example, you might need to use Microsoft Windows Server Active Directory domains, resolve DNS names between virtual networks. To cover these scenarios, Azure provides the ability for you to use your own DNS servers.

DNS servers within a virtual network can forward DNS queries to the recursive resolvers in Azure. This enables you to resolve host names within that virtual network. For example, a domain controller (DC) running in Azure can respond to DNS queries for its domains and forward all other queries to Azure. Forwarding queries allows VMs to see both your on-premises resources (via the DC) and Azure-provided host names (via the forwarder). Access to the recursive resolvers in Azure is provided via the virtual IP 168.63.129.16.

DNS forwarding also enables DNS resolution between virtual networks and allows your on-premises machines to resolve Azure-provided host names. In order to resolve a VM's host name, the DNS server VM must reside in the same virtual network and be configured to forward host name queries to Azure. Because the DNS suffix is different in each virtual network, you can use conditional forwarding rules to send DNS queries to the correct virtual network for resolution. 


### Azure provided DNS

Azure provides its own default internal DNS. It provides an internal DNS zone that always exists, supports automatic registration, requires no manual record creation, and is created when the VNet is created. And it's a free service. Azure provided name resolution provides only basic authoritative DNS capabilities. If you use this option, the DNS zone names and records will be automatically managed by Azure, and you will not be able to control the DNS zone names or the life cycle of DNS records.

Internal DNS defines a namespace as follows: .internal.cloudapp.net.

Any VM created in the VNet is registered in the internal DNS zone and gets a DNS domain name like myVM.internal.cloudapp.net. It's important to recognize that it's the Azure Resource name that is registered, not the name of the guest OS on the VM.

**Limitations of Internal DNS**

 -  Can't resolve across different VNets.
 -  Registers resource names, not guest OS names.
 -  Does not allow manual record creation.

### Azure Private DNS Zones

Private DNS zones in Azure are available to internal resources only. They are global in scope, so you can access them from any region, any subscription, any VNet, and any tenant. If you have permission to read the zone, you can use it for name resolution. Private DNS zones are highly resilient, being replicated to regions all throughout the world. They are not available to resources on the internet.

For scenarios which require more flexibility than Internal DNS allows, you can create your own private DNS zones. These zones enable you to:

 -  Configure a specific DNS name for a zone.
 -  Create records manually when necessary.
 -  Resolve names and IP addresses across different zones.
 -  Resolve names and IP addresses across different VNets.

### Create a private DNS zone by using the portal

You can create a private DNS zone using the Azure portal, Azure PowerShell, or Azure CLI. 
:::image type="content" source="../media/search-private-dns-ff4a44fc.png" alt-text="Azure portal - create private DNS zone.":::


When the new DNS zone is deployed, you can manually create resource records, or use auto-registration, which will create resource records based on the Azure resource name.

Private DNS zones support the full range of records including pointers, MX, SOA, service, and text records.

### Link VNets to private DNS zones

In Azure, a VNet represents a group of 1 or more subnets, as defined by a CIDR range. Resources such as VMs are added to subnets.

At the VNet level, default DNS configuration is part of the DHCP assignments made by Azure, specifying the special address 168.63.129.16 to use Azure DNS services.

If necessary, you can override the default configuration by configuring an alternate DNS server at the VM NIC.

:::image type="content" source="../media/dns-config-4456c8a1.png" alt-text="DNS default configuration.":::


Two ways to link VNets to a private zone:

 -  **Registration:** Each VNet can link to one private DNS zone for registration. However, up to 100 VNets can link to the same private DNS zone for registration.
 -  **Resolution:** There may be many other private DNS zones for different namespaces. You can link a VNet to each of those zones for name resolution. Each VNet can link to up to 1000 private DNS Zones for name resolution.

:::image type="content" source="../media/dns-zones-d964f066.png" alt-text="VNet is linked to a private DNS zone for registration and up to 100 private DNS zones for resolution.":::


### Integrating on-premises DNS with Azure VNets

If you have an external DNS server, for example an on-premises server, you can use custom DNS configuration on your VNet to integrate the two.

Your external DNS can run on any DNS server: BIND on UNIX, Active Directory Domain Services DNS, and so on. If you want to use an external DNS server and not the default Azure DNS service, you must configure the desired DNS servers.

Organizations often use an internal Azure private DNS zone for auto registration, and then use a custom configuration to forward queries external zones from an external DNS server.

Forwarding takes two forms:

 -  Forwarding - specifies another DNS server (SOA for a zone) to resolve the query if the initial server cannot.
 -  Conditional forwarding - specifies a DNS server for a named zone, so that all queries for that zone are routed to the specified DNS server.

> [!NOTE]
>  If the DNS server is outside Azure, it doesn't have access to Azure DNS on 168.63.129.16. In this scenario, setup a DNS resolver inside your VNet, forward queries for to it, and then have it forward queries to 168.63.129.16 (Azure DNS). Essentially, you're using forwarding because 168.63.129.16 is not routable, and therefore not accessible to external clients.

:::image type="content" source="../media/external-dns-fwd-7c81c29f.png" alt-text="On-premises DNS server uses conditional forwarding to forward queries for VNet 1. DNS resolver in VNet 1 sends queries to Azure DNS for resolution.":::


## Check your knowledge

Choose the best response for each of the questions below. When you're done, select **Check your answers**.