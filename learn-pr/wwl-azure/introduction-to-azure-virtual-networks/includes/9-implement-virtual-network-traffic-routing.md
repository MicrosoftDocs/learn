

Azure automatically creates a route table for each subnet within an Azure virtual network and adds system default routes to the table. You can override some of Azure's system routes with [custom routes](/azure/virtual-network/virtual-networks-udr-overview), and add more custom routes to route tables. Azure routes outbound traffic from a subnet based on the routes in a subnet's route table.

## System routes

Azure automatically creates system routes and assigns the routes to each subnet in a virtual network. You can't create or remove system routes, but you can override some system routes with custom routes. Azure creates default system routes for each subnet, and adds other optional default routes to specific subnets, or every subnet, when you use specific Azure capabilities.

### Default system routes

Whenever a virtual network is created, Azure automatically creates the following default system routes for each subnet within the virtual network. Each system route contains an address prefix and next hop type. 

| **Source** | **Address prefixes** | **Next hop type** |
| Default | Unique to the virtual network | Virtual network |
| Default | 0.0.0.0/0 | Internet |
| Default | 10.0.0.0/8 | None |
| Default | 192.168.0.0/16 | None |
| Default | 100.64.0.0/10 | None |

In routing terms, a hop is a waypoint on the overall route. Therefore, the next hop is the next waypoint that the traffic is directed to on its journey to its ultimate destination. The next hop types are defined as follows:

- **Virtual network:** Routes traffic between address ranges within the address space of a virtual network. Azure creates a route with an address prefix that corresponds to each address range defined within the address space of a virtual network. Azure automatically routes traffic between subnets using the routes created for each address range.
- **Internet:** Routes traffic specified by the address prefix to the Internet. The system default route specifies the 0.0.0.0/0 address prefix. Azure routes traffic for any address not specified by an address range within a virtual network to the Internet, unless the destination address is for an Azure service. Azure routes any traffic destined for its service directly to the service over the backbone network, rather than routing the traffic to the Internet. You can override Azure's default system route for the 0.0.0.0/0 address prefix with a custom route.
- **None:** Traffic routed to the None next hop type is dropped, rather than routed outside the subnet. 

:::image type="content" source="../media/create-custom-route-0e4d9372.png" alt-text="Screenshot of the next hop drop-down.":::

### Optional default system routes

Azure adds default system routes for any Azure capabilities that you enable. Depending on the capability, Azure adds optional default routes to either specific subnets within the virtual network, or to all subnets within a virtual network. 

| **Source** | **Address prefixes** | **Next hop type** | **Subnet within virtual network that route is added to** |
| --- | --- | --- | --- |
| Default | Unique to the virtual network, for example: 10.1.0.0/16 | Virtual network peering | All |
| Virtual network gateway |  Prefixes advertised from on-premises via BGP, or configured in the local network gateway. | All |
| Default | Multiple | VirtualNetworkServiceEndpoint | Only the subnet a service endpoint is enabled for. |


- **Virtual network (VNet) peering**: When you create a virtual network peering between two virtual networks, a route is added for each address range within the address space of each virtual network.
- **Virtual network gateway:** When you add a virtual network gateway to a virtual network, Azure adds one or more routes with Virtual network gateway as the next hop type. The source is listed as virtual network gateway because the gateway adds the routes to the subnet.
- **VirtualNetworkServiceEndpoint:** Azure adds the public IP addresses for certain services to the route table when you enable a service endpoint to the service. Service endpoints are enabled for individual subnets within a virtual network, so the route is only added to the route table of a subnet a service endpoint is enabled for. The public IP addresses of Azure services change periodically, and Azure manages the updates to the routing tables when necessary.

## Custom routes

To control the way network traffic is routed more precisely, you can override the default routes that Azure creates by using your own user-defined routes (UDR). This technique can be useful when you want to ensure that traffic between two subnets passes through a firewall appliance.

### User-defined routes

You can create custom, or user-defined(static), routes. These custom routes override Azure's default system routes. In Azure, each subnet can have zero or one associated route table. When you create a route table and associate it to a subnet, the routes within it are combined with, or override, the default routes Azure adds to a subnet.

You can specify the following next hop types when creating a user-defined route:

- **Virtual appliance:** A virtual appliance is a virtual machine that typically runs a network application, such as a firewall. When you create a route with the virtual appliance hop type, you also specify a next hop IP address. 
- **Virtual network gateway**: Specify when you want traffic destined for specific address prefixes routed to a virtual network gateway. The virtual network gateway must be created with type **VPN**.
- **None**: Specify when you want to drop traffic to an address prefix, rather than forwarding the traffic to a destination.
- **Virtual network**: Specify when you want to override the default routing within a virtual network.
- **Internet:** Specify when you want to explicitly route traffic destined to an address prefix to the Internet.

### Uses for custom routes (video)

This video reviews different usage cases for custom routes. 
> [!VIDEO https://learn-video.azurefd.net/vod/player?id=cdcb25bb-d79c-4fbb-8389-09ad07293679]

## Consider Azure Route Server

[Azure Route Server](/azure/route-server/quickstart-configure-route-server-portal)simplifies dynamic routing between your network virtual appliance (NVA) and your virtual network. Azure Route Server is a fully managed service and is configured with high availability. Azure Route Server simplifies configuration, management, and deployment of your NVA in your virtual network.

- You no longer need to manually update the routing table on your NVA whenever your virtual network addresses are updated.
- You no longer need to update user defined routes manually whenever your NVA announces new routes or withdraws old ones.
- You can peer multiple instances of your NVA with Azure Route Server. 
- The interface between NVA and Azure Route Server is based on a common standard protocol. As long as your NVA supports BGP, you can peer it with Azure Route Server.
- You can deploy Azure Route Server in any of your new or existing virtual network.

## Troubleshoot with effective routes

Imagine your attempts to connect to a specific virtual machine (VM) in your Azure virtual network consistently fail. You can diagnose a routing problem by viewing the effective for a virtual machine network interface. You can view the [effective routes](/azure/virtual-network/diagnose-network-routing-problem#diagnose-using-azure-portal) for each network interface by using the Azure portal.

:::image type="content" source="../media/view-nics-a9fe039b.png" alt-text="Screenshot of the Azure portal NIC.":::

Choose the best response for each question.