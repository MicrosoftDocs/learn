This unit shows you how to use your PowerShell client to create a host pool for Azure Virtual Desktop.

Run the following cmdlet to sign in to the Azure Virtual Desktop environment:

```powershell
New-AzWvdHostPool -ResourceGroupName <resourcegroupname> -Name <hostpoolname> -WorkspaceName <workspacename> -HostPoolType <Pooled|Personal> -LoadBalancerType <BreadthFirst|DepthFirst|Persistent> -Location <region> -DesktopAppGroupName <appgroupname>
```

This cmdlet will create the host pool, workspace, and desktop app group. Additionally, it will register the desktop app group to the workspace. You can either create a workspace with this cmdlet or use an existing workspace.

Run the next cmdlet to create a registration token to authorize a session host to join the host pool and save it to a new file on your local computer. You can specify how long the registration token is valid by using the `-ExpirationHours` parameter.

The token's expiration date can be no less than an hour and no more than one month. If you set `-ExpirationTime` outside of that limit, the cmdlet won't create the token.

```PowerShell
New-AzWvdRegistrationInfo -ResourceGroupName <resourcegroupname> -HostPoolName <hostpoolname> -ExpirationTime $((get-date).ToUniversalTime().AddDays(1).ToString('yyyy-MM-ddTHH:mm:ss.fffffffZ'))

```

For example, if you want to create a token that expires in two hours, run this cmdlet:

```PowerShell
New-AzWvdRegistrationInfo -ResourceGroupName <resourcegroupname> -HostPoolName <hostpoolname> -ExpirationTime $((get-date).ToUniversalTime().AddHours(2).ToString('yyyy-MM-ddTHH:mm:ss.fffffffZ'))

```

After that, run this cmdlet to add Azure Active Directory users to the default desktop app group for the host pool.

```PowerShell
New-AzRoleAssignment -SignInName <userupn> -RoleDefinitionName "Desktop Virtualization User" -ResourceName <hostpoolname+"-DAG"> -ResourceGroupName <resourcegroupname> -ResourceType 'Microsoft.DesktopVirtualization/applicationGroups'

```

Run this next cmdlet to add Azure Active Directory user groups to the default desktop app group for the host pool:

```PowerShell
New-AzRoleAssignment -ObjectId <usergroupobjectid> -RoleDefinitionName "Desktop Virtualization User" -ResourceName <hostpoolname+"-DAG"> -ResourceGroupName <resourcegroupname> -ResourceType 'Microsoft.DesktopVirtualization/applicationGroups'


```

Run the following cmdlet to export the registration token to a variable, which will be used later to register the virtual machines to the Azure Virtual Desktop host pool.

```PowerShell
$token = Get-AzWvdRegistrationInfo -ResourceGroupName <resourcegroupname> -HostPoolName <hostpoolname>

```

## Create virtual machines for the host pool

Now you can create an Azure virtual machine that can be joined to your Azure Virtual Desktop host pool.

You can create a virtual machine in multiple ways:

 -  Create a virtual machine from an Azure Gallery image.
 -  Create a virtual machine from a managed image.
 -  Create a virtual machine from an unmanaged image.

## Prepare the virtual machines for Azure Virtual Desktop agent installations

Do the following to prepare your virtual machines before you can install the Azure Virtual Desktop agents and register the virtual machines to your Azure Virtual Desktop host pool:

 -  Domain join the virtual machine. This allows incoming Azure Virtual Desktop users to be mapped from their Azure Active Directory account to their Active Directory account and be successfully allowed access to the virtual machine.
 -  Install the Remote Desktop Session Host (RDSH) role if the virtual machine is running a Windows Server OS. The RDSH role allows the Azure Virtual Desktop agents to install properly.

To successfully domain-join, do the following things on each virtual machine:

1.  Connect to the virtual machine with the credentials you provided when creating the virtual machine.
2.  On the virtual machine, launch **Control Panel** and select **System**.
3.  Select **Computer name**, select **Change settings**, and then select **Change…**
4.  Select **Domain** and then enter the Active Directory domain on the virtual network.
5.  Authenticate with a domain account that has privileges to domain-join machines.

## Register the virtual machines to the Azure Virtual Desktop host pool

To register the Azure Virtual Desktop agents, do the following on each virtual machine:

1.  Connect to the virtual machine with the credentials you provided when creating the virtual machine.
2.  Download and install the Azure Virtual Desktop Agent.
3.  Download the [Azure Virtual Desktop Agent](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv).
4.  Run the installer. When the installer asks you for the registration token, enter the value you got from the **Get-AzWvdRegistrationInfo** cmdlet.
5.  Download and install the Azure Virtual Desktop Agent Bootloader.
6.  Download the [Azure Virtual Desktop Agent Bootloader](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH).
7.  Run the installer.

