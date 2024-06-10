<!-- markdownlint-disable MD041 -->

In this unit, you continue with the example of a company that develops Linux admin tools. The goal
is to use Linux virtual machines (VMs) to allow potential customers to test your software. With a
resource group already set up, it's time to create the VMs.

Your company secured a booth at a large Linux trade show. You plan to set up a demo area with three
terminals, each connected to a separate Linux VM. You must delete the VMs and re-create them at the
end of each day so they start fresh every morning. Creating the VMs manually after a long day is
error-prone, so you need to write a PowerShell script to automate the VM creation process.

## Write a script to create virtual machines

Follow these steps to write a script in Azure Cloud Shell that automates the creation of virtual
machines.

> [!NOTE]
> Usually, you'd authenticate to Azure using your credentials with `Connect-AzAccount`, but in
> Cloud Shell, you're already authenticated, so this step is unnecessary.

1. Switch to your home folder:

   ```powershell
   Set-Location -Path $HOME
   ```

1. Create a new PowerShell script file:

   ```powershell
   New-Item -Name ConferenceDailyReset.ps1 -ItemType File
   ```

1. Open the integrated Visual Studio Code (VS Code) editor:

   ```powershell
   code ./ConferenceDailyReset.ps1
   ```

   > [!TIP]
   > The integrated Cloud Shell editor also supports vim, nano, and emacs if you prefer to use one
   > of those editors.

1. Define a parameter for your resource group name:

   Add the following line to your script:

   ```powershell
   param (
       [string]$ResourceGroupName
   )
   ```

1. Prompt for VM administrator credentials:

   ```powershell
   $adminCredential = Get-Credential -Message 'Enter a username and password for the VM administrator.'
   ```

1. Create a loop to execute three times:

   ```powershell
   $vms = 1..3
   foreach ($vm in $vms) {
       $vm
   }
   ```

1. In the loop, create a name for each VM and return it:

   ```powershell
   $vmName = "ConferenceDemo-$vm"
   Write-Output "Creating VM: $vmName"
   ```

1. Create a VM using the `$vmName` variable:

   ```azurepowershell
   $azVmParams = @{
       ResourceGroupName = $ResourceGroupName
       Name              = $vmName
       Credential        = $adminCredential
       Image             = 'Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest'
       OpenPorts         = 22
   }
   New-AzVm @azVmParams
   ```

1. Save the file:

   To save the script, use the ellipsis (`...`) context menu at the top-right corner of the editor
   or the <kbd>Ctrl</kbd> + <kbd>S</kbd> keyboard shortcut.

### Completed script

The completed script should look like the following example:

```azurepowershell
param (
    [string]$ResourceGroupName
)

$adminCredential = Get-Credential -Message 'Enter a username and password for the VM administrator.'

$vms = 1..3

foreach ($vm in $vms) {

    $vmName = "ConferenceDemo-$vm"
    Write-Output "Creating VM: $vmName"

    $azVmParams = @{
        ResourceGroupName = $ResourceGroupName
        Name              = $vmName
        Credential        = $adminCredential
        Image             = 'Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest'
        OpenPorts         = 22
    }
    New-AzVm @azVmParams
}
```

Once you confirm your script looks like the code in the previous example, close the editor using the
ellipsis (`...`) context menu at the top-right corner of the editor, or the <kbd>Ctrl</kbd> +
<kbd>Q</kbd> keyboard shortcut.

## Run the script

1. Execute the script using the following command:

   ```powershell
   ./ConferenceDailyReset.ps1 -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
   ```

1. Wait for completion. The script takes several minutes to complete.

1. Verify the VMs. Once the script finishes, verify it completed successfully by listing the VMs in
   the resource group:

   ```azurepowershell
   Get-AzVM -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
   ```

   You should see three VMs, each with a unique name.

You successfully created a script that automates the creation of three VMs, each in a specific
resource group, ensuring they're ready for daily demos at the trade show. Although the script is
short and straightforward, it significantly speeds up a process that would otherwise be
time-consuming and error-prone if performed manually through the Azure portal.
