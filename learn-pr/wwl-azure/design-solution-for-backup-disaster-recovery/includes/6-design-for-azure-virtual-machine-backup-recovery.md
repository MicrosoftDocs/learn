Azure Backup provides independent and isolated [backups for Azure virtual machines](/azure/backup/backup-azure-vms-introduction). You can use Azure Backup to take snapshot backups and restore the data on your virtual machines if there's data corruption or accidental deletion. 

### Things to know about virtual machine backup and recovery

Let's examine how Azure Backup supports backup and recovery of Azure virtual machines.

- Azure Backup allows for simple configuration and scaling for Windows and Linux virtual machines.

   > [!Note]
   > Azure Backup has specialized offerings for database workloads like SQL Server and SAP HANA. These offerings are workload-aware, provide 15-minute RPO (recovery point objective), and allow back up and restore of individual databases.

- The backup job for a virtual machine involves two phases:
   - First, a virtual machine snapshot is taken.
   - Second, the virtual machine snapshot is transferred to a Recovery Services vault. 

   The transfer of the backup data to the Recovery Services vault has no effect on your production workloads. 

- Azure virtual machine backups stored in a Recovery Services vault provide built-in management of recovery points.

- Virtual machine backups are optimized so you can easily restore a full backup, or from a specific recovery point.

- Snapshot backups support [different levels of consistency](/azure/backup/backup-azure-vms-introduction#snapshot-consistency), including _Application_, _System_, and _Crash_.

- Virtual machine backups are encrypted at rest with Storage Service Encryption (SSE). Azure Backup can also back up Azure virtual machines that are encrypted by using Azure Disk Encryption.

The following image shows a high-level view of how Azure virtual machines are backed up with Azure Backup.

:::image type="content" source="../media/virtual-machine-backups.png" alt-text="Diagram that shows how Azure virtual machine snapshot backups are stored in a Recovery Services vault." border="false":::
 
### Things to consider when using virtual machine backup and recovery

Here are some things to review when planning backup and recovery for your virtual machines. Consider how you can use Azure virtual machine backups in the Tailwind Traders solution. 

- **Consider your backup schedule**. Identify the best backup schedule for your business needs. To distribute backup traffic, consider backing up different virtual machines at different times of the day, and make sure the backup times don't overlap. Ensure your backup scheduled start time is during non-peak production application times.

- **Consider backup frequency**. Determine how frequently you need to create fresh backups. Implement both short-term (daily) and long-term (weekly) backups. If you need to take a backup outside of your scheduled via backup policy, you can use an on-demand backup. You might do on-demand backups multiple times per day when scheduled backup permits only one backup per day.

- **Consider backup policies**. Create a single backup policy for a group of virtual machines that require the same schedule start time, frequency, and retention settings. You might establish a backup policy for critical virtual machines, and a separate policy for non-critical machines. 

- **Consider plan changes**. After you implement your backup solution, continue to monitor and review your plan. As your business requirements change, make sure to review and change your backup policies. Enable monitoring and alerting features and review the results. 

- **Consider practice restore runs**. Restoring backups for virtual machines can be time-consuming. It's a recommended practice to try restoring from your backups before you experience a critical scenario where recovery is essential.

   The total restore time depends on the Input/Output operations per second (IOPS) and the throughput of the storage account. The total restore time can be affected if the target storage account is loaded with other application read and write operations. To improve restore operation, select a storage account that isn't loaded with other application data.

- **Consider throttling during restore**. If you're restoring virtual machines from a single Recovery Services vault, we highly recommend that you use different general-purpose v2 storage accounts. By using a v2 storage account, you can ensure your target storage account doesn't get throttled. Consider a scenario where each virtual machine must have a different storage account. If 10 virtual machines are being restored, plan to use 10 different storage accounts.

- **Consider Cross Region Restore (CRR)**. CRR allows you to restore Azure virtual machines in a secondary region, which is an Azure paired region. This option lets you conduct drills to meet audit or compliance requirements. You can also restore the virtual machine or its disk if there's a disaster in the primary region. CRR is an opt-in feature for any Recovery Services vault. CRR also works for SQL databases and SAP HANA databases hosted on Azure virtual machines.