SQL Server 2014 and later releases open the possibility to store database files directly on Azure Blob Store without the 'wrapper' of a VHD around them. Especially with using Standard Azure Storage or smaller VM types this type of deployment enables scenarios where you can overcome the limits of IOPS that would be enforced by a limited number of disks that can be mounted to some smaller VM types. This way of deployment works for user databases, but not for system databases of SQL Server. It also works for data and log files of SQL Server. If you'd like to deploy an SAP SQL Server database this way instead of 'wrapping' it into VHDs, keep in mind:

 -  The Storage Account used needs to be in the same Azure Region as the one that is used to deploy the VM SQL Server.
 -  Instead of accounting against the VM's storage I/O quota, the traffic against storage blobs representing the SQL Server data and log files will be accounted into the VM's network bandwidth of the specific VM type.
 -  As a result of pushing file I/O through the network quota, you are stranding the storage quota mostly, and so only partially using the overall bandwidth of the VM.
 -  The IOPS and I/O throughput performance targets that Azure Premium Storage has for the different disk sizes do not apply anymore, even if the blobs you created are located on Azure Premium Storage. As a result of placing SQL Server data files and log files directly on blobs that are stored on Azure Premium Storage, the performance characteristics can be different compared to VHDs on Azure Premium Storage.
 -  Host based caching as available for Azure Premium Storage disks is not available when placing SQL Server data files directly on Azure blobs.
 -  On M-Series VMs, Azure Write Accelerator can't be used to support sub-millisecond writes against the SQL Server transaction log file.

For production systems, the recommendation is to avoid this configuration. Instead, choose the placements of SQL Server data and log files in Azure Premium Storage VHDs instead of directly on Azure blobs.

:::image type="content" source="../media/data-files-directly-azure-blob-storage-f905ce9c.png" alt-text="Illustration of storing database files directly on Azure Blob Storage":::
