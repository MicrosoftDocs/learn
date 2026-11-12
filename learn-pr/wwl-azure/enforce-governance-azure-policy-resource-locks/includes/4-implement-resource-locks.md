Azure Policy can assess and enforce resource configuration, but critical resources also need safeguards against accidental control-plane deletion or modification. For Contoso's security team, a misconfigured deployment script could delete the production virtual network or a Recovery Services vault, causing a major outage. Here, you learn how to configure resource locks, understand lock inheritance, and control who can create and remove locks.

Management locks restrict control-plane operations on Azure resources. They provide a useful safeguard against accidental changes, but aren't a substitute for access control, backups, or service-specific data protection. The two lock levels provide different restrictions.

| Portal lock level | Command/API value | Control-plane behavior |
|---|---|---|
| **Delete** | `CanNotDelete` | Blocks deletion while permitting otherwise authorized reads and updates |
| **Read-only** | `ReadOnly` | Blocks deletion and updates, including some POST operations that appear to read information |

## Understand the difference between Delete and ReadOnly locks

With a Delete lock, Azure prevents control-plane deletion while still allowing otherwise authorized reads and updates. This level is useful for production resources that need ongoing configuration changes, but it can still affect workflows that depend on deleting related resources.

With a ReadOnly lock, Azure prevents control-plane deletion and updates. This lock type requires careful consideration because it can also block operations that appear to be read-only. For example, a ReadOnly lock on an Azure Storage account prevents listing storage keys because key listing uses a POST request. A ReadOnly lock on a resource group containing a virtual machine can prevent the VM from starting or restarting because those operations also use POST requests.

Consider Delete locks on resources where deletion would be catastrophic and recovery would be slow: virtual networks, network security groups, Recovery Services vaults, Key Vaults, and core DNS zones. Reserve ReadOnly locks for configuration-only resources after testing their management operations.

> [!IMPORTANT]
> Management locks apply to control-plane requests, not data-plane operations. A storage-account lock doesn't stop authorized users from changing or deleting blob data. A lock on a SQL logical server doesn't prevent database data transactions. Choose the service's own retention, recovery, or data-protection controls for those risks.

Lock selection also affects maintenance workflows, so plan for both protection and routine operations.

> [!WARNING]
> Test operational workflows before applying locks broadly. Delete locks can block role-assignment deletion and deployment-history cleanup. A Delete lock on the resource group that Azure Backup uses for restore points can prevent cleanup and cause backups to fail. ReadOnly locks can also interrupt configuration, scaling, and maintenance. Don't blanket-lock service-managed resource groups.

## Use lock inheritance to protect multiple resources

Locks applied to a parent scope protect current and future descendants, reducing the administrative burden of protecting large resource groups or subscriptions. A resource-group lock is inherited by its resources, and a subscription lock is inherited by its resource groups and resources. When several locks apply, the most restrictive lock governs the operation.

> [!IMPORTANT]
> You can apply management locks to subscriptions, resource groups, and resources, but not to management groups. A policy assigned at management-group scope can deploy locks to supported descendant scopes. That doesn't create a lock on the management group.
>
> Resource locks don't block subscription cancellation. Cancellation deactivates resources, and Azure can permanently delete them after a waiting period. Use appropriate subscription and billing access controls alongside locks, and maintain the recovery protections required by your workload.

A single Delete lock applied to Contoso's `network-core-rg` resource group protects its virtual networks, subnets, and network security groups without individual locks. A lock on a specific resource also applies to its child and extension resources, such as a diagnostic setting attached to that resource. It doesn't generally lock unrelated sibling resources.

A Delete lock on an individual resource can block deletion of its containing resource group as a whole, even when the group has no direct lock. Azure doesn't partially delete the group and leave only the locked resource.

Identify where each effective lock was created by using its resource ID and scope information in the management interface. To inspect group-level and inherited subscription locks with Azure PowerShell, run:

```azurepowershell
Get-AzResourceLock -ResourceGroupName "network-core-rg" -AtScope
```

Remove an inherited lock only at its originating scope, with appropriate authorization. Removing one direct lock doesn't remove other inherited restrictions.

