ExpressRoute is supported across all Azure regions and locations. This map provides a list of Azure regions and ExpressRoute locations. ExpressRoute locations are where Microsoft peers with several service providers. When you connected to at least one ExpressRoute location within the geopolitical region, you will access Azure services across all regions within a geopolitical region.

:::image type="content" source="../media/expressroute-map-425634b0.png" alt-text="Global map with partner locations.":::


## ExpressRoute benefits

### **Layer 3 connectivity**

Microsoft uses BGP to exchange routes between your on-premises network, your instances in Azure, and Microsoft public addresses. Multiple BGP sessions are created for different traffic profiles.

### **Redundancy**

Each ExpressRoute circuit consists of two connections to two Microsoft Enterprise edge routers (MSEEs) from the connectivity provider/your network edge. Microsoft requires dual BGP connection from the connectivity provider/your network edge – one to each MSEE.

### **Connectivity to Microsoft cloud services**

ExpressRoute connections enable access to Microsoft Azure services, Microsoft 365 services, and Microsoft Dynamics 365. Microsoft 365 was created to be accessed securely and reliably via the Internet, so ExpressRoute requires Microsoft authorization.

### **Connectivity to all regions within a geopolitical region**

You connect to Microsoft in one of our peering locations and access regions within the geopolitical region. For example, if you connect to Microsoft in Amsterdam through ExpressRoute, you'll have access to all Microsoft cloud services hosted in Northern and Western Europe.

### **Global connectivity with ExpressRoute premium add-on**

You enable the ExpressRoute premium add-on feature to extend connectivity across geopolitical boundaries. For example, if you connect to Microsoft in Amsterdam through ExpressRoute, you will have access to all Microsoft cloud services hosted in all regions across the world, except national clouds.

### **Across on-premises connectivity with ExpressRoute Global Reach**

You enable ExpressRoute Global Reach to exchange data across your on-premises sites by connecting your ExpressRoute circuits. For example, if you have a private data center in California connected to ExpressRoute in Silicon Valley, and another private data center in Texas connected to ExpressRoute in Dallas, with ExpressRoute Global Reach, you can connect your private data centers together through two ExpressRoute circuits. Your cross-data-center traffic will traverse through Microsoft's network.

### **Bandwidth options**

You purchase ExpressRoute circuits for a wide range of bandwidths. Be sure to check with your connectivity provider to determine the bandwidths they support.

### **Flexible billing models**

You pick a billing model that works best for you. Several [pricing options](https://azure.microsoft.com/pricing/details/expressroute/) are available.
