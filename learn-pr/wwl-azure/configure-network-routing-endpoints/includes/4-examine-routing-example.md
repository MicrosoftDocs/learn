Let’s review a specific network routing example. In this example, you have a virtual network that includes three subnets.

 -  The subnets are Private, DMZ, and Public. In the DMZ subnet, there is a network virtual appliance (NVA). NVAs are VMs that help with network functions like routing and firewall optimization.
 -  You want to ensure all traffic from the Public subnet goes through the NVA to the Private subnet.

:::image type="content" source="../media/AZ104_Routing_Example-0310ef85.png" alt-text="A public subnet uses a routing table to access the private subnet.":::


## Create a Routing Table

Creating a routing table is straightforward. You provide **Name**, **Subscription**, **Resource Group**, and **Location**. You also decide to use **Virtual network gateway route propagation**.

:::image type="content" source="../media/AZ104_Creating_a_Routing_Table-db48c539.png" alt-text="Screenshot of the Create route table page. BGP route propagation is Enabled.":::


Routes are automatically added to the route table for all subnets with Virtual network gateway propagation enabled. When you are using ExpressRoute, propagation ensures all subnets get the routing information.

## Create a Custom Route

For our example,

 -  The new route is named *ToPrivateSubnet*.
 -  The Private subnet is at 10.0.1.0/24.
 -  The route uses a virtual appliance. Notice the other choices for *Next hop type*: virtual network gateway, virtual network, internet, and none.
 -  The virtual appliance is located at 10.0.2.4.

:::image type="content" source="../media/AZ104_Create_a_Custom_Route-91d50849.png" alt-text="Screenshot of the Add route page. The Next hop type drop-down is highlighted. Virtual appliance is selected.":::


In summary, this route applies to any address prefixes in 10.0.1.0/24 (private subnet). Traffic headed to these addresses will be sent to the virtual appliance with a 10.0.2.4 address.

## Associate the Route Table

The last step in our example is to associate the Public subnet with the new routing table. Each subnet can have zero or one route table associated to it.

:::image type="content" source="../media/AZ104_Associate_a_Route-e68d9465.png" alt-text="Screenshot of a route table being assocated with a virtual network.":::


> [!NOTE]
> By default, using system routes traffic would go directly to the private subnet. However, with a user-defined route you can force the traffic through the virtual appliance.

> [!NOTE]
> In this example, the virtual appliance shouldn't have a public IP address and IP forwarding should be enabled.
