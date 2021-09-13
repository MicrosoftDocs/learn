A common concern with resources provisioned in Azure is the ease with which they can be deleted. An over-zealous or careless administrator can accidentally erase months of work with a few steps. Resource Manager locks allow organizations to put a structure in place that prevents the accidental deletion of resources in Azure.

 -  You can associate the lock with a subscription, resource group, or resource.
 -  Locks are inherited by child resources.

:::image type="content" source="../media/resource-manager-locks-853635fd.png" alt-text="Screenshot of the Resource Manager Locks page with Locks highlighted in the resource menu and in the Add Lock pane, with Lock type dropdown open.":::


## Lock types

There are two types of Resource Manager locks.

 -  **Read-Only lock**: This type of lock prevents any changes to the resource, resource group, or subscription.
 -  **Delete lock**: This type of lock prevents the resource, resource group, or subscription from being deleted.

> [!NOTE]
> Only Owner and User Access Administrator roles can create, edit, or delete Resource Manager locks.
