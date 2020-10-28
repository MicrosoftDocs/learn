Companies that have a business continuity and disaster recovery (BCDR) plan typically schedule test runs to ensure that the business can successfully recover from disasters. Now that you have successfully backed up your VMs, you want to explore the options available for restoring them as part of your BCDR testing.

In this unit, you'll learn about the options for restoring an Azure VM from a previous backup.

## Restore types

Azure Backup provides a number of ways to restore a VM. As explained earlier, you can either instantly restore from the snapshot tier (optimal for operational recoveries) or from the vault tier.

|Restore option |Details |
|---------|---------|
|**Create a new VM**    | Quickly creates and gets a basic VM up and running from a restore point. The new VM must be created in the same region as the source VM.        |
|**Restore disk**  |  Restores a VM disk, which can then be used to create a new VM. The disks are copied to the Resource Group you specify. Azure Backup provides a template to help you customize and create a VM. Alternatively, you can attach the disk to an existing VM, or create a new VM.<br><br> This option is useful if you want to customize the VM, add configuration settings that weren't there at the time of backup, or add settings that must be configured using the template or PowerShell. |
|**Replace existing**    |   You can restore a disk and use it to replace a disk on the existing VM. Azure Backup takes a snapshot of the existing VM before replacing the disk and stores it in the staging location you specify. Existing disks connected to the VM are replaced with the selected restore point. The current VM must exist. If it's been deleted, this option can't be used.      |
|**Cross Region (secondary region)**   |   Cross Region restore can be used to restore Azure VMs in the secondary region, which is an Azure paired region.<br> This feature is available for the options below:<br> <li> Create a VM <li> Restore Disks<br> We don't currently support the Replace existing disks option. |

## Recover files from a backup

You can also recover individual files from a recovery point by mounting the snapshot on the target machine using the iSCSI initiator in the machine. The steps to do so are listed [here](https://docs.microsoft.com/azure/backup/backup-azure-restore-files-from-vm).

## Restore an encrypted virtual machine

Azure Backup supports the backup and restore of machines encrypted through Azure Disk Encryption. Disk Encryption works with Azure Key Vault to manage the relevant secrets that are associated with the encrypted disk. For an additional layer of security, you can use key vault encryption keys (KEKs) to encrypt the secrets before they're written to the key vault.

Certain limitations apply when you restore encrypted virtual machines:

- Azure Backup supports only standalone key encryption. Any key that's part of a certificate isn't supported currently.
- File-level or folder-level restores are not supported with encrypted virtual machines. To restore to that level of granularity, the whole virtual machine has to be restored. You can then manually copy the file or folders.
- The **Replace existing VM** option isn't available for encrypted virtual machines.
