With your CAF Migration landing zone blueprint deployed, it's time to begin expanding your landing zone. This is done through a process called refactoring.

## Steps to refactor your landing zone

To accelerate your early adoption efforts, we suggest minimizing the number of blocking steps. The following approach allows for rapid landing zone configuration to meet minimum technical requirements to deploy low risk workloads.

- Assign the initial landing zone (the previous unit of this Learn module).
- Validate subscription scaling decisions.
- Adhere to naming and tagging conventions.
- Review networking options.
- Implement additional identity and access management considerations.
- Plan for parallel maturity of Govern, Security, and Manage methodologies.

> [!CAUTION]
> While this approach meets minimum technical standards, it may not initially meet your minimum operational standards. If security, governance, or operations management requirements must be met prior to your first adoption effort, then you might need to start executing that methodology prior to adoption. For an accelerated approach to an enterprise-ready environment, consider the options within **Start with Enterprise-scale** implementation.

## Validate subscription scaling decisions

In the prior unit of this Learn module, you assigned the initial blueprint to a single subscription. Before continuing, consider your subscription strategy. Is a single subscription enough to deliver on your cloud adoption plan?

### First two subscriptions

At a minimum, you'll likely need two subscriptions: production and nonproduction.

:::image type="content" source="../media/initial-subscription-model.png" alt-text="An initial subscription model showing keys next to boxes labeled production and nonproduction." border="false":::
_Figure 1: An initial subscription model with keys next to **production** and **nonproduction** boxes._

- Create one Azure subscription to contain your production workloads.
- Create a second subscription to serve as your nonproduction (dev/test) environment, using an [Azure Dev/Test offer](https://azure.microsoft.com/pricing/dev-test?azure-portal=true) for lower pricing.

This approach has many benefits:

- Using separate subscriptions for your production and nonproduction environments creates a boundary that makes management of your resources simpler and safer.
- Azure Dev/Test subscription offerings are available for nonproduction workloads. These offerings provide discounted rates on Azure services and software licensing.
- Your production and nonproduction environments will likely have different sets of Azure policies. Using separate subscriptions makes it simple to apply each distinct policy at the subscription level.
- You can allow certain types of Azure resources in your nonproduction subscription for testing purposes. You can enable those resource providers in your nonproduction subscription without making them available in your production environment.
- You can use dev/test subscriptions as isolated sandbox environments. These sandboxes allow administrators and developers to rapidly build up and tear down entire sets of Azure resources. This isolation can also help with data protection and security concerns.
- The acceptable cost thresholds that you define will likely vary between production and dev/test subscriptions.

### Sandbox subscriptions

If innovation goals are part of your cloud adoption strategy, consider creating one or more sandbox subscriptions. You can apply security policies to keep these test subscriptions isolated from your production and nonproduction environments. Users can easily experiment with Azure capabilities in these isolated environments. Use an Azure Dev/Test offer to create these subscriptions.

:::image type="content" source="../media/initial-subscription-model-with-sandboxes.png" alt-text="Image showing an initial subscription model showing keys next to boxes labeled production, nonproduction, and sandboxes." border="false":::
_Figure 2: A subscription model with sandbox subscriptions._

### Shared services subscription

If you're planning to host **more than 1,000 virtual machines or compute instances in the cloud within 24 months**, create another Azure subscription to host shared services. This will prepare you to support your end-state enterprise architecture. If you plan to implement enterprise operations, you may wish to further subdivide your shared services subscriptions to be feature-specific. For more information, see the **Start with enterprise-scale** Learn modules.

:::image type="content" source="../media/initial-subscription-model-with-shared-services.png" alt-text="An image showing an initial subscription model showing keys next to boxes labeled production and shared services." border="false":::
_Figure 3: A subscription model with shared services._

### Plan for subscription scaling

As cloud adoption grows, you may need to further subdivide your production subscriptions for a number of valid business reasons. This is true for central or enterprise operations. For more information on subscription scaling, see [Scale with multiple subscriptions](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/scale-subscriptions?azure-portal=true).

## Adhere to naming and tagging conventions

Organize your cloud assets to support operational management and accounting requirements. Well-defined naming and metadata tagging conventions help to quickly locate and manage resources. These conventions also help associate cloud usage costs with business teams via chargeback and showback accounting mechanisms.

Changing resource names can be difficult. Establish a comprehensive naming convention before you begin any large cloud deployment.

The article on [recommended naming and tagging conventions](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging?azure-portal=true) provides guidance, samples, automated approaches, and a Microsoft Excel workbook to capture and socialize your naming and tagging conventions.

## Review networking options

The CAF Migration landing zone blueprint demonstrates network configuration, but provides little actionable configuration. You'll need to refactor the network configuration in that blueprint prior to deploying workloads to the new landing zone.

- [Review networking options](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/considerations/networking-options?azure-portal=true) for some of the network options to consider.
- [Evaluate a network perspective](https://docs.microsoft.com/azure/cloud-adoption-framework/reference/networking-vdc?azure-portal=true) to see a number of ways to combine those network options to create a virtual datacenter within your Azure environment.
- [Plan for your virtual networks](https://docs.microsoft.com/azure/virtual-network/virtual-network-vnet-plan-design-arm?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json&azure-portal=true).
- [Follow best practices for network security](https://docs.microsoft.com/azure/security/fundamentals/network-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json&azure-portal=true).

## Implement additional identity and access management considerations

Similar to network, the CAF Migration landing zone blueprint deploys a basic role-based access control (RBAC) requirement. But you will likely want to refactor that requirement to include deeper identity considerations. For more information, see [RBAC considerations](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/considerations/roles?azure-portal=true).

## Plan for parallel maturity of Govern, Security, and Manage methodologies

The above steps help you prepare for your first cloud adoption efforts. However, to reach true scale in the cloud, you'll need to continue to invest in your Azure landing zones to reach operating model requirements regarding governance, security, and operations management. Each of these requirements is addressed in parallel methodologies in the Cloud Adoption Framework and their associated Learn modules.

> [!IMPORTANT]
> If parallel maturity is not a desirable approach, consider completing the CAF Enterprise-Scale Learn modules. The approach covered in those modules will guide you through a richer implementation option of Azure landing zones. That approach provides an opinionated implementation for all of the above considerations. That implementation establishes an environment that's ready to support enterprise operations.
