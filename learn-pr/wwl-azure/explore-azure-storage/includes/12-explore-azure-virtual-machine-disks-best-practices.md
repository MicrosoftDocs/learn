[SAP Note \#2015553](https://me.sap.com/notes/2015553) describes storage-specific provisions for Azure Virtual Machines hosting SAP workloads:

- “To increase the total number of IOPS per volume presented to the guest operating system in the virtual machine, multiple disks can be striped using functionality operating systems offer. Each disk is protected from physical drive failure by the means of mirroring, so using a software RAID level higher than RAID-0 isn't necessary.”
- “DB log files should be stored on different disks than the DB data files.”
- “Azure Virtual Machines automatically offer a D:\\ drive within the virtual machine instance. This drive isn't persisted and shouldn't be used at all for any DBMS files/directories or any SAP files/directories.”
- The use of managed disks is recommended for SAP workloads.

[SAP Note \#1928533](https://me.sap.com/notes/1928533) additionally states that Azure Standard HDD storage based managed disks aren't supported for SAP workloads. Microsoft recommends:

- Using Azure Standard SSD storage as the minimum for Azure Virtual Machines hosting the SAP application layer.
- Using Azure Standard SSD storage for non-performance sensitive DBMS deployment
- Using Azure Premium SSD storage for all other Azure Virtual Machines DBMS workloads.

[SAP Note \#2015553](https://me.sap.com/notes/2015553) describes the use cases for the Standard and Premium storage. Premium storage is required for all database-related files with exception of A-series virtual machine SKUs (including Standard\_A5, Standard\_A6, Standard\_A7, Standard\_A8, Standard\_A9, Standard\_A10, Standard\_A11) and D-series virtual machine SKUs (including Standard\_D11, Standard\_D12, Standard\_D13, and Standard\_D14).

More detailed information is available in [SAP Note \#2367194](https://me.sap.com/notes/2367194), which states:

“We strongly recommend using Azure Premium Storage for all SAP production systems in Azure Virtual Machines. Even for non-production systems, which require reliable and predictable performance, you should use Azure Premium Storage instead of Azure Standard Storage for placing your DBMS files.”

“As you deployed your SAP software in Azure Virtual Machines, and used Azure Standard Storage for your database files, you need to be aware of some limitations from the Azure Standard Storage side, such as:

- A single VHD can deliver a maximum of 500 IOPS. However, there's no guarantee that you'll get these 500 IOPS.
- An Azure Storage Account, which uses Standard Storage throttles around 20 K IOPS.
- Latency for typical DBMS I/Os is usually in the double-digit millisecond range. Depending on the size, latencies can be even in the middle double-digit millisecond range.
- You see large variations in disk latency.
- Latency for writing to DBMS transaction logs might be so high that the database throttles. This latency might restrict the CPU resource consumption for the DBMS, and slow down business processing of the SAP application.
- When using Azure Standard different virtual machine types might not be certified for SAP usage, for example, D- and G-Series. Only those virtual machines that work with Azure Premium Storage (DS- and GS-series) were certified."

Most of the performance issues of the DBMS that are deployed in Azure Virtual Machines are related to:

- IOPS limits of Standard Storage
- High latency with Azure Standard Storage, which slows down business processing

If you have problems with the DBMS performance of SAP applications in Azure Virtual Machines and when these problems aren't related to CPU resource or memory resource shortages, check whether the usage of Azure Premium Storage can solve the problems, before you open an SAP support ticket.”

It's important to note that the use of Premium Storage has cost implications, so customers might consider using a mix of Standard and Premium Storage disks on the same Azure Virtual Machine (for example, use Standard Storage for the OS disk).

[SAP Note \#2367194](https://me.sap.com/notes/2367194) also describes some SQL Server specific storage considerations:

“SQL Server offers to place SQL Server data files and transaction log files directly on Azure Storage Blobs without wrapping them in VHDs" ([SQL Server data files in Microsoft Azure](/sql/relational-databases/databases/sql-server-data-files-in-microsoft-azure)). As these were reasonable means to overcome the VHD limits on smaller Azure Virtual Machines, and a means to increase the IOPS using Azure Standard Storage, we don't recommend directly placing SQL Server data and transaction log on Azure Storage Blobs as standard deployment method. Reasons for this are:

- The Premium Storage Cache, which is established on the local compute node isn't used in such a scenario.
- The data volume throughput SLA of the virtual machine isn't honored.
- I/O traffic goes through the network channel and not through the storage I/O channel. Especially when using Premium Storage this can lead to disadvantages with regard to deterministic l/O latencies.
- A Premium Storage Account has a current size limitation of 35 TB.
- An Azure Standard Storage Account can't be transferred to a Premium Storage Account. If you want to move a VHD from Standard Storage to Premium Storage, you need to copy the VHDs between the two storage accounts.
- For SAP application servers, often Premium Storage isn't needed from a storage workload point of view.
- For Azure Standard Storage, we did not recommend any caching, which is offered during creation of VHDs. This is different from Azure Premium Storage.
- With Azure Premium Storage, we recommend allowing read-only caching for VHDs that support DBMS data files. VHDs supporting transaction log or redo files shouldn't use any caching with Azure Premium Storage
- Azure Premium Storage Read/Write caching shouldn't be used for VHDs that support database files.”

The choice of storage has also backup implications. As [SAP Note \#2367194](https://me.sap.com/notes/2367194) states, “backups of DBMS data files based on Premium Storage are way faster than on Azure Standard Storage. Writing the backups to VHD destination is also significantly faster with Azure Premium Storage”. Premium Storage must also be used in combination with Microsoft Data Protection Manager (DPM) in Azure.
