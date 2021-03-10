PowerShell lets you write commands and execute them immediately. This is known as **interactive mode**.

Recall that the overall goal in the Customer Relationship Management (CRM) example is to create three test environments containing Virtual Machines. You will use resource groups to ensure the VMs are organized into separate environments: one for unit testing, one for integration testing, and one for acceptance testing. You only need to create the resource groups once, which means using the interactive mode of PowerShell is a good choice.

When you enter a command into PowerShell, it matches it to a _cmdlet_ which then performs the requested action. We're going to look at some of the common commands you can use, and then look at installing the Azure support for PowerShell.

## What are PowerShell cmdlets?

A PowerShell command is called a **cmdlet** (pronounced "command-let"). A cmdlet is a command that manipulates a single feature. The term **cmdlet** is intended to imply "small command". By convention, cmdlet authors are encouraged to keep cmdlets simple and single-purpose.

The base PowerShell product ships with cmdlets that work with features such as sessions and background jobs. You add modules to your PowerShell installation to get cmdlets that manipulate other features. For example, there are third-party modules to work with ftp, administer your operating system, access the file system, and so on.

Cmdlets follow a verb-noun naming convention; for example, **Get-Process**, **Format-Table**, and **Start-Service**. There is also a convention for verb choice: "get" to retrieve data, "set" to insert or update data, "format" to format data, "out" to direct output to a destination, and so on.

Cmdlet authors are encouraged to include a help file for each cmdlet. The **Get-Help** cmdlet displays the help file for any cmdlet. For example, we could get help on the `Get-ChildItem` cmdlet with the following statement:

```powershell
Get-Help Get-ChildItem -detailed
```

## What is a PowerShell module?

Cmdlets are shipped in _modules_. A PowerShell Module is a DLL that includes the code to process each available cmdlet. You load cmdlets into PowerShell by loading the module they are contained in. You can get a list of loaded modules using the `Get-Module` command:

```powershell
Get-Module
```

This will output something like:

```output
ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   3.1.0.0    Microsoft.PowerShell.Management     {Add-Computer, Add-Content, Checkpoint-Computer, Clear-Con...
Manifest   3.1.0.0    Microsoft.PowerShell.Utility        {Add-Member, Add-Type, Clear-Variable, Compare-Object...}
Binary     1.0.0.1    PackageManagement                   {Find-Package, Find-PackageProvider, Get-Package, Get-Pack...
Script     1.0.0.1    PowerShellGet                       {Find-Command, Find-DscResource, Find-Module, Find-RoleCap...
Script     2.0.0      PSReadline                          {Get-PSReadLineKeyHandler, Get-PSReadLineOption, Remove-PS...
```

## What is the Az module?

