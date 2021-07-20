Choose the best response for each question. Then select Check your answers.

## Multiple Choice
A company has several Azure VMs that are currently running production workloads. There is a mix of production Windows Server and Linux servers. Which of the following is the best choice for production backups?
( ) Managed snapshots {{That's incorrect. An Azure Snapshot is a read-only copy of the existing disk in the Microsoft Azure Cloud. This snapshot can be used as a backup or to create a virtual machine. However, the snapshot is only for a single point in time and is not the best choice for production environments. }}
(x) Azure Backup {{That's correct. Azure Backup is the best option for production workloads.}}
( ) Azure Site Recovery {{That's incorrect. Azure Site Recovery would be better for scenarios involving replication, failover, and fallback.}}

## Multiple Choice
Which of these options is recommended to backup a database disk used for development? 
( ) Virtual machine backup {{That's incorrect. Is there a better choice for just the database?}}
( ) Azure Site Recovery {{That's incorrect. Azure Site Recovery would be better for scenarios involving replication, failover, and fallback.}}
(x) Disk snapshot  {{That's correct. Snapshots can be taken at any time and used to quickly restore the database data disk.}}

## Multiple Choice
A malware attack has deleted several virtual machine backups. How long are items available in the soft delete state?
( ) 7 days {{That's incorrect.}}
(x) 14 days {{That's correct. Backup data is retained for 14 additional days, allowing the recovery of that backup item with no data loss.}}
( ) 30 days {{That's incorrect.}}
 
