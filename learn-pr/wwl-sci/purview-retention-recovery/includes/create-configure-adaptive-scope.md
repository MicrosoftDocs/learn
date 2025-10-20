When managing retention in Microsoft Purview, it's important to control which users, groups, or sites a policy applies to. You can do this using either a **static** or **adaptive** scope.

Static scopes let you manually select specific users or locations, but they don't update automatically. Adaptive scopes use queries to define scope membership, which allows your policy to update automatically as users or resources change.

Adaptive scopes are supported in retention policies, retention label policies, and communication compliance policies. A single policy can include one or more adaptive scopes.

## Compare adaptive and static scopes

| Scope type | Description | Best for |
|------------|-------------|----------|
| Static | You manually choose the users, groups, or locations to include. Membership stays the same unless you update it. | Small-scale or stable environments |
| Adaptive | You define membership using queries based on attributes like department or region. Membership updates automatically as users or sites change. | Large or dynamic environments |

## Why use adaptive scopes

Adaptive scopes help you:

- **Target policies** based on user or site attributes.
- **Automatically adjust policy coverage** as users or sites change.
- **Reduce the number of policies** by avoiding the need for multiple static configurations.
- **Reuse scopes** across multiple policies to ensure consistent targeting.

**Example**: Apply a longer retention period to all executives by creating a scope that includes users with a job title of _Executive_. The scope updates as new executives are added.

## Scope types and supported locations

Each adaptive scope type can be used to target specific Microsoft 365 workloads:

| Scope type | Applies to |
|------------|------------|
| **Users** | Exchange mailboxes, OneDrive accounts, Teams chats, Copilot interactions |
| **SharePoint sites** | SharePoint sites, OneDrive accounts |
| **Microsoft 365 Groups** | Group mailboxes and sites, Teams channels, Viva Engage community messages |

## Configure adaptive scopes

Before you create an adaptive scope:

- Choose the scope type: Users, Microsoft 365 Groups, or Sites
- Make sure you're assigned one of these roles:
  - Records Management
  - Retention Management
  - Compliance Administrator
  - Compliance Data Administrator
  - Organization Management
  - Communication Compliance Admin

> [!NOTE]
> If your organization uses Microsoft Entra administrative units, you're limited to the units you've been assigned. You can only create scopes and manage policies within those units. If a user falls outside your assigned units, they won't be included, even if they match your query.

## Create an adaptive scope

To create a scope based on dynamic attributes:

1. In the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true), go to **Settings** > **Roles and scopes** > **Adaptive scopes**.

1. Select **Create scope**.

1. On the **Name your adaptive policy scope** page, enter a name and optional description.

1. On the **Assign admin unit** page, choose **Full directory** or select admin units if used.

1. On the **What type of scope do you want to create?** page, choose the scope type based on what you want the policy to target:
   - **Users** to use Microsoft Entra ID attributes like first name, department, or job title.
   - **SharePoint sites** to use SharePoint properties like site name, URL, or refinable strings.
   - **Microsoft 365 Groups** to use group attributes like name, description, or email address.
1. Define scope membership using conditions based on:

   - For **Users** or **Groups**, select attributes like **Department**, **Country/Region**, or **Job title**.

   - For **Sites**, choose properties like **Site name**, **URL**, or **Template**.

     :::image type="content" source="../media/example-adaptive-scope-grouping.png" alt-text="Screenshot showing attribute selection when creating an adaptive scope.":::

1. Use the Advanced query builder for more complex logic:

   - **Users and Groups**: Use OPATH queries
   - **Sites**: Use keyword query language (KQL)

1. Review the scope settings, and select **Submit** to create your adaptive scope.

> [!NOTE]
> Adaptive scopes might take up to five days to fully populate. Allow time before assigning them to policies.
