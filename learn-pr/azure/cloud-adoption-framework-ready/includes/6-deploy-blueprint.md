Based on the customer narrative, Tailwind Trader will start by deploying a few specific configuration options to meet their constraints. When deploying the Azure landing zone accelerator, the following options will mimic the process Tailwind Traders followed.

## Prerequisite

Before deploying the Azure Landing Zone Accelerator, you will need to create two Azure subscriptions:

1.	Networking subscription: This subscription will host networking and connectivity assets.
1.	Identity subscription: This subscription will host identity and access management assets 

You may also want to create a management subscription, if you plan to deploy the operations management configuration. Tailwind chose not to use that configuration option, so the third subscription isn’t required when following these step-by-step directions.

The article on creating an additional azure subscription can guide you through the process of creating these subscriptions. [Create an additional Azure subscription | Microsoft Docs](/azure/cost-management-billing/manage/create-subscription?msclkid=155dc2d3d16511ec86451b2c110c6653)

## Deploy the Azure Landing Zone Accelerator

1. Start by opening the Azure Landing Zone Accelerator portal experience: https://aka.ms/caf/ready/accelerator This experience will guide you through deployment.
1. Deployment location tab
   1. Directory: Choose the appropriate Azure Active Directory tenant.
      1. If you don't have proper permissions, an error will be displayed below your tenant.
   1. Choose a region: Tailwind Traders chose the default option: West Central US
1. Azure core setup tab
   1. Management Group Prefix: Tailwind Traders entered "tailwind-" as they're prefix.
   1. Platform resources: Choose the Dedicated option to keep all platform resources in a dedicated subscription

   > [!NOTE]
   > The choice of dedicated subscriptions for all platform resources will centralize any tools needed to manage the environment. As Tailwind adds security, operations, and governance they will use the dedicated subscription & management group structure created by this dedicated option. Choosing the single subscription option could require significant rework later in the adoption process.

1. Platform management, security, & governance tab
   1. Deploy Log Analytics: Tailwind chose No, because they will enhance their landing zone later to address security, management, and governance needs
1. Platform DevOps & automation tab
   1. Since Tailwind chose not to add any of the Log Analytics features, they cannot add any of the DevOps and Automation features. As such, there is nothing to choose here.
1. Network topology & connectivity tab
   1. Tailwind chose the Hub and spoke with Azure Firewall option. This will create a dedicated subscription for connectivity. Once the accelerator is deployed, their MPLS solution will connect to an Express Route deployed into that subscription. This will allow any application landing zone to connect over MPLS, but route traffic through an Azure Firewall first.
   1. After choosing Hub and spoke with Azure Firewall, a number of additional options will appear. These will define configuration options for the connectivity subscription.
      1. Choose the subscription that will be used as the connectivity sub.
      1. Enter an address space for any IPs in your networking hub
      1. Choose the region for your networking hub deployment. For Tailwind, this would be West Central US to ensure that the networking hub is in the same region as their other deployments.
      1. DDoS Protection Standard: Tailwind chose “No” They do not want to enable DDoS at this time because they are deferring security decisions & aren’t ready to approve the cost of that service yet.
      1. Create Private DNS Zones: Yes. Tailwind will be deploying some workloads as PaaS services, so they chose to enable this free service.
      1. Connectivity options (VPN & Express Route): Tailwind chose to leave these options defaulted to No because they aren’t ready to connect their MPLS to Azure ExpressRoute at this time.
      1. Azure Firewall: Leave the default set to Yes to deploy Azure Firewall.
      1. Subnet for Azure Firewall: Tailwind set the subnet range for their Azure Firewall.
      1. Any options not included in the above steps were left as the default values.
1. Identity tab
   1. Assign recommended policies to govern identity and domain controllers: Leave the default value set to “Yes (recommended)”
      1. Tailwind isn’t ready to adhere to the principle of policy-driven governance. However, they did choose to enable policies that govern their identity and domain controllers. This first step into governance automation will help keep their identity controllers safer in the cloud.
   1. Subscription: Choose which subscription will be used to host identity related assets
   1. Policies: Leave each policy set to the default option “Yes (recommended)”
   1. Virtual Network address space: Enter the address space for the virtual network that will host identity related assets.
1. Landing zone configuration tab
   1. Corp landing zone subscriptions: Tailwind had one existing subscription that is to be used as the destination for most VMs and other assets being migrated. They chose that subscription in the Corp landing zone subscriptions drop down.
   1. Online landing zone subscriptions: Tailwind also has a subscription that was allocated to host any of their public facing applications. They chose that subscription in the Online landing zone subscriptions drop down box.
   1. Recommended policies: Since Tailwind isn’t ready to adopt Policy-Driven governance, they set all of the listed policies to the Audit only radio option.

   > [!NOTE]
   > If Tailwind was adhering to the design principles of "App-centric design” or “Subscription democratization”, there’d be several additional subscriptions selected in the dropdown (or added later).

   > [!NOTE]
   > If Tailwind was adhering to the design principle of “Policy driven governance”, they would leave all of the listed policies with the recommended option of “Yes (recommended)” to automatically enforce governance decisions using Azure Policy.

1. Click "Review + create" at the bottom of the screen to proceed.
1. Click "Create" to deploy your environment

You have successfully deployed an Azure landing zone using the Azure Landing Zone accelerator. If you followed the process above, that deployment should be aligned to Tailwind Traders constraints.
