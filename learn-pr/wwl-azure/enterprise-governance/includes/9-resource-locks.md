As an administrator, you may need to lock a subscription, resource group, or resource to prevent other users in your organization from accidentally deleting or modifying critical resources. You can set the lock level to **CanNotDelete or ReadOnly**. In the portal, the locks are called **Delete and Read-only** respectively.

:::image type="content" source="../media/az500-resource-locks-1bb4601b.png" alt-text="Screenshot of adding a resource lock.":::


 -  **CanNotDelete** means authorized users can still read and modify a resource, but they can't delete the resource.
 -  **ReadOnly** means authorized users can read a resource, but they can't delete or update the resource. Applying this lock is similar to restricting all authorized users to the permissions granted by the Reader role.

### Who can create or delete locks

To create or delete management locks, you must have access to **`Microsoft.Authorization/*`**or `Microsoft.Authorization/locks/*` actions. Of the built-in roles, only **Owner** and **User Access Administrator** are granted those actions.
