Azure offers two primary tiers of Azure Storage—Standard and Premium—both of which can store Azure VM disk files. In both cases, Azure VM disks take the form of .vhd files stored as page blobs, because page blobs are optimized for random read-write access.

## What are the available storage tiers?

When choosing storage, consider the differences between Premium Storage and Standard Storage:

- Premium Storage offers superior performance, equivalent to what SSD technology provides.

- Standard Storage provides performance similar to commodity magnetic disks, referred to typically as hard disk drives (HDD).

- All Azure VM sizes support Standard Storage. Many Azure VM sizes also support Premium Storage.

## What are unmanaged and managed disks?

All Azure VM disks reside in Azure Storage accounts. An Azure Storage account is a logical namespace that, depending on its type, is capable of hosting different types of objects, including blobs, tables, queues, and files. When deploying an Azure VM, you must choose the type of disks that host the operating system disk, and optionally, data disks. You can use unmanaged or managed disk types.

### Unmanaged disks

The use of unmanaged disks involves potentially significant administrative overhead. You must decide how many storage accounts you create, then create those accounts, then decide how you distribute .vhd disk files across them. You must also manually implement resiliency provisions by ensuring that when provisioning two or more Azure VMs into the same availability set, their respective storage accounts don't reside in the same storage stamp.

### Managed disks

You can eliminate this administrative overhead by using managed disks. With this approach, the Azure platform controls Azure VM disk files placement and hides the complexity associated with managing Azure Storage accounts. Managed disks include the following benefits:

- Far higher number of disks per subscription

- Built-in resiliency for disks attached to Azure VMs in the same availability set

- Support for Azure VMs deployed into availability zones

- Granular, disk-level Role-Based Access Control (RBAC) permissions

- Support for server-side and Azure Disk Encryption

- Support for conversion between Standard and Premium storage tiers

- Ability to create an Azure VM from a custom image stored in any storage account in the same region and the same subscription

> [!IMPORTANT]
> Ensure that you select the appropriate disk type when you deploy your VMs. Although you can convert Azure VM unmanaged disks to managed disks, this requires stopping and deallocating all VMs in the availability set. In addition, there is no support for converting managed disks to unmanaged disks.
## What are the common storage issues?

Aside from the performance issues we discussed earlier in this module, you might occasionally encounter storage problems with your Azure VMs. There are many common issues that you might encounter. These include:

- Cannot extend an encrypted OS volume in Windows

- Errors when deleting storage resources

- Your VHD is not supported when you create a VM in Azure

- Azure disk encryption issues

### Troubleshoot extending an encrypted OS volume

If you're using Disk Management in Windows Server, and attempt to extend your operating system volume, you might find that the **Extend Volume** option on the context menu for the disk is unavailable.

This is caused because partition numbering has been incorrectly configured by Windows Server setup. Typically, the operating system volume (referred to as the *boot* partition) is assigned partition 2. Partition 1 should be assigned to the EFI System partition.

However, if you've created VMs based on a custom image that assigns partition 1 to the Boot partition, because there is no EFI System partition, you might encounter a problem when you later attempt to enable Azure Disk Encryption. When you enable disk encryption, you must create the EFI System partition, and it will be assigned the wrong partition number.

The high-level procedure to resolve this problem is:

1. Assign a larger disk SKU to the OS disk in the Azure portal

1. Extend the System Reserved volume into the unallocated space

1. Create a new boot volume in the remaining unallocated space

1. Delete the System Reserved volume and extend the Windows volume

### Troubleshoot errors when deleting storage resources

You might encounter an error in an Azure Resource Manager deployment when you attempt to delete:

- An Azure storage account

- A container

- A blob

The errors might include the following messages:

- Failed to delete storage account 'StorageAccountName'. Error: The storage account cannot be deleted due to its artifacts being in use.

- Failed to delete # out of # container(s): vhds: There is currently a lease on the container and no lease ID was specified in the request.

- Failed to delete # out of # blobs:BlobName.vhd: There is currently a lease on the blob and no lease ID was specified in the request.

Azure prevents deletion of:

- A disk attached to a VM to prevent corruption

- Containers and storage accounts that have a page blob that is attached to a VM

If you receive any of the listed errors, then follow this high-level guidance to resolve the issue:

1. Identify blobs attached to a VM

1. Delete VMs with attached OS disk

1. Detach all data disk(s) from remaining VM(s)

1. Retry deleting the storage account, container, or blob.

### Troubleshoot VHD support

