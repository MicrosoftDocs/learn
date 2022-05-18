Azure Backup provides independent and isolated [Azure virtual machines backups](/azure/backup/backup-azure-vms-introduction). Backups are stored in a Recovery Services vault with built-in management of recovery points. Configuration and scaling are simple, backups are optimized, and you can easily restore as needed. Back up is available for Windows and Linux VMs. 

 

### How do Azure virtual machines backups work?

An Azure backup job consists of two phases. First, a virtual machine snapshot is taken. Second, the virtual machine snapshot is transferred to the Azure Recovery Services vault. 

:::image type="content" source="../media/virtual-machine-backups.png" alt-text="Virtual machine snapshots are stored in the recovery services vault.":::


> [!NOTE]
> A recovery point is created only after both steps are completed. The recovery point is used to perform a restore. 

 

### Backup policies and retention

You can define the backup frequency and retention duration for your backups. Currently, the VM backup can be triggered daily or weekly, and can be stored for multiple years. 

- **Snapshot tier**: In phase 1, snapshots are stored locally for a maximum period of five days. This is referred to as the snapshot tier. Snapshot tier restores are faster (than restore from vault) because they eliminate the wait time for snapshots to copy to the vault before triggering the restore. This capability is called **Instant Restore**.

- **Vault tier**: In phase 2, snapshots are transferred to the vault for additional security and longer retention. This is referred to as **vault tier**.

**Considerations for Azure virtual machine backup and recovery**

- **Plan backup schedule policies**. Consider grouping VMs that require the same schedule start time, frequency, and retention settings within a single policy. Ensure the backup scheduled start time is during non-peak production application time. To distribute backup traffic, consider backing up different VMs at different times of the day and make sure the times don't overlap. For example, have policies for critical and non-critical virtual machines. 

- **Plan backup retention policies.** Implement both short-term (daily) and long-term (weekly) backups. If you need to take a backup not scheduled via backup policy, then you can use an on-demand backup. For example, backup on-demand multiple times per day when scheduled backup permits only one backup per day.

- **Optimize backup policies**. As your business requirements change, make sure to review and change your backup policies. Enable monitoring and alerting features and review the results. 

- **Consider Cross Region Restore (CRR).** CRR allows you to restore Azure VMs in a secondary region, which is an Azure paired region. This option lets you to conduct drills to meet audit or compliance requirements You can also restore the VM or its disk if there's a disaster in the primary region. CRR is an opt-in feature for any recovery services vault. CRR also works for SQL databases and SAP HANA databases hosted on Azure VMs.
