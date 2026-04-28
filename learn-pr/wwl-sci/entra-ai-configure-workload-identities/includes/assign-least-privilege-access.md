The workload can authenticate. The next question is what it should be allowed to do. That answer comes from what the workload's task actually requires, mapped to the specific permission planes that control access to those resources.

## Identify which permission planes the workload needs

Start from the workload's task. List what it actually does: read secrets from Key Vault, call an AI services endpoint, query user profiles from Microsoft Graph, invoke an operation on a custom API. Each of those tasks maps to a different permission plane, and each plane has its own assignment mechanism, consent model, and scoping rules.

- **Azure RBAC**: The workload accesses Azure resources such as storage accounts, Key Vault, or AI services. Roles are assigned at a specific scope: resource, resource group, subscription, or management group.
- **Microsoft Graph application permissions**: The workload reads or writes directory data or Microsoft 365 resources. These permissions are granted on the app registration and require admin consent.
- **App roles**: The workload calls a custom application or API. The target application defines the available roles.

Most AI workloads touch more than one plane. A workload that reads secrets from Key Vault and queries user profiles needs both an Azure RBAC role assignment and a Graph application permission. Treating these planes as interchangeable leads to permissions assigned in the wrong place or at the wrong scope.

:::image type="content" source="../media/ai-workload-least-privilege-access.png" alt-text="Diagram of an AI workload with three granted permissions and one not granted, showing least-privilege access." border="false":::

## Right-size Azure RBAC role assignments

The principle is straightforward. Find the narrowest built-in role that covers what the workload actually does, and assign it at the resource level. In practice, "what the workload actually does" is often broader than expected when AI workloads span multiple services.

Assigning Contributor at the subscription level when the workload only needs to read from a single storage account grants write access to every resource in the subscription. The same over-privilege happens at the resource group level. An AI workload that only needs to read secrets from Key Vault and call an Azure OpenAI endpoint doesn't need write access to every resource in the group. Resource-level role assignments for those specific services cover the actual workload task.

For AI services specifically, the distinction between inference and management matters for role selection. A workload that sends prompts and receives completions needs only inference access. A workload that also deploys or deletes models needs management access. These are different roles with different blast radii. The specific role choices come into play when assigning access to Azure AI services, Key Vault, and storage.

Can you name every Azure resource your workload accesses and the specific operation it performs on each? If not, the RBAC assignments aren't ready yet.

## Scope Microsoft Graph application permissions to the workload's task

Graph application permissions apply tenant-wide, so each one should be justified by a specific workload task. Choosing the right scope matters here because Graph permissions vary widely for what sounds like similar access.

A workload that reads user profiles for grounding data needs `User.Read.All`. `Directory.Read.All` would also work, but it grants access to groups, roles, and other directory objects the workload doesn't need. `Directory.ReadWrite.All` grants write access that most AI workloads should never have. The difference between "reads user profiles" and "reads and writes the entire directory" is one permission selection.

Every Graph permission should map to a specific workload operation. If a permission doesn't map to something the workload actually does, it shouldn't be on the app registration. For SharePoint access specifically, use the `Sites.Selected` permission to limit access to specific site collections rather than all sites in the tenant.

## Evaluate app roles before assigning them

App roles apply when the workload calls a custom application or API. Unlike RBAC and Graph, the target application's developer defines the available roles. That means you need to understand what the roles actually grant before assigning them.

If the target application exposes a single broad role like "Application.FullAccess," that role might grant more operations than your workload needs. Ask the application owner whether narrower roles exist or can be created. Accepting a broad role because it's the only one available carries the same over-privilege risk as assigning Contributor at the subscription level.

App roles are scoped to the target application, so they don't grant access to Azure resources or Microsoft Graph. Each permission plane must be configured independently.

## Record why each permission exists

When someone reviews this identity six months from now, or during an incident, they need to understand what access was granted, why, and whether it's still justified. Without that record, excess permissions persist because no one can determine whether they're needed.

For each permission assignment, record:

- Which identity holds it
- Which role or permission was assigned
- The resource boundary or scope
- The workload task it supports
- When it was assigned

This record is what makes future access reviews possible without re-investigating every permission from scratch.
