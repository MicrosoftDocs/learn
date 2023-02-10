
Azure ExpressRoute is supported across all Azure regions and locations. The following map provides a list of Azure regions and ExpressRoute locations. ExpressRoute locations are where Microsoft peers with several service providers. 

:::image type="content" source="../media/expressroute-map-425634b0.png" alt-text="Diagram of a global map that shows all Azure partner locations." border="false":::

### Things to know about Azure ExpressRoute

Let's take a closer look at how Azure ExpressRoute supports your network and site connections.

- Microsoft uses the Border Gateway Protocol (BGP) to exchange routes between your on-premises network, your instances in Azure, and Microsoft public addresses to provide Layer 3 connectivity. Multiple BGP sessions are created for different traffic profiles.

- Each ExpressRoute circuit consists of two connections to two Microsoft Enterprise edge routers (MSEEs) from the connectivity provider or your network edge. Microsoft requires dual BGP connection from the connectivity provider or your network edge, one to each MSEE. The dual BGP connections provide redundancy.

- ExpressRoute connections enable access to Microsoft Azure services, Microsoft 365 services, and Microsoft Dynamics CRM. Microsoft 365 is intended to be accessed securely and reliably via the internet, so ExpressRoute requires Microsoft authorization.

- You connect to Microsoft in one of our peering locations and access regions within the geopolitical region.

   Suppose you connect to Microsoft in Amsterdam through ExpressRoute. You can access all Microsoft cloud services hosted in Northern and Western Europe.

- The ExpressRoute premium add-on feature lets you extend connectivity across geopolitical boundaries.

   Suppose you connect to Microsoft in Amsterdam through ExpressRoute. When you enable the ExpressRoute premium add-on feature, you can access all Microsoft cloud services hosted in all regions across the world, except national clouds.

- **ExpressRoute Global Reach** lets you exchange data across your on-premises sites by connecting your ExpressRoute circuits.

   Suppose you have a private data center in California connected to ExpressRoute in Silicon Valley. You configure another private data center in Texas connected to ExpressRoute in Dallas and enable ExpressRoute Global Reach. You can connect your private data centers together through two ExpressRoute circuits. Your cross-data-center traffic then traverses through Microsoft's network.

- ExpressRoute circuits can be purchased for a wide range of bandwidths. Check with your connectivity provider to determine their supported bandwidths.

- Microsoft offers several [pricing options](https://azure.microsoft.com/pricing/details/expressroute/) for ExpressRoute.