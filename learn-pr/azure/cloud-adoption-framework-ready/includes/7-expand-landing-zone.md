With your CAF Migrate landing zone blueprint deployed, it's time to begin expanding your landing zone. This is done through a process called refactoring.

## Steps to refactor your landing zone

To accelerate your early adoption efforts, we suggest minimizing the number of blocking steps. The following approach allows for rapid landing zone configuration to meet minimum technical requirements to deploy low risk workloads.

- Assign the initial landing zone (Previous unit of this Learn module)
- Validate subscription scaling decisions
- Adhere to naming and tagging conventions
- Review networking options
- Implement additional identity and access management considerations
- Plan for parallel maturity of Govern, Security, and Manage methodologies

> [!CAUTION]
> While this approach meets minimum technical standards, it may not initial meet your minium operational standards. If security, governance, or operations management requirements must be met prior to your first adoption effort, you will likely need to be begin execution of that methodology prior to adoption. For an accelerated approach to an enterprise ready environment, you may want to consider the *Start with Enterprise-Scale* implementation options.

## Validate subscription scaling decisions

In the prior unit of this Learn Module, you assigned the initial blueprint to a single subscription. Before going any further, consider your subscription strategy. Is a single subscription enough to deliver on your cloud adoption plan?

### First two subscriptions

At minimum, you will likely need two subscriptions: Production and Non-Production

![An initial subscription model showing keys next to boxes labeled "production" and "nonproduction"](https://docs.microsoft.com/azure/cloud-adoption-framework/_images/ready/initial-subscription-model.png)

_Figure 1: An initial subscription model with keys next to boxes labeled "production" and "nonproduction"._

- Create one Azure subscription to contain your production workloads.
- Create a second subscription to serve as your nonproduction (dev/test) environment, using an [Azure Dev/Test offer](https://azure.microsoft.com/pricing/dev-test) for lower pricing.

<!-- docsTest:ignore Dev/Test -->

This approach has many benefits:

- Using separate subscriptions for your production and nonproduction environments creates a boundary that makes management of your resources simpler and safer.
- Azure Dev/Test subscription offerings are available for nonproduction workloads. These offerings provide discounted rates on Azure services and software licensing.
- Your production and nonproduction environments will likely have different sets of Azure policies. Using separate subscriptions makes it simple to apply each distinct policy at the subscription level.
- You can allow certain types of Azure resources in your nonproduction subscription for testing purposes. You can enable those resource providers in your nonproduction subscription without making them available in your production environment.
- You can use dev/test subscriptions as isolated sandbox environments. These sandboxes allow administrators and developers to rapidly build up and tear down entire sets of Azure resources. This isolation can also help with data protection and security concerns.
- The acceptable cost thresholds that you define will likely vary between production and dev/test subscriptions.

### Sandbox subscriptions

If innovation goals are part of your cloud adoption strategy, consider creating one or more sandbox subscriptions. You can apply security policies to keep these test subscriptions isolated from your production and nonproduction environments. Users can easily experiment with Azure capabilities in these isolated environments. Use an Azure Dev/Test offer to create these subscriptions.

![An initial subscription model showing keys next to boxes labeled "production", "nonproduction", and "sandboxes"](https://docs.microsoft.com/azure/cloud-adoption-framework/_images/ready/initial-subscription-model-with-sandboxes.png)
_Figure 2: A subscription model with sandbox subscriptions._

### Shared services subscription(s)

If you're planning to host **more than 1,000 VMs or compute instances in the cloud within 24 months**, create another Azure subscription to host shared services. This will prepare you to support your end-state enterprise architecture. If you plan to implement enterprise operations, you may wish to further sub-divide your shared services subscriptions to be feature specific, see the *Start with enterprise-scale* Learn Modules for more details.

![An initial subscription model showing keys next to boxes labeled "production" and "shared services"](https://docs.microsoft.com/azure/cloud-adoption-framework/_images/ready/initial-subscription-model-with-shared-services.png)

_Figure 3: A subscription model with shared services._

### Plan for subscription scaling

As cloud adoption grows, you may need to further sub-divide your production subscriptions for a number of valid business reasons. This is true for Central or Enterprise operations. For more information on subscription scaling, see the article on [scale with multiple subscriptions](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/scale-subscriptions) for additional learning.

## Adhere to naming and tagging conventions

Organize your cloud assets to support operational management and accounting requirements. Well-defined naming and metadata tagging conventions help to quickly locate and manage resources. These conventions also help associate cloud usage costs with business teams via chargeback and showback accounting mechanisms.

Changing resource names can be difficult. Establish a comprehensive naming convention before you begin any large cloud deployment.

The article on [Recommended naming and tagging conventions](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging) provides guidance, samples, automated approaches, and an excel workbook to capture and socialize your naming and tagging conventions.

## Review networking options

The CAF Migrate blueprint demonstrates network configuration, but provides little actionable configuration. You will need to refactor the network configuration in that blueprint prior to deploying workloads to the new landing zone.

- [Review networking options](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/considerations/networking-options) for some of the network options to consider.
- [Evaluate a network perspective](https://docs.microsoft.com/azure/cloud-adoption-framework/reference/networking-vdc) see a number of ways to combine those network options to create a virtual datacenter within your Azure environment
- [Plan for your virtual networks](https://docs.microsoft.com/azure/virtual-network/virtual-network-vnet-plan-design-arm?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json)
- [Follow best practices for network security](https://docs.microsoft.com/azure/security/fundamentals/network-best-practices?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json)

## Implement additional identity and access management considerations

Similar to network, the CAF Migrate blueprint deploys a basic Role Based Access Control (RBAC) requirement. But you will likely want to refactor that requirement to include deeper identity considerations. To learn more see the article on [Role-based access control considerations](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/considerations/roles)

## Plan for parallel maturity of Govern, Security, and Manage methodologies

The above steps will help get you ready for your first cloud adoption efforts. However, to reach true scale in the cloud, you will need to continue to invest in your Azure Landing Zones to reach operating model requirements regarding governance, security, and operations management. Each of these is addressed in parallel methodologies within the Cloud Adoption Framework, and their coordinated Learn Modules.

> [!IMPORTANT]
> If parallel maturity is not a desirable approach, consider completing the CAF Enterprise-Scale Learn Modules. The approach covered in those modules will guide you through a richer implementation option of Azure Landing Zones. That approach provides an opinionated implementation for all of the above considerations. That implementation will establish an environment that is ready to support Enterprise Operations.