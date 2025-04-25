

One of the benefits of Azure Virtual WAN is the ability to support reliable connections from many different technologies. These technologies include ExpressRoute, VPN Gateway, Barracuda CloudGen WAN, Cisco Cloud OnRamp for multicloud, and VMware SD-WAN. These types of devices are known as [network virtual appliances (NVAs)](/azure/virtual-wan/about-nva-hub). NVAs enable transitive connectivity throughout an organization's Virtual WAN.

NVAs are deployed directly into a Virtual WAN hub and have an externally facing public IP address. This capability lets customers connect their branch Customer Premises Equipment (CPE) to the same brand NVA in the virtual hub. 

## Manage an NVA in a Virtual Hub

There are many [partners that provide NVAs](/azure/virtual-wan/about-nva-hub#partners). Azure Marketplace can deploy your NVA choice directly into a virtual hub. Each NVA is deployed as a Managed Application in Azure.

This diagram shows the NVA deployment process:

:::image type="content" source="../media/nva-high-level-process-836b75d2.png" alt-text="Diagram of the NVA deployment process.":::


## Deploy an NVA in your Virtual Hub

To deploy an NVA in your virtual WAN hub, access the Microsoft Azure Marketplace and select the Managed Application for the NVA partner. All Managed Applications create two resource groups in your subscription.

 -  **Customer Resource Group** \- This contains an application placeholder for the Managed Application. Partners can use this resource group to expose whatever customer properties they choose.
 -  **Managed Resource Group** \- Customers can't configure or change resources in this resource group directly.

The NVA is configured automatically as part of the deployment process. Once the NVA is provisioned, you can't access the NVA directly.

Unlike Azure VPN Gateway configurations, you don't need to create Site resources, Site-to-Site connection resources, or point-to-site connection resources to connect your branch sites to your NVA in the Virtual WAN hub. 

You still need to create Hub-to-VNet connections to connect your Virtual WAN hub to your Azure VNets.

To learn more about deploying an NVA, view [How to create a Network Virtual Appliance in an Azure Virtual WAN hub](/azure/virtual-wan/how-to-nva-hub).