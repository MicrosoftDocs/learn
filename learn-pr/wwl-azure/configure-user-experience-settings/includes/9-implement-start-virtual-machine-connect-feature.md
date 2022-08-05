Start VM On Connect lets you reduce costs by enabling end users to turn on their session host virtual machines (VMs) only when they need them. You can them turn off VMs when they're not needed.

You can configure Start VM on Connect for personal or pooled host pools using the Azure portal or PowerShell. Start VM on Connect is a host pool setting.

For personal host pools, Start VM On Connect will only turn on an existing session host VM that has already been assigned or will be assigned to a user. For pooled host pools, Start VM On Connect will only turn on a session host VM when none are turned on. More VMs will only be turned on when the first VM reaches the session limit.

The time it takes for a user to connect to a session host VM that is powered off (deallocated) increases because the VM needs time to turn on again, much like turning on a physical computer. The Remote Desktop client has an indicator that lets the user know the VM is being powered on while they're connecting.

You can only configure Start VM on Connect on existing host pools. You can't enable it at the same time you create a new host pool.<br>

The following Remote Desktop clients support Start VM on Connect:

 -  The web client
 -  The Windows client (version 1.2.2061 or later)
 -  The Android client (version 10.0.10 or later)
 -  The macOS client (version 10.6.4 or later)
 -  The iOS client (version 10.2.5 or later)
 -  Thin clients listed in Thin client support<br>

If you want to configure Start VM on Connect using PowerShell, you'll need to have the Az.DesktopVirtualization PowerShell module (version 2.1.0 or later) installed on the device.

You must grant Azure Virtual Desktop access to power on session host VMs, check their status, and report diagnostic information.

## Create a custom RBAC role in the Azure portal

Before you can configure Start VM on Connect, you'll need to create a custom role-based access control (RBAC) role with your Azure subscription as the assignable scope.

Assigning a custom role at any level lower than your subscription, such as the resource group, host pool, or VM, will prevent Start VM on Connect from working properly. You'll need to add each Azure subscription as an assignable scope that contains host pools and session host VMs you want to use with Start VM on Connect.

The custom role and assignment will allow Azure Virtual Desktop to power on VMs, check their status, and report diagnostic information in those subscriptions.

> [!IMPORTANT]
> You must have the Microsoft.Authorization/roleAssignments/write permission on your subscriptions in order to create and assign the custom role for the Azure Virtual Desktop service principal on those subscriptions. The permissions are part of User Access Administrator and Owner built in roles.

To create the custom role with the Azure portal:

1.  Open the Azure portal and go to **Subscriptions** and select a subscription that contains a host pool and session host VMs you want to use with Start VM on Connect.
2.  Select **Access control (IAM)**.
3.  Select the **+ Add** button, then select **Add custom role** from the drop-down menu.
4.  Next, on the **Basics** tab, enter a custom role name and add a description. We recommend you name the role *Azure Virtual Desktop Start VM on Connect*.
5.  For baseline permissions, select **Start** from scratch and select **Next**.
6.  On the **Permissions** tab, select **Next**. You'll add the permissions later on the JSON tab.
7.  On the **Assignable scopes** tab, your subscription will be listed. If you also want to assign this custom role to other subscriptions containing host pools and session host VMs, select **Add assignable scopes** and add the relevant subscriptions.
8.  On the JSON tab, select **Edit** and add the following permissions to the **"actions": \[\]** array. These entries must be enclosed within the square brackets.
    
    ```
    "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Compute/virtualMachines/read",
    "Microsoft.Compute/virtualMachines/instanceView/read"
    ```
    
    The completed JSON should look like this, with the subscription ID for each subscription included as assignable scopes:
    
    ```
    {
    "properties": {
    "roleName": "Azure Virtual Desktop Start VM on Connect",
    "description": "Turns on session host VMs when users connect to them",
    "assignableScopes": [
    "/subscriptions/00000000-0000-0000-0000-000000000000"
    ],
    "permissions": [
    {
    "actions": [
    "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Compute/virtualMachines/read",
    "Microsoft.Compute/virtualMachines/instanceView/read"
    ],
    "notActions": [],
    "dataActions": [],
    "notDataActions": []
    }
    ]
    }
    }
    ```
9.  Select **Save**, then select **Next**.
10. Review the configuration and select **Create**. Once the role has been successfully created, select **OK**.

After you've created the custom role, you'll need to assign it to the Azure Virtual Desktop service principal and grant access to each subscription.

## Assign the custom role with the Azure portal

Assign the custom role with the Azure portal to the Azure Virtual Desktop service principal on the subscription your host pool.

1.  Open the Azure portal and go to **Subscriptions**. Select a subscription that contains a host pool and session host VMs you want to use with Start VM on Connect.
2.  Select **Access control (IAM)**.
3.  Select the **+ Add** button, then select **Add role assignment** from the drop-down menu.
4.  Select the role, for example *Azure Virtual Desktop Start VM on Connect* and select **Next**.
5.  On the **Members** tab, select **User, group, or service principal**, then select **+Select member**s. In the search bar, enter and select either Azure Virtual Desktop or Windows Virtual Desktop. Which value you have depends on when the *Microsoft.DesktopVirtualization* resource provider was first registered in your Azure tenant. I
6.  Select **Review + assign** to complete the assignment. Repeat for any other subscriptions that contain host pools and session host VMs you want to use with Start VM on Connect.

Assign the custom role with PowerShell to the Azure Virtual Desktop service principal on the subscription your host pool is deployed.

1.  Open Azure Cloud Shell with PowerShell as the shell type.
2.  Get the object ID for the service principal (which is unique in each Azure tenant) and store it in a variable:
    
    ```powershell
    $objId = (Get-AzADServicePrincipal -AppId "9cdead84-a844-4324-93f2-b2e6bb768d07").Id
    ```
3.  Find the name of the subscription you want to add the role assignment to by listing all that are available to you:
    
    ```powershell
    Get-AzSubscription
    ```
4.  Get the subscription ID and store it in a variable, replacing the value for -SubscriptionName with the name of the subscription from the previous step:
    
    ```powershell
    $subId = (Get-AzSubscription -SubscriptionName "Microsoft Azure Enterprise").Id
    ```
5.  Add the role assignment, where -RoleDefinitionName is the name of the custom role you created earlier:
    
    ```powershell
    New-AzRoleAssignment -RoleDefinitionName "Azure Virtual Desktop Start VM on Connect" -ObjectId $objId -Scope /subscriptions/$subId
    ```

## Enable or disable Start VM on Connect

Now that you've assigned the custom role to the service principal on your subscriptions, you can configure Start VM on Connect using the Azure portal or PowerShell.

To configure Start VM on Connect using the Azure portal:

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  In the search bar, type *Azure Virtual Desktop* and select the matching service entry.
3.  Select **Host pools**, then select the name of the host pool where you want to enable the setting.
4.  Select **Properties**.
5.  In the configuration section, you'll see **Start VM on connect**. Select **Yes** to enable it, or **No** to disable it.
6.  Select **Save**. The new setting is applied.
