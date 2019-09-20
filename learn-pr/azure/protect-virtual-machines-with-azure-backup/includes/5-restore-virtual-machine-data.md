Companies that have a business continuity and disaster recovery (BCDR) plan typically schedule test runs to ensure that the business can successfully recover from disasters. Now that you have successfully backed up your VMs, you want to explore the options available for restoring them as part of your BCDR testing.

In this unit, you'll learn about the options for restoring an Azure VM from a previous backup.

## Restore options

You have three options when you're restoring a machine from backup:

- **Create a new VM**
  - This is the quickest method to get a virtual machine up and running with default settings from a restore point.
  - You can choose the name, resource group, virtual network, and storage type before doing the restore.
- **Restore disk**
  - Restore the backed-up disk so that it can be used to create a new virtual machine. The portal provides a template to help you customize the new machine.
  - The restore copies the virtual hard disk (VHD) to your chosen storage account. The VHD should be in the same location as the Recovery Services vault you're using. You can also attach the restored disk to an existing virtual machine.
- **Replace existing**
  - Restore a disk and use it to replace the disk on an existing virtual machine.
  - Azure Backup takes a snapshot of the virtual machine before the recovered disk is attached. It stores the snapshot in a staging location that you specify. The Recovery Services vault stores the snapshot according to your retention policy.
  - This option supports only unencrypted managed virtual machines.

Each of these restore options can be useful in certain situations. For example:

- **Create a new VM** can be used to quickly create a development server from the live version's backup.
- **Restore disk** can be used to create a new virtual machine. This option allows for customization of the virtual machine before it's created. You can add configuration settings, like extra network adapters or an increased memory size. Using this option also allows for customization through PowerShell.
- **Replace existing** allows a disk to be restored and replaced on an existing virtual machine. This option can be useful if an operating system disk has failed during an update operation and can be recovered only with a restore.

## Recover files from a backup

Files and folders are available for recovery from Azure virtual machines if the backup was created with the Microsoft Azure Recovery Services (MARS) agent. You can restore data to the same machine that it was originally backed up from, or to a different machine in your subscription.

Use **Instant Restore** to restore data on the target machine by using the Azure Backup snap-in. After the snap-in is loaded, you can select the original server where the backup was created. Then, specify whether to restore individual files, folders, or a whole volume.

If you need to restore the data to the same server where it was backed up, select **This server**. If it's a different server, choose that machine instead.

To mount the recovery point as a drive on the local machine, select the date to restore, and then select **Mount**. You can copy the data to a new location.

## Restore an encrypted virtual machine

Azure Backup supports the backup and restore of machines encrypted through Azure Disk Encryption. Disk Encryption works with Azure Key Vault to manage the relevant secrets that are associated with the encrypted disk. For an additional layer of security, you can use *key vault encryption keys (KEKs)* to encrypt the secrets before they're written to the key vault.

Certain limitations apply when you restore encrypted virtual machines:

- Virtual machines can be backed up and restored only to the same subscription and region that they're a member of. The subscription and region have to be the same as the Recovery Services vault that you use.
- Azure Backup supports only standalone key encryption. Any key that's part of a certificate isn't supported currently.
- File-level or folder-level restores are not supported with encrypted virtual machines. To restore to that level of granularity, the whole virtual machine has to be restored. You can then manually copy the file or folders.
- The **Replace existing VM** option isn't available for encrypted virtual machines.
