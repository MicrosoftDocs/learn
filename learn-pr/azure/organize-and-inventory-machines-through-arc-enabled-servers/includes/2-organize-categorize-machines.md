Azure Arc-enabled servers allow Tailwind Manufacturing to organize and inventory their hybrid and multicloud resources using the native capabilities of Azure management. Azure uses a management hierarchy for organizing resources. Once you've established a hierarchy that suits your organization's needs, you can create and use tags to quickly identify and arrange them by category. Tags can also be used for reporting purposes. Now Tailwind can secure, manage, and track the costs of workloads on their Arc-enabled servers.

## Organize resources into hierarchies

Azure provides four levels of management:

- **Management groups** help you manage access, policy, and compliance for multiple subscriptions. All subscriptions in a management group automatically inherit the conditions that are applied to the management group.

- **Subscriptions** logically associate user accounts with the resources that they create. Each subscription has limits or quotas on the amount of resources that it can create and use. Organizations can use subscriptions to manage costs and the resources that are created by users, teams, and projects.

- **Resource groups** are logical containers where you can deploy and manage Azure resources like web apps, databases, and storage accounts.

- **Resources** are instances of services that you can create, such as virtual machines, storage, and SQL databases. A VM onboarded to Arc-enabled servers is a resource.

These levels of management help to manage access, policies, and compliance more efficiently. For example, if you apply a policy at one level, it propagates down to lower levels, helping improve governance posture. Moreover, these levels can be used to scope policies and security controls. For Arc-enabled servers, the different business units, applications, or workloads can be used to derive the hierarchical structure in Azure. Once resources have been onboarded to Azure Arc, you can seamlessly move an Arc-enabled server between different resource groups and scopes

:::image type="content" source="../media/management-levels.png" alt-text="Flow chart of Azure management levels.":::

### Creating management structures

1. You can easily create a management group, subscription, or resource group from the [Azure portal](https://ms.portal.azure.com/):

1. To create a *management group* to help you manage multiple subscriptions, go to **Management groups** and select **Create**.

1. To create a *subscription* to associate users with resources, go to **Subscriptions** and select **Add**.

1. To create a *resource group* to hold resources that share the same permissions and policies:
    1. Go to [Create a resource group](https://ms.portal.azure.com/#create/Microsoft.ResourceGroup).
    1. In the **Create a resource group** form:
    1. For **Subscription**, select the subscription in which to create the resource group.
    - For **Resource group**, enter a name for the new resource group.
    - For **Region**, select a region in which to locate the resource group.
    - Select **Review + create**. When the review passes, select **Create**.

## Tagging resources to capture additional data

Tags are metadata elements you apply to your Azure resources. They're key-value pairs that help identify resources, based on settings relevant to your organization. For example, you can tag the environment for a resource as `Production` or `Testing`. Alternatively, you can use tagging to capture the ownership for a resource, separating the `Creator` or `Administrator`. Tags can also capture details on the resource itself, such as the physical datacenter, business unit, or workload. You can apply tags to your Azure resources, resource groups, and subscriptions. This extends to infrastructure outside of Azure as well, through Azure Arc.

You can define tags in Azure portal through a simple point and click method. Tags can be defined when onboarding servers to Azure Arc-enabled servers or on a per-server basis. Alternatively, you can use Azure CLI, Azure PowerShell, ARM templates, or Azure policy for scalable tag deployments. Tags can be used to filter operations as well, such as the deployment of extensions or service attachments. This provides not only a more comprehensive inventory of your servers, but also operational flexibility and ease of management.

## Tags and billing

You can use tags to group your billing data. If you're running multiple VMs for different organizations, for example, use the tags to group usage by cost center. You can also use tags to categorize costs by runtime environment, such as the billing usage for VMs running in the production environment.

### Applying tags

1. To view the tags for a resource or a resource group, look for existing tags in the overview. If you have not previously applied tags, the list is empty.

1. To add a tag, select **Add tags**.

1. Provide a name and value.

1. Continue adding tags as needed. When done, select **Save**.

1. The tags are now displayed in the overview.

