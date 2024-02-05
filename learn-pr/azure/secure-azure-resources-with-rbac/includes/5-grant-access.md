A co-worker named Alain at First Up Consultants needs permission to create and manage virtual machines for a project on which he's working. Your manager has asked that you handle this request. Using the best practice to grant users the least privileges to get their work done, you decide to assign Alain the Virtual Machine Contributor role for a resource group.

## Grant access

Follow this procedure to assign the Virtual Machine Contributor role to a user at the resource group scope.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true) as an administrator that has permissions to assign roles, such as [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator) or [Owner](/azure/role-based-access-control/built-in-roles#owner).

1. In the Search box at the top, search for **Resource groups**.

    :::image type="content" source="../media/5-resource-groups.png" alt-text="Screenshot of the Azure portal that shows how to search for resource groups.":::

1. In the list of resource groups, select a resource group.

    These steps use a resource group named **example-group**, but your resource group's name will be different.

1. On the left menu pane, select **Access control (IAM)**.

1. Select the **Role assignments** tab to display the current list of role assignments at this scope.

   :::image type="content" source="../media/5-resource-group-role-assignment.png" alt-text="Screenshot showing Role assignments tab for the selected resource group.":::

1. Select **Add** > **Add role assignment**.

    If you don't have permissions to assign roles, the **Add role assignment** option will be disabled.

   :::image type="content" source="../media/5-resource-group-add-role-assignment.png" alt-text="Screenshot that shows Add role assignment menu.":::

    The **Add role assignment** page opens.

1. On the **Role** tab, search for and select **Virtual Machine Contributor**.

   :::image type="content" source="../media/5-select-role.png" alt-text="Screenshot that shows Add role assignment and list of roles.":::

1. Select **Next**.

1. On the **Members** tab, select **Select members**.

1. Search for and select a user.

    :::image type="content" source="../media/5-select-members-option.png" alt-text="Screenshot of the add role assignment page that shows the select members option.":::

1. Select **Select** to add the user to the Members list.

1. Select **Next**.

1. On the **Review + assign** tab, review the role assignment settings.

1. Select **Review + assign** to assign the role.

    After a few moments, the user is assigned the Virtual Machine Contributor role at the resource group scope. The user can now create and manage virtual machines just within this resource group.

    :::image type="content" source="../media/5-vm-contributor-assignment.png" alt-text="Screenshot that shows the Virtual Machine Contributor role assigned to a user.":::

## Remove access

In Azure RBAC, you can remove a role assignment to remove access.

1. In the list of role assignments, check the box for the user with the Virtual Machine Contributor role.

1. Select **Remove**.

    :::image type="content" source="../media/5-remove-role-assignment.png" alt-text="Screenshot that shows the Remove role assignment message.":::

1. In the **Remove role assignments** message that appears, select **Yes**.

In this unit, you learned how to grant a user access to create and manage virtual machines in a resource group using the Azure portal.
