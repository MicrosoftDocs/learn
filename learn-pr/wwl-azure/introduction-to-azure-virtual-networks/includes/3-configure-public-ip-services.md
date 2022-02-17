Public networks like the Internet communicate by using public IP addresses. Private networks like your Azure Virtual Network use private IP addresses, which are not routable on public networks. To support a network that exists both in Azure and on-premises, you must configure IP addressing for both types of networks.

Public IP addresses enable Internet resources to communicate with Azure resources and enable Azure resources to communicate outbound with Internet and public-facing Azure services. A public IP address in Azure is dedicated to a specific resource, until it's unassigned by a network engineer. A resource without a public IP assigned can communicate outbound through network address translation services, where Azure dynamically assigns an available IP address that isn't dedicated to the resource.

As an example, public resources like web servers must be accessible from the internet. You want to ensure that you plan IP addresses that support these requirements.

In this unit, you will learn about requirements for IP addressing when integrating an Azure network with on-premises networks, and you'll explore the constraints and limitations for public and private IP addresses in Azure. You also will look at the capabilities that are available in Azure to reassign IP addresses in your network.

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

**A static public IP address** is an assigned address that will not change over the lifespan of the Azure resource. To ensure that the IP address for the resource remains the same, set the allocation method explicitly to static. In this case, an IP address is assigned immediately. It is released only when you delete the resource or change the IP allocation method to dynamic.

## Choose the appropriate SKU for a public IP address

For public IP addresses, there are two types of SKUs to choose from: Basic and Standard. All public IP addresses created before the introduction of SKUs are Basic SKU public IP addresses. With the introduction of SKUs, you have the option to specify which SKU you would like the public IP address to be.

### Basic SKU

Basic SKU public IPs can be assigned by using static or dynamic allocation methods. Basic IPs have an adjustable inbound originated flow idle timeout of 4-30 minutes, with a default of 4 minutes, and a fixed outbound originated flow idle timeout of 4 minutes. Basic IPs are open by default, so the use of Network security groups is recommended but optional for restricting inbound or outbound traffic.

Basic public IPs can be assigned to any Azure resource that can be assigned a public IP address, such as network interfaces, VPN gateways, application gateways, and internet-facing load balancers. They do not support availability zone scenarios. You must use a Standard SKU public IP for an availability zone scenario.

### Standard SKU

Standard SKU public IP addresses always use the static allocation method. They have an adjustable inbound originated flow idle timeout of 4-30 minutes, with a default of 4 minutes, and a fixed outbound originated flow idle timeout of 4 minutes.

Standard IPs are secure by default and closed to inbound traffic. You must explicitly allow inbound traffic by using a network security group.

Standard IPs can be assigned to network interfaces, Standard public load balancers, application gateways, or VPN gateways. Standard IPs are zone-redundant by default and optionally zonal (they can be created zonal and guaranteed in a specific availability zone).

## Create a public IP address prefix

You can't bring your own public IP addresses from on-premises networks into Azure. Instead, an IP address is assigned from a pool of available addresses, based on the location of the resource. Public IP addresses are allocated from a range that's unique to each region in each Azure cloud. Public IP addresses can't be moved between regions; all IP addresses are region-specific. If your business needs to have datacenters in different regions, you will have a different public IP address range for each region. You can use technology like Azure Traffic Manager to balance traffic between region-specific instances.

To ensure a static range of public IP addresses, you can create a public IP address prefix. You can't specify the addresses when you create the prefix, but after the prefix is created, the addresses will be fixed. The IP addresses will be a contiguous range. The advantage of a public IP address prefix is that you can specify firewall rules for these IP addresses with the knowledge that they will not change. You can assign the addresses from a public IP address prefix to any resource in Azure that supports public IP addresses.

## Check your knowledge

Choose the best response for each of the questions below. When you're done, select **Check your answers**.