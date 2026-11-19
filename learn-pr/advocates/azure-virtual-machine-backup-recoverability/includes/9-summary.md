This module explains how to assess recoverability against agreed requirements: choose a suitable recovery point, restore in isolation, verify data and application behavior, measure recovery outcomes, and confirm continued protection. Distinguish service-side backup validation from application validation, and available tiers from the restore source actually used. Interpret the observed rehearsal result within those limits and separately assess the ongoing protection design's ability to meet the target. The result is a recovery decision with explicit limits, not merely a completed job.

## More info

These references were reviewed on 18 November 2026 and support the baseline and its exception decisions. Before each live drill, confirm that your chosen configuration is supported and that you have the required permissions.

- [Protect your virtual machines by using Azure Backup](/training/modules/protect-virtual-machines-with-azure-backup/)
- [Existing restore exercise](/training/modules/protect-virtual-machines-with-azure-backup/6-exercise-restore-virtual-machine-data)
- [Design for virtual machine backup and recovery](/training/modules/design-solution-for-backup-disaster-recovery/6-design-for-azure-virtual-machine-backup-recovery)
- [Azure virtual machine backup and restore support matrix](/azure/backup/backup-support-matrix-iaas)
- [Restore virtual machines through the portal](/azure/backup/backup-azure-arm-restore-vms)
- [Recover individual files and folders](/azure/backup/backup-azure-restore-files-from-vm)
- [Backup permissions and minimum VM backup role scopes](/azure/backup/backup-rbac-rs-vault#minimum-role-requirements-for-azure-vm-backup)
- [Trusted Launch for Azure virtual machines](/azure/virtual-machines/trusted-launch)
- [Agentless multidisk crash-consistent VM backup](/azure/backup/backup-azure-vms-agentless-multi-disk-crash-consistent-overview)
- [Back up and restore encrypted Azure VMs](/azure/backup/backup-azure-vms-encryption)
- [Encrypt backup data with customer-managed keys](/azure/backup/encryption-at-rest-with-cmk)
- [Back up Azure VMs with Enhanced policy](/azure/backup/backup-azure-vms-enhanced-policy)
- [Run an on-demand Azure VM backup](/azure/backup/backup-azure-manage-vms#run-an-on-demand-backup)
- [Azure Backup Instant Restore capability](/azure/backup/backup-instant-restore-capability)
- [Architecture strategies for disaster recovery](/azure/well-architected/reliability/disaster-recovery)
- [Python assertions and optimization](https://docs.python.org/3/reference/simple_stmts.html#the-assert-statement)
- [Python optimization environment variable](https://docs.python.org/3/using/cmdline.html#envvar-PYTHONOPTIMIZE)
- [PowerShell native-command exit codes](/powershell/module/microsoft.powershell.core/about/about_automatic_variables#lastexitcode)
- [SQLite transaction control](https://www.sqlite.org/lang_transaction.html)
- [Azure Data Lake Storage page-blob limitations](/azure/storage/blobs/data-lake-storage-known-issues#blob-storage-apis)
- [Azure Backup FAQ: GRS vaults with and without Cross Region Restore](/azure/backup/backup-azure-backup-faq#recovery-services-vault)
- [Azure Backup behavior during a region failure](/azure/reliability/reliability-backup#behavior-during-a-region-failure)
- [Cross Region Restore requirements and configuration implications](/azure/backup/backup-create-recovery-services-vault#set-cross-region-restore)
- [Azure VM backup job phases and service validation](/azure/backup/backup-azure-arm-vms-prepare#verify-the-backup-job-status)
