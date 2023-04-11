An Azure VPN gateway is a specific type of virtual network gateway that is used to send and receive encrypted traffic between an Azure virtual network and an on-premises location over the public Internet. Azure VPN gateways can also be used to connect separate Azure virtual networks using an encrypted tunnel across the Microsoft network backbone. 
  
:::image type="content" source="../images/vpn-gateway-network-structure.png" alt-text="Diagram that shows how Azure V P N Gateway works with the on-premises network.":::

Azure VPN Gateway supports both point-to-site and site-to-site connections:

- **Point-to-site VPN connection**: A point-to-site VPN connection can be used to connect a single computer to an Azure virtual network. A P2S connection is established by starting it from the client computer. This type of VPN connection is commonly used by remote workers with portable computers.
- **Site-to-site VPN connection**: A site-to-site VPN connection allows you to connect one network to another network with traffic between the two networks passing across an encrypted VPN tunnel. This type of VPN connection is commonly used to connect on-premises sites to Azure or Azure virtual networks to each other.

:::image type="content" source="../images/vpn-connection-types.png" alt-text="Diagram that depicts the types of connections Azure V P N Gateway supports.":::

Depending on the SKU chosen, Azure VPN gateways support:

- Between 10 and 30 site-to-site connections.
- 100 Mbps to 1.25 Gbps aggregate throughput.
- Border Gateway Protocol (BGP) support.
