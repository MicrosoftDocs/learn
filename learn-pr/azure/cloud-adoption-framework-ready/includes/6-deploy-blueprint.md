Based on the customer narrative, Tailwind Traders will start by deploying a few specific configuration options to meet its constraints. When you're deploying the Azure landing zone accelerator, the following options will mimic the process that Tailwind Traders follows.

## Prerequisites

Before you deploy the Azure landing zone accelerator, you need to create two Azure subscriptions:

- A networking subscription to host networking and connectivity assets
- An identity subscription to host identity and access management assets 

You might also want to create a management subscription, if you plan to deploy the operations management configuration. Tailwind Traders chose not to use that configuration option.

The article [Create a Microsoft Customer Agreement subscription](/azure/cost-management-billing/manage/create-subscription?msclkid=155dc2d3d16511ec86451b2c110c6653) can guide you through the process of creating these subscriptions.

## Deploy the Azure landing zone accelerator

1. Open the [Azure landing zone accelerator in the Azure portal](https://aka.ms/caf/ready/accelerator). This portal experience will guide you through deployment.
1. On the **Deployment settings** tab:
   1. For **Directory**, choose the appropriate Microsoft Entra tenant.
      
      If you don't have proper permissions, an error appears below your tenant.
   1. For **Region**, select a region from the dropdown list. 
   
      Tailwind Traders chooses the **West Central US** region.
1. On the **Azure core setup** tab:
   1. For **Resource prefix (Root ID)**, enter a prefix. 
   
      Tailwind Traders enters **tailwind-**.
   1. For **Platform subscription options**, choose the **Dedicated** option to keep all platform resources in a dedicated subscription.

      > [!NOTE]
      > The choice of dedicated subscriptions for all platform resources will centralize any tools needed to manage the environment. As Tailwind Traders adds security, operations, and governance, it will use the dedicated subscription and management group structure that this dedication option has created. Choosing the option for a single subscription could require significant rework later in the adoption process.

1. On the **Platform management, security, and governance** tab, you choose whether to deploy a Log Analytics workspace and enable monitoring. Select **No**.

   Tailwind Traders makes this choice because it will enhance its landing zone later to address security, management, and governance needs.
1. On the **Platform DevOps and automation** tab, you would normally select options that apply to your organization. 

   Because Tailwind Traders chose not to add any of the Log Analytics features, it can't add any of the DevOps and automation features. As such, there's nothing to choose here.
1. On the **Network topology and connectivity** tab:
   1. Select the **Hub and spoke with Azure Firewall** option. This will create a dedicated subscription for connectivity. 
   
      Tailwind Traders selects this option. After the accelerator is deployed, the company's MPLS solution will connect to an Azure ExpressRoute instance deployed into that subscription. This setup will allow any application landing zone to connect over MPLS, but route traffic through Azure Firewall first.
   1. After you choose the option for hub and spoke with Azure Firewall, more options appear so you can configure the connectivity subscription:
      1. For **Connectivity subscription**, choose your connectivity subscription.
      1. For **Address space**, enter an address space for any IPs in your networking hub.
      1. For **Region for the first networking hub**, choose a region for your deployment. 
      
         Tailwind Traders selects **West Central US** to ensure that the networking hub is in the same region as the other deployments.
      1. For **Enable DDoS Network Protection**, select **No**. 
      
         Tailwind Traders makes this choice because it doesn't want to enable DDoS protection at this time. The company is deferring security decisions and isn't ready to approve the cost of that service yet.
      1. For **Create Private DNS Zones for Azure PaaS services**, select **Yes**. 
      
         Tailwind Traders will deploy some workloads as PaaS services, so it chooses to enable this free service.
      1. For **Deploy VPN Gateway** and **Deploy ExpressRoute Gateway**, leave the default selection of **No**. 
      
         Tailwind Traders makes this choice because it isn't ready to connect its MPLS to Azure ExpressRoute at this time.
      1. For **Deploy Azure Firewall**, leave the default selection of **Yes** to deploy Azure Firewall.
      1. For **Subnet for Azure Firewall**, set the subnet range for your Azure Firewall instance.
      
      For any options not included in the preceding steps, leave the default values.
1. On the **Identity** tab:
   1. For **Assign recommended policies to govern identity and domain controllers**, leave the default selection of **Yes (recommended)**.
      
      Tailwind Traders isn't ready to adhere to the principle of policy-driven governance. However, it does choose to enable policies that govern its identity and domain controllers. This first step into governance automation will help keep the company's identity controllers safer in the cloud.
   1. For **Identity subscription**, choose which subscription will host identity-related assets.
   1. Leave all the policy-related options set to the default of **Yes (recommended)**.
   1. For **Virtual network address space**, enter the address space for the virtual network that will host identity-related assets.
1. On the **Landing zones configuration** tab:
   1. For **Connect corp landing zones to the connectivity hub**, select **Yes**.
   1. For **Corp landing zone subscriptions**, make a selection from the dropdown list. 
   
      Tailwind Traders has one existing subscription that will be used as the destination for most virtual machines and other assets being migrated. The company chooses that subscription here.
   1. For **Online landing zone subscriptions**, make a selection from the dropdown list. 
   
      Tailwind Traders also has a subscription that was allocated to host any of its public-facing applications. The company chooses that subscription here.
   1. For the series of recommended policies in **Landing Zone Management Group**, select **Audit only**. 
   
      Tailwind Traders sets all of the listed policies this way because it isn't ready to adopt policy-driven governance.

      > [!NOTE]
      > If Tailwind Traders wanted to adhere to the design principles of app-centric design or subscription democratization, there would be several additional subscriptions selected in the dropdown list (or added later).
      >
      > If Tailwind Traders wanted to adhere to the design principle of policy-driven governance, it would leave all of the listed policies with the recommended option of **Yes (recommended)** to automatically enforce governance decisions via Azure Policy.

1. On the **Review + create** tab, select **Create** to deploy your environment.

You have successfully deployed an Azure landing zone by using the accelerator. If you followed the preceding process, that deployment should be aligned to the constraints of Tailwind Traders.
