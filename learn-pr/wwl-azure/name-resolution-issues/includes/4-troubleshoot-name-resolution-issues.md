Name resolution in Azure is done by one of three methods: 

- Azure built-in name resolution  

- Azure custom name resolution

- Azure DNS private zones

In this unit you will learn how to troubleshoot each of these methods.

## 2.1 Troubleshoot built-in Azure name resolution

Built-in Azure name resolution provides basic authoritative DNS capabilities. DNS names and records are managed by Azure. Built-in Azure name resolution does not allow you to control the DNS names or the life cycle of DNS records.

Azure built-in name resolution works with public DNS names and provides internal name resolution for VMs and role instances within the same virtual network or cloud service.

Built-in Azure name resolution has some limitations:

- The Azure-created DNS suffix cannot be modified.

- DNS lookup is scoped to a virtual network. DNS names created for one virtual network can't be resolved from other virtual networks.

- You cannot manually register your own records.

- WINS and NetBIOS are not supported. You cannot see your VMs in Windows Explorer.

- Host names must be DNS-compatible. Names must use only 0-9, a-z, and '-', and cannot start or end with a '-'.

- DNS query traffic is throttled for each VM. Throttling shouldn't impact most applications. If request throttling is observed, ensure that client-side caching is enabled.

- Only VMs in the first 180 cloud services are registered for each virtual network in a classic deployment model. This limit does not apply to virtual networks in Azure Resource Manager.

- The Azure DNS IP address is 168.63.129.16. This is a static IP address, is used in all regions and all national clouds and will not change.

- Azure Dynamic Host Configuration Protocol (DHCP) provides an internal DNS suffix (.internal.cloudapp.net) to each VM. This suffix enables host name resolution because the host name records are in the internal.cloudapp.net zone.  

## 2.2 Troubleshoot DNS private zones

Azure Private DNS allows you to manage and resolve domain names in a virtual network without the need to add a custom DNS solution. You can use custom domain names, rather than the Azure-provided names.  

DNS resolution using a private DNS zone works only from virtual networks that are linked to it. These private DNS zones records cannot be resolved from the internet.  

You can link a private DNS zone to one or more virtual networks by creating [virtual network links](/azure/dns/private-dns-virtual-network-links). You can also enable the [autoregistration](/azure/dns/private-dns-autoregistration) feature to automatically manage the life cycle of the DNS records for the virtual machines that get deployed in a virtual network. With autoregistration enabled, Azure DNS will update the zone record whenever a virtual machine gets created, changes its' IP address, or gets deleted. 

NOTE: a Virtual Network can only have autoregistration enabled on one Private DNS Zone link. If you try to link two private DNS zones to the same VNet, only one of the links will be enabled for autoregistration.

![Diagram of private DNS zones on the same Vnet.](../media/2-link-dns-zones.png)

There are limits on how many private DNS zones you can create, how many records sets, and records per record set.

Single-labelled private DNS zones aren't supported. Your private DNS zone must have two or more labels. For example, contoso.com has two labels separated by a dot. A private DNS zone can have a maximum of 34 labels.

You can't create zone delegations (NS records) in a private DNS zone. If you intend to use a child domain, you can directly create the domain as a private DNS zone. Then you can link it to the virtual network without setting up a nameserver delegation from the parent zone.

To create a Private DNS zone:  

1. In the Azure portal, **type private dns zones** in the search text box and press **Enter**. The **Private DNS zones** blade is displayed.

1. Select **Create**. The **Create Private DNS** zone blade is displayed.

1. Type or select the following:

   1. Subscription

   1. Resource group

   1. Name – this must be unique within the Resource group.

   1. Resource group location

1. Select **Review + Create**.

1. Select **Create**.

To troubleshoot issues relating to DNS zones:

1. Review the Azure DNS audit logs.

1. Check that each DNS zone name is unique within its resource group.  

1. Do not create zone names that could affect the DNS resolution of Microsoft services, such as azure.com, and the like.

1. Do not use a .local domain for your private DNS zone. Not all operating systems support this.

