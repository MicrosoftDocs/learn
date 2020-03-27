In your manufacturing company, you are moving resources into Azure, starting with a database server. You want to ensure that the database server is accessible for clients in your on-premises network. Public resources like web servers must be accessible from the internet. You want to ensure that you plan IP addresses that support these requirements.

In this unit, you'll explore the constraints and limitations for public and private IP addresses in Azure. You also will look at the capabilities that are available in Azure to reassign IP addresses in your network.

## IP address types

There are two types of IP addresses that you can use in Azure:

- **Public IP addresses**
- **Private IP addresses**

Both types of IP addresses can be allocated in one of two ways:

- **Dynamic**
- **Static**

Let's take a closer look at how the IP address types work together.

## Public IP addresses

Use a public IP address for public-facing services. A public address can be either static or dynamic. A public IP address can be assigned to a VM, an internet-facing load balancer, a VPN gateway, or an application gateway.

**Dynamic public IP addresses** are assigned addresses that can change over the lifespan of the Azure resource. The dynamic IP address is allocated when you create or start a VM. The IP address is released when you stop or delete the VM. In each Azure region, public IP addresses are assigned from a unique pool of addresses. The default allocation method is dynamic.

**Static public IP addresses** are assigned addresses that will not change over the lifespan of the Azure resource. To ensure that the IP address for the resource remains the same, you can set the allocation method explicitly to static. In this case, an IP address is assigned immediately. It is released only when you delete the resource or change the IP allocation method to dynamic.

### Basic and Standard SKUs

For public IP addresses, there are two types of SKUs to choose from: **Basic** and **Standard**. All public IP addresses created before the introduction of SKUs are Basic SKU public IP addresses. With the introduction of SKUs, you have the option to specify which SKU you would like the public IP address to be.

#### Basic

Basic public IPs can be assigned by using static or dynamic allocation methods. Basic IPs have an adjustable inbound originated flow idle timeout of 4-30 minutes, with a default of 4 minutes, and a fixed outbound originated flow idle timeout of 4 minutes. Basic IPs are open by default. We recommend that you use network security groups to restrict inbound or outbound traffic. Network security groups are recommended but optional for restricting inbound or outbound traffic.

Basic public IPs can be assigned to any Azure resource that can be assigned a public IP address, such as network interfaces, VPN gateways, application gateways, and internet-facing load balancers. They do not support availability zone scenarios. You must use a Standard SKU public IP for an availability zone scenario.

#### Standard

Standard SKU public IP addresses always use the static allocation method. They have an adjustable inbound originated flow idle timeout of 4-30 minutes, with a default of 4 minutes, and a fixed outbound originated flow idle timeout of 4 minutes.

Standard IPs are secure by default and closed to inbound traffic. You must explicitly allow inbound traffic by using a network security group.

Standard IPs can be assigned to network interfaces, Standard public load balancers, application gateways, or VPN gateways. For more information about Standard load balancers, see [Azure Standard Load Balancer overview](https://docs.microsoft.com/azure/load-balancer/load-balancer-standard-overview). Standard IPs are zone-redundant by default and optionally zonal (they can be created zonal and guaranteed in a specific availability zone).

### Public IP address prefix

You can't bring your own public IP addresses from on-premises networks into Azure. Based on the location of the resource, an IP address is assigned from a pool of available addresses. Public IP addresses are allocated from a range that's unique to each region in each Azure cloud. Public IP addresses can't be moved between regions; all IP addresses are region-specific. If your business needs to have datacenters in different regions, you would have a different public IP address range for each region. You can use technology like Azure Traffic Manager to balance between region-specific instances.

To ensure a static range of public IP addresses, you can create a public IP address prefix. You can't specify the addresses when you create the prefix, but after the prefix is created, the addresses will be fixed. The IP addresses will be a contiguous range. The advantage of a public IP address prefix is that you can specify firewall rules for these IP addresses with the knowledge that they will not change. You can assign the addresses from a public IP address prefix to any resource in Azure that supports public IP addresses.

## Private IP addresses

Private IP addresses are used for communication within a virtual network. Private IP addresses are used within Azure Virtual Network virtual networks and your on-premises networks. They can be set to dynamic (DHCP lease) or static (DHCP reservation).

**Dynamic private IP addresses** are assigned through a DHCP lease and can change over the lifespan of the Azure resource.

**Static private IP addresses** are assigned through a DHCP reservation and do not change throughout the lifespan of the Azure resource. Static private IP addresses persist if a resource is stopped or deallocated.

## IP addressing for Azure virtual networks

A virtual network is a fundamental component that acts as an organization's network in Azure. In the virtual network, the administrator has full control over the IP address assignment, security settings, and security rules. When you create a virtual network, you define a scope of IP addresses. Private IP addressing in Azure works the same way as it does in the on-premises network. You choose the private IP addresses that are reserved by the Internet Assigned Numbers Authority (IANA) based on your network requirements:

- 10.0.0.0/8
- 172.16.0.0/12  
- 192.168.0.0/16

A subnet is a range of IP address within the virtual network. You can divide the virtual network into multiple subnets. Each subnet must have a unique address range, which is specified in classless inter-domain routing (CIDR) format. CIDR is a way to represent a block of network IP addresses. An IPv4 CIDR, specified as part of the IP address, shows the length of the network prefix.

Consider, for example, the CIDR 192.168.10.0/24. "192.168.10.0" is the network address. The "24" indicates that the first 24 bits are part of the network address, leaving the last 8 bits for specific host addresses. The address range can't overlap with other subnets in the virtual network or with the on-premises network.

The first three IP addresses are reserved for all subnets by default in Azure. For protocol conformance, the first and last IP addresses of all subnets also are reserved. An internal DHCP service within Azure assigns and maintains the lease of IP addresses. The .1, .2, .3, and last IP addresses are not visible or configurable by the Azure customer. These addresses are reserved and used by internal Azure services. 

In Azure virtual networks, IP addresses can be allocated to the following types of resources:

- Virtual machine network interfaces
- Load balancers
- Application gateways
