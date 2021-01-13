Storage performance is a critical component of an I/O heavy application like a database engine. Azure offers a broad array of storage options and can even build your storage solution to meet your workload requirements.

Azure Storage is a highly scalable, secure storage platform that offers a range of solutions to meet the needs of many applications. Because the focus of this course is databases, you will learn about the aspects of blob storage that are applicable to SQL Server workloads, which are disk, file, and blob storage. Note that all the above types of storage support encryption at rest with either a Microsoft managed or a user-defined encryption key.

**Blob Storage** - Blob storage is what is known as object-based storage and includes cold, hot, and archive storage tiers. In a SQL Server environment, blob storage will typically be used for database backups, using SQL Server’s back up to URL functionality.

**File Storage** - File storage is effectively a file share that can be mounted inside a virtual machine, without the need to set up any hardware. SQL Server can use File storage as a storage target for a failover cluster instance.

**Disk Storage** - Azure managed disks offer block storage that is presented to a virtual machine. These disks are managed just like a physical disk in an on-premises server, except that they are virtualized. There are several performance tiers within managed disks depending on your workload. This type of storage is the most commonly used type for SQL Server data and transaction log files.

## Azure managed disks

Azure managed disks are block-level storage volumes that are presented to Azure Virtual Machines. Block level storage refers to raw volumes of storage that are created and can be treated as an individual hard drive. These block devices can be managed within the operating system, and the storage tier is not aware of the contents of the disk. The alternative to block storage is object storage, where files and their metadata are stored on the underlying storage system. Azure Blob Storage is an example of an object storage model. While object storage works well for many modern development solutions, most workloads running in virtual machines will use block storage.

The configuration of your managed disks is important to the performance of your SQL Server workloads. If you are moving from an on-premises environment, it is important to capture metrics like **average disk seconds/read** and **average disk seconds/write** from Performance Monitor as detailed earlier. Another metric to capture is the I/O Operations per Second, which can be captured using the **SQL Server: Resource Pool Stats Disk Read and Write IO/sec** counters, which show you how many IOPs SQL Server is serving at its peak. It is important to understand your workloads. You will want to design your storage and virtual machine to meet the needs of those workload peaks without incurring significant latency. Note that each Azure Virtual Machine type has a limit on IOPs.

Azure managed disks come in four types:

**Ultra disk** - Ultra disks support high-IO workloads for mission critical databases with low latency.

**Premium SSD** - Premium SSD disks are high-throughput and low latency and can meet the needs of most database workloads running in the cloud.

**Standard SSD** - Standard SSDs are designed for lightly used dev/test workloads or web servers that do a small amount of IO, and require predictable latency.

**Standard HDD** - Standard HDDs are suitable for backups and file storage that is infrequently accessed.

Typically, production SQL Server workloads will use either Ultra disk or Premium SSD, or some combination of the two. Ultra disks are typically used where you are looking for submillisecond latency in response time. Premium SSDs typically have single digit millisecond response time, but have lower costs, and more flexibility in design. Premium SSDs also support read-caching, which can benefit read-heavy database workloads by reducing the number of trips to the disk. The read cache is stored on the local SSD (the D:\ drive on Windows or /dev/sdb1/ on Linux) which can help reduce the number of round trips to the actual disk.

## Striping disks for maximum throughput

One of the ways to get more performance and volume out of Azure disks is to stripe your data across multiple disks. This technique does not apply to Ultra disk, as you can scale IOPs, throughput, and maximum size independently on a single disk. However, with Premium SSDs it can be beneficial to scale both IOPs and storage volume. In order to stripe disks in Windows, you simply add the number of disks you would like to the VM, and then create a pool using Storage Spaces in Windows. Don't configure any redundancy for your pool (which would limit your performance) as the redundancy is provided by the Azure framework, which keeps three copies of all disks in synchronous replication to protect against a disk failure. When you create a pool, your pool has the sum of the IOPs and the sum of the volume of all the disks in your pool. For example, if you used 10 P30 disks that are each one TB and have 5000 IOPs per disk, you would have a 10-TB volume with 50,000 IOPs available.

## SQL Server storage configuration best practices

There are few recommendations for best practices for SQL Server on Azure VMs and their storage configuration:

- Create a separate volume for data and transaction log files

- Enable read caching on the data file volume

- Do not enable any caching on the log file volume

- Plan for an additional 20% of IOPs and throughput when building your storage for your VM to handle workload peaks

- Use the D: drive (the locally attached SSD) for TempDB files because TempDB is recreated upon server restart, so there is no risk of data loss

- Enable instant file initialization to reduce the impact of file-growth activities.

- Move trace file and error log directories to data disks

- For workloads requiring storage latency under one millisecond, consider using Ultra disk over Premium SSD.

## Azure Virtual Machine resource provider

One way to reduce the complexity of building storage for your SQL Server on an Azure Virtual Machine is to use the SQL Server templates in the Azure Marketplace, which allow you to configure your storage as part of your deployment as shown below. You can configure the IOPs as needed and the template will perform the work of creating your storage spaces pools within Windows.

:::image type="content" source="../media/module-44-optimize-resources-final-23.png" alt-text="SQL Server VM Disk Configuration":::

This resource provider also supports adding TempDB to the local SSD drive and creates a scheduled task to create the folder on startup.
