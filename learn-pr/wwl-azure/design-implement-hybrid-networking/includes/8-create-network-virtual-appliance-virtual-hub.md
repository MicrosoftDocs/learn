
One of the benefits of Azure Virtual WAN is the ability to support reliable connections from many different technologies. These technologies include ExpressRoute, VPN Gateway, Barracuda CloudGen WAN, Cisco Cloud OnRamp for multicloud, and VMware SD-WAN. These types of devices are known as network virtual appliances (NVAs). NVAs are deployed directly into a Virtual WAN hub and have an externally facing public IP address. This capability enables customers who want to connect their branch Customer Premises Equipment (CPE) to the same brand NVA in the virtual hub to take advantage of proprietary end-to-end SD-WAN capabilities. Once VNets are connected to the virtual hub, NVAs enable transitive connectivity throughout the organization's Virtual WAN.

## Manage an NVA in a Virtual Hub

The NVAs available in the Azure Marketplace can be deployed directly into a virtual hub and nowhere else. Each is deployed as a Managed Application, which allows Azure Virtual WAN to manage the configuration of the NVA. They can't be deployed within an arbitrary VNet.

The following diagram shows the NVA deployment process:

:::image type="content" source="../media/nva-high-level-process-836b75d2.png" alt-text="Diagram of the NVA deployment process.":::


## Deploy an NVA in your Virtual Hub

To deploy an NVA in your virtual hub, you can access the Azure Marketplace through the Azure portal and select the Managed Application for the NVA partner that you need to enable connectivity for your devices. When you create an NVA in the Virtual WAN hub, like all Managed Applications, there are two Resource Groups created in your subscription.

 -  **Customer Resource Group** \- This contains an application placeholder for the Managed Application. Partners can use this resource group to expose whatever customer properties they choose here.
 -  **Managed Resource Group** \- Customers can't configure or change resources in this resource group directly.

The NVA is configured automatically as part of the deployment process. Once the NVA is provisioned, you can't access the NVA directly.

Unlike Azure VPN Gateway configurations, you don't need to create Site resources, Site-to-Site connection resources, or point-to-site connection resources to connect your branch sites to your NVA in the Virtual WAN hub. 

You still need to create Hub-to-VNet connections to connect your Virtual WAN hub to your Azure VNets.

### Create the Network Virtual Appliance in the hub

In this step, you create a Network Virtual Appliance in the hub. The procedure for each NVA is different for each NVA partner's product. For this example, we're creating a Barracuda CloudGen WAN Gateway.

1.  Locate the Virtual WAN hub you created in the previous step and open it. 
:::image type="content" source="../media/nva-hub-eec1b931.png" alt-text="Screenshot of Azure Virtual WAN resource ion the Azure portal.":::
  
2.  Find the Network Virtual Appliances tile and select the Create link.
3.  On the Network Virtual Appliance blade, select Barracuda CloudGen WAN, then select the Create button. 
:::image type="content" source="../media/select-nva-0c5ab0b6.png" alt-text="Screenshot of Network Virtual Appliance configuration blade in Azure portal.":::
    
4.  The Azure Marketplace offers the Barracuda CloudGen WAN gateway. Read the terms, then select the **Create** button when you're ready. 

:::image type="content" source="../media/barracuda-create-basics-d11c3a3c.png" alt-text="Screenshot of creating a Barracuda CloudGen WAN gateway.":::
    
5.  On the Basics page you need to provide the following information:
    
     -  **Subscription -** Choose the subscription you used to deploy the Virtual WAN and hub.
     -  **Resource Group** \- Choose the same Resource Group you used to deploy the Virtual WAN and hub.
     -  **Region** \- Choose the same Region in which your Virtual hub resource is located.
     -  **Application Name** \- The Barracuda NextGen WAN is a Managed Application. Choose a name that makes it easy to identify this resource.
     -  **Managed Resource Group** \- All resources are deployed to this group. 
6.  Select the Next: CloudGen WAN gateway button. 
:::image type="content" source="../media/barracuda-cloudgen-wan-ebe559b5.png" alt-text="Screenshot of the Barracuda configuration page. ":::
    
7.  Provide the following information here:
    
     -  **Virtual WAN Hub** \- The Virtual WAN hub you want to deploy this NVA into.
     -  **NVA Infrastructure Units** \- Indicate the number of NVA Infrastructure Units you want to deploy this NVA with. Choose the amount of aggregate bandwidth capacity you want to provide across all of the branch sites.
     -  **Token** \- Barracuda requires that you provide an authentication token here in order to identify yourself as a registered user of this product. 

### NVA Infrastructure Units

When you create an NVA in the Virtual WAN hub, you must choose the number of NVA Infrastructure Units you want to deploy it with. An NVA Infrastructure Unit is a unit of aggregate bandwidth capacity for an NVA in the Virtual WAN hub. An NVA Infrastructure Unit is similar to a VPN Scale Unit in terms of the way you think about capacity and sizing.

 -  One NVA Infrastructure Unit represents 500 Mbps of aggregate bandwidth for all branch site connections coming into this NVA.
 -  Azure supports from 1-80 NVA Infrastructure Units for a given NVA virtual hub deployment.
 -  Each partner may offer different NVA Infrastructure Unit bundles that are a subset of all supported NVA Infrastructure Unit configurations.

To learn more about deploying an NVA, view [How to create a Network Virtual Appliance in an Azure Virtual WAN hub](/azure/virtual-wan/how-to-nva-hub).