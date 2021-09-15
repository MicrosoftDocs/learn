A common concern with resources provisioned in Azure is the ease with which they can be deleted. An over-zealous or careless administrator can accidentally erase months of work with a few steps. Resource Manager locks allow organizations to put a structure in place that prevents the accidental deletion of resources in Azure.

 -  You can associate the lock with a subscription, resource group, or resource.
 -  Locks are inherited by child resources.

:::image type="content" source="../media/resource-manager-locks-853635fd.png" alt-text="Screenshot of the Management locks page. In the Settings options, Locks are highlighted and in the Add Lock page, the Lock type, Ready-only, and Delete option are displayed and highlighted.":::


## Lock types

There are two types of resource locks.

 -  **Read-Only locks**, which prevent any changes to the resource.
 -  **Delete locks**, which prevent deletion.

> [!NOTE]
> Only the Owner and User Access Administrator roles can create or delete management locks.