1. Check you have not reached the maximum number of zones for your subscription. If so, you will see the error message "You have reached or exceeded the maximum number of zones in subscription {subscription ID}." Either use a different Azure subscription, delete some zones, or contact Azure Support to raise your subscription limit.

1. "The zone '{zone name}' is not available" indicates that Azure DNS is unable to allocate name servers for this DNS zone. Rename the zone or contact Azure support to allocate name servers for you.

To troubleshoot issues related to DNS records:

1. The record set already exists. Record set names must be unique within the zone.

1. CNAME records must not be created at the apex.

1. CNAME record sets cannot have the same name as other record sets.

1. Apex records consists of the ‘@’ character.

1. The maximum number of records that can be created is shown in the Azure portal, under the 'Properties' for the zone. If you've reached this limit, then either delete some record sets or contact Azure Support to raise your record limit for this zone.

> [!NOTE] 
> Apex records are records added at the root of the zone.

To troubleshoot resolving DNS records:

1. Check that the fully qualified name, zone name, and record type is correct.

1. Check that no DNS records have the same name, even if they are of different types.

1. Check that the DNS records resolve correctly on the Azure DNS name servers.

1. Check name resolution with a service such as **[digwebinterface](https://digwebinterface.com/)**. This tests the current state of the name servers by removing proxy servers and cached results.

1. Check that the name servers are correct for your DNS zone, as shown in the Azure portal.

1. Check that the DNS domain name has been correctly [delegated to Azure DNS](/azure/dns/dns-domain-delegation). Use nslookup to validate that the zone is delegated to in-built Azure DNS. 

> [!NOTE] 
> If your environment uses a hybrid approach and uses both private zone DNS and public zone, records in private zone DNS will be resolved first.

To troubleshoot resolving DNS records:

1. Check that the fully qualified name, zone name, and record type is correct.

1. Check that no DNS records have the same name, even if they are of different types.

1. Check that the DNS records resolve correctly on the Azure DNS name servers.

1. Check name resolution with a service such as [digwebinterface](https://digwebinterface.com/). This removes proxy servers and cached results, and only tests the current state of the name servers.

1. Check that the name servers are correct for your DNS zone, as shown in the Azure portal.

Azure Private DNS zones have the following limitations:

- If automatic registration of VM DNS is enabled, only one private zone can be linked to a virtual network. You can however link multiple virtual networks to a single DNS zone.

- Reverse DNS works only for private IP space in the linked virtual network.

- Reverse DNS for a private IP address in linked virtual network will return internal.cloudapp.net as the default suffix for the virtual machine. For virtual networks that are linked to a private zone with autoregistration enabled, reverse DNS for a private IP address returns two fully qualified domain names (FQDNs): one with default the suffix internal.cloudapp.net and another with the private zone suffix.

- Conditional forwarding isn't currently natively supported. To enable resolution between Azure and on-premises networks, see [Name resolution for VMs and role instances. ](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)

## 2.3 Troubleshoot custom DNS configuration issues

As well as Azure in-built DNS, you also have the option to configure a custom DNS server. For example, you might want to integrate with on-premises Active Directory or resolve names between VNets.

To use Azure custom DNS, you must add a list of IP addresses that point to DNS servers. This list will be distributed to any devices in the virtual network that were using the Azure DNS server.  

There are some limitations with Azure custom DNS:

- You cannot register a public domain name using Azure custom DNS.

- DNSSEC is not enabled.

- You cannot do zone transfers.

>[!NOTE] 
> Updating from in-built DNS (Inherit from virtual network) to custom DNS will restart all affected VMs.

In DNS settings, you can choose whether to inherit DNS settings from the virtual network or use custom DNS. Check that you have saved any change from Azure in-built DNS to custom DNS, otherwise, the changes will not persist.

To test whether custom DNS is working, use the PowerShell command:
```
test-netconnection -computername -port  
```
To check your custom DNS is using the correct DNS server, from a command prompt type:
```
Ipconfig /all
```