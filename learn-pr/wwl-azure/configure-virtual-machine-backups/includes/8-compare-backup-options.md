The are advantages and limits to using the different Azure backup options. In this section, we compare the Microsoft Azure Recovery Services (MARS) backup agent and Microsoft Azure Backup Server.

The following table summarizes features and restrictions, and identifies what data is protected by the backup, and where the backups are stored in the configuration.

| Azure backup option | Features and benefits | Limits and restrictions | What data is protected? | Where are backups stored? |
| --- | --- | --- | --- | --- 
| **MARS backup agent** | - Back up files and folders on physical or virtual machines running Windows <br> - No separate backup server required | - Backups triggered 3x per day <br> - Not application aware <br> - File, folder, and volume-level restore only <br> - No support for Linux | Files and folders | Azure Recovery Services vault |
| **Azure Backup Server** | - App-aware snapshots <br> - Full flexibility for when to trigger backups <br> - Recovery granularity <br> - Linux support on Hyper-V and VMware virtual machines <br> - Back up and restore VMware virtual machines <br> - No System Center license required | - Always requires an active Azure subscription <br> - No backups for Oracle workloads <br> - No support for tape backup | Files, folders, volumes, virtual machines, applications, and workloads | Azure Recovery Services vault or locally attached disks |