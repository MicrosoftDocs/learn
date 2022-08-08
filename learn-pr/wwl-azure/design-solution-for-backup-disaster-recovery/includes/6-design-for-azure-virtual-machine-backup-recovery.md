Azure Backup provides independent and isolated [Azure virtual machines backups](/azure/backup/backup-azure-vms-introduction). Backups are stored in a Recovery Services vault with built-in management of recovery points. Configuration and scaling are simple, backups are optimized, and you can easily restore as needed. Back up is available for Windows and Linux VMs. 

## How do Azure virtual machines backups work?

An Azure backup job consists of two phases. First, a virtual machine snapshot is taken. Second, the virtual machine snapshot is transferred to the Azure Recovery Services vault. 

:::image type="content" source="../media/virtual-machine-backups.png" alt-text="Diagram of virtual machine snapshots stored in the recovery services vault.":::
 
## Considerations for virtual machine backups and restore

Here are some things to consider when planning your virtual machine backups. 

- **Identify the best backup schedule**.  To distribute backup traffic, consider backing up different VMs at different times of the day and make sure the times don't overlap. Ensure the backup scheduled start time is during non-peak production application times.

- **Determine backup frequency**. Implement both short-term (daily) and long-term (weekly) backups. If you need to take a backup not scheduled via backup policy, then you can use an on-demand backup. For example, backup on-demand multiple times per day when scheduled backup permits only one backup per day.

- **Create backup policies**. Consider grouping VMs that require the same schedule start time, frequency, and retention settings into a single backup policy. For example, create policies for critical and non-critical virtual machines. 

- **Monitor and review your plan.** As your business requirements change, make sure to review and change your backup policies. Enable monitoring and alerting features and review the results. 

- **Practice restoring from backup.** Restoring backups can be very time-consuming. The total restore time depends on the Input/output operations per second (IOPS) and the throughput of the storage account. The total restore time can be affected if the target storage account is loaded with other application read and write operations. To improve restore operation, select a storage account that isn't loaded with other application data.

- **Consider throttling**. If you're restoring VMs from a single vault, we highly recommend that you use different general-purpose v2 storage accounts to ensure that the target storage account doesn't get throttled. For example, each VM must have a different storage account. For example, if 10 VMs are restored, use 10 different storage accounts.

- **Consider Cross Region Restore (CRR).** CRR allows you to restore Azure VMs in a secondary region, which is an Azure paired region. This option lets you  conduct drills to meet audit or compliance requirements  You can also restore the VM or its disk if there's a disaster in the primary region. CRR is an opt-in feature for any recovery services vault. CRR also works for SQL databases and SAP HANA databases hosted on Azure VMs.
