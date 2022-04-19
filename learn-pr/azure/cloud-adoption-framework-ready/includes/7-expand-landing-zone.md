With your CAF Migration landing zone blueprint deployed, it's time to begin expanding your landing zone. You do that through a process called refactoring.

To accelerate your early adoption efforts, we suggest minimizing the number of blocking steps. The following approach allows for rapid configuration of a landing zone to meet minimum technical requirements for deploying low-risk workloads:

- Assign the initial landing zone (the previous unit of this Learn module)
- Validate decisions for subscription scaling
- Adhere to naming and tagging conventions
- Review networking options
- Implement other considerations for identity and access management
- Plan for parallel maturity of Govern, Manage, and Security methodologies

> [!CAUTION]
> Although this approach meets minimum technical standards, it might not initially meet your minimum operational standards. If you must meet requirements for security, governance, or operations management before your first adoption effort, you might need to start executing that methodology before adoption. For an accelerated approach to an enterprise-ready environment, consider the options within the *Start with enterprise-scale* implementation.

## Validate decisions for subscription scaling

In the prior unit of this Learn module, you assigned the initial blueprint to a single subscription. Before you continue, consider your subscription strategy. Is a single subscription enough to deliver on your cloud adoption plan?

### First two subscriptions

At a minimum, you'll likely need two subscriptions:

- Create one Azure subscription to contain your *production* workloads
- Create a second subscription to serve as your *nonproduction* (dev/test) environment, by using an [Azure Dev/Test offer](https://azure.microsoft.com/pricing/dev-test/?azure-portal=true) for lower pricing

:::image type="content" source="../media/initial-subscription-model.png" alt-text="Diagram of an initial subscription model that shows keys next to boxes labeled production and nonproduction." border="false":::

*Figure 1: An initial subscription model with production and nonproduction subscriptions.*

This approach has many benefits:

- Using separate subscriptions for your production and nonproduction environments creates a boundary that makes management of your resources simpler and safer.
- Azure Dev/Test subscription offerings are available for nonproduction workloads. These offerings provide discounted rates on Azure services and software licensing.
- Your production and nonproduction environments will likely have different sets of Azure policies. Using separate subscriptions makes it simple to apply each distinct policy at the subscription level.
- You can allow certain types of Azure resources in your nonproduction subscription for testing purposes. You can enable those resource providers in your nonproduction subscription without making them available in your production environment.
- You can use Azure Dev/Test subscriptions as isolated sandbox environments. These sandboxes allow administrators and developers to rapidly build up and tear down entire sets of Azure resources. This isolation can also help with data protection and security concerns.
- The acceptable cost thresholds that you define will likely vary between production and Azure Dev/Test subscriptions.

### Sandbox subscriptions

If innovation goals are part of your cloud-adoption strategy, consider creating one or more sandbox subscriptions. You can apply security policies to keep these test subscriptions isolated from your production and nonproduction environments. Users can easily experiment with Azure capabilities in these isolated environments. Use an Azure Dev/Test offer to create these subscriptions.

:::image type="content" source="../media/initial-subscription-model-with-sandboxes.png" alt-text="Diagram of an initial subscription model that shows keys next to boxes labeled production, nonproduction, and sandboxes." border="false":::

*Figure 2: A subscription model with sandbox subscriptions.*

### Shared services subscription

If you're planning to host *more than 1,000 virtual machines or compute instances in the cloud within 24 months*, create another Azure subscription to host shared services. This subscription will prepare you to support your end-state enterprise architecture.

:::image type="content" source="../media/initial-subscription-model-with-shared-services.png" alt-text="Diagram of an initial subscription model that shows keys next to boxes labeled production and shared services." border="false":::

*Figure 3: A subscription model with shared services.*

If you plan to implement enterprise operations, you might want to further subdivide your shared services subscriptions to be feature specific. For more information, see the *Start with enterprise-scale* Learn modules.

### Plan for subscription scaling

As cloud adoption grows, you might need to further subdivide your production subscriptions for valid business reasons. This is true for central or enterprise operations. For more information on subscription scaling, see [Scale with multiple subscriptions](/azure/cloud-adoption-framework/ready/azure-best-practices/scale-subscriptions?azure-portal=true).

## Adhere to naming and tagging conventions

Organize your cloud assets to support operational management and accounting requirements. Well-defined conventions for naming and metadata tagging help to quickly locate and manage resources. These conventions also help to associate cloud-usage costs with business teams via chargeback and showback accounting mechanisms.

Changing resource names can be difficult. Establish a comprehensive naming convention before you begin any large cloud deployment.

The article on [recommended naming and tagging conventions](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging?azure-portal=true) provides guidance, samples, automated approaches, and a Microsoft Excel workbook to capture and socialize your naming and tagging conventions.

## Review networking options

The CAF Migration landing zone blueprint demonstrates network configuration, but it provides little actionable configuration. You'll need to refactor the network configuration in that blueprint before you deploy workloads to the new landing zone:

- [Review networking options](/azure/cloud-adoption-framework/ready/considerations/networking-options?azure-portal=true) for some of the network options to consider
- [Evaluate a network perspective](/azure/cloud-adoption-framework/reference/networking-vdc?azure-portal=true) to see ways to combine those network options to create a virtual datacenter within your Azure environment
- [Plan for your virtual networks](/azure/virtual-network/virtual-network-vnet-plan-design-arm?azure-portal=true&bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json)
- [Follow best practices for network security](/azure/security/fundamentals/network-best-practices?azure-portal=true&bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json)

## Implement other considerations for identity and access management

The CAF Migration landing zone blueprint deploys a basic role-based access control (RBAC) requirement. You'll likely want to refactor that requirement to include deeper identity considerations. For more information, see [RBAC considerations](/azure/cloud-adoption-framework/ready/considerations/roles?azure-portal=true).

## Plan for parallel maturity of Govern, Manage, and Secure methodologies

The preceding information helps you prepare for your first cloud-adoption efforts. To reach true scale in the cloud, you'll need to keep investing in your Azure landing zones to reach operating model requirements for governance, security, and operations management. The Cloud Adoption Framework and its associated Learn modules address each of these requirements in parallel methodologies.

> [!IMPORTANT]
> If parallel maturity is not an approach that you want, consider completing the Microsoft Learn modules for the Cloud Adoption Framework at enterprise scale. The approach covered in those modules will guide you through a richer implementation option of Azure landing zones. That approach provides an opinionated implementation for all of the considerations in this unit. That implementation establishes an environment that's ready to support enterprise operations.