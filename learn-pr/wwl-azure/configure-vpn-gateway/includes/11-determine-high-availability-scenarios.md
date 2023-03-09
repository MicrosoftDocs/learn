
You can implement a highly available VPN gateway to support cross-premises and VNet-to-VNet connections and configurations with multiple on-premises VPN devices. In these scenarios, the Azure VPN gateway consists of two instances in an _active-standby_ configuration.

You can also create an Azure VPN gateway in an _active-active_ configuration. Both instances of the gateway virtual machines establish site-to-site VPN tunnels to your on-premises VPN device. You can support an active-active configuration for Azure VPN gateways only, or in combination with multiple on-premises VPN devices.

### Things to know about active-standby

In a highly available scenario, every Azure VPN gateway has two instances in an active-standby configuration.

For any planned maintenance or unplanned disruption that happens to the _active_ instance, the _standby_ instance takes over (failover) automatically, and resumes the site-to-site VPN or VNet-to-VNet connections.

- The switch over causes a brief interruption.
- For planned maintenance, connectivity is commonly restored within 10 to 15 seconds.
- For unplanned issues, the connection recovery can be longer, taking from 1 minute to 1 and a half minutes in the worst case.
- For point-to-site VPN client connections to the gateway, the P2S connections are disconnected and users need to reconnect from the client machines.

:::image type="content" source="../media/active-standby-b1ae014b.png" alt-text="Diagram that shows an active-standby VPN gateway, where the active gateway is connected to an on-premises VPN." border="false":::

### Things to know about active-active

A highly available scenario can also be configured for an Azure VPN gateway in an active-active configuration. The virtual machines in both gateway instances establish site-to-site VPN tunnels to your on-premises VPN device.

- Each Azure VPN gateway instance has a unique public IP address.
- Each instance establishes an IPsec/IKE S2S VPN tunnel to your on-premises VPN device specified in your local network gateway and connection, but both VPN tunnels are part of the same connection.
- You still need to configure your on-premises VPN device to accept or establish two S2S VPN tunnels to the two Azure VPN gateway public IP addresses.

The traffic from your Azure virtual network to your on-premises network is routed through both VPN tunnels simultaneously. The same TCP or UDP flow always traverses the same VPN tunnel or path, unless a maintenance event happens on one of the instances.

When a planned maintenance or unplanned event happens to one gateway instance, the IPsec tunnel from that instance to your on-premises VPN device is disconnected. The corresponding routes on your VPN devices should be removed or withdrawn automatically so traffic is switched over to the other active IPsec tunnel. On the Azure side, the switch happens automatically from the affected instance to the active instance.

:::image type="content" source="../media/active-active-ea464be2.png" alt-text="Diagram that shows two active-active VPN gateways connecting through multiple paths to two on-premises VPN gateways." border="false":::