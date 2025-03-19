Azure Resource Manager is the deployment and management service for Azure. It provides a consistent management layer that enables you to create, update, and delete resources in your Azure subscription. You can use its access control, auditing, and tagging features to secure and organize Azure resources.

The core concept of Azure Resource Manager is a *resource*. A resource is an elementary building block of services and solutions that you deploy into Azure. In order to facilitate resource management, Azure Resource Manager interacts with resource providers, which implement actions that you invoke through an administrative interface, such as the Azure portal, Azure PowerShell, Azure CLI, or REST API.

Every resource exists in one, and only one, resource group. A resource group is a logical container that simplifies managing multiple resources. Resources in the same resource group typically share the same lifecycle, although you have full flexibility in choosing your own criteria for grouping resources. By using resource groups, you can manage some aspects of resource configuration at the group level, rather than individually. For example, you can delegate permissions, identify cost, and audit events for all resources within a group in a single step. Additionally, when you no longer need the resources in a resource group, you can remove them by deleting the group in which they reside.

:::image type="content" source="../media/consistent-management-layer-d65508b4.png" alt-text="Diagram of an overview of Azure Resource Manager.":::

Azure Resource Manager imposes limits and quotas on how many resources of each type you can provision per Azure subscription and per Azure region. Some limits are hard maximums, while others are soft limits that can be increased upon request. When working with virtual machines, storage accounts, databases, and other resources in the Microsoft Azure cloud you can easily reach these limits, so it’s important to know they exist and how to work around them.

The Azure cloud is made up of physical hardware and there are limits to its scalability. As a result, there are some limitations on a per Azure subscription basis, via subscription limits and quotas. Knowing what the subscription limits are enables you to calculate whether you need multiple subscriptions, or whether you need to ask for an extension to increase limits, such as the number of CPUs.

> [!NOTE]
> A subscription is also the "financial" constraint with spending limits that require a request to extend.
