In your manufacturing company, you are moving resources into Azure, starting with a database server. You want to ensure that the database server is accessible for clients in your on-premises network. Public resources, such as web servers, must be accessible from the internet. You want to ensure that you plan IP addresses that support these requirements.

In this unit, you'll explore the constraints and limitations for public and private addresses in Azure. You will also look at the capabilities available in Azure to reassign IP addresses in your network.

## IP address types

There are two types of IP address that you can use within Azure:

- **Public IP addresses**
- **Private IP addresses**

For both types of IP addresses, they can be allocated in one of two ways:

- **Dynamic**
- **Static**

Let's take a closer look at how these work together.

## Public IP addresses

Use a public IP address for public-facing services. A public address can be either static or dynamic and assigned to a VM, an internet-facing load balancer, a VPN gateway, or an application gateway.

**Dynamic public IP addresses** are assigned addresses that can change over the lifespan of the Azure resource. The dynamic IP address is allocated when you create or start a VM. The IP address is released when you stop or delete the VM. In each Azure region, public IP addresses are assigned from a unique pool of addresses. The default allocation method is dynamic.

**Static public IP addresses** are assigned addresses that will not change over the lifespan of the Azure resource. To ensure the IP address for the resource remains the same, you can set the allocation method explicitly to static. In this case, an IP address is assigned immediately. It is released only when you delete the resource or change the IP allocation method to dynamic.

### Basic and Standard SKU

For public IP addresses, there are two types of SKUs to choose from: **Basic** and **Standard**. All public IP addresses created before the introduction of SKUs are Basic SKU public IP addresses. With the introduction of SKUs, you have the option to specify which SKU you would like the public IP address to be.

#### Basic

Basic public IPs can be assigned with the static or dynamic allocation method. They have an adjustable inbound originated flow idle timeout of 4-30 minutes, with a default of 4 minutes, and fixed outbound originated flow idle timeout of 4 minutes. Basic IPs are open by default. It's recommended to use network security groups to restrict inbound or outbound traffic. Network security groups are recommended but optional for restricting inbound or outbound traffic.

Basic public IPs can be assigned to any Azure resource that can be assigned a public IP address, such as network interfaces, VPN Gateways, Application Gateways, and Internet-facing load balancers. The do not support availability zone scenarios. You need to use Standard SKU public IP for availability zone scenarios.

#### Standard

Standard SKU public IP addresses always use static allocation method. They have an adjustable inbound originated flow idle timeout of 4-30 minutes, with a default of 4 minutes, and fixed outbound originated flow idle timeout of 4 minutes.

Standard IPs are secure by default and closed to inbound traffic. You must explicitly allow inbound traffic with a network security group.

They can be assigned to network interfaces, Standard public Load Balancers, Application Gateways, or VPN Gateways. For more information about Standard Load Balancer, see Azure Standard Load Balancer. Standard IPs are zone redundant by default and optionally zonal (can be created zonal and guaranteed in a specific availability zone).

### Public IP address prefix

You cannot bring your own public IP addresses from on-premises networks into Azure. Based on the location of the resource, the IP address is assigned from a pool of available addresses. Public IP addresses are allocated from a range unique to each region in each Azure cloud. Public IP addresses cannot be moved between regions, all addresses are region-specific. If your business needs to have data centers in different regions, you would have a different public IP address range for each region. You can use technology such as Azure traffic manager to balance between the region-specific instances.

To ensure a static range of public IP addresses, you can create a public IP address prefix. You cannot specify the addresses at time of creation, but after creation the addresses will be fixed. The IP addresses will be a contiguous range. The advantage of a public IP address prefix is that you can specify firewall rules for these IP addresses with the knowledge that they will not change. You can assign the addresses from a public IP address prefix to any resource in Azure that supports public IP addresses.

## Private IP addresses

Private IP addresses are used for communication within a virtual network. Private IP addresses are used within Azure Virtual Networks (virtual networks) and your on-premises networks. They can be set to dynamic (DHCP lease) or static (DHCP reservation).

**Dynamic private IP addresses** are assigned through a DHCP lease and can change over the lifespan of the Azure resource.

**Static public IP addresses** are assigned through a DHCP reservation, and do not change through the lifespan of the Azure resource. They will persist if a resource is stopped or deallocated.

## IP addressing for Azure virtual networks

A virtual network is a fundamental component that acts as an organization's network in Azure, where the administrator can have full control over the IP address assignment, security settings, and security rules. When you create a virtual network, you define a scope of IP address. Private IP addressing in Azure works the same way as it does on the on-premises network. You choose the private IP addresses reserved by Internet Assigned Numbers Authority (IANA) based on your network requirements:

- 10.0.0.0/8
- 172.16.0.0/12  
- 192.168.0.0/16

A subnet is a range of IP address within the virtual network. You can divide the virtual network into multiple subnets. Each subnet must have a unique address range, specified in CIDR format. CIDR is a way to represent a network IP block. An IPv4 CIDR, specified as part of the IP address, shows the length of the network prefix.

Consider, for example, the CIDR 192.168.10.0/24. "192.168.10.0" is the network address. The "24" indicates that the first 24 bits are part of the network address, leaving the last 8 bits for specific host addresses. The address range cannot overlap with other subnets in the virtual network or with the on-premises network.

The first three IP addresses are reserved for all subnets by default in Azure. For protocol conformance, first and last IP addresses of all subnets are also reserved. Internal DHCP service within Azure assigns and maintains the lease of IP addresses. The .1, .2, .3, and last IP address are not visible or configurable by the Azure customer. These addresses are reserved and used by internal Azure services. 

In Azure virtual networks, IP addresses can be allocated to the following types of resources:

- Virtual machine network interfaces
- Load balancers
- Application gateways
