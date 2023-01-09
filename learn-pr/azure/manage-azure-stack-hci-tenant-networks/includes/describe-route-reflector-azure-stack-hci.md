To conclude your evaluation of Azure Stack HCI tenant networking functionality, you’ve decided to explore the concept of Route Reflector. You intend to determine its role in optimizing the routing functionality in multitenant scenarios.

## Describe Route Reflector on Azure Stack HCI

The BGP Route Reflector is part of SDN RAS Gateway. It provides an alternative to BGP full-mesh topology, which is normally required for route synchronization between routers. With full-mesh synchronization, all BGP routers must connect with all other routers in the routing topology. When you implement Route Reflector, it becomes the only router that connects with all of the other routers. These other routers are then referred to as *BGP Route Reflector clients*. This arrangement effectively simplifies route synchronization and reduces network traffic. The Route Reflector learns all routes, calculates the best routes, and then redistributes the best routes to its BGP clients.

For each tenant you add to your Azure Stack HCI deployment, SDN automatically configures the first of the tenant’s RAS Gateway VMs as a Route Reflector. Effectively, each tenant has a corresponding Route Reflector, which resides on one of the RAS Gateway VMs that are associated with that tenant.

A tenant Route Reflector acts as the Route Reflector for all of the RAS Gateway VMs that are associated with the tenant. Tenant gateways other than the RAS Gateway Route Reflector are the Route Reflector clients. The Route Reflector performs route synchronization across all Route Reflector clients so that the actual data path routing can occur.

> [!NOTE]
> Route Reflector doesn’t participate in data-plane routing.

In some scenarios, you might want to configure an individual tenant's remote access tunnels to terminate on more than one RAS Gateway VM. This provides increased flexibility in scenarios where a single RAS Gateway VM cannot meet all of the bandwidth requirements of incoming connections. However, this capability introduces the additional complexity of route management and effective synchronization of routes between the remote sites and virtual resources in an SDN environment. A BGP Route Reflector addresses this problem and abstracts the internal SDN fabric infrastructure details from remote tenants.

> [!NOTE]
> If a tenant uses BGP Routing in the Customer Address space, the tenant’s RAS Gateway Route Reflector is the only External BGP (eBGP) neighbor for all of the sites for that tenant. Effectively, it doesn’t matter which RAS Gateway VM terminates the S2S VPN tunnel for a tenant site, because the Route Reflector functions as an eBGP Peer for all the tenant sites.
