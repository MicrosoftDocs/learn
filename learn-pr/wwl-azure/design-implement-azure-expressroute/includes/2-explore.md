
This video summarizes the usage cases for Azure Expressroute. The video also covers the main components from the customer's network to the Microsoft Edge. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=b5e2293e-ac31-4916-a402-22374950d4dd]


## Basic ExpressRoute architecture

ExpressRoute extends on-premises networks into the Microsoft cloud over a private connection with the help of a connectivity provider. ExpressRoute establishes connections to various Microsoft cloud services, such as Microsoft Azure and Microsoft 365. Connectivity can be from an any-to-any (IP VPN) network, a point-to-point Ethernet network, or a virtual cross-connection through a connectivity provider at a colocation facility. Since ExpressRoute connections don't go over the public Internet, this approach offers more reliability, faster speeds, consistent latencies, and higher security.

:::image type="content" source="../media/expressroute-connection-overview.png" alt-text="Diagram of the ExpressRoute components.":::

## ExpressRoute connectivity models

ExpressRoute allows you to create a connection in two ways: the Service Provider model and the ExpressRoute Direct model. Within the Service Provider model there are three paths:  CloudExchange Colocation, Point-to-point Ethernet Connection, and Any-to-any (IPVPN) Connection. 

:::image type="content" source="../media/expressroute-connectivity-models-diagram-d3bd1d21.png" alt-text="Diagram of the ExpressRoute connectivity models.":::

1. **Co-located at a cloud exchange**. If you're colocated in a facility with a cloud exchange, you can request for virtual cross-connections to the Microsoft cloud through the colocation provider’s Ethernet exchange. Colocation providers can offer either Layer 2 cross-connections, or managed Layer 3 cross-connections between your infrastructure in the colocation facility and the Microsoft cloud.

2. **Point-to-point Ethernet connections**. You can connect your on-premises datacenters or offices to the Microsoft cloud through point-to-point Ethernet links. Point-to-point Ethernet providers can offer Layer 2 connections.

3. **Any-to-any (IPVPN) networks**. You can integrate your WAN with the Microsoft cloud. IPVPN providers (typically MPLS VPN) offer any-to-any connectivity between your branch offices and datacenters. The Microsoft cloud can be interconnected to your WAN to make it appear like any other branch office. WAN providers typically offer managed Layer 3 connectivity.

4. **ExpressRoute Direct**. You can connect directly into the Microsoft global network at a peering location strategically distributed across the world. ExpressRoute Direct provides dual 100-Gbps or 10-Gbps connectivity that supports Active/Active connectivity at scale.


> [!TIP]
> Learn more about Azure ExpressRoute in the [Introduction to Azure ExpressRoute](/training/modules/intro-to-azure-expressroute/) module.