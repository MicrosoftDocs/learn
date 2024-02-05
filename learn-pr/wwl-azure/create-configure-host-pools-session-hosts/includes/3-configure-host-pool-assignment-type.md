You can configure the assignment type of your personal desktop host pool to adjust your Azure Virtual Desktop environment to better suit your needs. In this unit, you'll see how to configure automatic or direct assignment for your users.

The instructions below apply to personal desktop host pools, not pooled host pools, since users in pooled host pools aren't assigned to specific session hosts. This applies to Azure Virtual Desktop with Azure Resource Manager Azure Virtual Desktop objects.

## Configure automatic assignment

Automatic assignment is the default assignment type for new personal desktop host pools created in your Azure Virtual Desktop environment. Automatically assigning users doesn't require a specific session host.

To automatically assign users, first assign them to the personal desktop host pool so that they can view the desktop in their feed.

When an assigned user launches the desktop in their feed, they will claim an available session host if they have not already connected to the host pool, which completes the assignment process.

To configure a host pool to automatically assign users to VMs, run the following PowerShell cmdlet:

```powershell
Update-AzWvdHostPool -ResourceGroupName <resourcegroupname> -Name <hostpoolname> -PersonalDesktopAssignmentType Automatic```

```

To assign a user to the personal desktop host pool, run the following PowerShell cmdlet:

```powershell
New-AzRoleAssignment -SignInName <userupn> -RoleDefinitionName "Desktop Virtualization User" -ResourceName <appgroupname> -ResourceGroupName <resourcegroupname> -ResourceType 'Microsoft.DesktopVirtualization/applicationGroups'

```

## Configure direct assignment

Unlike automatic assignment, when you use direct assignment, you must assign the user to both the personal desktop host pool and a specific session host before they can connect to their personal desktop. If the user is only assigned to a host pool without a session host assignment, they won't be able to access resources.

To configure a host pool to require direct assignment of users to session hosts, run the following PowerShell cmdlet:

```powershell
Update-AzWvdHostPool -ResourceGroupName <resourcegroupname> -Name <hostpoolname> -PersonalDesktopAssignmentType Direct

```

To assign a user to the personal desktop host pool, run the following PowerShell cmdlet:

```powershell
New-AzRoleAssignment -SignInName <userupn> -RoleDefinitionName "Desktop Virtualization User" -ResourceName <appgroupname> -ResourceGroupName <resourcegroupname> -ResourceType 'Microsoft.DesktopVirtualization/applicationGroups'

```

To assign a user to a specific session host, run the following PowerShell cmdlet:

```powershell
Update-AzWvdSessionHost -HostPoolName <hostpoolname> -Name <sessionhostname> -ResourceGroupName <resourcegroupname> -AssignedUser <userupn>

```

To directly assign a user to a session host in the Azure portal:

1.  Sign in to the Azure portal at [https://portal.azure.com](https://portal.azure.com).
2.  Enter **Azure Virtual Desktop** into the search bar.
3.  Under **Services**, select **Azure Virtual Desktop**.
4.  At the Azure Virtual Desktop page, go the menu on the left side of the window and select **Host pools**.
5.  Select the name of the host pool you want to update.
6.  Next, go to the menu on the left side of the window and select **Application groups**.
7.  Select the name of the desktop app group you want to edit, then select **Assignments**.
8.  Select **+ Add**, then select the users or user groups you want to publish this desktop app group to.
9.  Select **Assign VM** in the Information bar to assign a session host to a user.
10. Select the session host you want to assign to the user, then select **Assign**.
11. Select the user you want to assign the session host to from the list of available users.
12. When you're done, select **Select**.

