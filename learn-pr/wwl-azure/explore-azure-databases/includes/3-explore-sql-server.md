For SQL Server deployments, with all SAP certified virtual machine types (see [SAP Note \#1928533](https://me.sap.com/notes/1928533)), except A-Series virtual machines, tempdb data, and log files can be placed on the nonpersisted D:\\ drive. It's recommended to use multiple tempdb data files. These configurations enable tempdb to consume more space than the system drive can provide. The non-persistent D:\\ drive also offers better I/O latency and throughput (except for A-Series virtual machines). To determine the proper tempdb size, you can check the tempdb sizes on existing systems.

Note, if you place tempdb data files and log files into a folder on D:\\ drive that you created, you need to make sure that the folder does exist after a virtual machine restart. Since the D:\\ drive is freshly initialized after a virtual machine restart, all file and directory structures are deleted.

For SQL Server, the NTFS block size for disks containing SQL Server data and log files should be 64 KB. There's no need to format the D:\\ drive. This drive comes preformatted.

In order to make sure that the restore or creation of databases isn't initializing the data files by zeroing the content of the files, make sure that the user context the SQL Server service is running in have the right permission. Usually, users in the Windows Administrator group have these permissions. If the SQL Server service is run in the user context of non-Windows Administrator user, you need to assign to that user the user right to perform volume maintenance tasks.

The following diagram illustrates a virtual machine configuration, which runs SQL Server with an SAP database and where tempdb data and tempdb logfile are placed on the D:\\ drive:

:::image type="content" source="../media/simple-disk-structure-sql-server-6d98b649.png" alt-text="Diagram of simple virtual machine disk configuration for SQL Server.":::

The diagram displays a simple case. As alluded to in the article [Considerations for Azure Virtual Machines DBMS deployment for SAP workload](/azure/virtual-machines/workloads/sap/dbms_guide_general), Azure storage type, number, and size of disks are dependent on different factors.
