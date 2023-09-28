At First Up Consultants, you've been granted access to a resource group for the marketing team. You want to familiarize yourself with the Azure portal and see what roles are currently assigned.

[!include[](../../../includes/azure-subscription-prerequisite.md)]

## List role assignments for yourself

Follow these steps to see what roles are currently assigned to you.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the **Profile** menu, select the ellipsis (**...**) to see more links.

    :::image type="content" source="../media/4-my-permissions-menu.png" alt-text="Screenshot of user menu with My permissions highlighted.":::

1. Select **My permissions** to open the **My permissions** pane.

    :::image type="content" source="../media/4-my-permissions-pane.png" alt-text="Screenshot of the My permissions pane.":::

    You'll find the roles that you've been assigned and the scope. Your list will look different.

## List role assignments for a resource group

Follow these steps to see what roles are assigned at the resource group scope.

1. In the Search box at the top, search for and select **Resource groups**.

    :::image type="content" source="../media/4-resource-groups.png" alt-text="Screenshot of the Azure portal that shows how to search for resource groups.":::

1. In the list of resource groups, select a resource group.

    These steps use a resource group named **example-group**, but your resource group's name will be different.

1. On the left menu pane, select **Access control (IAM)**.

    :::image type="content" source="../media/4-resource-group-access-control.png" alt-text="Screenshot showing Access control (IAM) option on the resource group pane.":::

1. Select the **Role assignments** tab.

    This tab shows who has access to the resource group. Notice that some roles are scoped to **This resource**, while others are **(Inherited)** from a parent scope.

   :::image type="content" source="../media/4-resource-group-role-assignment.png" alt-text="Screenshot showing Role assignments tab for the selected resource group.":::

## List roles

As you learned in the previous unit, a role is a collection of permissions. Azure has more than 70 built-in roles that you can use in your role assignments. To list the roles:

- In the menu bar at the top of the pane, select the **Roles** tab to list of all the built-in and custom roles.

   Select a role's **View** link in the **Details** column, then select the **Assignments** tab to display the number of users and groups assigned to that role.

   :::image type="content" source="../media/4-roles-list.png" alt-text="Screenshot showing a list of Roles and users and groups assigned to each role.":::

In this unit, you learned how to list the role assignments for yourself in the Azure portal. You also learned how to list the role assignments for a resource group.
