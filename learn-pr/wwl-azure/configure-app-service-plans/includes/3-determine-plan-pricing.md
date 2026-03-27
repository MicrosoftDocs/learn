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

Here's a sample of different [plan details](/azure/app-service/overview-hosting-plans). 

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

The Premium service plan is designed for production apps that need higher performance and scale. PremiumV3 is the current Premium tier, offering Dav4 and Ddv4-series virtual machines and SSD storage. PremiumV3 supports standard compute SKUs and memory-optimized SKUs for high-memory workloads. PremiumV3 supports both rule-based autoscaling and automatic scaling. PremiumV3 is recommended for new deployments.

### Isolated

The Isolated service plan supports mission-critical workloads needing network isolation. IsolatedV2 is the preferred tier offering newer hardware, up to 200 instances, private environments, and enhanced security. IsolatedV2 is recommended for new workloads due to better performance and simpler pricing.

## Task to be done: Select an App Service plan

You can view the available App Service plans in the Azure portal. You can make your choice based on hardware or feature requirements. Hardware considerations include CPU, memory, and scaling instances. Feature considerations include backups, staging slots, and zone redundancy. 

> [!TIP]
> When selecting a service plan, consider both hardware and feature requirements.

1. In the Azure portal search for and select **App Service plans**. 
1. **Create** a new App Service plan. 
1. Select **Explore pricing plans** to view the available plans.

:::image type="content" source="../media/appserviceplans.gif" alt-text="Animated graphic showing how to view app service plans in the portal.":::


