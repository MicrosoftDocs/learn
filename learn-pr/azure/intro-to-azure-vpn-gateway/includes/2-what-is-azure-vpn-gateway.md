An Azure VPN gateway is a specific type of virtual network gateway that is used to send and receive encrypted traffic between an Azure virtual network and an on-premises location over the public Internet. Azure VPN gateways can also be used to connect separate Azure virtual networks using an encrypted tunnel across the Microsoft network backbone. 
  
:::image type="content" source="../images/vpn-gateway-network-structure.png" alt-text="Diagram that shows an encrypted site-to-site VPN tunnel between an Azure virtual network and an on-premises network.":::

Azure VPN Gateway supports both point-to-site and site-to-site connections:

- **Point-to-site VPN connection**: A point-to-site VPN connection can be used to connect a single computer to an Azure virtual network. A P2S connection is established by starting it from the client computer. This type of VPN connection is commonly used by remote workers with portable computers.
- **Site-to-site VPN connection**: A site-to-site VPN connection allows you to connect one network to another network with traffic between the two networks passing across an encrypted VPN tunnel. This type of VPN connection is commonly used to connect on-premises sites to Azure or Azure virtual networks to each other.

:::image type="content" source="../images/vpn-connection-types.png" alt-text="Diagram that shows on-premises sites and point-to-site users connecting to a hub VPN gateway and spoke networks in Azure.":::

Depending on the SKU chosen, Azure VPN gateways support:

- Up to 100 site-to-site or VNet-to-VNet tunnels, depending on gateway generation and SKU. Basic supports up to 10 site-to-site connections with a route-based gateway, or one with a policy-based gateway.
- Aggregate throughput benchmarks from 100 Mbps to 10 Gbps, depending on gateway generation and SKU.
- Border Gateway Protocol (BGP) support.

> [!NOTE]
> Throughput figures are benchmarks, not guarantees. All tunnels share the gateway's available bandwidth, and a single site-to-site or point-to-site connection can have much lower throughput. For current per-SKU limits and performance considerations, see [About gateway SKUs](/azure/vpn-gateway/about-gateway-skus).
