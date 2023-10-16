In your first week on your new job, you've looked through the existing resources in your company's Azure subscription. There are a number of resource groups that contain many different resources, but they aren't organized into a coherent structure. You've worked on Azure before, but aren't entirely sure how resource groups work and what their role is. You've guessed (correctly) that they can play a role in how you organize your resources. Let's look at what they are and how they can be used.

[!INCLUDE [azure-free-trial-note](../../../includes/azure-free-trial-note.md)]

<br/>

> [!VIDEO https://channel9.msdn.com/Shows/Learn-Azure/Azure-Resource-Manager/player?format=ny]

## What are resource groups?

Resource groups are a fundamental element of the Azure platform. A resource group is a logical container for resources deployed on Azure. These resources are anything you create in an Azure subscription, like virtual machines, Application Gateways, and Cosmos DB instances. All resources must be in a resource group, and a resource can only be a member of a single resource group. Many resources can be moved between resource groups, with some services having specific limitations or requirements to move. Resource groups can't be nested. Before you can provision any resource, you need a resource group in which to place it.

### Logical grouping

Resource groups exist to help manage and organize your Azure resources. By placing resources of similar usage, type, or location into resource groups, you can provide some order and organization to resources you create in Azure. Logical grouping is the aspect that you're most interested in here, because there's a lot of disorder among your company's resources.

![Conceptual image showing a resource group box with a Function, VM, database, and app included.](../media/2-rg.png)

### Lifecycle

If you delete a resource group, all resources contained within the group are also deleted. Organizing resources by lifecycle can be useful in non-production environments, where you might try an experiment and dispose of it when done. Resource groups make it easy to remove a set of resources at once.

### Authorization

Resource groups are also a scope for applying role-based access control (RBAC) permissions. By applying RBAC permissions to a resource group, you can reduce administration and limit access to allow only what's needed.

## Create a resource group

You can create resource groups by using the following methods:

- Azure portal
- Azure PowerShell
- Azure CLI
- Templates
- Azure SDKs (like .NET or Java)

Let's walk through the steps you'd take to create a resource group in the Azure portal. If you'd like to follow along in your own subscription, you can.

1. Open a web browser and sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).

    > [!IMPORTANT]
    > Make sure to use your _own_ subscription. Free sandbox environments don't allow you to create resource groups. You can tell which subscription you're using by looking at the tenant name under your profile picture at the top-left of the screen. You can switch tenants by selecting your profile picture and selecting **Switch Directory** from the options menu.

1. On the Azure portal or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the *Search services and marketplace* search box, search for and select *Resource group*. The **Resource group** pane appears.

1. Select **Create**. The **Create a resource group** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project details** |
    | Subscription | From the dropdown list, select the Azure subscription you'd like to use for this exercise. |
    | Resource group | Enter *msftlearn-core-infrastructure-rg*. |
    | **Resource details** |
    | Region | From the dropdown list, select a location close to you. |

    :::image type="content" source="../media/2-create-rg.png" alt-text="Screenshot of Azure portal showing the resource group creation with subscription, resource group, and region entered.":::

1. Select **Review + Create**, and after validation passes, select **Create** to create the resource group.

That's it, you've created a resource group that you can now use when you deploy Azure resources. Let's take a closer look at this resource group and some important things to consider.

## Explore a resource group and add a resource

1. On the Azure portal menu or from the **Home** page, under **Azure services**, select **Resource groups**.

1. From the list, select your newly created resource group. The **Resource group** pane appears.

    > [!NOTE]
    > You might also see a resource group called _NetworkWatcherRG_. You can ignore this resource group, as it's created automatically to enable Network Watcher in Azure virtual networks.

    :::image type="content" source="../media/2-resource-group-overview.png" alt-text="Screenshot of Azure portal showing new resource group pane with no resources in it yet.":::

1. On the **Overview** page, you'll find the basic information about the resource group, such as its subscription, the subscription ID, any tags that are applied, and a history of the deployments to this resource group. We'll cover tags in the next unit. If you expand **Essentials** at the top of the page, you'll find the **Deployments** link, which takes you to a new panel with the history of all deployments to this resource group. Whenever you create a resource, it's a deployment, and you'll see the history for each resource group here.

    Using the toolbar across the top of the resource group page, you can add more resources, change the columns in the list, move the resource group to another subscription, or delete it entirely.

    On the left menu, there are a number of options.

    You don't have any resources in this resource group yet, so the list at the bottom is empty. Let's create a couple of resources in the resource group.

1. In the top menu bar, select **Create**, or select the **Create resources** button at the bottom of the pane; either will work. The **Create a resource** pane appears.

1. In the _Search services and marketplace_ search box, search for and select **Virtual network**. The **Virtual network** pane appears.

