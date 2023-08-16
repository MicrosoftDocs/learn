
## Use cross-region connectivity to link multiple ExpressRoute locations

There are various ways of designing and implementing ExpressRoute based on specific organizational requirements.

ExpressRoute connections enable access to the following services:

 -  Microsoft Azure services
 -  Microsoft 365 services

**Connectivity to all regions within a geopolitical region**

You can connect to Microsoft in one of the peering locations and access regions within the geopolitical region.

For example, if you connect to Microsoft in Amsterdam through ExpressRoute, you will have access to all Microsoft cloud services hosted in Northern and Western Europe.

**Global connectivity with ExpressRoute Premium**

You can enable ExpressRoute Premium to extend connectivity across geopolitical boundaries. For example, if you connect to Microsoft in Amsterdam through ExpressRoute, you will have access to all Microsoft cloud services hosted in all regions across the world. You can also access services deployed in South America or Australia the same way you access North and West Europe regions. National clouds are excluded.

**Local connectivity with ExpressRoute Local**

You can transfer data cost-effectively by enabling the Local SKU. With Local SKU, you can bring your data to an ExpressRoute location near the Azure region you want. With Local, Data transfer is included in the ExpressRoute port charge.

**Across on-premises connectivity with ExpressRoute Global Reach**

You can enable ExpressRoute Global Reach to exchange data across your on-premises sites by connecting your ExpressRoute circuits. For example, if you have a private data center in California connected to an ExpressRoute circuit in Silicon Valley and another private data center in Texas connected to an ExpressRoute circuit in Dallas. With ExpressRoute Global Reach, you can connect your private data centers together through these two ExpressRoute circuits. Your cross-data-center traffic will traverse through Microsoft's network.

**Rich connectivity partner ecosystem**

ExpressRoute has a constantly growing ecosystem of connectivity providers and systems integrator partners. You can refer to [ExpressRoute partners and peering locations](/azure/expressroute/expressroute-locations).

**Connectivity to national clouds**

Microsoft operates isolated cloud environments for special geopolitical regions and customer segments.

**ExpressRoute Direct**

ExpressRoute Direct provides customers the opportunity to connect directly into Microsoft’s global network at peering locations strategically distributed across the world. ExpressRoute Direct provides dual 100-Gbps connectivity, which supports Active/Active connectivity at scale.


ExpressRoute is a private and resilient way to connect your on-premises networks to the Microsoft Cloud. You can access many Microsoft cloud services such as Azure and Microsoft 365 from your private data center or your corporate network. For example, you may have a branch office in San Francisco with an ExpressRoute circuit in Silicon Valley and another branch office in London with an ExpressRoute circuit in the same city. Both branch offices have high-speed connectivity to Azure resources in US West and UK South. However, the branch offices cannot connect and send data directly with one another. In other words, 10.0.1.0/24 can send data to 10.0.3.0/24 and 10.0.4.0/24 network, but NOT to 10.0.2.0/24 network.

:::image type="content" source="../media/global-reach-5558594f.png" alt-text="GlobalReach layout diagram":::


## Choose when to use ExpressRoute global reach

ExpressRoute Global Reach is designed to complement your service provider’s WAN implementation and connect your branch offices across the world. For example, if your service provider primarily operates in the United States and has linked all your branches in the U.S., but the service provider does not operate in Japan and Hong Kong SAR, with ExpressRoute Global Reach you can work with a local service provider and Microsoft will connect your branches there to the ones in the U.S. using ExpressRoute and the Microsoft global network.

:::image type="content" source="../media/global-reach-usecase-563b9539.png" alt-text="Global Reach layout with local providers for connectivity to global network":::


## Configure ExpressRoute global reach

These steps show you how to configure ExpressRoute Global Reach using Azure portal.

**Before you begin**

Before you start configuration, confirm the following criteria:

 -  You understand ExpressRoute circuit provisioning workflows.
 -  Your ExpressRoute circuits are in a provisioned state.
 -  Azure private peering is configured on your ExpressRoute circuits.
 -  If you want to run PowerShell locally, verify that the latest version of Azure PowerShell is installed on your computer.

**Identify circuits**

Identify the ExpressRoute circuits that you want use. You can enable ExpressRoute Global Reach between the private peering of any two ExpressRoute circuits, if they are in the supported countries/regions. The circuits are required to be created at different peering locations.

 -  If your subscription owns both circuits, you can choose either circuit to run the configuration in the following sections.
 -  If the two circuits are in different Azure subscriptions, you need authorization from one Azure subscription. Then you pass in the authorization key when you run the configuration command in the other Azure subscription.

:::image type="content" source="../media/expressroute-circuit-global-reach-list-46088d46.png" alt-text="Azure portal - view ExpressRoute circuits":::


**Enable connectivity**

Enable connectivity between your on-premises networks. There are separate sets of instructions for circuits that are in the same Azure subscription, and circuits that are different subscriptions.

**ExpressRoute circuits in the same Azure subscription**

1.  Select the **Azure private** peering configuration.

    :::image type="content" source="../media/expressroute-circuit-private-peering-b08fb7fd.png" alt-text="Azure portal - check that the ExpressRoute circuit is provisioned for private peering":::


2.  Select **Add Global Reach** to open the Add Global Reach configuration page.

    :::image type="content" source="../media/private-peering-enable-global-reach-1c7da165.png" alt-text="Azure portal - add circuit to GlobalReach":::


3.  On the Add Global Reach configuration page, give a name to this configuration. Select the ExpressRoute circuit you want to connect this circuit to and enter in a **/29 IPv4** for the Global Reach subnet. Azure uses IP addresses in this subnet to establish connectivity between the two ExpressRoute circuits. Do not use the addresses in this subnet in your Azure virtual networks, or in your on-premises network. Select **Add** to add the circuit to the private peering configuration.

    :::image type="content" source="../media/add-global-reach-configuration-200b331a.png" alt-text="Azure portal - Add GlobalReach details":::


4.  Select **Save** to complete the Global Reach configuration. When the operation completes, you will have connectivity between your two on-premises networks through both ExpressRoute circuits.

    :::image type="content" source="../media/save-private-peering-configuration-e0e38e8a.png" alt-text="Azure portal - save GlobalReach configuration":::


**Verify the configuration**

Verify the Global Reach configuration by selecting Private peering under the ExpressRoute circuit configuration. When configured correctly your configuration should look as followed:

:::image type="content" source="../media/verify-global-reach-configuration-664be1d8.png" alt-text="Azure portal - Verify GlobalReach configuration":::


**Disable connectivity**

To disable connectivity between an individual circuit, select the delete button next to the Global Reach name to remove connectivity between them. Then select **Save** to complete the operation.

:::image type="content" source="../media/disable-global-reach-configuration-c6a9b3d0.png" alt-text="Azure portal - disable GlobalReach configuration":::