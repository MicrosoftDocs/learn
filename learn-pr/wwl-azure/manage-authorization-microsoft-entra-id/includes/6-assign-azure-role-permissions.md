Azure role-based access control (Azure RBAC) is the authorization system you use to manage access to Azure resources. To grant access, you assign roles to users, groups, service principals, or managed identities at a particular scope.

## Prerequisites

To assign Azure roles, you must have:

`Microsoft.Authorization/roleAssignments/write` permissions, such as **Role Based Access Control Administrator** or **User Access Administrator**.

## Step 1: Identify the needed scope

When you assign roles, you must specify a scope. Scope is the set of resources the access applies to. In Azure, you can specify a scope at four levels from broad to narrow: management group, subscription, resource group, and resource.

:::image type="content" source="../media/scope-levels-85683f9f.png" alt-text="Diagram showing an example of Azure role-based access control scope of resources.":::


1. Sign in to the [Azure portal](https://portal.azure.com/).

2. In the Search box at the top, search for the scope you want to grant access to. For example, search for **Management groups**, **Subscriptions**, **Resource groups**, or a specific resource.

3. Click the specific resource for that scope.

The following shows an example resource group.

:::image type="content" source="../media/resource-group-example-c72538bd.png" alt-text="Screenshot showing an example of an Azure reource group.":::


## Step 2: Open the Add role assignment page

**Access control (IAM)** is the page that you typically use to assign roles to grant access to Azure resources. It's also known as identity and access management (IAM) and appears in several locations in the Azure portal.

1.  Click **Access control (IAM)**. The following shows an example of the Access control (IAM) page for a resource group.
    
    :::image type="content" source="../media/resource-group-access-control-a5addda3.png" alt-text="Screenshot showing an example of the Identity and Access Management controls in the Azure portal.":::
    
2.  Click the **Role assignments** tab to view the role assignments at this scope.
3.  Click **Add** &gt; **Add role assignment**.
4.  If you don't have permissions to assign roles, the Add role assignment option will be disabled.
    
    :::image type="content" source="../media/add-role-assignment-menu-example-f69cae06.png" alt-text="Screenshot showing an example of how to add role assignments.":::
    

## Step 3: Select the appropriate role<br>

1.  On the Role tab, select a role that you want to use. You can search for a role by name or by description. You can also filter roles by type and category.
    
    :::image type="content" source="../media/add-role-assignement-page-9ce8d477.png" alt-text="Screenshot showing the add role assignment page in the Azure portal.":::
    
2.  If you want to assign a privileged administrator role, select the Privileged administrator roles tab to select the role. For best practices when using privileged administrator role assignments, see [Best practices for Azure RBAC](/azure/role-based-access-control/best-practices#limit-privileged-administrator-role-assignments).
    
    :::image type="content" source="../media/privileged-administrator-roles-0f70c249.png" alt-text="Screenshot showing the privileged administrator role assignment in the Azure portal.":::
    
3.  In the **Details** column, click **View** to get more details about a role.
    
    :::image type="content" source="../media/storage-blob-reader-86b5c2ee.png" alt-text="Screenshot showing permissions detail for a storage blob data reader.":::
    
4.  Click **Next**.

## Step 4: Select who needs access

1.  On the **Members** tab, select **User**, **group**, or **service principal** to assign the selected role to one or more Microsoft Entra users, groups, or service principals (applications).
    
    :::image type="content" source="../media/member-user-group-principal-20baff0d.png" alt-text="Screenshot showing how to assign who needs access in the role assignment page.":::
    
2.  Click **Select members**.
3.  Find and select the users, groups, or service principals.
    
    You can type in the **Select** box to search the directory for display name or email address.
    
    :::image type="content" source="../media/select-members-3c98ed7b.png" alt-text="Screenshot showing how to select a specific member for assignment.":::
    
4.  Click **Select** to add the users, groups, or service principals to the Members list.
5.  To assign the selected role to one or more managed identities, select **Managed identity**.
6.  Click **Select members**.
7.  In the **Select managed identities** pane, select whether the type is [user-assigned managed identity](/azure/active-directory/managed-identities-azure-resources/overview) or [system-assigned managed identity](/azure/active-directory/managed-identities-azure-resources/overview).
8.  Find and select the managed identities.
    
    :::image type="content" source="../media/select-managed-identities-f2c81cd7.png" alt-text="Screenshot showing how to select a user or system assigned managed identities.":::
    
9.  Click **Select** to add the managed identities to the Members list.
10. In the **Description** box enter an optional description for this role assignment. Later you can show this description in the role assignments list.
11. Click **Next**.

## Step 5: (Optional) Add condition

If you selected a role that supports conditions, a **Conditions** tab will appear and you have the option to add a condition to your role assignment. A [condition](/azure/role-based-access-control/conditions-overview) is an additional check that you can optionally add to your role assignment to provide more fine-grained access control.

The **Conditions** tab will look different depending on the role you selected.

Delegating Azure role assignment management with conditions is currently in PREVIEW. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

If you selected one of the following privileged roles, follow the steps in this section.

 -  [Owner](/azure/role-based-access-control/built-in-roles#owner)
 -  [Role Based Access Control Administrator](/azure/role-based-access-control/built-in-roles#role-based-access-control-administrator)
 -  [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator)

1.  On the **Conditions** tab under **What user can do**, select the **Allow user to only assign selected roles to selected principals (fewer privileges)** option.
    
    :::image type="content" source="../media/add-role-assignment-conditions-d559b9c2.png" alt-text="Screenshot showing how to assign selected roles to selected principals.":::
    
2.  Click **Select roles and principals** to add a condition that constrains the roles and principals this user can assign roles to.
3.  Follow the steps in [Delegate Azure role assignment management to others with conditions](/azure/role-based-access-control/delegate-role-assignments-portal#step-3-add-a-condition).

## Step 6: Assign role

1.  On the **Review + assign** tab, review the role assignment settings.
    
    :::image type="content" source="../media/add-role-assignment-blank-subscription-b3f62757.png" alt-text="Screenshot showing the add role assignment review and assign page.":::
    
2.  Click **Review + assign** to assign the role. After a few moments, the security principal is assigned the role at the selected scope.
3.  If you don't see the description for the role assignment, click **Edit columns** to add the **Description** column.
    
    :::image type="content" source="../media/resource-group-role-assignments-444690de.png" alt-text="Screenshot showing how a security principal is assigned the role at the selected scope.":::
    
