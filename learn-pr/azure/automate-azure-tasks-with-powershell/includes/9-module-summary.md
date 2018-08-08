## Module Summary
In this module, we wrote a script to automate the creation of multiple VMs. Even though the script was relatively short, you can see the potential power when you combine loops, variables, and functions from PowerShell with cmdlets from Azure PowerShell.

Azure PowerShell is a good automation choice for admins with PowerShell experience. The combination of clean syntax and a powerful scripting language also makes it worth considering even if you are new to PowerShell. This level of automation for time-consuming and error-prone tasks should help you reduce administrative time and increase quality.

## Cleanup
Provisioned and running VMs incur costs against your subscription. You should remove unneeded VMs to avoid unnecessary charges. The easiest way to clean up your Azure subscription is to remove the resource group; this will also delete all the VMs in the group. When you are finished with this module, please run the following Azure PowerShell cmdlet:

   ```powershell
   Remove-AzureRmResourceGroup -Name TrialsResourceGroup
   ```

When you are asked to confirm the delete, answer **Yes**. The command may take several minutes to complete as resources are deleted. 