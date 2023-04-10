Public networks like the Internet communicate by using public IP addresses. Private networks like your Azure Virtual Network use private IP addresses, which aren't routable on public networks. To support a network that exists both in Azure and on-premises, you must configure IP addressing for both types of networks.

Public IP addresses enable Internet resources to communicate with Azure resources and enable Azure resources to communicate outbound with Internet and public-facing Azure services. A public IP address in Azure is dedicated to a specific resource, until it's unassigned by a network engineer. A resource without a public IP assigned can communicate outbound through network address translation services, where Azure dynamically assigns an available IP address that isn't dedicated to the resource.

As an example, public resources like web servers must be accessible from the internet. You want to ensure that you plan IP addresses that support these requirements.

In this unit, you'll learn about requirements for IP addressing when integrating an Azure network with on-premises networks, and you'll explore the constraints and limitations for public and private IP addresses in Azure. You also will look at the capabilities that are available in Azure to reassign IP addresses in your network.

## Use dynamic and static public IP addresses

In Azure Resource Manager, a [public IP](/azure/virtual-network/virtual-network-public-ip-address) address is a resource that has its own properties. Some of the resources you can associate a public IP address resource with:

 -  Virtual machine network interfaces 
 -  Virtual machine scale sets
 -  Public Load Balancers
 -  Virtual Network Gateways (VPN/ER)
 -  NAT gateways
 -  Application Gateways
 -  Azure Firewall
 -  Bastion Host
 -  Route Server 

Public IP addresses are created with an IPv4 or IPv6 address, which can be either static or dynamic.

**A dynamic public IP address** is an assigned address that can change over the lifespan of the Azure resource. The dynamic IP address is allocated when you create or start a VM. The IP address is released when you stop or delete the VM. In each Azure region, public IP addresses are assigned from a unique pool of addresses. The default allocation method is dynamic.

**A static public IP address** is an assigned address that won't change over the lifespan of the Azure resource. To ensure that the IP address for the resource remains the same, set the allocation method explicitly to static. In this case, an IP address is assigned immediately. It's released only when you delete the resource or change the IP allocation method to dynamic.

## Choose the appropriate SKU for a public IP address

Public IP addresses are created with one of the following SKUs:

| Public IP address | **Standard** | **Basic**|
| --- | --- |--- |
| Allocation method | Static | 	For IPv4: Dynamic or Static; For IPv6: Dynamic. |
| Idle Timeout | Have an adjustable inbound originated flow idle timeout of 4-30 minutes, with a default of 4 minutes, and fixed outbound originated flow idle timeout of 4 minutes. | 	Have an adjustable inbound originated flow idle timeout of 4-30 minutes, with a default of 4 minutes, and fixed outbound originated flow idle timeout of 4 minutes. |
|Security |	Secure by default model and be closed to inbound traffic when used as a frontend. Allow traffic with network security group (NSG) is required (for example, on the NIC of a virtual machine with a Standard SKU Public IP attached).	|Open by default. Network security groups are recommended but optional for restricting inbound or outbound traffic|
|Availability zones	| Supported. Standard IPs can be non-zonal, zonal, or zone-redundant. Zone redundant IPs can only be created in regions where 3 availability zones are live. IPs created before zones are live won't be zone redundant.|	Not supported.|
|Routing preference	| Supported to enable more granular control of how traffic is routed between Azure and the Internet.|	Not supported.|
|Global tier |	Supported via cross-region load balancers.|	Not supported.|


## Create a public IP address prefix

Public IP prefixes are assigned from a pool of addresses in each Azure region. You create a public IP address prefix in an Azure region and subscription by specifying a name and prefix size. The prefix size is the number of addresses available for use. Public IP address prefixes consist of IPv4 or IPv6 addresses. In regions with Availability Zones, Public IP address prefixes can be created as zone-redundant or associated with a specific availability zone. After the public IP prefix is created, you can create public IP addresses.

## Custom IP address prefix (BYOIP)

Addresses from a custom IP address prefix can be used in the same way as Azure owned public IP address prefixes. Addresses from a custom IP address prefix can be associated to Azure resources, interact with internal/private IPs and virtual networks, and reach external destinations outbound from the Azure Wide Area Network.


## Check your knowledge

Choose the best response for each of the questions below. When you're done, select **Check your answers**.