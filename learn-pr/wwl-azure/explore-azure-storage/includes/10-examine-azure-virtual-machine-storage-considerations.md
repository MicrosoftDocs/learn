## Paging/swap file

Use the following recommendations when configuring the paging/swap file:

- Windows operating system pagefile should reside on the D: drive (non-persistent disk)
- Linux swapfile should reside under /mnt/resource and be configured in the configuration file of the Linux Agent /etc/waagent.conf. Add or change the following settings:

  - ResourceDisk.EnableSwap=**y**
  - ResourceDisk.SwapSizeMB=**\[size in MBs\]**
- To activate the changes, you need to restart the Linux Agent by running:

  - `sudo service waagent restart`

For information regarding the recommended swap file size, refer to [SAP Note \#1597355](https://aka.ms/az-120-sapnote-1597355).

## Managed disks

The use of managed disks is recommended for all SAP workloads. Note that managed disks are required to implement Write Accelerator. As explained earlier, Write Accelerator is a disk capability of M-Series Azure VMs with Premium storage-based Azure managed disks. Its purpose is to improve the I/O latency of writes. Write Accelerator is ideally suited where log file updates are required to persist to disk in a highly performant manner for modern databases.

## Premium Storage

Premium Storage provides significantly better performance than Standard Storage, especially for critical transaction log writes. Microsoft recommends using Azure Standard SSD storage as the minimum for Azure VMs hosting the SAP application layer and for non-performance sensitive DBMS deployment and using Azure Premium SSD storage for all other Azure VMs DBMS workloads.

For SAP application servers, including the Central Services virtual machines, you could potentially use Azure Standard Storage to reduce cost, because application execution takes place in memory and uses disks for logging only. However, as explained earlier, Standard Storage is only certified for unmanaged disks. Since application servers do not host any data, you can also use the smaller P4 and P6 Premium Storage disks to help minimize cost.

## Multi-disk volumes

The number of disks used for the DBMS data files and the type of Azure Storage these disks are hosted on should be determined by the IOPS requirements and the latency required. It is important to note that IOPS traffic to different data files is not always the same since existing customer systems might have differently sized data files representing their databases. Effectively, it is recommended to use striping over multiple disks to create volumes hosting data files.

Stripe multiple Azure data disks using Storage Spaces to increase I/O bandwidth up to the target virtual machine's IOPS and throughput limits. On Linux, use the MDADM utility to stripe disks together. The MDADM is a small program which will allow you to configure and manage RAID devices in Linux.

Depending on the type of workload your application is running, choose an appropriate stripe size. For random small IO requests, use a smaller stripe size. For large sequential IO requests, use a larger stripe size. Find out the stripe size recommendations for the application you will be running on Premium Storage. For SQL Server, configure a stripe size of 64 KB for OLTP workloads and 256 KB for data warehousing workloads.

Storage latency is critical for DBMS systems, even for SAP HANA, which, for the most part, keeps data in-memory. The critical path in storage is usually around the transaction log writes of the DBMS systems. However, operations like writing savepoints or loading data in-memory after crash recovery can also be critical. Therefore, it is mandatory to leverage Azure Premium Disks for **/hana/data** and **/hana/log** volumes. In order to achieve the minimum throughput of **/hana/log** and **/hana/data** as required by SAP, build a RAID 0 volume using MDADM or LVM over multiple Azure Premium Storage disks. As stripe sizes for the RAID 0 the recommendation is to use:

- 64 KB or 128 KB for **/hana/data**
- 32 KB for **/hana/log**

## I/O scheduling modes

Linux has several different I/O scheduling modes. Common recommendation through Linux vendors and SAP is to set the I/O scheduler mode for disk volumes away from the cfq mode to the noop mode. Details are referenced in [SAP Note \#1984798](https://launchpad.support.sap.com/#/notes/1984798).

## Caching

When you mount disks to VMs, you can choose whether the I/O traffic between the VM and those disks located in Azure storage is cached. Standard and Premium storage use two different technologies for this type of cache.

The following caching recommendations assume these I/O characteristics for standard DBMS:

- I/O consists mostly of a read workload against data files of a database. These reads are performance-critical for the DBMS system.
- Writing against the data files occurs in bursts based on checkpoints or a constant stream. Averaged over a day, there are fewer writes than reads. Opposite to reads from data files, these writes are asynchronous and don't hold up any user transactions.
- There are hardly any reads from the transaction log or redo files. Exceptions are large I/Os when you do transaction log backups.
- The main load against transaction or redo log files is writes. Dependent on the nature of the workload, you can have I/Os as small as 4 KB or, in other cases, I/O sizes of 1 MB or more.
- All writes must be persisted on disk in a reliable fashion.

Premium Storage offers the following caching options:

- None
- Read
- Read/Write
- None + Write Accelerator, which is only for Azure M-Series VMs
- Read + Write Accelerator, which is only for Azure M-Series VMs

Premium Storage specific recommendation is to use Read caching for disks hosting SAP database data files and No caching for the disks containing SAP database log files.

The same principle applies to SAP HANA, where the caching for volumes using Azure Premium Storage should be set as follows:

- **/hana/data** \- no caching
- **/hana/log** \- no caching (with exception for M-Series VMs)
- **/hana/shared** \- read caching

For M-Series deployments, Microsoft recommends that you use Azure Write Accelerator for your DBMS deployment. As a matter of fact, SAP HANA certification for Azure M-Series virtual machines requires that Azure Write Accelerator be enabled for the **/hana/log** volume. There are limits of Azure Premium Storage VHDs per VM that can be supported by Azure Write Accelerator. The current limits are:

- 16 VHDs for an M128xx and M416xx VM
- 8 VHDs for an M64xx and M208xx VM
- 4 VHDs for an M32xx VM

These caching recommendations are based on the I/O characteristics of SAP HANA, including:

- There is hardly any read workload against the HANA data files. Exceptions are large sized I/Os after restart of the HANA instance or when data is loaded into HANA. Another case of larger read I/Os against data files can be HANA database backups. As a result, read caching mostly does not make sense since in most of the cases, all data file volumes need to be read completely.
- Writing against the data files is experienced in bursts based on HANA savepoints and HANA crash recovery. Writing savepoints is asynchronous and are not holding up any user transactions. Writing data during crash recovery is performance-critical to get the system to respond fast again. However, crash recoveries should be rather exceptional situations.
- There are hardly any reads from the HANA redo files. Exceptions are large I/Os when performing transaction log backups, crash recovery, or in the restart phase of a HANA instance.
- Main load against the SAP HANA redo log file is writes. Dependent on the nature of workload, you can have I/Os as small as 4 KB or in other cases I/O sizes of 1 MB or more. Write latency against the SAP HANA redo log is performance critical.
- All writes need to be persisted on disk in a reliable fashion.
