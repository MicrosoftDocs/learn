Suppose you are developing a financial management application for new business startups. You want to ensure that all your customers' data is secured, so you have decided to implement Azure Disk Encryption (ADE) across all OS and data disks on the servers that will host this application. As part of your compliance requirements, you also need to be responsible for your own encryption key management.

<!-- Activate the sandbox -->
[!include[](../../../includes/azure-sandbox-activate.md)]

In this unit, you'll encrypt disks on an existing virtual machine, and manage the encryption keys using your own Azure Key Vault.

## Prepare the environment

We'll start by deploying a new Windows VM in an Azure Virtual Machine.

### Deploy Windows VM

Use the Azure PowerShell to create and deploy a new Windows virtual machine.

1. Start by deciding where to place the new resources. Select a location near you from the following list.

    <!-- Resource selection -->  
    [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]
    

1. Define a PowerShell variable to hold the selected location. It's defined as "East US" here, change it to your preferred location.

    ```powershell
    $location = "eastus"
    ```
    
    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. Next, define a few more convenient variables to capture the _name_ of the VM and the _resource group_. Note that we are using the pre-created resource group here, normally you would create a _new_ resource group in your subscription using `New-AzResourceGroup`.

    ```powershell
    $vmName = "fmdata-vm01"
    $rgName = "<rgn>[sandbox Resource Group]</rgn>"
    ```
    
1. Use `New-AzVm` to create a new virtual machine.
    
    ```powershell
    New-AzVm `
        -ResourceGroupName $rgName `
        -Name $vmName `
        -Location $location `
        -OpenPorts 3389
    ```
    
    Enter a username and password for the VM when you are prompted by the Cloud Shell. This will be used as the initial account created for the VM.
    
    > [!NOTE]
    > This command will use some defaults since we didn't supply a bunch of options. Specifically, this will create a _Windows 2016 Server_ image with the size to _Standard_DS1_v2_. Remember that the Basic tier VMs do not support ADE if you decide to specify the VM size.

1. Once the VM finishes deploying, capture the VM details in a variable. You can use this variable to explore what was created.

    ```powershell
    $vm = Get-AzVM -Name $vmName -ResourceGroupName $rgName
    ```
    
1. You can see the OS disk attached to the VM:

    ```powershell
    $vm.StorageProfile.OSDisk
    ```

    ```output
    OsType                  : Windows
    EncryptionSettings      :
    Name                    : fmdata-vm01_OsDisk_1_6bcf8dcd49794aa785bad45221ec4433
    Vhd                     :
    Image                   :
    Caching                 : ReadWrite
    WriteAcceleratorEnabled :
    CreateOption            : FromImage
    DiskSizeGB              : 127
    ManagedDisk             : Microsoft.Azure.Management.Compute.Models.ManagedDiskP
                              arameters
    ```
        
1. Check the current status of encryption on the OS disk (and any data disks).

    ```powershell
    Get-AzVmDiskEncryptionStatus  `
        -ResourceGroupName $rgName `
        -VMName $vmName
    ```

    As you can see the disks are current _unencrypted_. 

    ```output
    OsVolumeEncrypted          : NotEncrypted
    DataVolumesEncrypted       : NotEncrypted
    OsVolumeEncryptionSettings :
    ProgressMessage            : No Encryption extension or metadata found on the VM
    ```
    
Let's change that.
    
## Encrypt the VM disks with Azure Disk Encryption

We need to protect this data, so let's encrypt the disks. Recall that there are several steps we need to perform:

1. Create a key vault.
1. Set the key vault up to support disk encryption.
1. Tell Azure to encrypt the VM disks using the key stored in the Key Vault.

> [!TIP]
> We're going to walk through the steps individually, but when you're doing this task in your own subscription, you can use a handy PowerShell script which is linked in the Summary of this module.

### Create a key vault

To create an Azure Key Vault, we need to enable the service in our subscription. This is a one-time requirement.

