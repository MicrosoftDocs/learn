Azure has many storage types that differ vastly in capabilities, throughput, latency, and prices. Some of the storage types are well suited or optimized for specific SAP workload scenarios while others are less so. Some Azure storage types got certified for the usage with SAP HANA. In this document, we'll review the different types of storage and describe their capability and usability with SAP workloads and SAP components.

Public cloud vendors now use GiB ([Gibibyte](https://en.wikipedia.org/wiki/Gibibyte)) or TiB ([Tebibyte](https://en.wikipedia.org/wiki/Tebibyte)) as size units, instead of Gigabyte or Terabyte. All Azure documentation and pricing uses those units. Throughout this document, we reference these size units of MiB, GiB, and TiB units exclusively. If you need to plan with MB, GB, and TB, be aware of some small differences in the calculations.

## Microsoft Azure Storage resiliency

Microsoft Azure storage keeps the base VHD (with OS) and VM attached data disks or VHDs in three copies on three different storage nodes. This applies the same to Standard HDD, Standard SSD, Azure premium storage, and Ultra disks. When there is a storage node failure, the system transparently fails over to another replica, and seeds a new replica. Because of this redundancy, you don't need to use any kind of storage redundancy layer across multiple Azure disks. This approach is called Local Redundant Storage (LRS). LRS is the default for these types of storage in Azure. [Azure NetApp Files](https://azure.microsoft.com/services/netapp/) provides sufficient redundancy to achieve the same SLAs as other native Azure storage.

## Azure managed disks

Managed disks are a resource type in Azure Resource Manager. They can be used instead of VHDs stored in Azure Storage Accounts. Managed Disks automatically align with the availability set of the virtual machine they're attached to. They increase the availability of your virtual machine and the services that are running on the virtual machine. 

Related to resiliency, this example demonstrates the advantage of managed disks:

- You're deploying your two DBMS VMs for your SAP system in an Azure availability set
- As Azure deploys the VMs, the disk with the OS image will be placed in a different storage cluster. This approach avoids both VMs being affected by an issue with a single Azure storage cluster.
- As you create new managed disks, and assign them to the VMs to store the data and log files of your database, Azure also deploys the new disks in separate storage clusters. None of the first VM's disks are sharing storage clusters with the disks of the second VM.

When deploying without managed disks in customer-defined storage accounts, disk allocation is arbitrary. It has no awareness of the fact that VMs are deployed within an AvSet for resiliency purposes.

> [!NOTE] 
> New deployments of VMs that use Azure block storage for their disks (all Azure storage except Azure NetApp Files) must use Azure managed disks for the base VHD/OS disks, data disks that contain SAP database files, independent of whether you deploy the VMs through availability sets, across Availability Zones, or independent of the sets and zones. Disks that are used for the purpose of storing backups aren't necessarily required to be managed disks. Azure managed disks provide local redundancy (LRS) only.

## Storage scenarios with SAP workloads

Persisted storage is needed in SAP workloads in various components of the stack that you deploy in Azure. These scenarios include:

- Persisted storage for the base VHD of your VM that holds the operating system and other software you install in that disk. This disk/VHD is the root of your VM. Any changes that you make need to be persisted. This ensures that the next time you stop and restart the VM, all of the changes you made before still exist. This capability is especially important when the VM is being deployed onto a different host from where it was running originally.
- Persisted data disks. These disks are VHDs you attach to store application data in. This application data could be data and log/redo files of a database, backup files, or software installations. It’s also used for any disk beyond your base VHD that holds the operating system.
- File shares or shared disks that contain your global transport directory for NetWeaver or S/4HANA. The content of those shares is either consumed by software running in multiple VMs, or is used to build high-availability failover cluster scenarios.
- The /sapmnt directory or common file shares for EDI processes or similar. Content of those shares is either consumed by software running in multiple VMs or is used to build high-availability failover cluster scenarios.

## Azure premium storage

Azure premium SSD storage provides:

- Low I/O latency
- SLAs for IOPS and throughput
- Less variability in I/O latency

Azure premium storage is one of the Azure storage types recommended for SAP workloads in non-production and production systems. Azure premium storage is suited to handle database workloads. The usage of Azure Write Accelerator is going to improve write latency against Azure premium disks substantially. However, for DBMS systems with high IOPS and throughput rates, you need to either over-provision storage capacity, or use functionality like Windows Storage Spaces or logical volume managers in Linux. This allows you to build stripe sets that give you the capacity you want on the one side, but also the necessary IOPS or throughput at best cost efficiency.

### Azure burst functionality for premium storage

Burst functionality is offered for Azure premium storage disks 512 GiB or less in capacity. The ideal cases where this burst functionality can be planned in is likely going to be the volumes or disks that contain data files for the different DBMS. The I/O workload expected against those volumes, especially with small to mid-ranged systems is expected to be similar to:

- Low to moderate read workload, since data ideally is cached in memory, or when HANA should be completely in memory
- Bursts of write triggered by database checkpoints or savepoints that are issued regularly
- Backup workload that reads in a continuous stream in cases where backups aren't executed via storage snapshots
- For SAP HANA, load of the data into memory after an instance restart

Burst functionality can also make sense for the disks or volumes that store the transaction or redo log. This is true especially on smaller DBMS systems where your workload is handling a few hundred transactions per second only. Expected workload against such a disk or volumes is similar to:

- Regular writes to the disk that are dependent on the nature of the workload, since every commit that's issued by the application is likely to trigger an I/O operation
- Higher workload in throughput for cases of operational tasks, like creating or rebuilding indexes
- Read bursts when performing transaction log or redo log backups

## Azure Ultra disk

Azure ultra disks are a suitable storage with low latency for all kinds of SAP workload. So far, Ultra disk can only be used in combinations with VMs that have been deployed through Availability Zones (zonal deployment). Ultra disk doesn't support storage snapshots at this time. Unlike other storage, Ultra disk cannot be used for the base VHD disk. Ultra disk is ideal for cases where I/O workload fluctuates a lot. It allows you to adapt deployed storage throughput or IOPS to storage workload patterns, instead of sizing for maximum usage of bandwidth and IOPS.

## Azure NetApp files (ANF)

Azure NetApp Files is a HANA certified low latency storage that allows to deploy NFS and SMB volumes or shares. The storage comes with three different service levels. These provide different throughput and IOPS in a linear manner, per GiB capacity of the volume. The ANF storage is enabling to deploy SAP HANA scale-out scenarios with a standby node. The storage is suitable for providing file shares as needed for /sapmnt or SAP global transport directory. ANF storage come with functionality availability that is available as native NetApp functionality.

## Azure standard SSD storage

Azure standard SSD storage is the minimum recommendation for non-production VMs for base VHD, and eventual DBMS deployments with relative latency insensitivity and/or low IOPS and throughput rates. This Azure storage type is no longer supported for hosting the SAP Global Transport Directory.

## Azure standard HDD storage

Standard HDD is an Azure storage type that should be used only to store SAP backups. It's suitable only as base VHD for rather inactive systems, like retired systems used for looking up data here and there. But no active development, QA or production VMs should be based on that storage. Nor should database files being hosted on that storage

## Azure VM limits in storage traffic

The individual VM type you select plays a vital role in the storage bandwidth you can achieve. As limitations, you can note that:

- The smaller the VM, the fewer disks you can attach. This limit doesn't apply to ANF. Since you mount NFS or SMB shares, you don't meet a limit of number of shared volumes to be attached
- VMs have I/O throughput and IOPS limits that easily could be exceeded with premium storage disks and Ultra disks
- With ANF, the traffic to the shared volumes is consuming the VM's network bandwidth and not storage bandwidth
- With large NFS volumes in the double digit TiB capacity space, the throughput accessing such a volume out of a single VM will plateau, based on limits of Linux for a single session interacting with the shared volume.

As you up-size Azure VMs in the lifecycle of an SAP system, you should evaluate the IOPS and storage throughput limits of the new and larger VM type. In some cases, it also could make sense to adjust the storage configuration to the new capabilities of the Azure VM.

## Striping or not striping

Creating a stripe set out of multiple Azure disks into one larger volume allows you to accumulate the IOPS and throughput of the individual disks into one volume. It's used for Azure standard storage and Azure premium storage only. Azure Ultra disk where you can configure the throughput and IOPS independent of the capacity of a disk, doesn't require the usage of stripe sets. Shared volumes based on NFS or SMB can't be striped. Azure premium storage throughput and IOPS are non-linear in nature. Because of this, you can provision smaller capacity with the same IOPS and throughput than you can with large single Azure premium storage disks. This method achieves higher throughput or IOPS at lower cost, using Azure premium storage. For example:

- Striping across two P15 premium storage disks gets you to a throughput of 250 MiB/sec. Such a volume is going to have 512-GiB capacity. For a single disk that gives you throughput of 250-MiB/sec, you need a P40 disk with 2-TiB capacity.
- Alternatively, you could achieve a throughput of 400 MiB/sec by striping four P10 premium storage disks, with an overall capacity of 512 GiB. For a single disk with a minimum throughput of 500-MiB/sec, you need a P60 premium storage disk with 8 TiB. Since costing or premium storage is near linear with the capacity, you can sense the cost savings by using striping.

There are some rules that you should follow on striping:

- No in-VM configured storage should be used since Azure storage keeps the data redundant already
- The disks the stripe set is applied to, need to be of the same size

Striping across multiple smaller disks is the best way to achieve a good price/performance ratio using Azure premium storage. Striping has some extra deployment and management overhead.