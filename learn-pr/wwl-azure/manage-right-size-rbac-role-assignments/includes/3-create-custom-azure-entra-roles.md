Built-in roles provide a strong foundation for Azure access control, but real-world scenarios often require permissions that no single built-in role provides at exactly the right level. For example, Contoso's DevOps team needs to restart VMs and read Key Vault secrets without the ability to create or delete resources—a combination no built-in role offers. Here, you learn how to create custom Azure roles for resource operations in Azure. You also explore Microsoft Entra custom roles for directory management, understand when each system applies, and decide when custom roles are the right solution.

| Scenario | Custom Role Needed? |
|----------|---------------------|
| Need to restart VMs and read logs, but not create or delete VMs | Yes—no built-in role grants exactly this combination |
| Need read-only access to resource configurations without data plane access | Yes—built-in Reader grants data access in some services |
| Need to reset user passwords and manage groups, but not configure Conditional Access | Yes—requires Microsoft Entra custom role |
| Need VM Contributor access only for development resource groups | No—use built-in role with narrow scope assignment |

## When custom roles are needed

Built-in roles either grant too many permissions or don't exist for specific operational needs. Contoso faces this challenge in two scenarios.

First, the DevOps team needs to restart Azure VMs when deployments fail, view diagnostic logs for troubleshooting, and read Key Vault secrets used by applications. They shouldn't create or delete VMs, modify network settings, or perform other infrastructure changes. No single built-in role covers exactly this combination—Virtual Machine Contributor grants create and delete permissions, while Reader doesn't include the restart action or Key Vault data plane access.

Second, a compliance auditor needs to read resource configurations across all subscriptions to verify policy compliance. The auditor must NOT access sensitive data plane content like storage blob data or Key Vault secret values. The built-in Reader role grants configuration access but also allows reading data in some services, violating the principle of least privilege.

The rule of thumb: create a custom role when the narrowest built-in role still grants operations the identity shouldn't have, or when a required combination of permissions spans multiple services in a way no built-in role covers.

## Azure custom role structure

Azure RBAC custom roles use JSON definitions that specify exactly which operations are permitted or denied. Each property controls a different aspect of access.

```json
{
  "Name": "Contoso VM Operator",
  "IsCustom": true,
  "Description": "Can restart and view logs for Azure VMs. Cannot create, delete, or modify VMs.",
  "Actions": [
    "Microsoft.Compute/virtualMachines/read",
    "Microsoft.Compute/virtualMachines/restart/action",
    "Microsoft.Insights/diagnosticSettings/read",
    "Microsoft.OperationalInsights/workspaces/read"
  ],
  "NotActions": [],
  "DataActions": [
    "Microsoft.KeyVault/vaults/secrets/getSecret/action"
  ],
  "NotDataActions": [],
  "AssignableScopes": [
    "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  ]
}
```

The **Actions** property lists control plane operations—creating, reading, modifying, or deleting Azure resources through Azure Resource Manager (ARM). These operations manage the resource itself, not the data inside it. In the example, `Microsoft.Compute/virtualMachines/read` allows viewing VM properties, and `restart/action` enables the restart operation.

**NotActions** creates exclusions from the Actions list. Any action listed here's subtracted from what Actions grants, even when Actions use wildcards. For example, if Actions contain `Microsoft.Compute/*` but NotActions contains `Microsoft.Compute/virtualMachines/delete`, the role grants all Compute operations except VM deletion. NotActions does NOT create a Deny—it only subtracts from wildcard grants. Another role assignment could still grant that action. Only Azure Policy Deny or RBAC Deny assignments create true denies.

**DataActions** controls data plane operations—reading or writing data within a resource. Examples include reading blob content in storage accounts, retrieving secret values from Key Vault, or sending messages to a queue. The separation exists because some Azure services distinguish between managing the resource (control plane) and accessing data inside it (data plane). Storage and Key Vault are the most common examples.

**NotDataActions** works like NotActions but applies to data plane permissions. It subtracts specific data operations from broader DataActions grants.

**AssignableScopes** defines where this role can be assigned—the management groups, subscriptions, or resource groups that can use this custom role. You must include at least the subscription where the role definition lives. Scopes use Azure resource paths like `/subscriptions/{subscription-id}` or `/subscriptions/{subscription-id}/resourceGroups/{rg-name}`.

Azure enforces two key limits: up to 5,000 custom role definitions per Microsoft Entra tenant, and up to 2,000 role assignments per subscription for each custom role.

## Create a custom Azure role through the portal

The Azure portal provides a guided experience for building custom role definitions without writing JSON manually.

