Azure uses **system routes** to direct network traffic between virtual machines, on-premises networks, and the Internet. The following situations are managed by these system routes:

 -  Traffic between VMs in the same subnet.
 -  Between VMs in different subnets in the same virtual network.
 -  Data flow from VMs to the Internet.

For example, consider this virtual network with two subnets. Communication between the subnets and from the frontend to the internet are all managed by Azure using the default system routes.

:::image type="content" source="../media/system-routes-08992506.png" alt-text="Diagram of two subnets. One subnet is using a System route to access the internet. The other subnet is using a System route to access the first subnet. Both subnets are accessing a route table.":::


> [!NOTE]
> Information about the system routes is recorded in a route table. A route table contains a set of rules, called routes, that specifies how packets should be routed in a virtual network. Routing tables are associated to subnets, and each packet leaving a subnet is handled based on the associated route table. Packets are matched to routes using the destination. The destination can be an IP address, a virtual network gateway, a virtual appliance, or the internet. If a matching route can't be found, then the packet is dropped.
