Several Azure Virtual Desktop features require you to assign Azure role-based access control (Azure RBAC) roles to one of the Azure Virtual Desktop service principals. Features that you need to assign a role to an Azure Virtual Desktop service principal include:

 -  [Autoscale](/azure/virtual-desktop/autoscale-scaling-plan).
 -  [Start VM on Connect](/azure/virtual-desktop/start-virtual-machine-connect).
 -  [App attach](/azure/virtual-desktop/app-attach-setup) (when using Azure Files and your session hosts joined to Microsoft Entra ID).

> [!TIP]
> You can find which role you need to assign to which service principal in the article for each feature. For a list of all the available roles specifically for Azure Virtual Desktop, see [Built-in Azure RBAC roles for Azure Virtual Desktop](/azure/virtual-desktop/rbac) To learn more about Azure RBAC, see [Azure RBAC documentation](/azure/role-based-access-control/).

Depending on when you registered the *Microsoft.DesktopVirtualization* resource provider, the service principal names begin with either *Azure Virtual Desktop* or *Windows Virtual Desktop*. If you used both Azure Virtual Desktop Classic and an Azure Virtual Desktop (Azure Resource Manager), you see apps with the same name. You can make sure you're assigning roles to the correct service principal by checking its application ID. The application ID for each service principal is in the following table:

| **Service principal**                                                      | **Application ID**                   |
| -------------------------------------------------------------------------- | ------------------------------------ |
| Azure Virtual Desktop<br>Windows Virtual Desktop                           | 9cdead84-a844-4324-93f2-b2e6bb768d07 |
| Azure Virtual Desktop Client<br>Windows Virtual Desktop Client             | a85cf173-4192-42f8-81fa-777a763e6e2c |
| Azure Virtual Desktop ARM Provider<br>Windows Virtual Desktop ARM Provider | 50e95039-b200-4007-bc97-8d5790743a63 |

This unit shows you how to assign a role to the correct Azure Virtual Desktop service principals by using the Azure portal, Azure CLI, or Azure PowerShell.

## Prerequisites

Before you can assign a role to an Azure Virtual Desktop service principal, you need to meet the following prerequisites:

 -  You must have the Microsoft.Authorization/roleAssignments/write permission to an Azure subscription in order to assign roles on that subscription. This permission is part of the [Owner](/azure/role-based-access-control/built-in-roles) or [User Access Administrator](/azure/role-based-access-control/built-in-roles) built in roles.
 -  If you want to use Azure PowerShell or Azure CLI locally, see [Use Azure CLI and Azure PowerShell with Azure Virtual Desktop](/azure/virtual-desktop/cli-powershell) to make sure you have the [Az.DesktopVirtualization](/powershell/module/az.desktopvirtualization) PowerShell module or [desktopvirtualization](/cli/azure/desktopvirtualization) Azure CLI extension installed. Alternatively, use the [Azure Cloud Shell](/azure/cloud-shell/overview).

## Assign a role to an Azure Virtual Desktop service principal

To assign a role to an Azure Virtual Desktop service principal, select the relevant tab for your scenario and follow the steps. In these examples, the scope of the role assignment is an Azure subscription, but you need to use the scope and the role required by each feature.

Here's how to assign a role to an Azure Virtual Desktop service principal using the Azure portal.

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  In the search box, enter *Microsoft Entra ID* and select the matching service entry.
3.  On the **Overview** page, in the search box for Search your tenant, enter the application ID for the service principal you want to assign from the earlier table.
4.  In the results, select the matching enterprise application for the service principal you want to assign, starting either Azure Virtual Desktop or Windows Virtual Desktop.
5.  Under **properties**, make a note of the name and the object ID. The object ID correlates to the application ID, and is unique to your tenant.
6.  In the search box, enter *Subscriptions* and select the matching service entry.
7.  Select the subscription you want to add the role assignment to.
8.  Select **Access control (IAM)**, then **select + Add** followed by **Add role assignment**.
9.  Select the role you want to assign to the Azure Virtual Desktop service principal, then select **Next**.
10. Ensure **Assign access to** is set to **Microsoft Entra user, group, or service principa**l, then select **Select members**.
11. Enter the name of the enterprise application you made a note of earlier.
12. Select the matching entry from the results, then select **Select**. If you have two entries with the same name, select them both for now.
13. Review the list of members in the table. If you have two entries, remove the entry that doesn't match the object ID you made a note of earlier.
14. Select **Next**, then select **Review + assign** to complete the role assignment.
