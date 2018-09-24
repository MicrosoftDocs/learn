In this exercise, you will create a virtual machine and then resize it using the portal and Azure PowerShell.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Create a VM with PowerShell

1. Let's use the `New-AzureRmVm` cmdlet in Azure PowerShell to create a VM.
    - Use the Resource Group **<rgn>[Sandbox resource group name]</rgn>**.
    - Name it "my-test-vm".
    - Pass in _Standard_DS2_v2_ for the **Size** parameter.
    - Select a location close to you from the following list available in the Azure Sandbox. Make sure to change the value in the below example command if you are using copy and paste.

        [!include[](../../../includes/azure-sandbox-regions-note.md)]

    - Use the `Get-Credential` cmdlet and feed the results into the `Credential` parameter as shown below.

       When prompted to enter credentials, use LocalAdmin as the user name and Adm1nPa$$word as the password.

    ```powershell
    New-AzureRmVm `
        -ResourceGroupName <rgn>[Sandbox resource group name]</rgn> `
        -Name my-test-vm `
        -Credential (Get-Credential) `
        -Size "Standard_DS2_v2" `
        -Location eastus
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]


1. Wait until the deployment is complete before continuing the exercise.

## Resize using the portal

1. Sign into the [Azure portal for Sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Select **Resource Groups** from the left side bar.

1. Select the <rgn>[Sandbox resource group name]</rgn> resource group, and in the overview, click the **my-test-vm** virtual machine object.

1. On the **Overview** of the virtual machine, notice that the current size of the VM is _Standard DS2 v2 (2 vcpus, 7 GB memory)_ which is what we created a moment ago.

1. In the **Settings** section, select **Size**.

1. On the **Choose a size** blade, try to find the **F2s_v2** size. You will not see it in the list of available sizes because the VM is currently running and that size is from a different family. In some cases, you will need to stop the VM in order to see all available VM sizes.

1. Let's choose a size that is currently available while this VM is running. While still on the **Choose a size** blade, select _DS3_v2 Standard_ and then click **Select**. Notice the notification about resizing the virtual machine.

1. On the **Overview** panel, confirm that the VM has been resized to _Standard DS3 v2 (4 vcpus, 14 GB memory)_.

## Resize using PowerShell

1. In the Azure portal, open Azure Cloud Shell by clicking the Cloud Shell button in the top toolbar.

    Ensure that the Cloud Shell is set to use PowerShell and not Bash, in the top left of the Cloud Shell window.

1. Use the following cmdlet to get the list of available virtual machine sizes.

    ```PowerShell
    Get-AzureRmVMSize -ResourceGroupName <rgn>[Sandbox resource group name]</rgn> -VMName my-test-vm
    ```

1. Use the following cmdlet to resize the virtual machine back to a _DS2_v2_ size.

    ```PowerShell
    $vm = Get-AzureRmVM -ResourceGroupName <rgn>[Sandbox resource group name]</rgn> -VMName my-test-vm
    $vm.HardwareProfile.VmSize = "Standard_DS2_v2"
    Update-AzureRmVM -VM $vm -ResourceGroupName <rgn>[Sandbox resource group name]</rgn>
    ```

1. Click the **Refresh** button in the **my-test-vm** blade while you are waiting for the PowerShell command to finish. You should notice that the virtual machine is restarting to accommodate the change in size.

In this exercise, you created a virtual machine and resized it with two different tools. A good tip to keep in mind is that the target size may not be available while the virtual machine is running; stopping the virtual machine lets you choose more sizes.