If you attempt to create an Azure VM by uploading a VHD, the operation might fail, and you could receive the following message:

*New-AzureRmVM : Long running operation failed with status 'Failed'.*

*ErrorCode: InvalidVhd*

*ErrorMessage: The specified cookie value in VHD footer indicates that disk 'diskname' with blob `https://xxxxxx.blob.core.windows.net/vhds/samplename.vhd` is not a supported VHD. Disk is expected to have cookie value 'conectix'.*

This can occur for two reasons:

- Your VHD is corrupt or not supported. In this circumstance, you should rebuild the VHD.

- The VHD you're uploading doesn't comply with the 1-MB alignment. The disk size should be 1 MB * N. For example, the disk should be 102,401 MB.

To resolve the 1-MB alignment issue, use the `Resize-VHD` Windows PowerShell cmdlet:

1. Install the Hyper-V role on Windows Server

1. Convert the virtual disk to a fixed size VHD

### Troubleshoot Azure Disk Encryption issues

Azure Disk Encryption is a capability built into the Azure platform that enables you to encrypt file system volumes residing on Windows and Linux Azure VM disks. Azure Disk Encryption uses existing file system–based encryption technologies. For Windows, Azure Disk Encryption uses BitLocker Drive Encryption. Azure Disk Encryption can automatically encrypt:

- The operating system disk

- Data disks

- The temporary disk

It also supports both managed and unmanaged disks. If you experience problems enabling Azure Disk Encryption on your Windows Server VMs, ensure your VMs meet the requirements. These are outlined in the following table.

| Requirement| Details|
| :--- | :--- |
| VM size| Azure Disk Encryption isn't available on Basic, A-series VMs. It's also not available on Lsv2-series VMs.|
| VM generation| Azure Disk Encryption isn't available on Generation 2 VMs.|
| Memory| Azure Disk Encryption isn't available on VMs with less than 2 gigabytes (GB) of memory.|
| Networking| To get a token to connect to your key vault, the Windows VM must be able to connect to an Azure AD endpoint, login.microsoftonline.com. To write the encryption keys to your key vault, the Windows VM must be able to connect to the key vault endpoint.|
| Group Policy| Azure Disk Encryption uses the BitLocker external key protector for Windows VMs. For domain-joined VMs, don't push any Group Policy Object (GPO) settings that enforce Trusted Platform Module (TPM) protectors. BitLocker policy on domain-joined VMs with custom GPO must include the following setting: Configure user storage of BitLocker recovery information -> Allow 256-bit recovery key. Azure Disk Encryption fails when custom GPO settings for BitLocker are incompatible. Azure Disk Encryption also fails if domain-level GPOs block the AES-CBC algorithm, which is used by BitLocker.|
| Encryption key storage| Azure Disk Encryption requires a key vault to control and manage disk encryption keys and secrets. Your key vault and VMs must reside in the same Azure region and subscription.|

### Troubleshoot Azure Disk Encryption behind a firewall

Disk encryption is managed by a VM extension in Windows Server VMs. The ability of the extension to perform required tasks can be disrupted when connectivity to your target VM is restricted by:

- A firewall

- Proxy requirements

- Network security group (NSG) settings

You might encounter the following message: *Extension status not available on the VM.* In this situation, use the guidance in the following table to help resolve the issue.

| Restriction| Solution|
| :--- | :--- |
| NSG| Any NSG settings that are applied must still allow the endpoint to meet the documented network configuration prerequisites for disk encryption.|
| Azure Key Vault behind a firewall| When encryption is being enabled with Azure AD credentials, the target VM must allow connectivity to both Azure Active Directory (Azure AD) endpoints and Key Vault endpoints.|
| Azure Instance Metadata Service| Your VM must be able to access the Azure Instance Metadata service endpoint (`169.254.169.254`) and the virtual public IP address (`168.63.129.16`) used for communication with Azure platform resources. Proxy configurations that alter local HTTP traffic to these addresses (for example, adding an X-Forwarded-For header) are not supported.|

### Review encryption status

The Azure portal might not display disk encryption status accurately. For example, it might display a disk as encrypted even after it has been unencrypted within the VM.

This status error can occur if you use low-level commands to directly unencrypt the disk from within the VM. However, if you use the higher level Azure Disk Encryption management commands, they:

- Unencrypt the disk from within the VM

- Update important platform level encryption settings and extension settings associated with the VM

> [!NOTE]
> If these are not kept in alignment, the platform can't report encryption status or provision the VM properly.