Let’s review a specific network routing example. In this example, you have a virtual network that includes three subnets.

 -  The subnets are Private, DMZ, and Public. In the DMZ subnet, there is a network virtual appliance (NVA). NVAs are VMs that help with network functions like routing and firewall optimization.
 -  You want to ensure all traffic from the Public subnet goes through the NVA to the Private subnet.

:::image type="content" source="../media/routing-example-cec52490.png" alt-text="A public subnet uses a routing table to access the private subnet.":::


## Create a routing table

Creating a routing table is straightforward. You provide **Name**, **Subscription**, **Resource Group**, and **Location**. You also decide to use **Virtual network gateway route propagation**.

:::image type="content" source="../media/create-routing-table-31fab29d.png" alt-text="Screenshot of the Create route table page. BGP route propagation is Enabled.":::


Routes are automatically added to the route table for all subnets with Virtual network gateway propagation enabled. When you are using ExpressRoute, propagation ensures all subnets get the routing information.

## Create a custom route

For our example,

 -  The new route is named *ToPrivateSubnet*.
 -  The Private subnet is at 10.0.1.0/24.
 -  The route uses a virtual appliance. Notice the other choices for *Next hop type*: virtual network gateway, virtual network, internet, and none.
 -  The virtual appliance is located at 10.0.2.4.

:::image type="content" source="../media/create-custom-route-66c1d2ed.png" alt-text="Screenshot of the Add route page. The Next hop type drop-down is highlighted. Virtual appliance is selected.":::


In summary, this route applies to any address prefixes in 10.0.1.0/24 (private subnet). Traffic headed to these addresses will be sent to the virtual appliance with a 10.0.2.4 address.

## Associate the route table

The last step in our example is to associate the Public subnet with the new routing table. Each subnet can have zero or one route table associated to it.

:::image type="content" source="../media/associate-route-e9ecaa5c.png" alt-text="Screenshot of a route table being assocated with a virtual network.":::


> [!NOTE]
> By default, using system routes traffic would go directly to the private subnet. However, with a user-defined route you can force the traffic through the virtual appliance.

> [!NOTE]
> In this example, the virtual appliance shouldn't have a public IP address and IP forwarding should be enabled.