> [!TIP]
> Depending on your subscription, you might need to enable the **Microsoft.KeyVault** provider with the `Register-AzResourceProvider` cmdlet. This is not necessary in the Azure sandbox subscription.

1. Decide on a name for your new key vault. It must be unique and can be between 3 and 24 characters, composed of numbers, letters, and and dashes. Try adding some random numbers to the end, replacing the "1234" below.

    ```powershell
    $keyVaultName = "mvmdsk-kv-1234"
    ```
        
1. Create an Azure Key Vault with `New-AzKeyVault`.
    - Make sure it's placed in the same resource group _and_ location as your VM.
    - Enable the Key Vault for use with disk encryption. 
    - Specify a unique Key Vault name.

    ```powershell
    New-AzKeyVault -VaultName $keyVaultName `
        -Location $location `
        -ResourceGroupName $rgName `
        -EnabledForDiskEncryption
    ```

    You will get a warning from this command about no users having access.

    ```output
    WARNING: Access policy is not set. No user or application have access permission to use this vault. This can happen if the vault was created by a service principal. Please use Set-AzKeyVaultAccessPolicy to set access policies.
    ```

    This is ok since we are just using the vault to store the encryption keys for the VM and users won't need to access this data.

### Encrypt the disk

We are almost ready to encrypt the disks. Before we do, a warning about creating backups.

> [!IMPORTANT]
> If this were a production system, we would need to perform a backup of the managed disks - either using Azure Backup, or by creating a snapshot. You can create snapshots in the Azure portal, or through the command line. In PowerShell, use the `New-AzSnapshot` cmdlet. Since this is a simple exercise and we're going to throw this data away when you're done, we're going to skip this step. 

1. Start by defining a variable to hold the Key Vault information.

    ```powershell
    $keyVault = Get-AzKeyVault `
        -VaultName $keyVaultName `
        -ResourceGroupName $rgName
    ```

1. Then, use the `Set-AzVmDiskEncryptionExtension` cmdlet to encrypt the VM disks.
    - The `VolumeType` parameter allows you to specify which disks to encrypt: [_All_ | _OS_ | _Data_]. It will default to _All_. You can only encrypt data disks for some distributions of Linux.
    - You have to supply the `SkipVmBackup` flag for managed disks or the command will fail because there is no snapshot.

    ```powershell
    Set-AzVmDiskEncryptionExtension `
    	-ResourceGroupName $rgName `
        -VMName $vmName `
        -VolumeType All `
    	-DiskEncryptionKeyVaultId $keyVault.ResourceId `
    	-DiskEncryptionKeyVaultUrl $keyVault.VaultUri `
        -SkipVmBackup
    ```

1. The cmdlet will warn you that the VM must be taken offline, and that the task may take several minutes to complete. Go ahead and let it continue.

    ```output
    Enable AzureDiskEncryption on the VM
    This cmdlet prepares the VM and enables encryption which may reboot the machine and takes 10-15 minutes to
    finish. Please save your work on the VM before confirming. Do you want to continue?
    [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): Y
    ```
    
1. Once it's complete, check the encryption status again.

    ```powershell
    Get-AzVmDiskEncryptionStatus  -ResourceGroupName $rgName -VMName $vmName
    ```

    Now the OS disk should be encrypted. Any attached data disks that are visible to Windows will also be encrypted.

    ```output
    OsVolumeEncrypted          : Encrypted
    DataVolumesEncrypted       : NoDiskFound
    OsVolumeEncryptionSettings : Microsoft.Azure.Management.Compute.Models.DiskEncryptionSettings
    ProgressMessage            : Provisioning succeeded
    ```

> [!NOTE]        
> New disks added after encryption will _not_ be automatically encrypted. You can re-run the `Set-AzVMDiskEncryptionExtension` cmdlet to encrypt new disks. Make sure to provide a new sequence number if you add disks to a VM that has already had disks encrypted. In addition, disks that are not visible to the operating system will not be encrypted - the disk must be properly partitioned, formatted, and mounted to be seen by the Bitlocker extension.
