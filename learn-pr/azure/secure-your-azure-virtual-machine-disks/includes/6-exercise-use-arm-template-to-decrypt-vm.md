In this unit, you'll use an Azure Resource Manager template to decrypt the Windows VM you created earlier. We encrypted the OS drive on our Windows VM. However, the OS drive won't have any confidential information on it, so we could leave it unencrypted. Let's use a template to decrypt the OS drive.

## Decrypt a VM using an Azure Resource Manager template

You're going to use a template that Microsoft published on GitHub that's specifically designed to decrypt a running Windows VM.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same account you used to activate the sandbox.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

1. In the search box, enter **Template deployment**.

1. From the resulting list, select **Template deployment (deploy using custom templates)**. The **Template deployment (deploy using custom templates)** appears.

    :::image type="content" source="../media/6-create-template.png" alt-text="Screenshot showing the Template Deployment item selected with the Create button highlighted.":::

1. Select **Create**.  The **Custom deployment** pane appears.

1. On the **Select a template** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Start with a quickstart template or template spec** |
    | Template source | Quickstart template |
    | Quickstart template (disclaimer) | Select the field, then enter *decrypt-running-windows-vm-without-aad* and select the **decrypt-running-windows-vm-without-aad** template |

    :::image type="content" source="../media/6-custom-deployment.png" alt-text="Screenshot showing the Select a Template search box with autocompletion.":::

1. To launch the template runner, select **Select template**. The **Disable encryption on Windows VM encrypted without AAD** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Project details** |
    | Subscription |  Concierge Subscription |
    | Resource group | Select sandbox resource group <rgn>Sandbox RG</rgn>. This autoselects the region as well. |
    | **Instance details** |
    | Region | Autoselected from *Resource group* selection |
    | Vm Name | Enter *fmdata-vm01* |
    | Volume Type | Accept default *All* |
    | Force Update Tag | Accept default |
    | Location | Accept default |

1. Select **Review + create**.

1. After validation passes, select **Create**.

The deployment may take a few minutes to complete.

## Verify the encryption status of the VM

In Cloud Shell, check the encryption status.

   ```powershell
    $vmName = "fmdata-vm01"
    $rgName = "<rgn>[sandbox Resource Group]</rgn>"
    Get-AzVmDiskEncryptionStatus  -ResourceGroupName $rgName -VMName $vmName
  ```

Now, the OS disk isn't encrypted.

  ```output
    OsVolumeEncrypted          : NotEncrypted
    DataVolumesEncrypted       : NoDiskFound
    OsVolumeEncryptionSettings : Microsoft.Azure.Management.Compute.Models.DiskEncryptionSettings
    ProgressMessage            : [2.2.0.36] Disable Encryption completed successfully
  ```
