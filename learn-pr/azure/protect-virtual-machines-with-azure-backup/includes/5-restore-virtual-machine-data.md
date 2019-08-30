Companies who have a business continuity and disaster recovery (BCDR) plan will typically schedule test runs to ensure the business can successfully recover from disasters. With your backups created for your VMs, you can now use them to test recovering from a VM failure.

After doing a successful backup of your servers, you would now like to explore the options available to you to restore them as part of your BCDR testing.

In this unit, you'll learn about the different options for restoring an Azure VM from a previous backup.

## Restore options

You have several options when you are restoring a machine from backup:

- **Create a new VM**
  - This is the quickest method to get a virtual machine up and running with default settings from a restore point.
  - You can choose the name, resource group, virtual network, and storage type before doing the restore.
- **Restore disk**
  - Restores the backed-up disk so that it can be used to create a new virtual machine. A template is provided within the portal to allow you to customize the new machine.
  - The restore copies the virtual hard disk (VHD) to your chosen storage account. The VHD should be in the same location as the Recovery Service vault you're using. You can also attach the restored disk to an existing virtual machine.
- **Replace existing**
  - Restore a disk and use it to replace the disk on an existing virtual machine.
  - Azure Backup takes a snapshot of the virtual machine before the recovered disk is attached, it stores it in a staging location you specify. The Recovery Service vault stores the snapshot according to your retention policy.
  - Replace existing only supports unencrypted managed virtual machines.

Each of these restore options can be useful in different situations. For example:

- **Create a new virtual machine** could be used to quickly create a development server from the live versions backup.
- **Restore disk** could be used to create a new virtual machine; this option allows for customization of the virtual machine before it's created. You can add configuration settings, like extra network adaptors, or an increased memory size. Using this option also allows for customization using PowerShell.
- **Replace existing** allows a disk to be restored and replaced on an existing virtual machine. This could be useful in cases where an operating system disk has failed during an update operation and can only be recovered with a restore.

## Recover files from a backup

Files and folders are available for recovery from Azure virtual machines if the backup was created with the Microsoft Azure Recovery Services (MARS) agent. You can restore data to the same machine that it was originally backed up from, or to a different machine in your subscription.

Use **Instant Restore** to do the restore on the target machine using the Azure Backup snap-in. Once the snap-in has loaded, you can select the original server where the backup was created, and specify whether to restore individual files, folders, or a whole volume.

If you need to restore the data to the same server it was backed up on, then you would select **This server**, or if it's a different server then choose that machine instead.

Select the date to restore and then select **Mount**, to mount the recovery point as a drive on the local machine. The data can then be copied to a new location.

## Restore an encrypted virtual machine

Azure Backup supports the backup and restore of machines encrypted using **Azure Disk Encryption (ADE)**. ADE integrates with the Azure Key Vault to manage the relevant secrets that are associated with the encrypted disk. For an additional layer or security, **Key Vault Encryption (KEKs)** Keys can be used to encrypt the secrets before they're written to the Key Vault.

Certain limitations apply when you restore encrypted virtual machines:

- Virtual machines can only be backed up and restored to the same subscription and region that they're a member of, and the subscription and region have to be the same as the Recovery Services vault that you use.
- Azure Backup only supports standalone key encryption. Any key that is part of a certificate isn't supported currently.
- File or folder level restores are not supported with encrypted virtual machines. To restore to that level of granularity, the whole virtual machine has to be restored, and then the file or folders can be manually copied.
- The **Replace existing VM** option isn't available for encrypted virtual machines.
