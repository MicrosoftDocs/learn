

Azure automatically creates a route table for each subnet within an Azure virtual network and adds system default routes to the table. You can override some of Azure's system routes with [custom routes](/azure/virtual-network/virtual-networks-udr-overview), and add more custom routes to route tables. Azure routes outbound traffic from a subnet based on the routes in a subnet's route table.

## System routes

Azure automatically creates system routes and assigns the routes to each subnet in a virtual network. You can't create or remove system routes, but you can override some system routes with custom routes. Azure creates default system routes for each subnet, and adds other optional default routes to specific subnets, or every subnet, when you use specific Azure capabilities.

### Default routes

Each route contains an address prefix and next hop type. When traffic leaving a subnet is sent to an IP address within the address prefix of a route, the route that contains the prefix is the route Azure uses. Whenever a virtual network is created, Azure automatically creates the following default system routes for each subnet within the virtual network:

:::row:::
  :::column:::
    **Source**
  :::column-end:::
  :::column:::
    **Address prefixes**
  :::column-end:::
  :::column:::
    **Next hop type**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Default
  :::column-end:::
  :::column:::
    Unique to the virtual network
  :::column-end:::
  :::column:::
    Virtual network
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Default
  :::column-end:::
  :::column:::
    0.0.0.0/0
  :::column-end:::
  :::column:::
    Internet
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Default
  :::column-end:::
  :::column:::
    10.0.0.0/8
  :::column-end:::
  :::column:::
    None
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Default
  :::column-end:::
  :::column:::
    192.168.0.0/16
  :::column-end:::
  :::column:::
    None
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Default
  :::column-end:::
  :::column:::
    100.64.0.0/10
  :::column-end:::
  :::column:::
    None
  :::column-end:::
:::row-end:::

In routing terms, a hop is a waypoint on the overall route. Therefore, the next hop is the next waypoint that the traffic is directed to on its journey to its ultimate destination. The next hop types listed in the previous table represent how Azure routes traffic destined for the address prefix listed. The next hop types are defined as follows:

- **Virtual network:** Routes traffic between address ranges within the address space of a virtual network. Azure creates a route with an address prefix that corresponds to each address range defined within the address space of a virtual network. Azure automatically routes traffic between subnets using the routes created for each address range.
- **Internet:** Routes traffic specified by the address prefix to the Internet. The system default route specifies the 0.0.0.0/0 address prefix. Azure routes traffic for any address not specified by an address range within a virtual network to the Internet, unless the destination address is for an Azure service. Azure routes any traffic destined for its service directly to the service over the backbone network, rather than routing the traffic to the Internet. You can override Azure's default system route for the 0.0.0.0/0 address prefix with a custom route.
- **None:** Traffic routed to the None next hop type is dropped, rather than routed outside the subnet. Azure automatically creates default routes for the following address prefixes:

  - 10.0.0.0/8, 172.16.0.0/12 and 192.168.0.0/16: Reserved for private use in RFC 1918.
  - 100.64.0.0/10: Reserved in RFC 6598.


### Optional default routes

Azure adds default system routes for any Azure capabilities that you enable. Depending on the capability, Azure adds optional default routes to either specific subnets within the virtual network, or to all subnets within a virtual network. The system routes and next hop types that Azure may add are:

:::row:::
  :::column:::
    **Source**
  :::column-end:::
  :::column:::
    **Address prefixes**
  :::column-end:::
  :::column:::
    **Next hop type**
  :::column-end:::
  :::column:::
    **Subnet within virtual network that route is added to**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Default
  :::column-end:::
  :::column:::
    Unique to the virtual network, for example: 10.1.0.0/16
  :::column-end:::
  :::column:::
    VNet peering
  :::column-end:::
  :::column:::
    All
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Virtual network gateway
  :::column-end:::
  :::column:::
    Prefixes advertised from on-premises via BGP, or configured in the local network gateway
  :::column-end:::
  :::column:::
    Virtual network gateway
  :::column-end:::
  :::column:::
    All
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Default
  :::column-end:::
  :::column:::
    Multiple
  :::column-end:::
  :::column:::
    VirtualNetworkServiceEndpoint
  :::column-end:::
  :::column:::
    Only the subnet a service endpoint is enabled for
  :::column-end:::
:::row-end:::

- **Virtual network (VNet) peering**: When you create a virtual network peering between two virtual networks, a route is added for each address range within the address space of each virtual network.
- **Virtual network gateway:** When you add a virtual network gateway to a virtual network, Azure adds one or more routes with Virtual network gateway as the next hop type. The source is listed as virtual network gateway because the gateway adds the routes to the subnet.

  - There are limits to the number of routes you can propagate to an Azure virtual network gateway, so you should summarize on-premises routes to the largest address ranges possible. For more information on the number of routes, you can propagate, see [Networking limits](/azure/azure-resource-manager/management/azure-subscription-service-limits?toc=/azure/virtual-network/toc.json).

