Scripts created for the AzureRM cmdlets won't automatically work with the Az module. To make the transition easier, the AzureRM to Az migration toolkit was developed. No migration to a new command set is ever convenient, but it's important that you understand how to transition to the Az PowerShell module.

The new cmdlet names have been designed to be easier to learn. Instead of using AzureRm or Azure in cmdlet names, you use Az cmdlets. For example, the old cmdlet **New-AzureRMVm** has become **New-AzVm**. However, migration is more than just becoming familiar with the new cmdlet names. There are renamed modules, parameters, and other important changes.

Before taking any migration steps, check which versions of AzureRM are installed on your system. Doing so allows you to make sure scripts are already running on the latest release and let you know which versions of AzureRM must be uninstalled.

To check which versions of AzureRM you've installed, run the following command:

```powershell
Get-Module -Name AzureRM -ListAvailable -All
```

> [!NOTE]
> The latest available release of AzureRM is 6.13.1. If you don't have this version installed, your existing scripts might need additional modifications to work with the Az module.

The recommended option to migrate from AzureRM to the Az PowerShell module is to use automatic migration. For this, you need to install the AzureRM to Az migration toolkit by running the following command:

```powershell
Install-Module -Name Az.Tools.Migration
```

With the AzureRM to Az migration toolkit, you can generate a plan to determine what changes will be performed on your scripts before making any modifications to them and before installing the Az PowerShell module.

> **Additional reading:** To learn about the steps for automatic migration, refer to [Quickstart: Automatically migrate PowerShell scripts from AzureRM to the Az PowerShell module](https://aka.ms/quickstart-automatically-migrate-powershell-scripts-from-azurerm-to-the-az-powershell-module).

You can also use Microsoft Visual Studio Code to migrate your existing scripts. To do so, you first need to install the Azure PowerShell extension for Visual Studio Code. Then, you need to perform the following steps:

1. Load your AzureRM script in Visual Studio Code.
1. Open the command palette by selecting **Ctrl+Shift+P**.
1. Select the **Migrate Azure PowerShell** script.
1. Select the **AzureRM** source version.
1. Follow the recommended actions for each underlined command or parameter.
