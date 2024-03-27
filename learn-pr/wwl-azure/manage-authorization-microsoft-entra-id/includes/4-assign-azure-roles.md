Azure role-based access control (Azure RBAC) is the authorization system you use to manage access to Azure resources. To grant access, you assign roles to users, groups, service principals, or managed identities at a particular scope.

## Prerequisites

**To assign Azure roles, you must have**:

 -  `Microsoft.Authorization/roleAssignments/write permissions`, such as **User Access Administrator** or **Owner**.<br>

## Step 1: Identify the needed scope

1. Sign in to the **Azure portal**.

2. In the Search box at the top, search for the scope you want to grant access to. For example, search for **Management groups**, **Subscriptions**, **Resource groups**, or a specific resource.<br>

3. Click the specific resource for that scope.<br>

**The following shows an example resource group**.

## Step 2: Open the Added role assignment page

Access control (IAM) is the page that you typically use to assign roles to grant access to Azure resources. It's also known as identity and access management (IAM) and appears in several locations in the Azure portal.

1. Click **Access control (IAM)**.

2. Click the **Role assignments** tab to view the role assignments at this scope.

3. Click **Add**, **Add** role assignment.

> [!NOTE]
> If you don't have permissions to assign roles, the Add role assignment option will be disabled.

## Step 3: Select the appropriate role

1. On the **Role** tab, select a role that you want to use.

You can search for a role by name or by description. You can also filter roles by type and category.

2. If you want to assign a privileged administrator role, select the **Privileged administrator roles** tab to select the role.

Privileged administrator roles are roles that grant privileged administrator access, such as the ability to manage Azure resources or assign roles to other users. You should avoid assigning a privileged administrator role when a job function role can be assigned instead. If you must assign a privileged administrator role, use a narrow scope, such as resource group or resource.

3. In the **Details** column, click **View** to get more details about a role.

4. Click **Next**.<br>

## Step 4: Select who needs access

1. On the **Members** tab, select **User**, **group**, or **service principal** to assign the selected role to one or more Microsoft Entra ID users, groups, or service principals (applications).

2. Click **Select members**.<br>

3. Find and select the users, groups, or service principals.<br>

> [!NOTE]
> You can type in the **Select** box to search the directory for display name or email address.<br>

4. Click Select to add the users, groups, or service principals to the Members list.<br>

5. To assign the selected role to one or more managed identities, select **Managed identity**.<br>

6. Click **Select members**.<br>

7. In the **Select managed identities** pane, select whether the type is user-assigned managed identity or system-assigned managed identity.<br>

8. Find and select the managed identities.

For system-assigned managed identities, you can select managed identities by Azure service instance.

9. Click **Select** to add the managed identities to the Members list.<br>

10. In the **Description** box enter an optional description for this role assignment.<br>

Later you can show this description in the role assignments list.<br>

11. Click **Next**.

## Step 5: (Optional) Add condition

If you selected a role that supports conditions, a **Conditions** tab will appear and you have the option to add a condition to your role assignment. A condition is an additional check that you can optionally add to your role assignment to provide more fine-grained access control.

The **Conditions** tab will look different depending on the role you selected.

If you selected one of the following privileged roles, follow the steps in this section.

 -  Owner<br>
 -  Role Based Access Control Administrator **(Preview)**
 -  User Access Administrator

1. On the **Conditions** tab under **Delegation type**, select the **Constrained (recommended)** option.

2. Click **Add condition** to add a condition that constrains the roles and principals this user can assign roles to.<br>

## Step 6: Assign role

1. On the **Review + assign** tab, review the role assignment settings.

2. Click **Review + assign** to assign the role.<br>

After a few moments, the security principal is assigned the role at the selected scope.<br>

3. If you don't see the description for the role assignment, click **Edit columns** to add the **Description** column.<br>

## Remove roles

You can remove role assignments from the **Administrative roles** page for a selected user.

1.  Browse to **Identity**, **Users**, **All users**.<br>
2.  Search for and select the user getting the role assignment removed.<br>
3.  Go to the **Assigned roles** page and select the **Remove** link for the role that needs to be removed. Confirm the change in the pop-up message.
