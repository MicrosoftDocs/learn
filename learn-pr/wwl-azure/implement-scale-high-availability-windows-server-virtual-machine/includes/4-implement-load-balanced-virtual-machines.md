

You can use *Load balancing* to evenly distribute inbound network traffic across a group of resources or servers. In this scenario, the load balancers are considered *front end* devices, while the Azure resources to which clients want to connect are the *backend pool* instances.

> [!NOTE]
> The backend pool instances can be Azure VMs or instances in a virtual machine scale set.

In Azure, you manage this inbound traffic with load balancing rules and health probes.

There are two types of load balancers that you can use in Azure, as described in the following table.

|Load balancer type|Description|
|---------------------|------------------------------------------------------------|
|Public load balancer|You use a public load balancer to provide outbound connections for VMs inside your Azure virtual network (VNet). These connections are accomplished by translating their private IP addresses to public IP addresses. You use public load balancers to load balance internet traffic to your VMs.|
|Internal load balancer|You use an internal (or *private*) load balancer where private IPs are needed at the frontend only. You use internal load balancers to load balance traffic inside an Azure VNet.|

> [!TIP]
> You can access a load balancer frontend from an on-premises network in a hybrid scenario.

Azure Load Balancer includes a few key components. You can configure these components in your subscription using:

- Azure portal
- Azure CLI
- Azure PowerShell
- Azure Resource Manager templates

## Frontend IP configuration

The IP address of your Azure Load Balancer is the point of contact for clients. These IP addresses can be either:
- Public IP addresses
- Private IP addresses

The nature of the IP address determines the type of load balancer created, as described in the following table.

||Public Load Balancer|Internal Load Balancer|
|:----------------------------|:-----------------------------------------------------------|:-----------------------------------------------------------|
|Frontend IP configuration|Public IP address|Private IP address|
|Description|A public load balancer maps the public IP and port of incoming traffic to the private IP and port of the VM. The load balancer then maps traffic the other way around for the response traffic from the VM. You can distribute specific types of traffic across multiple VMs or services by applying load-balancing rules. For example, you can spread the web request traffic across multiple web servers.|An internal load balancer distributes traffic originating on a private IP address to resources that are inside a VNet. Azure restricts access to the frontend IP addresses of a VNet that is load balanced. Front-end IP addresses and VNets are never directly exposed to an internet endpoint. Internal line-of-business (LOB) applications run in Azure, and are accessed either from within Azure or from on-premises resources.|
|SKUs supported|Basic, Standard|Basic, Standard|

> [!NOTE]
> A load balancer can have multiple frontend IPs.

## Backend pool

A backend pool can be associated to Azure VMs or virtual machine scale set. VMs in the backend pool serve the incoming requests.  

When you scale instances up or down, the load balancer instantly reconfigures itself by using automatic reconfiguration. Adding or removing VMs from the backend pool reconfigures the load balancer without additional operations. The load balancer can balance requests to VMs and virtual machine scale set instances that are connected to the same VNet as the load balancer only.

> [!NOTE]
> A load balancer doesn't automatically balance request to all VMs that are connected to the same VNet; you must specify them by associating them to the backend pool.

When considering how to design your backend pool, design for the least number of individual backend pool resources to optimize the length of management operations. There's no difference in data plan performance or scale.

## Additional reading

Learn more by reviewing the following documents:

- [Tutorial: Load balance Windows virtual machines in Azure to create a highly available application with Azure PowerShell](https://aka.ms/tutorial-load-balancer?azure-portal=true)
- [Multiple frontends for Azure Load Balancer](https://aka.ms/load-balancer-multivip-overview?azure-portal=true)
