SAP HANA file-level backups can be carried out using multiple methods:

## SAP HANA backup with the Azure Backup service

The log and non-log backups in SAP HANA Azure Virtual Machines provided via Backint are streams to Azure Recovery Services vaults, which internally use Azure Storage Blob. It's important to understand this streaming methodology.

The Backint component of HANA provides the 'pipes' (a pipe to read from and a pipe to write into), connected to underlying disks where database files reside, which are then read by the Azure Backup service and transported to Azure Recovery Services vault, which is a remote Azure Storage Account. The Azure Backup service also performs a checksum to validate the streams, in addition to the Backint native validation checks. These validations ensure that the data present in Azure Recovery Services vault is indeed reliable and recoverable.

Since the streams primarily deal with disks, you need to understand the disk performance for read and network performance to transfer backup data to gauge the backup and restore performance. For further information, refer to the [Tutorial: Back up SAP HANA databases in an Azure Virtual Machine](/azure/backup/tutorial-backup-sap-hana-db).

## Other backup methods

Without using Azure Backup service, the standard way to manage backup/restore at the file level is with a file-based backup via SAP HANA Studio or via SAP HANA SQL statements. When choosing type "file," one has to specify a path in the file system where SAP HANA writes the backup files. Restore works the same way.

While this choice sounds straightforward, there are some considerations. An Azure Virtual Machine has a limitation on number of data disks. There might not be capacity to store SAP HANA backup files on the file systems of the virtual machine, depending on the size of the database and disk throughput requirements. Remediating this might require software striping across multiple data disks. Another option, which offers more freedom regarding total capacity, is Azure blob storage. In addition, this option gives customers the choice to select cool blob storage, which has a cost benefit.

For extra resiliency, you can use a geo-replicated storage account to store the SAP HANA backups. One could place dedicated VHDs for SAP HANA backups in a dedicated backup storage account that's geo-replicated. Or else one could copy the VHDs that keep the SAP HANA backups to a geo-replicated storage account, or to a storage account that's in a different region.

### Azure Backup agent

Azure Backup offers the option to not only back up complete virtual machines but also files and directories via the backup agent, which has to be installed on the guest OS. But this agent is only supported on Windows. A workaround is to first copy SAP HANA backup files to a Windows virtual machine on Azure (for example, via SAMBA share) and then use the Azure backup agent from there. While it's technically possible, it would add complexity and slow down the backup or restore process quite a bit due to the copy between the Linux and the Windows virtual machine. It isn't recommended to follow this approach.

### Azure Storage utilities

To copy files to Azure storage, you can use CLI or PowerShell, or develop a tool using one of the Azure SDKs. Other options for copying SAP HANA backup files include AzCopy and blobxfer (both available on GitHub), used by many customers in production environments. The tools allow copying data directly to either Azure blob storage or Azure file share. They also offer a range of useful features, like md5 hash or automatic parallelism when copying a directory with multiple files.

### Blob copy of dedicated Azure data disks in backup software RAID

Unlike the manual virtual machine data disk backup, in this approach one doesn't back up all the data disks on a virtual machine to save the whole SAP installation, including HANA data, HANA log files, and config files. Instead, the idea is to have dedicated software RAID with striping across multiple Azure data VHDs for storing a full SAP HANA file backup. The copy process involves only the disks that have the SAP HANA backup. They could easily be kept in a dedicated HANA backup storage account, or attached to a dedicated "backup management virtual machine" for further processing.

As the copy affects only the dedicated file system for keeping the backup files, there are no concerns about SAP HANA data or log file consistency on the disk. A benefit of this command is that it works while the virtual machine stays online. To be certain that no process writes to the backup stripe set, be sure to unmount it before the blob copy, and mount it again afterward. Or one could use an appropriate way to "freeze" the file system (for example, via xfs\_freeze for the XFS file system).

### Copy SAP HANA backup files to NFS share

To lessen the potential effect on the SAP HANA system from a performance or disk space perspective, one might consider storing the SAP HANA backup files on an NFS share. Technically it works, but traditionally this required using a second Azure Virtual Machine as the host of the NFS share. This can be avoided by using Azure NetApp Files. Writing on an NFS share puts a load on the network and affects to some extent the SAP HANA system, but there's no subsequent effect related to managing the backup files.

### Copy SAP HANA backup files to Azure Files

It is possible to mount an Azure Files share inside an Azure Linux virtual machine. Tests have shown, however, that SAP HANA backup doesn't currently work directly with this kind of CIFS mount. It's also stated in [SAP Note \#1820529](https://me.sap.com/notes/1820529) that CIFS isn't recommended.
