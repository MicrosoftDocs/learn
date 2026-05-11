Azure Policy prevents noncompliant resources from being created, but critical resources that already exist and are correctly configured still need protection from accidental or malicious deletion. For Contoso's security team, a misconfigured deployment script or an overprivileged account could delete the production virtual network or a Recovery Services vault, causing a major outage. Here, you learn how to configure resource locks. Locks prevent deletion or modification of critical resources, understand lock inheritance behavior, and control who can create and remove locks.

| Lock type | Effect | Common use cases |
|-----------|--------|------------------|
| **Delete** | Prevents resource deletion; allows read and write operations | Virtual networks, Network Security Groups (NSGs), Recovery Services vaults, Key Vaults, DNS zones |
| **ReadOnly** | Prevents resource deletion and modification; allows read operations only | Configuration-only resources with no runtime write operations |

## Understand the difference between Delete and ReadOnly locks

Resource locks provide two levels of protection, each suited to different scenarios. With a Delete lock, Azure prevents the resource from being deleted while still allowing all read and write operations to succeed. This lock type protects production resources from accidental deletion without interfering with normal operations, making it the most commonly used lock type.

With a ReadOnly lock, Azure prevents the resource from being deleted or modified, allowing only read operations. This lock type requires careful consideration because it can cause unexpected failures in some scenarios. For example, applying a ReadOnly lock to an Azure Storage account prevents listing storage keys, because key listing is treated as a write action even though it appears to be read-only. Similarly, a ReadOnly lock on a virtual network can prevent virtual machines from starting in some configurations.

Use Delete locks on resources where deletion would be catastrophic and recovery would be slow: virtual networks, network security groups, Recovery Services vaults, Key Vaults, and core DNS zones. Reserve ReadOnly locks for resources that are genuinely configuration-only and have no runtime write operations.

## Use lock inheritance to protect multiple resources

Locks applied to a parent scope automatically protect all child resources, reducing the administrative burden of protecting large resource groups or subscriptions. When you apply a lock to a resource group, every resource in that group inherits the lock. When you apply a lock to a subscription, every resource group and resource in that subscription inherits the lock.

Understanding inheritance behavior helps you apply locks efficiently. Child resources inherit parent locks but don't display the lock in their own lock list. The lock appears only on the parent scope where it was created. A single Delete lock applied to Contoso's `network-core-rg` resource group protects all virtual networks, subnets, and network security groups in that group without requiring individual locks on each resource.

Locks applied directly to a specific resource protect only that resource and don't affect other resources in the same resource group. This granular approach works well when most resources in a group are safe to delete, but a few critical resources need protection.

## Control who can create and remove locks

Resource locks provide separation of duties between users who manage resources and users who control governance. Creating or deleting a resource lock requires the `Microsoft.Authorization/locks/write` and `Microsoft.Authorization/locks/delete` permissions, which are granted by the **Owner** and **User Access Administrator** built-in roles.

The Contributor role grants permission to create, update, and delete resources but doesn't include permission to manage locks. This design ensures that developers with Contributor access can manage their resources but can't remove locks applied by the security or governance team.

> [!NOTE]
> Resource locks override all role-based access control (RBAC) role assignments, including Owner. When a lock is applied, users must remove the lock before they can delete or modify the resource, regardless of their role. This enforcement applies universally; even subscription Owners can't delete a locked resource until the lock is removed.

## Apply a resource lock in the portal

Protecting a critical resource with a lock requires just a few steps in the Azure portal:

1. Navigate to the resource or resource group you want to protect
2. Under **Settings**, select **Locks**
3. Select **+ Add**
4. Enter a **Lock name** that describes the purpose (for example, `network-core-delete-lock`)
5. Set **Lock type** to **Delete** or **ReadOnly** based on the required protection level
6. Optionally add notes explaining why the lock is applied and when it can be removed
7. Select **OK**

The lock now appears in the resource's lock list. Any attempt to delete the resource results in an error message indicating the lock must be removed first. Users with appropriate permissions can return to the **Locks** pane and select **Delete** to remove the lock when needed.

## Enforce locks at scale with Azure Policy

Applying locks manually works for known critical resources, but new resources provisioned without locks reintroduce the risk. Use a built-in or custom Azure Policy definition with a **DeployIfNotExists** effect to automatically deploy a Delete lock on resources that match specific criteria, such as all Recovery Services vaults or all production virtual networks tagged `Environment: Production`.

This approach connects back to the policy remediation concepts from the previous unit. A DeployIfNotExists policy with a remediation task creates locks on existing resources and ensures that new resources receive locks automatically during provisioning. This scalable mechanism enforces lock protection across Contoso's entire Azure estate without manual intervention.
