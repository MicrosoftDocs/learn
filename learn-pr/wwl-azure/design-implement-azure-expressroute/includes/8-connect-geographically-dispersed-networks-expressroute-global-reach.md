


## Use cross-region connectivity to link multiple ExpressRoute locations

There are various ways of designing and implementing ExpressRoute based on specific organizational requirements.

ExpressRoute connections enable access to the following services:

 -  Microsoft Azure services
 -  Microsoft 365 services

**Connectivity to all regions within a geopolitical region**

You can connect to Microsoft in one of the peering locations and access regions within the geopolitical region.

For example, if you connect to Microsoft in Amsterdam through ExpressRoute, you have access to all Microsoft cloud services hosted in Northern and Western Europe.

**Global connectivity with ExpressRoute Premium**

You can enable ExpressRoute Premium to extend connectivity across geopolitical boundaries. For example, if you connect to Microsoft in Amsterdam through ExpressRoute, you have access to all Microsoft cloud services hosted in all regions across the world. You can also access services deployed in South America or Australia the same way you access North and West Europe regions. National clouds are excluded.

**Local connectivity with ExpressRoute Local**

You can transfer data cost-effectively by enabling the Local SKU. With Local SKU, you can bring your data to an ExpressRoute location near the Azure region you want. With Local, Data transfer is included in the ExpressRoute port charge.

**Across on-premises connectivity with ExpressRoute Global Reach**

You can enable ExpressRoute Global Reach to exchange data across your on-premises sites by connecting your ExpressRoute circuits. With ExpressRoute Global Reach, you can connect your private data centers together through these two ExpressRoute circuits. Your cross-data-center traffic traverses through Microsoft's network.

**Rich connectivity partner ecosystem**

ExpressRoute has a constantly growing ecosystem of connectivity providers and systems integrator partners. You can refer to [ExpressRoute partners and peering locations](/azure/expressroute/expressroute-locations).

**Connectivity to national clouds**

Microsoft operates isolated cloud environments for special geopolitical regions and customer segments.

**ExpressRoute Direct**

ExpressRoute Direct provides customers the opportunity to connect directly into Microsoft’s global network at peering locations strategically distributed across the world. ExpressRoute Direct provides dual 100-Gbps connectivity, which supports Active/Active connectivity at scale.


ExpressRoute is a private and resilient way to connect your on-premises networks to the Microsoft Cloud. You can access many Microsoft cloud services such as Azure and Microsoft 365 from your private data center or your corporate network. For example, you might have a branch office in San Francisco and another branch office in London. Both branch offices have high-speed connectivity to Azure resources in US West and UK South. However, the branch offices can't connect and send data directly with one another. In other words, 10.0.1.0/24 can send data to 10.0.3.0/24 and 10.0.4.0/24 network, but NOT to 10.0.2.0/24 network.

:::image type="content" source="../media/global-reach-5558594f.png" alt-text="Diagram of the GlobalReach layout.":::


## Choose when to use ExpressRoute global reach

ExpressRoute Global Reach is designed to complement your service provider’s WAN implementation and connect your branch offices across the world. 

:::image type="content" source="../media/global-reach-usecase-563b9539.png" alt-text="Diagram of the Global Reach layout with local providers.":::