**Az** is the formal name for the Azure PowerShell module containing cmdlets to work with Azure features. It contains hundreds of cmdlets that let you control nearly every aspect of every Azure resource. You can work with resource groups, storage, virtual machines, Azure Active Directory, containers, machine learning, and so on. This module is an open source component [available on GitHub](https://github.com/Azure/azure-powershell).

> [!NOTE]
> You may have seen or used Azure PowerShell commands that used a `-AzureRM` format. In October 2018 we announced the replacement of the **AzureRM** module with the **Az** module. This new module has several features, notably a shortened cmdlet noun prefix of `-Az` instead of `-AzureRM`. The **Az** module ships with backwards compatibility with the **AzureRM** module so the `-AzureRM` cmdlet format will work, but you should transition to the **Az** module and use the `-Az` commands going forward.

### Install the Az module

The Az module is available from a global repository called the PowerShell Gallery. You can install the module onto your local machine through the `Install-Module` command. You need an elevated PowerShell shell to install modules from the PowerShell Gallery. 

::: zone pivot="windows"

To install the latest Azure PowerShell module, run the following commands:

1. Open the **Start** menu, and enter **Windows PowerShell**.

1. Right-click the **Windows PowerShell** icon and select **Run as administrator**.

1. In the **User Account Control** dialog, select **Yes**.

1. Enter the following command, and then press <kbd>Enter</kbd>.

    ```powershell
    Install-Module -Name Az -AllowClobber -SkipPublisherCheck
    ```

This installs the module for all users by default (controlled by the scope parameter).

The command relies on NuGet to retrieve components, depending on the version of NuGet you have installed you might get a prompt to download and install the latest version of NuGet.

```output
NuGet provider is required to continue
PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with NuGet-based repositories. The NuGet
 provider must be available in 'C:\Program Files (x86)\PackageManagement\ProviderAssemblies' or
'C:\Users\<username>\AppData\Local\PackageManagement\ProviderAssemblies'. You can also install the NuGet provider by running
'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force'. Do you want PowerShellGet to install and import
 the NuGet provider now?
```

By default, the PowerShell gallery isn't configured as a trusted repository for PowerShellGet. The first time you use the PSGallery you see the following prompt:

```output
You are installing the modules from an untrusted repository. If you trust this repository, change its
InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want to install the modules from
'PSGallery'?
```

#### Script execution failed

Depending on your security configuration, `Import-Module` might fail with something like the following.

```output
import-module : File C:\Program Files (x86)\WindowsPowerShell\Modules\az\0.7.0\Az.psm1 cannot be loaded
because running scripts is disabled on this system. For more information, see about_Execution_Policies at
https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ import-module Az
+ ~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [Import-Module], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess,Microsoft.PowerShell.Commands.ImportModuleCommand
```

This normally indicates that the execution policy is "restricted", meaning you can't execute modules you download from an external source - including the PowerShell gallery. You can check whether this is the case by executing the command `Get-ExecutionPolicy`. If it returns "Restricted", then do the following:

1. Open an elevated PowerShell command prompt.

1. Use the `SetExecutionPolicy` cmdlet to change the policy to "RemoteSigned":

```powershell
Set-ExecutionPolicy RemoteSigned
```

This will prompt you for permission:

```output
The execution policy helps protect you from scripts that you do not trust. Changing the execution policy might expose
you to the security risks described in the about_Execution_Policies help topic at
https:/go.microsoft.com/fwlink/?LinkID=135170. Do you want to change the execution policy?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): Y
```

You should then be able to use `Import-Module` to load the cmdlets.

:::zone-end

::: zone pivot="linux,macos"

We use the same commands to install the Azure PowerShell on either Linux or macOS.

1. In a terminal, run the following command to launch PowerShell Core with elevated privileges.

    ```bash
    sudo pwsh
    ```

1. Run the following command at the PowerShell Core prompt to install Azure PowerShell.

    ```powershell
    Install-Module Az -AllowClobber
    ```

1. If you are asked whether you trust modules from **PSGallery**, answer **Yes** or **Yes to All**.

:::zone-end

### Update a module

If you get a warning or error message indicating that a version of the Azure PowerShell module is already installed, you can update to the _latest_ version by issuing the command:

```powershell
Update-Module -Name Az
```

As with the `Install-Module` command, answer **Yes** or **Yes to All** when prompted to trust the module. You can also use the `Update-Module` command to re-install a module if you are having trouble with it.

## Example: How to create a resource group with Azure PowerShell

Once you have the Azure module loaded, you can begin working with Azure. Let's do a common task - create a Resource Group. As you know, we use resource groups to administer related resources together. Creating a new resource group is one of the first tasks you'll do when starting a new Azure solution.

There are four steps we need to perform:

1. Import the Azure cmdlets.

1. Connect to your Azure subscription.

1. Create the resource group.

1. Verify that creation was successful (see the following).

The following illustration shows an overview of these steps.

![An illustration showing the steps to create a resource group.](../media/5-create-resource-overview.png)

Each step corresponds to a different cmdlet.

### Import the Azure cmdlets

At startup, PowerShell loads only the core cmdlets by default. This means the cmdlets you need to work with Azure won't be loaded. The most reliable way to load the cmdlets you need is to import them manually at the start of your PowerShell session.

You use the **Import-Module** cmdlet to load modules. This cmdlet has many parameters to handle a variety of situations. For example, it can load multiple modules, a specific module version, part of a module, and so on.

For example, we can load all the cmdlets for Az with the following command **in an elevated PowerShell session**:

```powershell
Import-Module Az
```

> [!TIP]
> If you find that you work with Azure PowerShell frequently, there are two ways you can automate the module-loading process. You can add an entry to your PowerShell profile to import the Azure module at startup or use the latest versions of PowerShell, which loads the containing module automatically when you use a cmdlet.

### Connect

When you are working with a local install of Azure PowerShell, you will need to authenticate before you can execute Azure commands. The **Connect-AzAccount** cmdlet prompts for your Azure credentials and then connects to your Azure subscription. It has many optional parameters, but if all you need is an interactive prompt, no parameters are needed:

```powershell
Connect-AzAccount
```

You'll need to repeat these steps for every new PowerShell session you start since this module is not part of the core set.

### Work with subscriptions

If you are new to Azure, you probably only have a single subscription. But if you have been using Azure for a while, you may have created multiple Azure subscriptions. You can configure Azure PowerShell to execute commands against a particular subscription.

You can only be in one subscription at a time. Use the `Get-AzContext` cmdlet to determine which subscription is active. If it's not the correct one, you can change it.

1. Get a list of all subscription names in your account with the `Get-AzSubscription` command. 

1. Change the subscription by passing the name of the one to select.

```powershell
Select-AzSubscription -SubscriptionId '53dde41e-916f-49f8-8108-558036f826ae'
```

If you need to look up the **Subscription ID** > open Azure, and on the home page, select **Subscriptions**.

### Get a list of all resource groups

You can retrieve a list of all Resource Groups in the active subscription.

```powershell
Get-AzResourceGroup
```

To get a more concise view, you can send the output from the `Get-AzResourceGroup` to the `Format-Table` cmdlet using a pipe '|'.

```powershell
Get-AzResourceGroup | Format-Table
```

The output will look something like this.

```output
ResourceGroupName                  Location       ProvisioningState Tags TagsTable ResourceId
-----------------                  --------       ----------------- ---- --------- ----------
cloud-shell-storage-southcentralus southcentralus Succeeded                        /subscriptions/xxxxxxxx-d3ce-4172...
ExerciseResources                  eastus         Succeeded                        /subscriptions/xxxxxxxx-d3ce-4172...
```

### Create a resource group

As you know, when you are creating resources in Azure, you will always place them into a resource group for management purposes. A resource group is often one of the first things you will create when starting a new application.

You can create resource groups with the `New-AzResourceGroup` cmdlet. You must specify a name and location. The name must be unique within your subscription. The location determines where the metadata for your resource group will be stored (which may be important to you for compliance reasons). You use strings like "West US", "North Europe", or "West India" to specify the location. As with most of the Azure cmdlets, `New-AzResourceGroup` has many optional parameters; however, the core syntax is:

```powershell
New-AzResourceGroup -Name <name> -Location <location>
```

> [!NOTE]
> Remember, we will be working in the Azure sandbox which creates the Resource Group for you. The above command would be used if you work in your own subscription.

### Verify the resources

The `Get-AzResource` lists your Azure resources. This is useful here to verify whether creation of the resource group was successful.

```powershell
Get-AzResource
```

Like the `Get-AzResourceGroup` command, you can get a more concise view through the `Format-Table` cmdlet. Here we will use a shorthand version `ft`:

```powershell
Get-AzResource | ft
```

You can also filter it to specific resource groups to only list resources associated with that group:

```powershell
Get-AzResource -ResourceGroupName ExerciseResources
```

### Create an Azure Virtual Machine

Another common task that could be done with PowerShell is to create VMs.

Azure PowerShell provides the `New-AzVm` cmdlet to create a virtual machine. The cmdlet has many parameters to let it handle the large number of VM configuration settings. Most of the parameters have reasonable default values so we only need to specify five things:

- **ResourceGroupName**: The resource group into which the new VM will be placed.
- **Name**: The name of the VM in Azure.
- **Location**: Geographic location where the VM will be provisioned.
- **Credential**: An object containing the username and password for the VM admin account. We will use the `Get-Credential` cmdlet. This cmdlet will prompt for a username and password and package it into a credential object.
- **Image**: The operating system image to use for the VM. This is often a Linux distribution, or Windows Server.

```powershell
   New-AzVm 
       -ResourceGroupName <resource group name> 
       -Name <machine name> 
       -Credential <credentials object> 
       -Location <location> 
       -Image <image name>
```

You can supply these parameters directly to the cmdlet as shown above. Alternatively, other cmdlets can be used to configure the virtual machine, such as `Set-AzVMOperatingSystem`, `Set-AzVMSourceImage`, `Add-AzVMNetworkInterface`, and `Set-AzVMOSDisk`.

Here's an example that strings the `Get-Credential` cmdlet together with the `-Credential` parameter:

```powershell
New-AzVM -Name MyVm -ResourceGroupName ExerciseResources -Credential (Get-Credential) ...
```

The `AzVM` suffix is specific to VM-based commands in PowerShell. There are several others you can use:

| Command | Description |
|---------|-------------|
| `Remove-AzVM` | Deletes an Azure VM. |
| `Start-AzVM` | Start a stopped VM. |
| `Stop-AzVM` | Stop a running VM. |
| `Restart-AzVM` | Restart a VM. |
| `Update-AzVM` | Updates the configuration for a VM. |

#### Example: Getting information for a VM

You can list the VMs in your subscription with the `Get-AzVM -Status` command. This can also specify a VM with the `-Name` property. Here we assign it to a PowerShell variable:

```powershell
$vm = Get-AzVM  -Name MyVM -ResourceGroupName ExerciseResources
```

The interesting thing is this is an _object_ you can interact with. For example, you can take that object, make changes and then push changes back to Azure with the `Update-AzVM` command:

```powershell
$ResourceGroupName = "ExerciseResources"
$vm = Get-AzVM  -Name MyVM -ResourceGroupName $ResourceGroupName
$vm.HardwareProfile.vmSize = "Standard_DS3_v2"

Update-AzVM -ResourceGroupName $ResourceGroupName  -VM $vm
```

PowerShell's interactive mode is appropriate for one-off tasks. In our example, we'll likely use the same resource group for the lifetime of the project, which means creating it interactively is reasonable. Interactive mode is often quicker and easier for this task than writing a script and executing that script exactly once.