1. Go to the subscription or management group where you want to create the role, then select **Access control (IAM)** from the left menu.
2. Select **+ Add** at the top of the page, then choose **Add custom role** from the dropdown.
3. On the **Basics** tab, enter the role name and description. Choose whether to start from scratch, clone an existing built-in role, or upload a JSON file.
4. On the **Permissions** tab, select **+ Add permissions** to search for and add specific actions from the available resource providers. Switch to the **JSON** tab to edit the role definition directly if you prefer working with the raw structure.
5. On the **Assignable scopes** tab, verify the scopes where the role can be assigned. By default, this includes the current subscription.
6. On the **Review + create** tab, review the complete role definition, and select **Create** to save it.

> [!TIP]
> Clone an existing built-in role as a starting point, then remove the permissions the custom role shouldn't have. This approach is faster than building from scratch, and ensures you include common read permissions that support the primary operations.

After creation, the custom role appears in the role list when you assign access, just like built-in roles. You assign it to identities using the same **Add role assignment** workflow you use for built-in roles.

## Microsoft Entra custom roles—a different system

Azure RBAC custom roles control access to Azure resources like VMs and storage accounts. Microsoft Entra custom roles control an entirely separate domain—directory operations in Microsoft Entra ID.

Microsoft Entra roles manage directory objects: users, groups, applications, Conditional Access policies, and directory settings. Creating users, resetting passwords, managing group membership, and configuring Microsoft Entra applications all require Microsoft Entra role permissions, not Azure RBAC permissions. The permissions are separate permission systems. An Azure RBAC custom role has no effect on Microsoft Entra directory operations, and a Microsoft Entra custom role has no effect on Azure resources.

Contoso's helpdesk team illustrates this distinction. They need to reset user passwords and manage group membership for access control, but they shouldn't configure Conditional Access policies or manage application registrations. No built-in Microsoft Entra role grants exactly this combination—User Administrator grants password reset but also includes application management permissions the team doesn't need.

You create Microsoft Entra custom roles in the Microsoft Entra admin center. Navigate to **Roles and administrators**, then select **+ New custom role**. Define permissions from the Microsoft Entra permission set using actions like `microsoft.directory/users/password/update` and `microsoft.directory/groups/members/update`. Unlike Azure RBAC assignable scopes, Microsoft Entra custom roles support only two scope options: tenant-wide (the entire directory) or scoped to a specific application registration. You can't scope Microsoft Entra custom roles to individual groups or users—that's a key limitation compared to Azure RBAC resource-level scoping.

| Characteristic | Azure RBAC custom role | Microsoft Entra custom role |
|----------------|-------------------------|------------------------------|
| Controls access to | Azure resources (VMs, storage, subscriptions) | Entra ID directory objects (users, groups, apps) |
| Created in | Azure portal (IAM) or ARM/Bicep templates | Microsoft Entra admin center |
| Permission source | Azure resource provider action namespaces | Microsoft Entra directory permission set |
| Assignable scope | Management group, subscription, resource group, or individual resource | Tenant-wide or specific application registration |
| Maximum custom roles per tenant | 5,000 | 100 |

The two systems have different limits: Azure RBAC supports up to 5,000 custom role definitions per tenant, while Microsoft Entra custom roles are limited to 100 per tenant. These limits are independent—you can have 5,000 Azure RBAC custom roles and 100 Microsoft Entra custom roles in the same tenant.

## When to use a custom role versus alternatives

Custom roles solve specific problems, but they require ongoing maintenance that built-in roles don't. When Azure resource providers add new operations, existing custom roles don't automatically include them. If a new operation is added that users with the custom role need, you must manually update the role definition to grant that permission.

Before creating a custom role, verify that no closely matching built-in role already exists. Sometimes a built-in role appears too broad when assigned at the subscription level but provides exactly the right permissions when assigned at a narrower scope. For example, if users need VM Contributor access only for development resource groups, assign the built-in Virtual Machine Contributor role scoped to those specific resource groups rather than creating a custom role.

Custom roles are the right solution for stable, well-understood permission sets—not for frequently changing requirements. If the permission needs shift often, the maintenance burden of updating custom roles outweighs the security benefit. In those cases, consider whether broader built-in roles assigned at narrow scopes might provide better operational efficiency while maintaining acceptable security posture.

You can now create roles that grant exactly the right permissions for both Azure resource operations and Microsoft Entra directory management. But knowing how to create roles correctly doesn't eliminate the problem of existing over-broad assignments. The next unit covers how to identify and right-size the overprivileged assignments that already exist in the environment.
