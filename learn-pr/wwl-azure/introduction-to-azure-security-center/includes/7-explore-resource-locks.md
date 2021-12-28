**Locks** help you prevent accidental deletion or modification of your Azure resources. You can manage locks from within the Azure portal.

In the Azure portal, locks are called **Delete** and **Read-only,** respectively.

Go to the Settings section on the resource's settings blade to review, add, or delete locks for a resource in the Azure portal.

You might need to lock a subscription, resource group, or resource to prevent users from accidentally deleting or modifying critical resources.

You can set a lock level to **CanNotDelete** or **ReadOnly**:

 -  **CanNotDelete** means that authorized users can read and modify a resource, but they can't delete it.
 -  **ReadOnly** means that authorized users can read a resource, but they can't modify or delete it.

You can read more about Locks on the [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/resource-group-lock-resources) webpage.
