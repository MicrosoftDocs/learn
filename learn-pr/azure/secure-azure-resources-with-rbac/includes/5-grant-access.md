A coworker named Alain at First Up Consultants needs permission to create and manage virtual machines for a project on which they're working. Your manager has asked that you handle this request. Using the best practice to grant users the least privileges to get their work done, you decide to assign Alain the Virtual Machine Contributor role for a resource group.

> [!NOTE]
> Virtual Machine Contributor grants VM-management permissions, but it doesn't grant management of the virtual network or storage account used by a VM. A deployment that also creates these dependencies can require additional permissions. Use administrator-prepared dependencies or obtain only the additional permissions required at their scopes; an assignment on this resource group doesn't automatically cover a shared network in another resource group.
>
> This role includes powerful VM operations, including running commands and managing extensions. Assign it only when those capabilities are appropriate. The resource-group scope limits this assignment, not access that the user receives through other role assignments.

## Grant access

> [!IMPORTANT]
> Use the non-production resource group selected in the previous exercise and an existing user in the subscription's Microsoft Entra tenant whom you're authorized to use for this exercise. Alain is an example identity; select your approved test user instead. If the user can't be found, confirm the tenant and identity with your administrator rather than creating an account or granting yourself directory permissions.
>
> Your administrator account needs `Microsoft.Authorization/roleAssignments/write` to create the assignment and `Microsoft.Authorization/roleAssignments/delete` to remove it at this resource group. For example, Role Based Access Control Administrator can provide these permissions at the resource group or an applicable parent scope. Any delegation conditions must permit this role and recipient. An eligible administrator role must be activated before use. You don't need subscription-wide Owner access for this exercise, and you don't need to deploy a VM.

Follow these steps to assign the Virtual Machine Contributor role to a user at the resource group scope:

1. Sign in to the Azure portal as an administrator who has permissions to assign roles, such as User Access Administrator or Owner. The portal link and role references are in the Summary unit's More info section.

1. In the Search box at the top, search for **Resource groups**.

    :::image type="content" source="../media/5-resource-groups.png" alt-text="Screenshot of the Azure portal search menu with Resource groups and example-group listed.":::

1. In the list of resource groups, select a resource group.

    These steps use a resource group named **example-group**, but your resource group's name will be different.

1. On the left menu pane, select **Access control (IAM)**.

1. Select the **Role assignments** tab to display the current list of role assignments at this scope.

1. Select **Add** > **Add role assignment**.

    If you don't have permissions to assign roles, the **Add role assignment** option will be disabled.

    The **Add role assignment** page opens.

1. On the **Role** tab, select **Job function roles** if role-category tabs are shown. Search for and select **Virtual Machine Contributor**.

    > [!NOTE]
    > Select **Virtual Machine Contributor** for virtual machines managed through Azure Resource Manager. Review Virtual Machine Contributor permissions in the Summary unit's More info section to confirm that this role is appropriate for the approved test user and resource-group scope.

1. Select **Next**.

1. On the **Members** tab, select **Select members**.

1. Search for and select a user.

    :::image type="content" source="../media/5-select-members-option.png" alt-text="Screenshot of the Azure portal Add role assignment page with Alain selected in the Select members pane.":::

1. Select **Select** to add the user to the Members list.

1. Select **Next**.

1. If an **Assignment type** tab appears, review the assignment type and duration. This tab can appear at resource-group scope when Microsoft Entra ID P2 or Microsoft Entra ID Governance functionality is available.

    For the basic exercise, select **Active** and use **Permanent** only if organizational policy permits and the assignment is approved. If policy requires **Time bound**, use approved start and end times and ensure that the assignment is currently in its active time window. If an eligible assignment is required instead, select the permitted settings and have the user activate the role before using it. Users with eligible or time-bound assignments need a valid PIM license, and the administrator must be authorized for the chosen PIM workflow. If necessary, have the authorized PIM administrator follow Azure resource role assignment in PIM, listed in the Summary unit's More info section. Don't change organizational policy to bypass these requirements.

    Select **Next**. If no Assignment type tab appears, continue to **Review + assign**.

1. On **Review + assign**, verify the role, selected user, resource-group scope, and any assignment-type settings.

1. Select **Review + assign**.

1. Return to the resource group's **Access control (IAM)** page. Confirm that the assignment lists the intended user, **Virtual Machine Contributor**, and the intended scope. If assignment-state tabs or a State column are shown, confirm that the assignment is active before expecting the user to use it.

1. On the **Check access** tab, select **Check access**. Choose **User, group, or service principal**, search for the selected user, and open their assignments. Review access at this scope and inherited access. For an eligible assignment, the user must complete the activation requirements before using the role; see Check access and activate an eligible role in the Summary unit's More info section.

This assignment grants the role's permissions for resources in the selected resource group while the assignment is active. Other assignments can grant additional access, and VM deployments must also satisfy the dependency permissions described earlier.

> [!NOTE]
> An assignment can appear in the portal before its permissions become effective. Azure role-assignment changes can take up to 10 minutes to take effect. If access has just changed, sign out and back in to refresh credentials and allow time for propagation. If access still fails, check the tenant, scope, assignment state, conditions, and any applicable deny assignments. See Troubleshoot Azure RBAC in the Summary unit's More info section.

## Remove the exercise assignment

Remove only the assignment created for this exercise. Removing one assignment doesn't remove access granted through other direct assignments, groups, or parent scopes. Follow these steps to remove the exercise assignment:

1. Open the same resource group's **Access control (IAM)** page and select **Role assignments**.

1. Find the exact assignment created for the test user: **Virtual Machine Contributor** at this resource group. Confirm the principal and scope before selecting it.

1. For an active permanent assignment, select its checkbox, select **Remove**, and confirm **Yes**. Some portal layouts label the removal action **Delete**.

    For an eligible or active time-bound assignment, use the corresponding PIM assignment-management workflow to remove the assignment. Follow Update or remove an existing Azure resource role assignment in PIM in the Summary unit's More info section. PIM assignments can't be removed within the first five minutes after creation. Deactivating an eligible role's current activation isn't the same as removing the eligibility.

1. Refresh the relevant assignment list and confirm that the exercise assignment is no longer present. Review **Check access** if the user still has access; another assignment might grant it. Allow for the role-assignment propagation delay described above.

> [!IMPORTANT]
> An inherited role assignment must be managed at the scope where it was created. Don't remove a parent-scope or group assignment just to clean up this exercise, because doing so could affect other resources or people. Don't delete the resource group or its resources as part of role-assignment cleanup.

In this unit, you learned how to grant a user access to create and manage virtual machines in a resource group using the Azure portal.
