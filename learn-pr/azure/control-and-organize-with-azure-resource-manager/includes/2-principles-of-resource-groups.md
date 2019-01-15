In your first week on your new job, you've been taking a look through the existing resources in your company's Azure subscription. There are a number of resource groups that contain many different resources, but they are not organized into a coherent structure. You've worked on Azure before, but aren't entirely sure how resource groups work and what their role is. You've guessed (correctly) that they can play a role in how you organize your resources. Let's take a look at what they are, and how they can be used.

> [!NOTE]
> For this module, you can use your own subscription to follow along. We'll be working with resources that will have no cost associated with them, so a trial subscription or a subscription you already have access to will work to follow along with these exercises.

[!INCLUDE [azure-free-trial-note](../../../includes/azure-free-trial-note.md)]

## What are resource groups?

Resource groups are a fundamental element of the Azure platform. A resource group is a logical container for resources deployed on Azure. These resources are anything you create in an Azure subscription: virtual machines, Application Gateways, CosmosDB instances, etc. All resources must reside in a resource group and a resource can only be a member of a single resource group. Resources can be moved between resource groups at any time. Resource groups cannot be nested. Before any resource can be provisioned, you need a resource group for it to be placed in.

### Logical grouping

Resource groups exist to help manage and organize your Azure resources. By placing resources of similar usage, type, or location, you can provide some order and organization to resources you create on Azure. Logical grouping is the aspect that we're most interested in here, since there's a lot of disorder amongst our resources.

![Conceptual image showing a resource group box with a Function, VM, database and app included](../media/2-rg.PNG)

### Life-cycle

If you delete a resource group, all resources contained within are also deleted. Organizing resources by life cycle can be useful in non-production environments, where you might try an experiment, but then dispose of it when done. Resource groups make it easy to remove a set of resources at once.

### Authorization 

Resource groups are also a scope for applying role-based access control (RBAC) permissions. By applying RBAC permissions to a resource group, you can ease administration and limit access to allow only what is needed.

## Create a Resource Group

Resource groups can be created by using the following methods:

- Azure portal
- Azure PowerShell
- Azure CLI
- Templates
- Azure SDKs (.NET, Java, etc.)

Let's walk through the steps you'd take to create a resource group in the Azure portal. If you'd like to follow along in your own subscription, you may.

