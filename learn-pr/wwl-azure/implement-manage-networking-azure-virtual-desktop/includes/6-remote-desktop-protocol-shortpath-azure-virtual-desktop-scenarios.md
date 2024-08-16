Here are some example scenarios to show how connections are evaluated to decide whether RDP Shortpath is used across different network topologies.

### Scenario 1

A UDP connection can only be established between the client device and the session host over a public network (internet). A direct connection, such as a VPN, isn't available. UDP is allowed through firewall or NAT device.

:::image type="content" source="../media/rdp-shortpath-scenario-1-e7e17531.png" alt-text="Diagram that shows RDP Shortpath for public networks uses STUN.":::


### Scenario 2

A firewall or NAT device is blocking a direct UDP connection, but an indirect UDP connection can be relayed using TURN between the client device and the session host over a public network (internet). Another direct connection, such as a VPN, isn't available.

:::image type="content" source="../media/rdp-shortpath-scenario-2-ef9b1415.png" alt-text="Diagram that shows RDP Shortpath for public networks uses TURN.":::


### Scenario 3

A UDP connection can be established between the client device and the session host over a public network or over a direct VPN connection, but RDP Shortpath for managed networks isn't enabled. When the client initiates the connection, the ICE/STUN protocol can see multiple routes and will evaluate each route and choose the one with the lowest latency.

In this example, a UDP connection with RDP Shortpath for public networks over the direct VPN connection will be made as it has the lowest latency, as shown by the green line.

:::image type="content" source="../media/rdp-shortpath-scenario-3-de01ebf1.png" alt-text="Diagram that shows a UDP connection using RDP Shortpath for public networks over the direct VPN connection will be made as it has the lowest latency.":::


### Scenario 4

Both RDP Shortpath for public networks and managed networks are enabled. A UDP connection can be established between the client device and the session host over a public network or over a direct VPN connection. When the client initiates the connection, there are simultaneous attempts to connect using RDP Shortpath for managed networks through port 3390 (by default) and RDP Shortpath for public networks through the ICE/STUN protocol. The first-found algorithm is used to and the user will use whichever connection gets established first for that session.

Since going over a public network has more steps, for example a NAT device, a load balancer, or a STUN server, it's likely that the first-found algorithm will select the connection using RDP Shortpath for managed networks and be established first.

:::image type="content" source="../media/rdp-shortpath-scenario-4-a684417d.png" alt-text="Diagram that shows the first-found algorithm will select the connection using RDP Shortpath for managed networks and be established first.":::


### Scenario 5

A UDP connection can be established between the client device and the session host over a public network or over a direct VPN connection, but RDP Shortpath for managed networks isn't enabled. To prevent ICE/STUN from using a particular route, an admin can block one of the routes for UDP traffic. Blocking a route would ensure the remaining path is always used.

In this example, UDP is blocked on the direct VPN connection and the ICE/STUN protocol establishes a connection over the public network.

:::image type="content" source="../media/rdp-shortpath-scenario-5-f2d63924.png" alt-text="Diagram that shows UDP is blocked on the direct VPN connection and the ICE/STUN protocol establishes a connection over the public network.":::


### Scenario 6

Both RDP Shortpath for public networks and managed networks are configured, however a UDP connection couldn't be established using direct VPN connection. A firewall or NAT device is also blocking a direct UDP connection using the public network (internet), but an indirect UDP connection can be relayed using TURN between the client device and the session host over a public network (internet).

:::image type="content" source="../media/rdp-shortpath-scenario-6-75033899.png" alt-text="Diagram that shows UDP is blocked on the direct VPN connection and a direct connection.":::


### Scenario 7

Both RDP Shortpath for public networks and managed networks are configured, however a UDP connection couldn't be established. In this instance, RDP Shortpath will fail and the connection will fall back to TCP-based reverse connect transport.

:::image type="content" source="../media/rdp-shortpath-scenario-7-69d12404.png" alt-text="Diagram that shows a UDP connection couldn't be established.":::