## Control who can create and remove locks

Resource locks support separation of duties between users who manage resources and users who control governance. Creating a lock requires `Microsoft.Authorization/locks/write`, and deleting one requires `Microsoft.Authorization/locks/delete`, at the relevant scope. **Owner** and **User Access Administrator** include the necessary access. Other specialized built-in roles and custom roles can also grant it.

**Contributor alone** doesn't grant lock-management permission. A developer who also has another role with lock-delete permission can remove a lock, so review effective permissions rather than relying on one role's name.

> [!NOTE]
> An applicable lock's control-plane restriction takes precedence over resource permissions, including Owner. A Delete lock must be removed before a protected delete, but not for an otherwise permitted update. ReadOnly also restricts updates. An identity with lock-delete permission can explicitly remove the lock, so locks don't prevent malicious deletion by a principal that retains that authority.

## Apply a resource lock in the portal

To perform this walkthrough, use a test resource or resource group and an identity with lock-write permission at that scope. Use least privilege and verify the removal permissions and operational impact before a production rollout.

Protecting a critical resource with a lock requires the following steps in the Azure portal:

1. Navigate to the resource or resource group you want to protect.
1. Under **Settings**, select **Locks**.
1. Select **+ Add**.
1. Enter a **Lock name** that describes the purpose (for example, `network-core-delete-lock`).
1. Set **Lock type** to **Delete** or **Read-only** based on the required protection level.
1. Optionally add notes explaining why the lock is applied and when it can be removed.
1. Select **OK**.

Verify the saved lock and its originating scope. A protected control-plane delete fails until applicable locks are removed. Users with lock-delete permission can return to **Locks** at the originating scope and select **Delete** to remove a lock when approved. Check for remaining inherited restrictions before retrying an operation.

## Enforce locks at scale with Azure Policy

Applying locks manually works for known critical resources, but new resources provisioned without locks reintroduce the risk. As an extension of the custom-policy approach, a **DeployIfNotExists** definition can deploy a management lock for matching resources, such as production virtual networks tagged `Environment: Production`.

The embedded template must deploy a `Microsoft.Authorization/locks` extension resource at the intended scope with lock level `CanNotDelete`. The assignment's managed identity needs `Microsoft.Authorization/locks/write` and the deployment operations required by the template at the relevant scopes. Contributor alone isn't sufficient for lock creation. Grant the required permissions through an authorized operator using an appropriate least-privilege role rather than granting Owner as a shortcut.

> [!IMPORTANT]
> A policy-deployed lock isn't present at the beginning of provisioning. Deployment is asynchronous: the create or update must succeed, the evaluation delay must elapse, and the lock deployment must succeed. The default delay is 10 minutes unless configured otherwise. Verify the resulting lock before treating the resource as protected.

This approach uses the remediation concepts from the previous unit. Background scans mark unprotected resources noncompliant but don't deploy locks or automatically recreate removed locks. Existing unprotected resources need a remediation task or another applicable create or update that triggers a successful deployment.

> [!NOTE]
> Azure Policy also supports `denyAction` to reject matching delete requests once the assignment applies, without first deploying a lock. It isn't a universal replacement for management locks. For an Indexed-mode policy, `cascadeBehaviors.resourceGroup` set to `deny` lets matching resources block resource-group deletion. Parent-resource deletion can still remove child or extension resources targeted by a policy. Management-lock and policy-assignment resources are exempt from `denyAction`, so it can't make locks or assignments undeletable. `denyAction` also doesn't block removal of resources during subscription deletion, so it isn't a workaround for the subscription-lifecycle limitation of locks.

## More info

The following resources explain management locks and policy-based protection:

- [Lock levels, inheritance, operational considerations, and permissions](/azure/azure-resource-manager/management/lock-resources).
- [Get-AzResourceLock](/powershell/module/az.resources/get-azresourcelock).
- [DeployIfNotExists timing](/azure/governance/policy/concepts/effect-deploy-if-not-exists) and [remediation permissions and tasks](/azure/governance/policy/how-to/remediate-resources).
- [denyAction evaluation and cascade behavior](/azure/governance/policy/concepts/effect-deny-action).
