When virtual networks are peered, you configure a VPN gateway in the peered virtual network as a transit point. In this case, a peered virtual network uses the remote gateway to gain access to other resources. A virtual network can have only one gateway. Gateway transit is supported for both VNet Peering and Global VNet Peering.

:::image type="content" source="../media/gateway-transit-173a51a0.png" alt-text="Two VNets, VNet1 and VNet2, are shown in a region and are connected by VNet peering. VNet1 has Allow Gateway transit and VNet2 has use remote gateways.":::


When you Allow Gateway Transit the virtual network can communicate to resources outside the peering. For example, the subnet gateway could:

 -  Use a site-to-site VPN to connect to an on-premises network.
 -  Use a VNet-to-VNet connection to another virtual network.
 -  Use a point-to-site VPN to connect to a client.

In these scenarios, gateway transit allows peered virtual networks to share the gateway and get access to resources. This means you do not need to deploy a VPN gateway in the peer virtual network.

> [!NOTE]
> Network security groups can be applied in either virtual network to block access to other virtual networks or subnets. When configuring virtual network peering, you can either open or close the network security group rules between the virtual networks.