1. Open a web browser and sign into the [Azure portal](https://portal.azure.com/?azure-portal=true).

    > [!IMPORTANT]
    > Make sure to use your _own_ subscription. When you are in the free sandbox environment, it will not allow you to create resource groups. You can tell which subscription you are by looking at the tenant name under your profile picture. You can switch tenants by clicking on your profile picture and selecting **Switch Directory** from the options menu.

1. On the left blade, select **+ Create a resource**

1. Click the plus sign to add a new resource group. Type **Resource Group** in the search box and hit Enter.

1. The first item in the list should be the resource group resource. Select it and then click the **Create** button.

    ![Search results searching the marketplace for a new resource group](../media/2-create-search-resource-group.png)

1. Enter your resource group name, let's use **msftlearn-core-infrastructure-rg**. Select the subscription it should reside in, and select the region for the resource group. Click **Create** to create the resource group.

    ![Fill in the required fields to create the resource group](../media/2-create-resource-group.png)

That's it, you've created a resource group that you can now use when you deploy Azure resources. Let's take a closer look at the resource group we just created and some important things to consider.

## Explore a resource group and add a resource

In the portal, select **Resource groups** on the left menu, and select your newly created resource group.

![Overview panel of resource group](../media/2-rg-overview.png)

On the Overview panel, we can see basic information about the resource group such as the subscription it resides in, the subscription ID, any tags that are applied, and a history of the deployments to this resource group. We'll cover tags in the next unit. The deployments link takes you to a new panel where you can see the history of all deployments to this resource group. Any time you create a resource, it's a deployment, and you can see that history for the resource group here.

Across the top you can add more resources, change the columns in the list, move the resource group to another subscription, or delete it entirely.

On the left menu, there are a number of options

We don't have any resources in this resource group yet, so the list at the bottom is empty. Let's create a couple resources inside the resource group.

1. Click **+ Add** at the top or click the **Create resources**, either will work. This shows a panel with the marketplace.

1. Search for **Virtual network**. The first result should be the virtual network resource. Click it, and on the subsequent screen click **Create**.

1. Name the virtual network **msftlearn-vnet1**. For the **Resource group** drop-down, select the **msftlearn-core-infrastructure** resource group. Leave the defaults for all other options, and click **Create**.

1. Repeat the steps again to create one more VNet. Name it **msftlearn-vnet2** and make sure to place it in the **msftlearn-core-infrastructure** resource group.

1. Go back to your resource group, and on the **Overview** panel you should see the two VNets you created.

    ![Overview panel of resource group showing the VNet](../media/2-rg-with-vnet.png)

Our resource group now contains two virtual network resources because we specified in our deployment (when we created the resources) which resource group we wanted the VNet to be placed in. We could create additional resources inside this resource group, or we could create additional resource groups in the subscription to deploy resources into.

When creating resources, you usually have the option to create a new resource group as an alternative to using an existing resource group. This simplifies the process a bit, but as you see in your new organization, can lead to resources spread across resource groups with little thought as to how to organize them.

## Use resource groups for organization

So how can you use resource groups to your advantage in your new organization? There are some guidelines and best practices that can help with the organization.

### Consistent naming convention

You can start with using an understandable naming convention. We named our resource group **msftlearn-core-infrastructure-rg**. We've given some indication of what it's used for (**msftlearn**), the types of resources contained within (**core-infrastructure**), and the type of resource it is itself (**rg**). This descriptive name gives us a better idea of what it is. If we had named it **my-resource-group** or **rg1**, we have no idea on a glance of what the usage may be. In this case, we can deduce that there are probably core pieces of infrastructure contained within. If we created additional VNets, storage accounts, or other resources the company may consider _core infrastructure_ we could place them here as well, improving the organization of our resources. Naming conventions can vary widely between and even within companies, but a little bit of planning can help.

### Organizing principles

Resource groups can be organized in a number of ways, let's take a look at a few examples. In our example, we might put all resources deemed _core infrastructure_ into this resource group, but we could also organize them strictly by resource type, putting all VNets in one resource group, all storage accounts in another resource group, all Cosmos DB instances in yet another resource group, and so on.

![Image of resources organized by type](../media/2-resource-type-rg.png)

We could organize them by environment (prod, test, dev). In this case, all production resources are in one resource group, all test resources are in another resource group, and so on.

![Image of resources organized by environment](../media/2-environment-rg.png)

We could organize them by department (marketing, finance, human resources). Marketing resources go in one resource group, finance in another resource group, and HR in a third resource group.

![Image of resources organized by department](../media/2-department-rg.png)

We could even use a combination of these, organizing by environment and department in this case. Production finance resources are in one resource group, dev finance resources in another, and the same for the marketing resources.

![Image of resources organized by environment and department](../media/2-env-dept-rg.png)

There are a few factors that can play into the strategy you use to organize resources: authorization, resource life-cycle, and billing.

#### Organizing for authorization

Since resource groups are a scope of RBAC, you can organize resources by _who_ needs to administer them. If you database administration team is responsible for managing all of your Azure SQL Database instances, putting them in the same resource group would simplify administration, as you could give them the proper permissions at the resource group level to administer the databases within the resource group. Similarly, the database administration team could be denied access to the resource group with virtual networks, so they don't inadvertently make changes to resources outside the scope of their responsibility.

#### Organizing for life-cycle

We mentioned earlier that resource groups serve as the life cycle for the resources within, deleting a resource group will delete all the resources contained within. Use this to your advantage, especially in areas where resources are more disposable, such as non-production environments. If you deploy 10 servers for a project that you know will only last a couple of months, when the time comes to clean it up it will be easier to clean up if you place them all in a single resource group instead of 10 or more resource groups.

#### Organizing for billing

Lastly, placing resources in the same resource group is a way to group them for usage in billing reports. If you are trying to understand how your costs are distributed in your Azure environment, grouping them by resource group is one way to filter and sort the data to better understand where costs are allocated.

## Summary

The bottom line is that you have flexibility in how to organize resources in your resource groups. Put some thought into it so that you have a coherent approach to how you use resource groups in your Azure environment.