**VirtualNetworkServiceEndpoint:** Azure adds the public IP addresses for certain services to the route table when you enable a service endpoint to the service. Service endpoints are enabled for individual subnets within a virtual network, so the route is only added to the route table of a subnet a service endpoint is enabled for. The public IP addresses of Azure services change periodically, and Azure manages the updates to the routing tables when necessary.

The **VNet peering** and **VirtualNetworkServiceEndpoint** next hop types are only added to route tables of subnets within virtual networks created through the Azure Resource Manager deployment model. The next hop types aren't added to route tables that are associated to virtual network subnets created through the classic deployment model.

## Custom routes

To control the way network traffic is routed more precisely, you can override the default routes that Azure creates by using your own user-defined routes (UDR). This technique can be useful when you want to ensure that traffic between two subnets passes through a firewall appliance.

### User-defined routes

You can create custom, or user-defined(static), routes in Azure to override Azure's default system routes, or to add other routes to a subnet's route table.

In Azure, each subnet can have zero or one associated route table. When you create a route table and associate it to a subnet, the routes within it are combined with, or override, the default routes Azure adds to a subnet.

You can specify the following next hop types when creating a user-defined route:

**Virtual appliance:** A virtual appliance is a virtual machine that typically runs a network application, such as a firewall. When you create a route with the virtual appliance hop type, you also specify a next hop IP address. The IP address can be:

- The private IP address of a network interface attached to a virtual machine.
- The private IP address of an Azure internal load balancer.

**Virtual network gateway**: Specify when you want traffic destined for specific address prefixes routed to a virtual network gateway. The virtual network gateway must be created with type **VPN**.

**None**: Specify when you want to drop traffic to an address prefix, rather than forwarding the traffic to a destination.

**Virtual network**: Specify when you want to override the default routing within a virtual network.

**Internet:** Specify when you want to explicitly route traffic destined to an address prefix to the Internet.

### Uses for custom routes (video)

This video reviews different usage cases for custom routes. The entire video is available in the [On Demand Instructor-led Training Series](/shows/on-demand-instructor-led-training-series/?terms=700).

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=cdcb25bb-d79c-4fbb-8389-09ad07293679]

## Configure Azure Route Server

Azure Route Server simplifies dynamic routing between your network virtual appliance (NVA) and your virtual network. Azure Route Server is a fully managed service and is configured with high availability.

Azure Route Server simplifies configuration, management, and deployment of your NVA in your virtual network.

- You no longer need to manually update the routing table on your NVA whenever your virtual network addresses are updated.

- You no longer need to update User-Defined Routes manually whenever your NVA announces new routes or withdraw old ones.

- You can peer multiple instances of your NVA with Azure Route Server. 

- The interface between NVA and Azure Route Server is based on a common standard protocol. As long as your NVA supports BGP, you can peer it with Azure Route Server.

- You can deploy Azure Route Server in any of your new or existing virtual network.

- Learn how to deploy [Azure Route Server](/azure/route-server/quickstart-configure-route-server-portal)

## Diagnose a routing problem

Imagine your attempts to connect to a specific virtual machine (VM) in your Azure virtual network fail persistently. You can diagnose a routing problem by viewing the routes that are effective for a network interface in a VM. 

You can view the effective routes for each network interface by using the Azure portal, Azure PowerShell, or Azure CLI. The following steps show examples of each technique. In each case, output is only returned if the VM is in the running state. If there are multiple network interfaces attached to the VM, you can review the effective routes for each network interface. Since each network interface can be in a different subnet, each network interface can have different effective routes.

### View effective routes in Azure portal

1. Log into the Azure portal with an Azure account that has the [necessary permissions](/azure/virtual-network/virtual-network-network-interface).
2. In the search box, enter the name of the VM that you want to investigate.
3. Select the VM from the search results.
4. Under **Settings**, select **Networking**, and navigate to the network interface resource by selecting its name.

    :::image type="content" source="../media/view-nics-a9fe039b.png" alt-text="Screenshot of the Azure portal NIC.":::

5. Under **Support + troubleshooting**, select **Effective routes**. The effective routes for a network interface named **myVMNic1** are shown, in the following image:

    :::image type="content" source="../media/view-effective-routes-69875697.png" alt-text="Screenshot of the Azure portal effective routes.":::

Choose the best response for each question.