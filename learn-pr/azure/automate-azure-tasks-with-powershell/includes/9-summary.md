In this module, we wrote a script to automate creating multiple VMs. Even though the script was relatively short, you can see the potential power when you combine loops, variables, and functions from PowerShell with cmdlets from Azure PowerShell.

Azure PowerShell is a good automation choice for admins with PowerShell experience. The combination of clean syntax and a powerful scripting language also makes it worth considering even if you're new to PowerShell. This level of automation for time-consuming and error-prone tasks should help you reduce administrative time and increase quality.

<!-- Cleanup sandbox -->
[!include[](../../../includes/azure-sandbox-cleanup.md)]

When you're running in your own subscription, you can use the following PowerShell cmdlet to delete the resource group and all related resources (replacing *MyResourceGroupName* with the resource group you created).

```powershell
Remove-AzResourceGroup -Name MyResourceGroupName
```

When you're asked to confirm the delete, answer **Yes**, or you can add the `-Force` parameter to skip the prompt. The command might take several minutes to complete.
