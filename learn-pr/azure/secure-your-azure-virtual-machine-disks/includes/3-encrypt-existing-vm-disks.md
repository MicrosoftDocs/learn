Suppose your company has decided to implement Azure Disk Encryption (ADE) across all VMs. You need to evaluate how to roll out encryption to existing VM volumes. Here, we'll look at the requirements for ADE, and the steps involved in encrypting disks on existing Linux and Windows VMs. In the next unit, you'll work through the process of encrypting existing VM disks.

## Azure Disk Encryption prerequisites

Before you can encrypt your VM disks, you need to:

1. Create a key vault.
1. Set the key vault access policy to support disk encryption.
1. Use the key vault to store the encryption keys for ADE.

### Azure Key Vault

The encryption keys ADE uses can be stored in Azure Key Vault. Azure Key Vault is a tool for securely storing and accessing secrets. A secret is anything to which you want to tightly control access, such as API keys, passwords, or certificates. This provides highly available and scalable secure storage, as defined in Federal Information Processing Standards (FIPS) 140-2 Level 2 validated Hardware Security Modules (HSMs). Using Key Vault, you keep full control of the keys used to encrypt your data, and you can manage and audit your key usage.

> [!NOTE]
> Azure Disk Encryption requires that your key vault and your VMs are in the same Azure region; this ensures that encryption secrets do not cross regional boundaries.

You can configure and manage your key vault with:

#### PowerShell

```powershell
New-AzKeyVault -Location <location> `
    -ResourceGroupName <resource-group> `
    -VaultName "myKeyVault" `
    -EnabledForDiskEncryption
```

### Azure CLI

```azurecli
az keyvault create \
    --name "myKeyVault" \
    --resource-group <resource-group> \
    --location <location> \
    --enabled-for-disk-encryption True
```

### Azure portal

An Azure Key Vault is a resource that you can create in the [Azure portal](https://aka.ms/portal) using the normal resource creation process.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

1. In the search box, search for and select **Key Vault**. The **Key Vault** pane appears.

1. Select **Create**. The **Create a key vault** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Project details** |
    | Subscription | Select the subscription in which to place the key vault (defaults to your current subscription) |
    | Resource group | Select an existing resource group or create a new one to own the key vault |
    | **Instance details** |
    | Key vault name | Enter a name for your key vault |
    | Region | Select the region in which your VM resides |
    | Pricing tier | **Standard**. You can select either Standard or Premium for the pricing tier. The main difference is that the premium tier allows for hardware encryption-backed keys |

    ![Screenshot showing Key vault pane.](../media/3-create-keyvault.png)

1. Select **Next** to move to the Access configuration tab. You must change the Access policies to support Disk Encryption. By default, it adds *your* account to the policy.

1. On the **Access configuration** tab, enter the following value for the setting.

    | Setting | Value |
    |---------|---------|
    | **Resource access**  | Check the box for **Azure Disk Encryption for volume encryption**. You can remove your account if you like, as it's not necessary if you only intend to use the key vault for disk encryption.  |

1. Select **Review + create**.

1. After validation passes, to create the new Key Vault, select **Create**.

## Enable access policies in the key vault

Azure needs access to the encryption keys or secrets in your key vault to make them available to the VM for booting and decrypting the volumes. You did this in the preceding steps when you changed the **Access policy**.

There are three policies you can enable:

- **Disk encryption**: Required for Azure Disk encryption.
- **Deployment**: (Optional) Enables the Microsoft.Compute resource provider to retrieve secrets from this key vault when this key vault is referenced in resource creation; for example, when creating a VM.
- **Template deployment**: (Optional) Enables Azure Resource Manager to get secrets from this key vault when this key vault is referenced in a template deployment.

Here's how to enable the disk encryption policy. The other two policies are similar but use different flags.

```powershell
Set-AzKeyVaultAccessPolicy -VaultName <keyvault-name> -ResourceGroupName <resource-group> -EnabledForDiskEncryption
```

```azurecli
az keyvault update --name <keyvault-name> --resource-group <resource-group> --enabled-for-disk-encryption true
```

## Encrypt an existing VM disk

After you have the key vault set up, you can encrypt the VM using either Azure CLI or Azure PowerShell. The first time you encrypt a Windows VM, you can choose to encrypt either all disks or the OS disk only. On some Linux distributions, only the data disks can be encrypted. To be eligible for encryption, your Windows disks must be formatted as NTFS volumes.

> [!WARNING]
> Before you can turn on encryption, you must take a snapshot or a backup of managed disks. The following `SkipVmBackup` flag informs the tool that the backup is complete on managed disks. Without the backup, you'll be unable to recover the VM if the encryption fails for some reason.

To enable encryption by using PowerShell, run the `Set-AzVmDiskEncryptionExtension` cmdlet.

```powershell

Set-AzVmDiskEncryptionExtension `
    -ResourceGroupName <resource-group> `
    -VMName <vm-name> `
    -VolumeType [All | OS | Data]
    -DiskEncryptionKeyVaultId <keyVault.ResourceId> `
    -DiskEncryptionKeyVaultUrl <keyVault.VaultUri> `
     -SkipVmBackup
```

To enable encryption by using the Azure CLI, run the `az vm encryption enable` command and specify the volume you want to encrypt using the `--volume-type [all | os | data]` parameter. Here's an example of encrypting all volumes for a virtual machine:

```azurecli
az vm encryption enable \
    --resource-group <resource-group> \
    --name <vm-name> \
    --disk-encryption-keyvault <keyvault-name> \
    --volume-type all
```

## View status of disk

You can check whether specific disks are encrypted.

```powershell
Get-AzVmDiskEncryptionStatus  -ResourceGroupName <resource-group> -VMName <vm-name>
```

```azurecli
az vm encryption show --resource-group <resource-group> --name <vm-name>
```

Both of these commands will return the status of each disk attached to the specified VM.

## Decrypt drives

To reverse the encryption through PowerShell, run the `Disable-AzVMDiskEncryption` cmdlet.

```powershell
Disable-AzVMDiskEncryption -ResourceGroupName <resource-group> -VMName <vm-name>
```

For the Azure CLI, run the `vm encryption disable` command.

```azurecli
az vm encryption disable --resource-group <resource-group> --name <vm-name>
```

These commands disable encryption for volumes of type *all* for the specified VM. Just like the encryption version, to decide what disks to decrypt, you can specify a `-VolumeType` parameter `[All | OS | Data]`. It defaults to `All` if not supplied.

> [!WARNING]
> Disabling data disk encryption on Windows VM when both OS and data disks have been encrypted doesn't work as expected. You must disable encryption on all disks instead.

In the next exercise, you'll try some of these commands out on a new VM.
