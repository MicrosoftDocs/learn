If your organization has many subscriptions, you may need a way to efficiently manage access, policies, and compliance for those subscriptions. Azure management groups provide a level of scope above subscriptions. You organize subscriptions into containers called "management groups" and apply your governance conditions to the management groups. All subscriptions within a management group automatically inherit the conditions applied to the management group.

Management groups give you enterprise-grade management at a large scale no matter what type of subscriptions you might have.

## Change the name of a management group

You can change the name of the management group by using the portal, PowerShell, or Azure CLI.

### Change the name in the portal

1.  Log into the [Azure portal](https://portal.azure.com/).
2.  Select **All services** &gt; **Management groups.**
3.  Select the management group you would like to rename.
4.  Select **details**.
5.  Select the **Rename group** option at the top of the page.
    
    :::image type="content" source="../media/detail-action-small-4c3e9c4c.png" alt-text="Screenshot showing the rename group control bar in the Azure portal.":::
    
6.  When the menu opens, enter the new name you would like to have displayed.
    
    :::image type="content" source="../media/rename-group-92580662.png" alt-text="Screenshot showing the rename group menu tab in the Azure portal.":::
    
7.  Select **Save**.

### Change the name in PowerShell

To update the display name use **Update-AzManagementGroup**. For example, to change a management groups display name from "Contoso IT" to "Contoso Group", you run the following command:

```powershell
Update-AzManagementGroup -GroupId 'ContosoIt' -DisplayName 'Contoso Group'








```

### Change the name in Azure CLI

For Azure CLI, use the update command.

```azurecli
az account management-group update --name 'Contoso' --display-name 'Contoso Group'








```

## Delete a management group

To delete a management group, the following requirements must be met:

 -  There are no child management groups or subscriptions under the management group. To move a subscription or management group to another management group, see [Moving management groups and subscriptions in the hierarchy](/azure/governance/management-groups/manage#moving-management-groups-and-subscriptions).
 -  You need write permissions on the management group ("Owner", "Contributor", or "Management Group Contributor"). To see what permissions you have, select the management group and then select IAM. To learn more on Azure roles, see [Azure role-based access control (Azure RBAC)](/azure/role-based-access-control/overview).

### Delete in the portal

1.  Log into the [Azure portal](https://portal.azure.com/).
2.  Select **All services** &gt; **Management groups**.
3.  Select the management group you would like to delete.
4.  Select **details**.
5.  Select **Delete.**

:::image type="content" source="../media/azure-portal-delete-page-5eb815f7.png" alt-text="Screenshot showing how to delete a management group.":::
<br>

> [!TIP]
> If the icon is disabled, hovering your mouse selector over the icon shows you the reason.

6.  There's a window that opens confirming you want to delete the management group.

:::image type="content" source="../media/delete-confirm-8cc86988.png" alt-text="Screenshot showing the delete group confirmation tab in the Azure portal.":::
<br>

7.  Select **Yes**.

### Delete in PowerShell<br>

Use the **Remove-AzManagementGroup** command within PowerShell to delete management groups.

```powershell
Remove-AzManagementGroup -GroupId 'Contoso'








```

### Delete in Azure CLI

With Azure CLI, use the command az account management-group delete.

```azurecli
az account management-group delete --name 'Contoso'








```

## View management groups

You can view any management group you have a direct or inherited Azure role on.

### View in the portal

1.  Log into the [Azure portal](https://portal.azure.com/).
2.  Select **All services** &gt; **Management groups**.
3.  The management group hierarchy page will load. This page is where you can explore all the management groups and subscriptions you have access to. Selecting the group name takes you to a lower level in the hierarchy. The navigation works the same as a file explorer does.
4.  To see the details of the management group, select the **(details)** link next to the title of the management group. If this link isn't available, you don't have permissions to view that management group.
    
    :::image type="content" source="../media/management-groups-page-401f0680.png" alt-text="Screenshot showing the management group hierarchy page in the Azure portal.":::
    

### View in PowerShell

You use the Get-AzManagementGroup command to retrieve all groups. See [Az.Resources](/powershell/module/az.resources/Get-AzManagementGroup) modules for the full list of management group GET PowerShell commands.

```powershell
Get-AzManagementGroup








```

For a single management group's information, use the -GroupId parameter

```powershell
Get-AzManagementGroup -GroupId 'Contoso'








```

### View in Azure CLI

You use the list command to retrieve all groups.

```azurecli
az account management-group list








```

For a single management group's information, use the show command

```azurecli
az account management-group show --name 'Contoso'








```

To return a specific management group and all the levels of the hierarchy under it, use **-Expand** and **-Recurse** parameters.

```azurecli
az account management-group show --name 'Contoso' -e -r








```

## Moving management groups and subscriptions

One reason to create a management group is to bundle subscriptions together. Only management groups and subscriptions can be made children of another management group. A subscription that moves to a management group inherits all user access and policies from the parent management group

When moving a management group or subscription to be a child of another management group, three rules need to be evaluated as true.

If you're doing the move action, you need permission at each of the following layers:

 -  Child subscription / management group
    
    
     -  Microsoft.management/managementgroups/write
     -  Microsoft.management/managementgroups/subscriptions/write (only for Subscriptions)
     -  Microsoft.Authorization/roleAssignments/write
     -  Microsoft.Authorization/roleAssignments/delete
     -  Microsoft.Management/register/action
 -  Target parent management group
    
    
     -  Microsoft.management/managementgroups/write
 -  Current parent management group
    
    
     -  Microsoft.management/managementgroups/write

**Exception**: If the target or the existing parent management group is the Root management group, the permissions requirements don't apply. Since the Root management group is the default landing spot for all new management groups and subscriptions, you don't need permissions on it to move an item.

If the Owner role on the subscription is inherited from the current management group, your move targets are limited. You can only move the subscription to another management group where you have the Owner role. You can't move the subscription to a management group where you're only a contributor because you would lose ownership of the subscription. If you're directly assigned to the Owner role for the subscription, you can move it to any management group where you're a contributor.

## Move subscriptions

### Add an existing Subscription to a management group in the portal

1.  Log into the [Azure portal](https://portal.azure.com/).
2.  Select **All services** &gt; **Management groups**.
3.  Select the management group you're planning to be the parent.
4.  At the top of the page, select **Add subscription**.
5.  Select the subscription in the list with the correct ID.
    
    :::image type="content" source="../media/add-subscription-2d348364.png" alt-text="Screenshot showing the add subscription page in the Azure portal.":::
    
6.  Select **Save**.

### Remove a subscription from a management group in the portal

1.  Log into the [Azure portal](https://portal.azure.com/).
2.  Select **All services** &gt; **Management groups**.
3.  Select the management group you're planning that is the current parent.
4.  Select the ellipse at the end of the row for the subscription in the list you want to move.
    
    :::image type="content" source="../media/move-role-a2255228.png" alt-text="Screenshot showing how to remove a subscription from a management group in the portal.":::
    
5.  Select **Move**.
6.  On the menu that opens, select the **Parent management group**.
    
    :::image type="content" source="../media/move-parent-management-group-c86a4fbd.png" alt-text="Screenshot showing the parent management group tab in the Azure portal.":::
    
7.  Select **Save**.

### Move subscriptions in PowerShell

To move a subscription in PowerShell, you use the New-AzManagementGroupSubscription command.

```powershell
New-AzManagementGroupSubscription -GroupId 'Contoso' -SubscriptionId '12345678-1234-1234-1234-123456789012'








```

To remove the link between the subscription and the management group use the Remove-AzManagementGroupSubscription command.

```powershell
Remove-AzManagementGroupSubscription -GroupId 'Contoso' -SubscriptionId '12345678-1234-1234-1234-123456789012'








```

### Move subscriptions in Azure CLI

To move a subscription in CLI, you use the add command.

```azurecli
az account management-group subscription add --name 'Contoso' --subscription '12345678-1234-1234-1234-123456789012'








```

To remove the subscription from the management group, use the subscription remove command.

```azurecli
az account management-group subscription remove --name 'Contoso' --subscription '12345678-1234-1234-1234-123456789012'








```

## Move management groups

### Move management groups in the portal

1.  Log into the [Azure portal](https://portal.azure.com/).
2.  Select **All services** &gt; **Management groups**.
3.  Select the management group you're planning to be the parent.
4.  At the top of the page, select **Add management group**.
5.  In the menu that opens, select if you want a new or use an existing management group.
    
    
     -  Selecting new will create a new management group.
     -  Selecting an existing will present you with a dropdown list of all the management groups you can move to this management group.
    
    :::image type="content" source="../media/add-management-group-d4e224a5.png" alt-text="Screenshot showing the add management group page in the Azure portal.":::
    
6.  Select **Save**.

### Move management groups in PowerShell

Use the Update-AzManagementGroup command in PowerShell to move a management group under a different group.

```powershell
$parentGroup = Get-AzManagementGroup -GroupId ContosoIT








```

```powershell
Update-AzManagementGroup -GroupId 'Contoso' -ParentId $parentGroup.id








```

### Move management groups in Azure CLI

Use the update command to move a management group with Azure CLI.

```azurecli
az account management-group update --name 'Contoso' --parent ContosoIT








```

## Audit management groups using activity logs<br>

Management groups are supported within [Azure Activity Log](/azure/azure-monitor/essentials/platform-logs-overview). You can query all events that happen to a management group in the same central location as other Azure resources. For example, you can see all Role Assignments or Policy Assignment changes made to a particular management group.

:::image type="content" source="../media/azure-activity-log-fd3a4948.png" alt-text="Screenshot showing the audit management group activity logs in the Azure portal.":::


When looking to query on Management Groups outside of the Azure portal, the target scope for management groups looks like "**/providers/Microsoft.Management/managementGroups/\{yourMgID\}**".

## Referencing management groups from other Resource Providers

When referencing management groups from other Resource Provider's actions, use the following path as the scope. This path is used when using PowerShell, Azure CLI, and REST APIs.

`/providers/Microsoft.Management/managementGroups/{yourMgID}`

An example of using this path is when assigning a new role assignment to a management group in PowerShell:

```powershell
New-AzRoleAssignment -Scope "/providers/Microsoft.Management/managementGroups/Contoso"








```

The same scope path is used when retrieving a policy definition at a management group.

`GET https://management.azure.com/providers/Microsoft.Management/managementgroups/MyManagementGroup/providers/Microsoft.Authorization/policyDefinitions/ResourceNaming?api-version=2019-09-01`
