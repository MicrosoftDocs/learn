The pricing tier of an Azure App Service plan determines what App Service features you get and how much you pay for the plan. Pricing tier examples are: Free, Shared, Basic, Standard, Premium, PremiumV2, PremiumV3, Isolated, and IsolatedV2. 

## How applications run and scale in App Service plans

The Azure App Service plan is the scale unit of App Service applications. Depending on the pricing tier for your Azure App Service plan, your applications run and scale in a different manner. If your plan is configured to run five virtual machine instances, then all applications in the plan run on all five instances. If your plan is configured for autoscaling, then all applications in the plan are scaled out together based on the autoscale settings.

The pricing tiers are grouped into three categories:

- **Shared compute**:
   - Free and Shared, the two base tiers, run an app on the same Azure VM as other App Service apps, including apps of other customers. 
   - These tiers allocate CPU quotas to each app that runs on the shared resources, and the resources can't scale out. 
   - These tiers are intended to be used only for development and testing purposes.
- **Dedicated compute**: 
   - The Basic, Standard, Premium, PremiumV2, and PremiumV3 tiers run apps on dedicated Azure VMs. 
   - Only apps in the same App Service plan have the same compute resources. The higher the tier, the more VM instances that are available to you for scale-out.
- **Isolated**: 
   - The Isolated and IsolatedV2 tiers run dedicated Azure VMs on dedicated Azure virtual networks. 
   - This tier provides network isolation on top of compute isolation to your apps. 
   - This tier provides the maximum scale-out capabilities.

Here's a sample of different [plan details](/azure/app-service/overview-hosting-plans). For more information, you can use the Azure portal. Select *Create App Service Plan* and then *Explore pricing plans*. You can view either by hardware or feature capability. 

| Feature | Free F1 | Basic B1 | Standard S1 | Premium P1V3 | 
| --- | --- | --- | --- | --- | 
| Usage | Development, Testing | Development, Testing | Production workloads | Enhanced scale, performance | 
| Staging slots | N/A | N/A | 5 | 20 |
| Auto scale | N/A | Manual | Rules | Rules, Elastic |
| Scale instances | N/A | 3 | 10 | 30 |
| Daily backups | N/A | N/A | 10 | 50 |

### Free and Shared

The Free and Shared service plans are base tiers that run on the same Azure virtual machines as other applications. Some applications might belong to other customers. These tiers are intended to be used for development and testing purposes only. No SLA is provided for the Free and Shared service plans. Free and Shared plans are metered on a per application basis.

### Basic

The Basic service plan is designed for applications that have lower traffic requirements, and don't need advanced auto scale and traffic management features. Pricing is based on the size and number of instances you run. Built-in network load-balancing support automatically distributes traffic across instances. The Basic service plan with Linux runtime environments supports Web App for Containers.

### Standard

The Standard service plan is designed for running production workloads. Pricing is based on the size and number of instances you run. Built-in network load-balancing support automatically distributes traffic across instances. The Standard plan includes auto scale that can automatically adjust the number of virtual machine instances running to match your traffic needs. The Standard service plan with Linux runtime environments supports Web App for Containers.

### Premium

The Premium service plan is designed to provide enhanced performance for production applications. The upgraded Premium plan, Premium v2, offers Dv2-series virtual machines with faster processors, SSD storage, and double memory-to-core ratio compared to the Standard tier. The new Premium plan also supports higher scale via increased instance count while still providing all the advanced capabilities of the Standard tier. The first generation of Premium plan is still available to support existing customer scaling needs.

### Isolated

The Isolated service plan is designed to run mission critical workloads that are required to run in a virtual network. The Isolated plan allows customers to run their applications in a private, dedicated environment in an Azure datacenter. The plan offers Dv2-series virtual machines with faster processors, SSD storage, and a double memory-to-core ratio compared to the Standard tier. The private environment used with an Isolated plan is called the App Service Environment. The plan can scale to 100 instances with more available upon request.

## Try it in the Azure portal

You can view the available App Service plans in the Azure portal. You can make your choice based on hardware or feature requirements. 

1. Use the Azure portal to search for and select **App Service plans**. 
1. **Create** a new App Service plan. 
1. Select **Explore pricing plans** to view the available plans.