1. Select **Create**. The **Create virtual network** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project details** |
    | Subscription | From the dropdown list, select the Azure subscription you'd like to use for this exercise. |
    | Resource group | Ensure *msftlearn-core-infrastructure-rg* appears. |
    | **Instance details** |
    | Name | Enter *msftlearn-vnet1*. |
    | Region | From the dropdown list, select a location close to you. |

1. Select **Review + create**, and after validation passes, select **Create** to add the virtual network to your resource group.

1. Repeat the virtual network creation steps again to create one more virtual network. Make sure to place the virtual network in the resource group that you created earlier, and name the virtual network _msftlearn-vnet2_.

1. Go back to your resource group. The two virtual networks you created should appear on the **Overview** pane.

    :::image type="content" source="../media/2-resource-group-vnet.png" alt-text="Screenshot of Azure portal showing resource group overview containing two virtual network resources.":::

Your resource group contains two virtual network resources, because you specified the resource group when you created the resources. You could create more resources inside this resource group, or you could create more resource groups in the subscription and deploy resources into those resource groups.

When creating resources, you usually have the option to create a new resource group as an alternative to using an existing resource group. This might simplify the process, but as you see in your new organization, doing so can lead to resources spread across resource groups with little thought as to how to organize them.

## Use resource groups for organization

So, how can you use resource groups to your advantage in your new organization? Here are some guidelines and best practices that can help with the organization.

### Consistent naming convention

You can start with using an understandable naming convention. You named your resource group **msftlearn-core-infrastructure-rg**. You've given some indication of what it's used for (**msftlearn**), the types of resources contained within (**core-infrastructure**), and the type of resource it is (**rg**). This descriptive name gives us a better idea of what it is. If you had named it **my-resource-group** or **rg1**, you'd have no idea on a glance of what the usage may be. In this case, you can deduce that there are probably core pieces of infrastructure contained within. If you created more virtual networks, storage accounts, or other resources that the company might consider _core infrastructure_, you could also place them here to improve your company's resource organization. Naming conventions can vary widely between and even within companies, but some planning can help.

### Organizing principles

You can organize resource groups in a number of ways; let's take a look at a few examples. You might put all resources that are _core infrastructure_ into this resource group, but you could also organize resources strictly by resource type. For example, you might put all virtual networks in one resource group, all virtual machines in another resource group, and all Azure Cosmos DB instances in another resource group.

![Diagram of resources grouped by type: vnet-rg for virtual networks, vm-rg for virtual machines, and db-rg for databases.](../media/2-resource-type-rg.png)

You could organize them by environment (prod, qa, dev). In this case, all production resources are in one resource group, all test resources are in another resource group, and so on.

![Diagram of resources grouped by environment: prod-rg for production, qa-rg for QA, and dev-rg for development.](../media/2-environment-rg.png)

You could organize them by department (marketing, finance, human resources). Marketing resources go in one resource group, finance in another resource group, and HR in a third resource group.

![Diagram of resources grouped by department: finance-rg for finance, marketing-rg for marketing, and hr-rg for HR.](../media/2-department-rg.png)

You could even use a combination of these strategies and organize by environment and department. Put production finance resources in one resource group, dev finance resources in another, and the same for the marketing resources.

![Diagram of resources grouped by environment and department: prod-finance, dev-finance, prod-marketing, and dev-marketing.](../media/2-env-dept-rg.png)

There are a few factors that can play into the strategy you use to organize resources: authorization, resource lifecycle, and billing.

#### Organize for authorization

Because resource groups are a scope of RBAC, you can organize resources by _who_ needs to administer them. If your database administration team is responsible for managing all of your Azure SQL Database instances, putting them in the same resource group simplifies administration. You could give the team the proper permissions at the resource-group level to administer the databases within the resource group. Similarly, the database administration team could be denied access to the resource group with virtual networks so they don't inadvertently make changes to resources outside their scope of responsibility.

#### Organize for lifecycle

We previously described that resource groups serve as the lifecycle for the resources within them. If you delete a resource group, you also delete all the resources in the group. Use this to your advantage, especially in areas where resources are more disposable, like non-production environments. If you deploy 10 servers for a project that you know will only last a couple of months, you might put them all in a single resource group. One resource group is easier to clean up than 10 or more resource groups.

#### Organize for billing

Lastly, placing resources in the same resource group is a way to group them for usage in billing reports. If you're trying to understand how your costs are distributed in your Azure environment, grouping them by resource group is one way to filter and sort the data to better understand where costs are allocated.

## Summary

The bottom line is that you have flexibility in how to organize resources in your resource groups. Put some thought into it so that you have a coherent approach to how you use resource groups in your Azure environment.
