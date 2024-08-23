Companies that have a business continuity and disaster recovery (BCDR) plan typically schedule test runs to ensure that the business can successfully recover from disasters. Now that you've successfully backed up your VMs, you want to explore the options available for restoring them as part of your BCDR testing.

In this unit, you'll learn about the options for restoring an Azure VM from a previous backup.

## Restore types

Azure Backup provides many ways to restore a VM. As explained earlier, you can either instantly restore from the snapshot tier (optimal for operational recoveries) or from the vault tier.

|Restore option |Details |
|---------|---------|
|**Create a new VM**    | Quickly creates and gets a basic VM up and running from a restore point. The new VM must be created in the same region as the source VM.        |
|**Restore disk**  |  Restores a VM disk, which can then be used to create a new VM. The disks are copied to the resource group you specify. Azure Backup provides a template to help you customize and create a VM. Alternatively, you can attach the disk to an existing VM, or create a new VM.<br><br> This option is useful if you want to customize the VM, add configuration settings that weren't there at the time of backup, or add settings that must be configured using the template or PowerShell. |
|**Replace existing**    |   You can restore a disk and use it to replace a disk on the existing VM. Azure Backup takes a snapshot of the existing VM before replacing the disk and stores it in the staging location you specify. Existing disks connected to the VM are replaced with the selected restore point. The current VM must exist. If it's been deleted, this option can't be used.      |
|**Cross region (secondary region)**   |   Cross region restore can be used to restore Azure VMs in the secondary region, which is an Azure paired region.<br> This feature is available for the options below:<br> <li> Create a VM <li> Restore Disks<br> We don't currently support the Replace existing disks option. |
| **Cross Subscription Restore** | The restore operation on secondary region can be performed by Backup Admins and App admins. <br> Cross Subscription Restore: <br><br> - Allows you to restore Azure Virtual Machines or disks to a different subscription within the same tenant as the source subscription (as per the Azure RBAC capabilities) from restore points. <br> - Allowed only if the Cross Subscription Restore property is enabled for your Recovery Services vault. <br> - Works with Cross Region Restore and Cross Zonal Restore. <br> - You can trigger Cross Subscription Restore for managed virtual machines only. <br> - Cross Subscription Restore is supported for Restore with Managed System Identities (MSI). <br> - It's unsupported for snapshots tier recovery points. <br> - It's unsupported for unmanaged VMs and ADE encrypted VMs. |
| **Cross Zonal Restore** | Allows you to restore Azure Virtual Machines or disks pinned to any zone to different available zones (as per the Azure RBAC capabilities) from restore points. Note that when you select a zone to restore, it selects the logical zone (and not the physical zone) as per the Azure subscription you will use to restore to. <br> - You can trigger Cross Zonal Restore for managed virtual machines only. <br> - Cross Zonal Restore is supported for Restore with Managed System Identities (MSI). <br> - Cross Zonal Restore supports restore of an Azure zone pinned/non-zone pinned VM from a vault with Zonal-redundant storage (ZRS) enabled. Learn how to set Storage Redundancy. <br> - It's supported to restore an Azure zone pinned VM only from a vault with Cross Region Restore (CRR) (if the secondary region supports zones) or Zone Redundant Storage (ZRS) enabled. <br> - Cross Zonal Restore is supported from secondary regions. <br> - It's unsupported from snapshots restore point. <br> - It's unsupported for Encrypted Azure VMs. |
| **Selective disk backup** | Allows you to backup and restore selective VM disks through Enhanced policy. Using this capability, you can selectively back up a subset of the data disks that are attached to your VM, and then restore a subset of the disks that are available in a recovery point, both from instant restore and vault tier. <br><br>  This is useful when you: <br><br> - Manage critical data in a subset of the VM disks. <br> - Use database backup solutions and want to back up only their OS disk to reduce cost. |

## Recover files from a backup

You can also recover individual files from a recovery point by mounting the snapshot on the target machine using the iSCSI initiator in the machine. To learn more, see [Recover files from Azure virtual machine backup](/azure/backup/backup-azure-restore-files-from-vm).

## Restore an encrypted virtual machine

Azure Backup supports the backup and restore of machines encrypted through Azure Disk Encryption. Disk Encryption works with Azure Key Vault to manage the relevant secrets that are associated with the encrypted disk. For an extra layer of security, you can use key vault encryption keys (KEKs) to encrypt the secrets before they're written to the key vault.

Certain limitations apply when you restore encrypted VMs:

- Azure Backup supports only standalone key encryption. Any key that's part of a certificate isn't currently supported.
- File-level or folder-level restores aren't supported with encrypted VMs. To restore to that level of granularity, the entire VM has to be restored. You can then manually copy the file or folders.
- The **Replace existing VM** option isn't available for encrypted VMs.