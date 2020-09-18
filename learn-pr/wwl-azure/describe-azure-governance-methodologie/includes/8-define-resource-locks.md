## Resource locks

**Contoso, Ltd. Case Study** - In a recent conversation, your manager mentioned that there had been instances where critical Azure resources were mistakenly deleted. Since there was disorganization across their Azure environment, good intentions of cleaning up unnecessary resources resulted in accidental deletions of resources critical to other systems. You've heard of resource locks on Azure. You mention to your manager that you think you can help prevent this type of incident from happening in the future. You'll take a look at how you could use resource locks to solve this problem.

### What are resource locks?

[resource locks](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-lock-resources?azure-portal=true) help you prevent accidental deletion or modification of your Azure resources. You can manage these locks from within the Azure portal. To view, add, or delete locks, go to the **SETTINGS** section of any resource's settings blade.

:::image type="content" source="../media/resource-locks.png" alt-text="Screenshot of the add Lock page.":::

You may need to lock a subscription, resource group, or resource to prevent other users in your organization from accidentally deleting or modifying critical resources. You can set the lock level to **CanNotDelete** or **ReadOnly**:

+ **CanNotDelete** means authorized admins can still read and modify a resource, but they can't delete the resource. 

+ **ReadOnly** means authorized admins can read a resource, but they can't delete or update the resource. Applying this lock is like restricting all authorized users to the permissions granted by the Reader role. 

When a resource lock is applied, you must first remove the lock in order to perform that activity. By putting an additional step in place before allowing the action to be taken on the resource, it helps protect resources from inadvertent actions, and helps protect your administrators from doing something they may not have intended to do. Resource locks apply regardless of RBAC permissions. Even if you are an owner of the resource, you must still remove the lock before you'll actually be able to perform the blocked activity.
