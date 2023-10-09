
The **next hop** feature in Azure Network Watcher checks if traffic is being directed to the intended destination. This feature lets you view the next connection point (or _next hop_) in your network route, and helps you verify a correct network configuration.

:::image type="content" source="../media/next-hop-d7dde5f6.png" alt-text="Screenshot of the next hop feature in the Azure portal." border="false":::

### Things to know about next hop

Let's review the configuration properties and summary of the next hop feature in Azure Network Watcher.

- You configure the next hop feature with the following properties in the Azure portal:
   - Your subscription and resource group
   - Virtual machine and network interface
   - Source IP address
   - Destination IP address (If you want to confirm a specified target is reachable)

- The feature tests the next connection point in your network route configuration.

- The next hop test returns three items:
   - Next hop type
   - IP address of the next hop (If available)
   - Route table for the next hop (If available)

- The next hop type can be _Internet_, _VirtualAppliance_, _VirtualNetworkGateway_, _VirtualNetwork_, _VirtualNetworkPeering_, _VirtualNetworkServiceEndpoint_, _MicrosoftEdge_, or _None_.

- If the next hop is a user-defined route (UDR), the process returns the UDR route. Otherwise, next hop returns the system route.

- If the next hop is of type _None_, there might be a valid system route to the destination IP address, but no next hop exists to route the traffic to the target.

### Things to consider when using next hop

The next hop feature is ideal for identifying unresponsive virtual machines or broken routes in your network.

When you create a virtual network, Azure creates several default outbound routes for network traffic. Outbound traffic from all resources (such as virtual machines) deployed in the virtual network is routed based on Azure's default routes. You can override Azure's default routes or create other routes.

You might find that a virtual machine can no longer communicate with other resources connected by a specific route. You can use the next hop feature to examine a specific source and destination IP address in your configuration.

Next hop tests the communication between the source and destination, and reports the type of next hop in the traffic route. You can then remove, change, or add a route, to resolve routing issues.