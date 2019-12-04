You've identified the development resources that have been wrongly added to the production resource group. Now, you want to assess whether those development resources can be moved to a dedicated resource group. Some resources can't be moved, while it's OK to move others with certain restrictions.

In this unit, you'll learn:

- How to identify the resource types in the resource group.
- How to check resource types against an approved move list, and check for limitations on moving identified resource types.

## Identify your resource types

First you need to identify the resource type of the resources you want to move. In the Azure portal, you can see the resource type for each resource in the **All resources** page. The same **Type** column is also included in the list of resources in a resource group.

![Viewing the resource types](../media/4-view-resource-types.png)

## Check the limitations on resource types

After identifying the resource types of your resources, you must investigate whether they can be moved and the restrictions that might be in place. Check your resource types against the [move support for resources](https://docs.microsoft.com/azure/azure-resource-manager/move-support-resources) list. The list shows whether each resource type can be moved between resource groups or between subscriptions. For example:

- Azure Active Directory domain services can't be moved.
- Azure Backup vaults can't be moved.
- Azure Storage accounts can be moved.
- Azure Compute virtual machines can be moved.
- Azure virtual networks can be moved.
- Azure App Service web apps can be moved, but you can't move any third-party SSL certificates that they use.
- Azure App Service gateways can't be moved.

In your case, you'll need to move a pair of storage accounts that support the development version of an application. The storage accounts have been put into the production resource group wrongly. According to the move operation support for resources list, you can move these storage accounts between resource groups and between subscriptions without any limitations.

The list also gives links to guidance on moving specific resource types. For example, in the list you'll see that App Service resources have some limitations. The move guidance for Azure App Service states that, if you're moving a Web App to another resource group in the same subscription, you can't automatically move third-party SSL certificates. 

Virtual machines have their own limitations you must keep in mind. Here's a summary of limitations for virtual machines:

- If you want to move a virtual machine, all of its dependants must go with it.  
- You can't move virtual machines with certificates in Key Vault between subscriptions.
- You can't move virtual machine scale sets with standard load balancers or standard public IP.
- You can't move any managed disks that are in availability zones to different subscriptions.

Consider all the relevant limitations before attempting to move your resources. You can then decide which resources are candidates for a move.