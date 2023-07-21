You work for a manufacturing company and are moving resources into Azure. The database server must be accessible for clients in your on-premises network. Public resources, like web servers, must be accessible from the internet. You want to ensure that you plan IP addresses that support both these requirements.

In this unit, you explore the constraints and limitations for public and private IP addresses in Azure. You also look at the capabilities that are available in Azure to reassign IP addresses in your network.

## IP address types

In Azure, you can use two types of IP addresses:

- **Public IP addresses**
- **Private IP addresses**

Both types of IP addresses can be allocated in one of two ways:

- **Dynamic**
- **Static**

Let's take a closer look at how the IP address types work together.

## Public IP addresses

Use a public IP address for public-facing services. A public address can be either static or dynamic. A public IP address can be assigned to a VM, an internet-facing load balancer, a VPN gateway, or an application gateway.

- **Dynamic public IP addresses** are assigned addresses that can change over the lifespan of the Azure resource. The dynamic IP address is allocated when you create or start a VM. The IP address is released when you stop or delete the VM. In each Azure region, public IP addresses are assigned from a unique pool of addresses. The default allocation method is dynamic.

- **Static public IP addresses** are assigned addresses that don't change over the lifespan of the Azure resource. To ensure that the IP address for the resource remains the same, you can set the allocation method to static. In this case, an IP address is assigned immediately, and is released only when you delete the resource or change the IP allocation method to dynamic.

### SKUs for public IP addresses

For public IP addresses, there are two SKUs to choose from: **Basic** and **Standard**. All public IP addresses created before the introduction of SKUs are Basic SKU public IP addresses. With the introduction of SKUs, you can choose the scale, features, and pricing for load balancing internet traffic.

Both Basic and Standard SKUs have:

- A default inbound originated flow idle timeout of 4 minutes, which is adjustable to up to 30 minutes.
- A fixed outbound originated flow idle timeout of 4 minutes.

#### Basic SKU

Basic public IPs can be assigned by using static or dynamic allocation methods. Basic public IPs can be assigned to any Azure resource that can be assigned a public IP address. Including, network interfaces, VPN gateways, application gateways, and internet-facing load balancers.

 By default, Basic SKU IP addresses:

- Are open. Network security groups are recommended but optional for restricting inbound or outbound traffic.
- Are available for inbound only traffic.
- Are available when using instance meta data service (IMDS).
- Don't support Availability Zones.
- Don't support routing preferences.

#### Standard SKU

By default, Standard SKU IP addresses:

- Always use static allocation.
- Are secure, and thus closed to inbound traffic. You must enable inbound traffic by using a network security group.
- Are zone-redundant; and optionally zonal (they can be created as zonal and guaranteed in a specific availability zone).
- Can be assigned to network interfaces, Standard public load balancers, application gateways, or VPN gateways.
- Can be utilized with the routing preference to enable more granular control of how traffic is routed between Azure and the Internet.
- Can be used as anycast frontend IPs for cross-region load balancers.

For more information, see [SKU comparison](/azure/load-balancer/skus), Load Balancer [overview](/azure/load-balancer/load-balancer-standard-overview), and [components](/azure/load-balancer/components).

### Public IP address prefix

In Azure, a *public IP address prefix* is a reserved, static range of public IP addresses. Azure assigns an IP address from a pool of available addresses that's unique to each region in each Azure cloud. When you define a Public IP address prefix, associated public IP addresses are assigned from a pool for an Azure region.  

In a region with Availability Zones, Public IP address prefixes can be created as zone-redundant or associated with a specific availability zone.

The benefit of a public IP address prefix is that you can specify firewall rules for a known range of IP addresses. If your business needs to have datacenters in different regions, you need a different public IP address range for each region. You can assign the addresses from a public IP address prefix to any Azure resource that supports public IP addresses.

You can create a public IP address prefix by specifying a name and prefix size. The prefix size is the number of reserved addresses available for use.

- Public IP address prefixes consist of IPv4 or IPv6 addresses. 
- You can use technology like Azure Traffic Manager to balance region-specific instances.
- You can only bring your own public IP addresses from on-premises networks into Azure by using a [Custom IP address prefix (BYOIP)](/azure/virtual-network/ip-services/custom-ip-address-prefix).
- You can't specify addresses when you create a prefix; Azure assigns them. After a prefix is created, the IP addresses are fixed in a contiguous range.
- Public IP addresses can't be moved between regions; all IP addresses are region-specific.

## Private IP addresses

Private IP addresses are used for communication within an Azure Virtual Network, including virtual networks and your on-premises networks. Private IP addresses can be set to dynamic (DHCP lease) or static (DHCP reservation).

**Dynamic private IP addresses** are assigned through a DHCP lease and can change over the lifespan of the Azure resource.

**Static private IP addresses** are assigned through a DHCP reservation and don't change throughout the lifespan of the Azure resource. Static private IP addresses persist if a resource is stopped or deallocated.

## IP addressing for Azure virtual networks

In Azure, a virtual network is a fundamental component that acts as an organization's network. The administrator has full control over IP address assignment, security settings, and security rules. When you create a virtual network, you define a scope of IP addresses. Private IP addressing works the same way as it does in an on-premises network. You choose the private IP addresses that the Internet Assigned Numbers Authority (IANA) reserves based on your network requirements:

- 10.0.0.0/8
- 172.16.0.0/12  
- 192.168.0.0/16

A subnet is a range of IP address within the virtual network. You can divide a virtual network into multiple subnets. Each subnet must have a unique address range, which is specified in classless interdomain routing (CIDR) format. CIDR is a way to represent a block of network IP addresses. An IPv4 CIDR, specified as part of the IP address, shows the length of the network prefix.

Consider, for example, CIDR 192.168.10.0/24. "192.168.10.0" is the network address, and "24" indicates that the first 24 bits are part of the network address, leaving the last 8 bits for specific host addresses. The address range of a subnet can't overlap with other subnets in the virtual network or with the on-premises network.

For all subnets in Azure, the first three IP addresses are reserved by default. For protocol conformance, the first and last IP addresses of all subnets also are reserved. In Azure, an internal DHCP service assigns and maintains the lease of IP addresses. The `.1`, `.2`, `.3`, and last IP addresses aren't visible or configurable by the Azure customer. These addresses are reserved and used by internal Azure services.

In Azure virtual networks, IP addresses can be allocated to the following types of resources:

- Virtual machine network interfaces
- Load balancers
- Application gateways
