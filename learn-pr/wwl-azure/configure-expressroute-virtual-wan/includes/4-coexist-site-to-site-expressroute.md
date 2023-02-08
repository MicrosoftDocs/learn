
Azure ExpressRoute is a direct, private connection from your WAN (not over the public internet) to Microsoft services, including Azure. Site-to-site VPN traffic travels encrypted over the public internet. Being able to configure site-to-site VPN and ExpressRoute connections for the same virtual network has several advantages.

You configure a site-to-site VPN as a secure failover path for ExpressRoute. You can also use site-to-site VPNs to connect to sites that aren't part of your network, but are connected through ExpressRoute. Notice this configuration requires two virtual network gateways for the same virtual network. One network uses the gateway type *VPN*, and the other network uses the gateway type *ExpressRoute*.

:::image type="content" source="../media/coexisting-connections-4af27ce9.png" alt-text="Diagram that shows Azure ExpressRoute and a site-to-site VPN configuration coexisting together." border="false":::

### Things to know about ExpressRoute connection models

You create a connection between your on-premises network and the Microsoft cloud in three different ways: colocated at a cloud exchange, point-to-point Ethernet connection, and any-to-any (IPVPN) connection. Connectivity providers offer one or more connectivity models. You work with your connectivity provider to pick the model that works best for you.

| Connection model | How it works | Layer support | 
| --- | --- | --- | 
| **Colocated at cloud exchange** | If you're colocated in a facility with a cloud exchange, you order virtual cross-connections to the Microsoft cloud through the colocation provider's Ethernet exchange. | Colocation providers offer either Layer 2 cross-connections, or managed Layer 3 cross-connections between your infrastructure in the colocation facility and the Microsoft cloud. |
| **Point-to-point Ethernet connections** | You connect your on-premises datacenters and offices to the Microsoft cloud through point-to-point Ethernet links. | Point-to-point Ethernet providers offer Layer 2 connections, or managed Layer 3 connections between your site and the Microsoft cloud. |
| **Any-to-any (IPVPN) networks** | You integrate your WAN with the Microsoft cloud. IPVPN providers, typically Multiprotocol Label Switching (MPLS) VPN, offer any-to-any connectivity between your branch offices and datacenters. The Microsoft cloud can be interconnected to your WAN to make it appear just like any other branch office. | WAN providers typically offer managed Layer 3 connectivity. |

> [!NOTE]
> Currently, the deployment options for site-to-site (S2S) and ExpressRoute coexisting connections are only possible through PowerShell, and not the Azure portal.