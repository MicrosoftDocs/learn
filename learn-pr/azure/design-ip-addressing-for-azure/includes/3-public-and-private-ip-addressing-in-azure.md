An administrator who wants to create Virtual Machines (VMs) in Azure must understand how to assign IP addresses appropriately.

In your manufacturing company, you are moving resources into Azure, starting with a database server. You want to ensure that the database server is accessible for clients in your on-premises network. Public resources, such as web servers, must be accessible from the Internet. You want to ensure that you plan IP addresses that support these requirements.

In this unit, you'll explore the constraints and limitations for public and private addresses in Azure. You will also look at the capabilities available in Azure to reassign IP addresses in your network.

## Public and private IP addresses

There are two types of IP address that you can use within Azure:

- **Public IP addresses.** Public IP addresses help resources to communicate with the Internet. 
- **Private IP addresses.** Private IP addresses are used for communication within a local area network. 

### Public IP addresses

Use a public IP address for public-facing services. A public address can be either static or dynamic and assigned to a VM, an internet-facing load balancer, a VPN gateway, or an application gateway.

- **Dynamic public IP addresses** The default allocation method is dynamic. The dynamic IP address is allocated when you create or start a VM. The IP address is released when you stop or delete the VM. In each Azure region, public IP addresses are assigned from a unique pool of addresses. The public IP prefix is available in these regions:

    - West Central US
    - West US
    - West US 2
    - Central US
    - North Europe
    - West Europe
    - Southeast Asia

    Azure does not let you specify the public IP addresses for the prefix. Public IP addresses are allocated based on the size you specify. Once the prefix has been created, it cannot be changed. All addresses can only be assigned to Azure Resource Manager resources. All addresses from the prefix must exist and be assigned to resources in the same Azure region and subscription as the prefix. The prefix range only supports IPv4 addresses. A prefix can't be deleted if any addresses within it are assigned to public IP address resources. In order to delete a prefix, dissociate all IP addresses from the prefix first.

- **Static public IP addresses** To ensure the IP address for the resource remains the same, you can set the allocation method explicitly to static. In this case, an IP address is assigned immediately. It is released only when you delete the virtual machine or change its allocation method to dynamic.  You cannot bring your own public IP addresses from on-premises networks into Azure. 
 
 Even with static allocation method, Azure does not let you specify the actual IP address. Based on the location of the resource, the IP address is assigned from a pool of available addresses. Public IP addresses are allocated from a range unique to each region in each Azure cloud. Public IP addresses cannot be moved between regions, all addresses are region-specific. If your business needs to have data centers in different regions, you would have a different public IP address range for each region. You can use technology such as Azure traffic manager to balance between the region-specific instances. Azure services such as SQL or Azure storage are addressed across regions based on region-specific public IP.

- **Public IP address prefix** To ensure a static range of IP addresses, you can create a public IP address prefix. You cannot specify the addresses at time of creation, but after creation the addresses will be fixed. The IP addresses will be a contiguous range. The advantage of a public IP address prefix is that you can specify firewall rules for these IP addresses with the knowledge that they will not change. You can assign the addresses from a public IP address prefix to any resource in Azure that supports public IP addresses.


### Private IP addresses

Private IP addresses are used for communication within a virtual network. Private IP addresses are used within Azure Virtual Networks (virtual networks) and your on-premises networks. They can be set to dynamic (DHCP lease) or static (DHCP reservation). In the Azure Resource Manager, a private IP address is allocated to the following types of resources:

- Virtual machine network interfaces
- Internal load balancers
- Application gateways

In Azure Resource Manager, you can have:

- 1,000 Virtual networks. 
- 3,000 subnets per virtual network.
- 65,536 private IP addresses per virtual network.
- 25,000 VMs per subscription and region.

A virtual network is a fundamental component that acts as an organization's network in Azure, where the administrator can have full control over the IP address assignment, security settings, and security rules. When you create a virtual network, you define a scope of IP address. Private IP addressing in Azure works the same way as it does on the on-premises network. You choose the private IP addresses reserved by Internet Assigned Numbers Authority (IANA) based on your network requirements:

- 10.0.0.0 /8
- 172.16.0.0 /12  
- 192.168.0.0 /16

A subnet is a range of IP address within the virtual network. You can divide the virtual network into multiple subnets. Each subnet must have a unique address range, specified in CIDR format. CIDR is a way to represent a network IP block. An IPv4 CIDR, specified as part of the IP address, shows the length of the network prefix.

Consider, for example, the CIDR 192.168.10.0/24. "192.168.10.0" is the network address. The "24" indicates that the first 24 bits are part of the network address, leaving the last 8 bits for specific host addresses. The address range cannot overlap with other subnets in the virtual network or with the on-premises network.

## IP addressing for Azure virtual networks

The first three IP addresses are reserved for all subnets by default in Azure. For protocol conformance, first and last IP addresses of all subnets are also reserved. Internal DHCP service within Azure assigns and maintains the lease of IP addresses. The .1, .2, .3, and last IP address are not visible or configurable by the Azure customer. These addresses are reserved and used by internal Azure services. 

In Azure, you can also download your entire infrastructure in a JSON file, change the IP addresses, and then redeploy the same infrastructure with the new IP addresses.