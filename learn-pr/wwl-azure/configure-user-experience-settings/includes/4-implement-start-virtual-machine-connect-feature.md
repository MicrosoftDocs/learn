Start VM on Connect lets you reduce costs by enabling end users to power on the virtual machines (VMs) used as session hosts only when they're needed. You can then power off VMs when they're not needed.

For personal host pools, Start VM on Connect only powers on an existing session host VM that is already assigned or can be assigned to a user. For pooled host pools, Start VM on Connect only powers on a session host VM when none are turned on and more VMs are only be turned on when the first VM reaches the session limit.

The time it takes for a user to connect to a remote session on a session host that is powered off (deallocated) increases because the VM needs time to power on again, much like turning on a physical computer. When a user uses Windows App and the Remote Desktop app to connect to Azure Virtual Desktop, they're told a VM is being powered on while they're connecting.

You can enable Start VM on Connect for session hosts on Azure and Azure Stack HCI in personal or pooled host pools using the Azure portal, Azure PowerShell, or Azure CLI. Start VM on Connect is configured per host pool.

Before you can use Start VM on Connect, you need:

 -  An existing host pool that's associated with an application group and workspace. You can only configure Start VM on Connect on existing host pools. You can't enable it at the same time you create a new host pool.
 -  The Azure account you use to configure Start VM on Connect must have the [Desktop Virtualization Host Pool Contributor](/azure/virtual-desktop/rbac#desktop-virtualization-host-pool-contributor) role-based access control (RBAC) role assigned.
 -  Windows App or the Remote Desktop app installed on a local device with a user account assigned to a desktop or application in the application group you can test with.
 -  Make sure that the name of the host pool, session hosts in that host pool, and the resource group only have ANSI characters.
 -  If you want to use Azure PowerShell or Azure CLI locally, see [Use Azure PowerShell and Azure CLI with Azure Virtual Desktop](/azure/virtual-desktop/cli-powershell) to make sure you have the [Az.DesktopVirtualization](/powershell/module/az.desktopvirtualization) PowerShell module or the [desktopvirtualization](/cli/azure/desktopvirtualization) Azure CLI extension installed. Alternatively, use the [Azure Cloud Shell](/azure/cloud-shell/overview).

## Assign the Desktop Virtualization Power On Contributor role with the Azure portal

To configure Start VM on Connect, you need to assign the *Desktop Virtualization Power On Contributor* role-based access control (RBAC) role to the Azure Virtual Desktop service principal with your Azure subscription as the assignable scope. If you assign this role at any level lower than a subscription, such as the resource group, host pool, or VM, prevents Start VM on Connect from working properly.

You need to add each Azure subscription that contains host pools and session host VMs you want to use with Start VM on Connect as an assignable scope. This role assignment allows Azure Virtual Desktop to power on VMs, check their status, and report diagnostic information for those subscriptions.

## Enable or disable Start VM on Connect

Once you assign the *Desktop Virtualization Power On Contributor* role to the service principal on relevant subscriptions, you can configure Start VM on Connect using the Azure portal, Azure PowerShell, or Azure CLI.

To configure Start VM on Connect using the Azure portal:

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  In the search bar, enter *Azure Virtual Desktop* and select the matching service entry.
3.  Select **Host pools**, then select the name of the host pool where you want to enable the setting.
4.  Select **Properties**.
5.  In the configuration section, set **Start VM on connect** to **Yes** to enable it, or **No** to disable it.
6.  Select **Save** to apply the settings.

> [!NOTE]
> For pooled host pools, Start VM on Connect will start a VM every five minutes at most. If other users try to sign in during this five-minute period and there still aren't any available resources, Start VM on Connect won't start a new VM. Instead, the users trying to sign in will receive an error message that says, **No resources available**. They should wait a few minutes and try to connect again.
