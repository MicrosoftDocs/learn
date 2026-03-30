As your cloud usage grows, it's increasingly important to stay organized. A good tagging strategy helps you understand your cloud usage and helps you manage costs.

One way to organize related resources is to place them in their own subscriptions. You can also use resource groups to manage related resources. Resource tags are another way to organize resources. Tags provide extra information, or metadata, about your resources. This metadata is useful for:

:::image type="content" source="../media/resource-tag-use-cases.png" alt-text="Diagram showing six resource tag use cases: resource management, cost management, operations, security, governance, and automation.":::

 -  **Resource management** Tags enable you to locate and act on resources that are associated with specific workloads, environments, teams, and owners.
 -  **Cost management and optimization** Tags enable you to group resources so that you can report on costs, allocate internal cost centers, track budgets, and forecast estimated cost.
 -  **Operations management** Tags enable you to group resources according to how critical their availability is to your operations. This grouping helps you formulate service-level agreements (SLAs). An SLA is an uptime or performance guarantee between you and your users.
 -  **Security** Tags enable you to classify data by its security level, such as public or confidential.
 -  **Governance and regulatory compliance** Tags enable you to identify resources that align with governance or regulatory compliance requirements, such as ISO 27001. Tags can also be part of your standards enforcement efforts. For example, you might require that all resources be tagged with an owner or department name.
 -  **Workload optimization and automation** Tags can help you visualize all of the resources that participate in complex deployments. For example, you might tag a resource with its associated workload or application name and use software such as Azure DevOps to perform automated tasks on those resources.

A practical starter tag set for many teams is `Environment`, `Owner`, `CostCenter`, and `Workload`. This set supports common day-to-day tasks such as filtering costs, finding service owners, and scoping automation.

## How do I manage resource tags?

You can add, modify, or delete resource tags through the Azure portal, PowerShell, the Azure CLI, Azure Resource Manager templates, or the REST API.

You can use Azure Policy to enforce tagging rules and conventions. For example, you can require that certain tags be added to new resources as they're provisioned. You can also define rules that reapply tags that have been removed. Resources don't inherit tags from subscriptions and resource groups, meaning that you can apply tags at one level and not have those tags automatically show up at a different level, allowing you to create custom tagging schemas that change depending on the level (resource, resource group, subscription, and so on).

### An example tagging structure

A resource tag consists of a name and a value. You can assign one or more tags to each Azure resource.

| **Name**    | **Value**                                                                                                         |
| ----------- | ----------------------------------------------------------------------------------------------------------------- |
| AppName     | The name of the application that the resource is part of.                                                         |
| CostCenter  | The internal cost center code.                                                                                    |
| Owner       | The name of the technical or service owner who's responsible for the resource.                                    |
| Environment | An environment name, such as "Prod," "Dev," or "Test."                                                            |
| Impact      | How important the resource is to operations, such as "Mission-critical," "High-impact," or "Low-impact."        |

Keep in mind that you don't need to enforce that a specific tag is present on all of your resources. For example, you might decide that only mission-critical resources have the Impact tag. All non-tagged resources would then not be considered as mission-critical.

