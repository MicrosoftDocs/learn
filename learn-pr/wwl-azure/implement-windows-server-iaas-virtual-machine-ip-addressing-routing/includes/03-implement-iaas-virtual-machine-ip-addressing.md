


Contoso IT would like to continue using the same IPv4 address ranges in Azure that they currently use on-premises. The head offices and regional branch offices use the 10.0.0.0/8 private address range. As part of the Azure pilot program<!-- Verify, is "program" the right word? -->, you decide to create a number of VMs, and then verify that you can configure them with the appropriate private IPv4 addresses. It's also important that some servers are accessible publicly, and those will need a public IPv4 address.

## Private IP addressing

You use private IP addresses to communicate between resources in Azure. Resources might include:

- Azure services, such as VMs, VNets, load balancers, and application gateways.
- VMs on a VNet.
- On-premises resources accessed through a virtual private network (VPN) gateway or Azure ExpressRoute circuit.

> [!NOTE]
>  You can learn more about ExpressRoute at [ExpressRoute Overview](https://aka.ms/expressroute-introduction?azure-portal=true).

By default, each network interface receives a single, private IP address from the subnet's range of IP addresses. That IP address becomes part of the network interface's primary IP configuration. Alternatively, you can assign a static IP address to each interface. You can also create multiple secondary configurations with their own IP addresses, up to the limit imposed by the platform.

Azure uses the Dynamic Host Configuration Protocol (DHCP) to manage both static and dynamic IP addresses that belong to the IP address ranges you allocated when you created the virtual network subnet to which the Azure VM's network interface is connected.

The DHCP lease is infinite, which means that IP addresses remain allocated for as long as the Azure VM is in use. However, if you place the Azure VM in the stopped (deallocated) state, the platform releases its dynamic IP address, and returns it back to a pool maintained by DHCP. As a result, DHCP might assign that IP address to another resource on the same subnet. To prevent this situation, you can designate its IP address as static.

> [!TIP]
>  You might want to assign a static IP address if an Azure VM hosts a DNS service, or if you control network access by using a firewall with rules that reference a source or target IP address.

You assign a static private IP address when you create the Azure VM or at any point after. The address assignment occurs on the Azure VM network interface level, rather than within the operating system itself.

> [!IMPORTANT]
> Do not modify an IP configuration within an OS running in an Azure VM, as this will result in connectivity issues.

To create static, private IP address assignments, you can use an Azure portal, Azure PowerShell, Azure Command-Line Interface (Azure CLI), or Azure Resource Manager template.

> [!NOTE]
>  Setting a static IP address triggers an OS reboot within the Azure VM.

### Allocation method

Azure assigns private IP addresses to your resources from the address range of the virtual network subnet where the resource resides. Azure reserves the first four addresses in each subnet address range. You cannot assign these four addresses to your resources. For example, if the subnet's address range is 10.2.0.0/16, addresses 10.2.0.0-10.2.0.3 and 10.2.255.255 are unavailable.

> [!NOTE]
> Azure can only assign IP addresses within the subnet's address range to one resource at a time.

There are two ways in which Azure assigns private IP addresses, as described in the following table.

|Type|Explanation|
|----|----|
|Dynamic|Azure assigns the next available unassigned or unreserved IP address in the subnet's address range. For example, Azure assigns 10.2.0.10 to a new resource if addresses 10.2.0.4-10.2.0.9 are already assigned to other resources. After they are assigned, dynamic IP addresses are released if a network interface is deleted, reassigned to a different subnet within the same virtual network, or you change the allocation method to static and specify a different IP address.|
|Static|You can select and assign any unassigned or unreserved IP address in the subnet's address range. For example, if a subnet's address range is 10.2.0.0/16 and addresses 10.2.0.4-10.2.0.9 are assigned to other resources, you can assign any address between 10.2.0.10 - 10.2.255.254. Static addresses are only released if a network interface is deleted.|

> [!NOTE]
> Dynamic is the default allocation method.

### VMs

Azure assigns one or more private IP addresses to one or more network interfaces for your VMs. By default, Azure configures VMs to use Azure managed DNS servers. You can, however, change this default behavior and configure custom DNS settings for your VMs. To enable name resolution for the VM, Azure creates a mapping in Azure managed DNS servers for the VM's hostname to the VM's assigned private IP address.

For more information on Azure managed DNS servers, refer to [Name resolution for resources in Azure virtual networks, Azure-provided name resolution](https://aka.ms/azure-provided-name-resolution?azure-portal=true).

### Internal load balancers and application gateways

You can assign private IP addresses to the front-end configuration of both internal load balancers and application gateways. You can assign either a dynamic or static IP to these resources as well<!-- Verify the "as well." -->.

The assigned private IP address acts as an internal endpoint. Only the resources within the resource's VNet and the remote networks connected to it can access this endpoint.

### Summary

The following table briefly describes how to configure top-level resources using private IP addresses.

|Resource|IP address association|Dynamic|Static|
|---------------|----------------------|-------|------|
|VM|Network interface|Yes|Yes|
|Application gateway|Front-end configuration|Yes|Yes|
|Load balancer|Front-end configuration|Yes|Yes|

## Public IP addressing

Public IP addresses enable Azure resources to be accessible directly from the internet. For example, to provide inbound connectivity from the internet to an Azure VM, you can assign a public IP address to the Azure VM's network interface. You can assign a public IP address to the following:

- VM network interfaces
- Internet-facing load balancers
- VPN gateways
- Application gateways
- Azure Firewall

When you assign a public IP address to a resource, it remains dedicated to that resource until you unassign it.

> [!NOTE]
> A resource without a public IP assigned can still communicate outbound.

Public IP addresses are available in two stock keeping units (SKUs), as described in the following table.



|SKU|Description|
|--------|------------------------------------------------------------|
|Basic|Basic SKUs supports both dynamic and static allocation methods. You can assign them to Azure VM network interfaces, internet-facing Basic SKU Azure Load Balancers, application gateways, and VPN gateways. Basic SKUs<!-- Verify --> facilitate IPv6 public IP address assignments to internet-facing Azure Load Balancers Basic.<!-- Andy from Tarina: Verify the "Basic" at the end of this name. -->|
|Standard|Standard SKUs support only static allocation. They facilitate assignment of IPv6 public IP addresses to internet-facing Azure Load Balancers Standard. You can assign them to  Azure VM and internet-facing Standard SKU Azure Load Balancer network interfaces. You can configure them as redundant, or assign them to a specific zone. You can assign both types of IP addresses to the same Standard SKU Azure Load Balancer.|

> [!NOTE]
> As of May 2020, Azure virtual networks no longer support IPv6-based connectivity. However, as mentioned earlier, you can provide inbound access to Azure VMs on a virtual network by using a dynamically allocated public IPv6 address assigned to an internet-facing Azure Load Balancer.
