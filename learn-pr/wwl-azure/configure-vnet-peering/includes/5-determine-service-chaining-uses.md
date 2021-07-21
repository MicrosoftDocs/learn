VNet Peering is nontransitive. When you establish VNet peering between VNet1 and VNet2 and between VNet2 and VNet3, VNet peering capabilities do not apply between VNet1 and VNet3. However, you can configure user-defined routes and service chaining to provide the transitivity. This allows you to:

 -  Implement a multi-level hub and spoke architecture.
 -  Overcome the limit on the number of VNet peerings per virtual network.

## Hub and spoke architecture

When you deploy hub-and-spoke networks, the hub virtual network can host infrastructure components like the network virtual appliance or VPN gateway. All the spoke virtual networks can then peer with the hub virtual network. Traffic can flow through network virtual appliances or VPN gateways in the hub virtual network.

:::image type="content" source="../media/service-chains-5c9286d1.png" alt-text="Hub virtual network with virtual appliance and gateway is being accessed by other virtual networks.":::


## User-defined routes and service chaining

Virtual network peering enables the next hop in a user-defined route to be the IP address of a virtual machine in the peered virtual network, or a VPN gateway.

Service chaining lets you define user routes. These routes direct traffic from one virtual network to a virtual appliance, or virtual network gateway.

## Checking connectivity

You can check the status of the VNet peering.

 -  **Initiated**: When you create the peering to the second virtual network from the first virtual network, the peering status is Initiated.
 -  **Connected**: When you create the peering from the second virtual network to the first virtual network, its peering status is Connected. When you view the peering status for the first virtual network, you see its status changed from Initiated to Connected. The peering is not successfully established until the peering status for both virtual network peerings is Connected.
