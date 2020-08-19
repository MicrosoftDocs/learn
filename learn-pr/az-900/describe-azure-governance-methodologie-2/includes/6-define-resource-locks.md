A _resource lock_ prevents resources from being accidentally deleted or changed.

Even with Azure RBAC policies in place, there's still a risk that people with the right level of access could delete critical cloud resources. Think of a resource lock as a warning system that reminds you that a resource should not be deleted or changed.

For example, at Tailwind Traders, an IT administrator was performing routine cleanup of unused resources in Azure. They accidentally deleted resources that appeared to be unused. However, these resources were critical to an application that's used seasonally. How can resource locks help prevent this kind of incident from happening in the future?

## How do I manage resource locks?

You can manage resource locks from the Azure portal, PowerShell, the Azure CLI, from an Azure Resource Manager Template.

To view, add, or delete locks in the Azure portal, go to the **Settings** section of any resource's settings blade in the Azure portal.

<div style="background: yellow;">
TODO: 
Describe this better or diagram the actual blade section (menu)
</div>

:::image type="content" source="../media/resource-locks.png" alt-text="Screenshot of the add Lock page.":::

## What levels of locking are available?

You can apply locks to a subscription, to a resource group, or to an individual resource. You can set the lock level to **CanNotDelete** or **ReadOnly**.

* **CanNotDelete** means authorized people can still read and modify a resource, but they can't delete the resource without removing the lock first.

* **ReadOnly** means authorized people can read a resource, but they can't delete or change the resource. Applying this lock is like restricting all authorized users to the permissions granted by the **Reader** role.

## How do I delete or change a locked resource?

Although locking helps prevent accidental changes, you can still make changes by following a two-step process.

To modify a locked resource, you must first remove the lock. After you remove the lock, you can apply any action you have permissions to perform. This additional step allows the action to be taken, but helps protect your administrators from doing something they may not have intended to do.

Resource locks apply regardless of RBAC permissions. Even if you are an owner of the resource, you must still remove the lock before you you can perform the blocked activity.

At Tailwind Traders, you have decided to implement the following resource locks:
<div style="background: yellow;">
TODO: 
Diagram
</div>
