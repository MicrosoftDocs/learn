When managing retention in Microsoft Purview, it’s important to control which users, groups, or sites a policy applies to. Purview supports two types of policy scopes: **static** and **adaptive**.

Static scopes let you manually select specific users or locations, but they don’t update automatically. Adaptive scopes use queries to define scope membership, which allows your policy to update automatically as users or resources change.

## Compare adaptive and static scopes

| Scope type | Description | Best for |
|------------|-------------|----------|
| Static | You manually choose the users, groups, or locations to include. Membership stays the same unless you update it. | Small-scale or stable environments |
| Adaptive | You define membership using queries based on attributes like department or region. Membership updates automatically as users or sites change. | Large or dynamic environments |

## Why use adaptive scopes

Adaptive scopes help you:

- **Automatically adjust policy coverage** as users or sites change
- **Target policies** based on user or site attributes
- **Reduce the number of policies** by avoiding the need for multiple static configurations

**Example**: Apply a longer retention period to all executives by creating a scope that includes users with a job title of _Executive_. The scope updates as new executives are added.

## Configure adaptive scopes

Before you create an adaptive scope:

- Choose the scope type: Users, Microsoft 365 Groups, or Sites
- Make sure you have the right permissions:
  - Records Management
  - Retention Management
  - Compliance Administrator
  - Compliance Data Administrator
  - Organization Management
  - Communication Compliance Admin

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
1. Add conditions to define membership:

   - For **Users** or **Groups**, select attributes like **Department**, **Country/Region**, or **Job title**.

   - For **Sites**, choose properties like **Site name**, **URL**, or **Template**.

     :::image type="content" source="../media/example-adaptive-scope-grouping.png" alt-text="Screenshot showing attribute selection when creating an adaptive scope.":::

1. Use the Advanced query builder for more complex logic:

   - **Users and Groups**: Use OPATH queries
   - **Sites**: Use KQL

1. Review the scope settings, and select **Submit** to create your adaptive scope.

> [!NOTE]
> Adaptive scopes might take up to five days to fully populate. Allow time before assigning them to policies.
