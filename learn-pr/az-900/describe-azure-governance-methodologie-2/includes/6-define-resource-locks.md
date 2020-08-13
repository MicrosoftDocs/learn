## Resource locks
Even with role-based access control defined, there is still a risk that people with the right level of access could delete critical cloud resources. Azure provides a warning system to help remind people that a resource should not be deleted, by protecting it with a resource lock.

**The Tailwind Traders tidy-up** - With the good intention of cleaning up unnecessary resources in Azure, an IT Admin has accidentally deleted resources that appeared to be unused, but were critical to some seasonal applications. You are investigating resource locks to see if they can help prevent this type of incident from happening in the future. 

> [!NOTE]
> Resource locks do not completely prevent resource deletion. Instead, the lock must first be removed and then a deletion can be actioned.  

### What are resource locks?

[Resource locks](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-lock-resources?azure-portal=true) can be managed from within the Azure portal, via PowerShell, via the Azure CLI or defined in an Azure Resource Manager Template. To view, add, or delete locks in the Azure portal, go to the **SETTINGS** section of any resource's settings blade.
<div style="background: yellow;">
TODO: 
Describe this better or diagram the actual blade section (menu)
</div>

:::image type="content" source="../media/resource-locks.png" alt-text="Screenshot of the add Lock page.":::

You can add a lock to a subscription, to a resource group, or to an individual resource to prevent other users in your organization from accidentally deleting or modifying critical resources. You can set the lock level to **CanNotDelete** or **ReadOnly**:

+ **CanNotDelete** means authorized people can still read and modify a resource, but they can't delete the resource without removing the lock first. 

+ **ReadOnly** means authorized people can read a resource, but they can't delete or update the resource. Applying this lock is like restricting all authorized users to the permissions granted by the Reader role. 

When a resource lock is applied, you must first remove the lock in order to perform that activity. By putting an additional step in place before allowing the action to be taken on the resource, it helps protect resources from inadvertent actions, and helps protect your administrators from doing something they may not have intended to do. Resource locks apply regardless of RBAC permissions. Even if you are an owner of the resource, you must still remove the lock before you'll actually be able to perform the blocked activity.

At Tailwind Traders, you have decided to implement the following resource locks:
<div style="background: yellow;">
TODO: 
Diagram
</div>