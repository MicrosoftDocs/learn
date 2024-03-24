When virtual networks are peered, you can configure Azure VPN Gateway in the peered virtual network as a _transit point_. In this scenario, a peered virtual network uses the remote VPN gateway to gain access to other resources.

Consider a scenario where three virtual networks in the same region are connected by virtual network peering. Virtual network A and virtual network B are each peered with a hub virtual network. The hub virtual network contains several resources, including a gateway subnet and an Azure VPN gateway. The VPN gateway is configured to allow VPN gateway transit. Virtual network B accesses resources in the hub, including the gateway subnet, by using a remote VPN gateway. 

:::image type="content" source="../media/gateway-transit-173a51a0.png" alt-text="Diagram of a regional virtual network peering. One network allows VPN gateway transit and uses a remote VPN gateway to access resources in a hub virtual network." border="false":::

### Things to know about Azure VPN Gateway

Let's take a closer look at how Azure VPN Gateway is implemented with Azure Virtual Network peering.

- A virtual network can have only one VPN gateway.

- Gateway transit is supported for both regional and global virtual network peering.

- When you allow VPN gateway transit, the virtual network can communicate to resources outside the peering. In our sample illustration, the gateway subnet gateway within the hub virtual network can complete tasks such as:
   - Use a site-to-site VPN to connect to an on-premises network.
   - Use a vnet-to-vnet connection to another virtual network.
   - Use a point-to-site VPN to connect to a client.

- Gateway transit allows peered virtual networks to share the gateway and get access to resources. With this implementation, you don't need to deploy a VPN gateway in the peer virtual network.

- You can apply network security groups in a virtual network to block or allow access to other virtual networks or subnets. When you configure virtual network peering, you can choose to open or close the network security group rules between the virtual networks.