

- Use the latest possible OS with latest patches.
- Use the latest possible DB with latest patches.
- Use the latest possible SAP Kernel with latest patches (for example, upgrade from 7.45 kernel to 7.49 or 7.53).
- Consider using the largest available Azure VM. The VM type can be lowered to a smaller VM after the Import process
- Create multiple transaction log files with the first transaction log file on the local nonpersistent SSD. Additional transaction log files can be created on P50 disks. VLDB migrations could require more than 5 TB of transaction log space. It's recommended to ensure there's always a large amount of transaction log space is always free (20% is a safe figure). Extending transaction log files during an import isn't recommended and impacts performance.
- SQL Server max degree of parallelism (MAXDOP) should usually be set to 1. Only certain index build operations benefit from MAXDOP and then only for specific tables.
- Accelerated Networking is mandatory for DB and R3load servers.
- Limit the maximum memory a single SQL Server query can request with Resource Governor. The memory limit is needed to prevent index build operations from requesting very large memory grants.
- Secondary indexes for very large tables can be removed from the STR file and built ONLINE with scripts after the main portion of the import has finished and post-processing tasks such as configuring STMS are occurring.
- Customers using SQL Server TDE are recommended to pre-create the database and transaction log files, then enable TDE prior to starting the import. TDE runs for a similar amount of time on a DB that is full of data or empty. Enabling TDE on a VLDB can lead to blocking/locking issues and it's recommended to import into a TDE database. The overhead importing to a TDE database is relatively low.

## Cost optimizations

- When you shut down an Azure VM and the VM is deallocated, you no longer have to pay for it (only for storage). With pay-as-you-go pricing, snoozing a typical SAP VM provides considerable savings, as much as ~60-70%.
- For Virtual Machines that need to run all or most of the time, use Azure Reserved Virtual Machine Instances. Reserving an instance for one year can provide savings of ~40-45% or as much as ~60-65% for a 3-year reservation.
