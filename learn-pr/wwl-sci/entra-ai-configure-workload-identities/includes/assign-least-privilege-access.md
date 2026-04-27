The workload can authenticate. The next question is what it should be allowed to do. That answer comes from what the workload's task actually requires, mapped to the specific permission planes that control access to those resources.

## Identify which permission planes the workload needs

Start from the workload's task. List what it actually does: read secrets from Key Vault, call an AI services endpoint, query user profiles from Microsoft Graph, invoke an operation on a custom API. Each of those tasks maps to a different permission plane, and each plane has its own assignment mechanism, consent model, and scoping rules.

- **Azure RBAC**: The workload accesses Azure resources such as storage accounts, Key Vault, or AI services. Roles are assigned at a specific scope: resource, resource group, subscription, or management group.
- **Microsoft Graph application permissions**: The workload reads or writes directory data or Microsoft 365 resources. These permissions are granted on the app registration and require admin consent.
- **App roles**: The workload calls a custom application or API. The target application defines the available roles.

Most AI workloads touch more than one plane. A workload that reads secrets from Key Vault and queries user profiles needs both an Azure RBAC role assignment and a Graph application permission. Treating these planes as interchangeable leads to permissions assigned in the wrong place or at the wrong scope.

:::image type="content" source="../media/ai-workload-least-privilege-access.png" alt-text="Diagram of an AI workload with three granted permissions and one not granted, showing least-privilege access." border="false":::

## Right-size Azure RBAC role assignments

Azure RBAC roles range from broad (Owner, Contributor) to narrow (specific to a resource type and operation). For AI workload identities, narrow roles at a specific resource scope are almost always the correct choice.

To right-size an Azure RBAC assignment:

1. Identify the specific Azure resource the workload needs to access.
1. Determine the operations the workload performs on that resource (read, write, list, delete).
1. Find the narrowest built-in role that covers those operations.
1. Assign the role at the resource level, not at the resource group or subscription level, unless the workload genuinely needs broader scope.
1. Document why the role was assigned and what operations it supports.

Assigning Contributor at the subscription level when the workload only needs to read from a single storage account grants write access to every resource in the subscription. The same over-privilege happens at the resource group level. An AI workload that only needs to read secrets from Key Vault and call an AI services endpoint doesn't need write access to every resource in the group. Resource-level role assignments for those specific services cover the actual workload task.

Before moving to Graph permissions, check: can you name every Azure resource your workload accesses and the specific operation it performs on each? If not, the Azure RBAC assignments aren't ready yet.

## Configure Microsoft Graph application permissions

Microsoft Graph application permissions grant app-only access to directory data and Microsoft 365 operations. These permissions apply tenant-wide, so each one should be justified by a specific workload task.

The narrowing decision matters here because Graph permissions vary widely in scope for what sounds like similar access. A workload that reads user profiles needs `User.Read.All`. `Directory.Read.All` would also work, but it grants access to groups, roles, and other directory objects the workload doesn't need. `Directory.ReadWrite.All` grants write access that most AI workloads should never have. The difference between "reads user profiles" and "reads and writes the entire directory" is one permission selection.

To configure Graph permissions:

1. List the Microsoft Graph operations the workload must perform.
1. Map each operation to the narrowest application permission that supports it.
1. Add the permissions to the app registration.
1. Grant admin consent for the permissions.
1. Record which permission supports which workload task, so future reviews can confirm each permission is still justified.

A workload that receives broad Graph permissions because no one identifies the specific operations it performs turns a single compromised identity into tenant-wide directory exposure. For SharePoint access specifically, use the `Sites.Selected` permission to limit access to specific site collections rather than all sites in the tenant.

## Assign app roles for custom applications

App roles apply when the AI workload calls a custom application or API that your organization or a partner built. Unlike role-based access control and Graph, you don't pick from a platform-defined set of roles. The target application's developer defines the available roles, their names, and what operations each role allows. That means you need to understand what the roles actually grant before assigning them.

If the target application exposes a single broad role like "Application.FullAccess," that role might grant more operations than your workload needs. Ask the application owner whether narrower roles exist or can be created. Accepting a broad role because it's the only one defined carries the same over-privilege risk as assigning Contributor at the subscription level.

1. Identify which custom application or API the workload needs to call.
1. Review the app roles defined on that target application and confirm what operations each role grants.
1. Assign only the roles required for the workload's specific operations.
1. Verify the assignment by confirming the workload can perform its intended operations without receiving an access denied error.

App roles are scoped to the target application, so they don't grant access to Azure resources or Microsoft Graph. Each permission plane must be configured independently.

## Record why each permission exists

When someone reviews this identity six months from now, or during an incident, they need to understand what access was granted, why, and whether it's still justified. Without that record, excess permissions persist because no one can determine whether they're needed.

For each permission assignment, record which identity holds it, which role or permission was assigned, the resource boundary or scope, the workload task it supports, and when it was assigned.
