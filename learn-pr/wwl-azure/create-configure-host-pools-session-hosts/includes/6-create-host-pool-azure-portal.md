This unit describes how to create a host pool using the [Az.DesktopVirtualization](/powershell/module/az.desktopvirtualization) PowerShell module. The samples show you how to create a pooled host pool and a personal host pool.<br>

You'll need to change the *&lt;placeholder&gt;* values for your own.<br>

Launch the [Azure Cloud Shell](/azure/cloud-shell/overview) in the Azure portal with the *PowerShell* terminal type, or run PowerShell on your local device.

 -  If you're using Cloud Shell, make sure your [Azure context is set to the subscription you want to use](/powershell/azure/context-persistence).
 -  If you're using PowerShell locally, first [Sign in with Azure PowerShell](/powershell/azure/authenticate-azureps), then make sure your [Azure context is set to the subscription you want to use](/powershell/azure/context-persistence).
 -  Use the New-AzWvdHostPool cmdlet with the following examples to create a host pool. More parameters are available; for more information, see the [New-AzWvdHostPool PowerShell reference](/powershell/module/az.desktopvirtualization/new-azwvdhostpool).

To create a pooled host pool using the *breadth-first*[load-balancing algorithm](/azure/virtual-desktop/host-pool-load-balancing) and *Desktop* as the preferred [app group type](/azure/virtual-desktop/environment-setup#app-groups), run the following command:

```powershell
$parameters = @{
Name = '<Name>'
ResourceGroupName = '<ResourceGroupName>'
HostPoolType = 'Pooled'
LoadBalancerType = 'BreadthFirst'
PreferredAppGroupType = 'Desktop'
MaxSessionLimit = '<value>'
Location = '<AzureRegion>'
}

New-AzWvdHostPool @parameters
```

To create a personal host pool using the *Automatic* assignment type and *Desktop* as the preferred [app group type](/azure/virtual-desktop/environment-setup#app-groups), run the following command:

```powershell
$parameters = @{
Name = '<Name>'
ResourceGroupName = '<ResourceGroupName>'
HostPoolType = 'Personal'
LoadBalancerType = 'Persistent'
PreferredAppGroupType = 'Desktop'
PersonalDesktopAssignmentType = 'Automatic'
Location = '<AzureRegion>'
}

New-AzWvdHostPool @parameters
```

You can view the properties of your new host pool by running the following command:

```powershell
Get-AzWvdHostPool -Name <Name> -ResourceGroupName <ResourceGroupName> | FL *

```
