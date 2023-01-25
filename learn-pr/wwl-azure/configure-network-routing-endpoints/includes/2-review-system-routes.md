Azure uses _system routes_ to direct network traffic between virtual machines, on-premises networks, and the internet. Information about the system routes is recorded in a _route table_. 

### Things to know about system routes

Let's take a closer look at how Azure implements system routes.

- Azure uses system routes to control traffic for virtual machines in several scenarios:
   - Traffic between virtual machines in the same subnet
   - Traffic between virtual machines in different subnets in the same virtual network
   - Traffic from virtual machines to the internet

- A route table contains a set of rules (called _routes_) that specifies how packets should be routed in a virtual network.

- Routing tables are associated to subnets, and each packet leaving a subnet is handled based on the associated route table.

- Packets are matched to routes by using the destination. The destination can be an IP address, a virtual network gateway, a virtual appliance, or the internet.

- When a matching route can't be found, the packet is dropped.

#### Business scenario

Consider a scenario where you have a virtual network with two subnets. You can use Azure system routes to control communication between the subnets and between specified subnets and the internet. The front-end subnet uses a system route to access the internet. The back-end subnet uses a system route to access the front-end subnet. Both subnets access a route table. The following illustration highlights this scenario:

:::image type="content" source="../media/system-routes-08992506.png" alt-text="Diagram that shows two subnets that use system routes as described in the text." border="false":::