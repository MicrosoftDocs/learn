The VPN gateway settings that you chose are critical to creating a successful connection.

:::image type="content" source="../media/create-virtual-gateways-fc2fd022.png" alt-text="Screenshot of the create virtual network gateway page .":::


 -  **Gateway type**. VPN or ExpressRoute.
 -  **VPN type**. Route based or Policy based. Most VPN types are Route-based. The type of VPN you choose depends on the make and model of your VPN device, and the kind of VPN connection you intend to create. Typical route-based gateway scenarios include point-to-site, inter-virtual network, or multiple site-to-site connections. Route-based is also selected when you coexist with an ExpressRoute gateway or if you need to use IKEv2. Policy-based gateways support only IKEv1.
 -  **SKU**. Use the drop-down to select a gateway SKU. Your choice will affect the number of tunnels you can have and the aggregate throughput benchmark. The benchmark is based on measurements of multiple tunnels aggregated through a single gateway. It is not a guaranteed throughput due to Internet traffic conditions and your application behaviors.
 -  **Generation**. Generation1 or Generation2. You cannot change generations or SKUs across generations. Basic and VpnGw1 SKUs are only supported in Generation1. VpnGw4 and VpnGw5 SKUs are only supported in Generation2.
 -  **Virtual networks**. The virtual network that will be able to send and receive traffic through the virtual network gateway. A virtual network cannot be associated with more than one gateway.

> [!NOTE]
> You can view the IP address assigned to the gateway. The gateway should appear as a connected device.
