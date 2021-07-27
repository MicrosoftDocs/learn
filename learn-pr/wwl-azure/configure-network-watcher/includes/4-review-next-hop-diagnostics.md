**Next Hop Purpose**: To determine if traffic is being directed to the intended destination. Next hop information will help determine if network routing is correctly configured.

When you create a virtual network, Azure creates several default outbound routes for network traffic. The outbound traffic from all resources, such as VMs, deployed in a virtual network, are routed based on Azure's default routes. You might override Azure's default routes or create additional routes.

**Example**

You may find that a VM can no longer communicate with other resources because of a specific route. The next hop capability enables you to specify a source and destination IPv4 address. Next hop then tests the communication and informs you what type of next hop is used to route the traffic. You can then remove, change, or add a route, to resolve a routing problem.

:::image type="content" source="../media/next-hop-d7dde5f6.png" alt-text="Screenshot of the Next hop page. The Next hop button is highlighted showing that the next hop is a virtual appliance on IP address 10.1.2.4.":::


Next Hop also returns the route table associated with the next hop. If the route is defined as a user-defined route, that route is returned. Otherwise, Next Hop returns the system route. Depending on your situation, the next hop could be the Internet, Virtual Appliance, Virtual Network Gateway, VNet Local, VNet Peering, or None. A returned value of None lets you know that there may be a valid system route to the destination, there is no next hop to route the traffic to the destination.
