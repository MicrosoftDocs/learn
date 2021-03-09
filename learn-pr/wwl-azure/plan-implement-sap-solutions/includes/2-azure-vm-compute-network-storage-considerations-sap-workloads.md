The SAP Application Performance Standard (SAPS) metric constitutes one of the major criteria for determining whether a VM size offers throughput requirement necessary for a given SAP workload. Effectively, it also represents one the primary factors considered by Microsoft and SAP when certifying Azure VMs for SAP NetWeaver and SAP HANA.

> [!NOTE]
> It is important to note that the listing does not include every certified Azure VM type. It also does not include the vCPU and memory definition of the VM, but rather the theoretical capacity for the case when Intel Hyperthreading is configured on the host. Effectively, you should not use it for sizing purposes or draw any conclusions regarding the number of vCPUs or the volume of memory for a given Azure VM size. 
 

When comparing different Azure VM sizes and calculating the ratio of SAPS to vCPU, it is worth noting that information provided by Microsoft and SAP always references vCPUs or CPU threads rather than CPU cores. An Intel CPU bare-metal core could represent one CPU thread in the case the Hyper-V host is configured without Hyperthreading or two CPU threads with Hyperthreading enabled.

Hyperthreading on bare-metal server improves the overall throughput. However, the increase is not directly proportional to the number of CPU threads of the host. The throughput improvement by Hyperthreading under a typical SAP workload is ranging from 30-40%. As a result, one core with two hyperthreaded CPU threads on the host will deliver 130-140% of the throughput the same processor core delivers without Hyperthreading. This means that a single CPU thread of a hyperthreaded core will deliver between 65-70% of what a non-hyperthreaded core delivers with a single CPU thread.

The following NetWeaver and/or SAP HANA certified Azure VM families are running on host hardware where Intel Hyperthreading is enabled: 

* **D(S)v3**

* **D(S)v4**

* **E(S)v3**

* **M-Series**

When sizing your intended deployment, you must also consider whether you will implement it by using the 2-tier or 3-tier architecture.

VM types have certain bandwidth limitations as well. In general, we can state that the smaller the VM in a VM family is, the smaller the storage and network bandwidth. In case of large VMs, like M128s or M128ms, or ES64v3 the VM is the only VM running on a host. As a result, it benefits from the complete network and storage bandwidth the host has available. In the case of smaller VMs, the network and storage bandwidth need to be divided across multiple VMs. Especially for SAP HANA, but also for SAP NetWeaver, it is vitally important that a VM running intensive workload does not affect CPU, memory, network, and storage bandwidth capacity of other VMs running on the same host. As a result, in sizing a VM, you also need to consider the required network and storage bandwidth. 

To maximize performance, Microsoft recommends applying additional factors and considerations after conducting an SAP sizing analysis. Some factors are not covered by SAP sizing techniques at all such as the use of SSD and large amounts of RAM. 

There are several approaches to sizing SAP systems: 

* **Reference-Based Sizing** – ST03 and EarlyWatch data is analyzed and compared to another known customer with similar workload and a known hardware configuration 

* **SAP Quicksizer** – SAP tool that calculates SAPS, DB size, and RAM based on many inputs including business document volumes and number of users 

* **T-Shirt** – sizing based on the anticipated number of SAP users where precise information is unavailable 

You might have the option of evaluating performance of your existing Azure deployments by leveraging load testing tools (such as LoadRunner by Micro Focus, available from Azure Marketplace).

## Networking considerations
Network throughput is unaffected by the following factors:

* **Number of network interfaces**: The bandwidth limit is cumulative of all outbound traffic from the virtual machine.

* **Accelerated networking**: Though the feature can be helpful in achieving the published limit, it does not change the limit.

* **Traffic destination**: All destinations count toward the outbound limit.

* **Protocol**: All outbound traffic over all protocols counts towards the limit.

The following best networking practices are based on existing customer deployments:

* The virtual networks the SAP application is deployed into don't have access to the internet.

* The database VMs run in the same virtual network as the application layer.

* The VMs within the virtual network have a static allocation of the private IP address. This is particularly important when deploying SAP HANA because some configuration attributes for HANA reference IP addresses.

* To separate and isolate traffic to the DBMS VM, assign different NICs to the VM. Every NIC gets a different IP address, and every NIC is assigned to a different virtual network subnet. For example, one NIC can connect to the management subnet, and one NIC to facilitate connectivity from the on-premises network or other Azure virtual networks.

* Traffic restrictions to and from Azure VMs hosting SAP workloads are not controlled by using operating system firewalls, but rather by using network security groups (NSGs). 

* Divide virtual network address space into subnets. Each subnet can be associated with an NSG that defines the access policies for the subnet. Place application servers on a separate subnet so you can secure them more easily by managing the subnet security policies, not the individual servers. Associate NSGs with subnets, rather than individual network adapters to minimize management overhead. When an NSG is associated with a subnet, it applies to all the Azure VMs connected to that subnet.

Keep in mind that configuring network virtual appliances in the communication path between the SAP application and the DBMS layer of an SAP NetWeaver-, Hybris-, or S/4HANA-based SAP system isn't supported. This restriction is for functionality and performance reasons. The communication path between the SAP application layer and the DBMS layer must be a direct one. The restriction doesn't include application security group (ASG) and NSG rules if those ASG and NSG rules allow a direct communication path.

Other scenarios where network virtual appliances aren't supported include:

* Communication paths between Azure VMs that represent Linux Pacemaker cluster nodes and SBD devices.

* Communication paths between Azure VMs and Windows Server Scale-Out File Server (SOFS).

Azure VMs can benefit from Accelerated Networking and Proximity Placement Groups. Use them when you deploy Azure VMs for an SAP workload, especially for the SAP application layer and the SAP DBMS layer.

## Accelerated Networking

* It is not possible to switch on Accelerated Networking for existing VMs. Accelerated Networking must be enabled when a VM is created. It is possible to delete a VM (by default the boot and data disks are kept) and create the VM again using the same disks

* SQL Server running with datafiles stored directly on blob storage are likely to greatly benefit from Accelerated Networking

* It is possible to have one or more Accelerated Network NICs and a traditional non-accelerated network card on the same VM

* SAP application server to database server latency can be tested with ABAP report /SSA/CAT -> ABAPMeter

* Inefficient “chatty” ABAP code or particularly intensive operations such as large Payroll jobs or IS-Utilities Billing jobs have shown significant improvement after enabling Accelerated Networking

* To take advantage of Accelerated Networking in load-balancing scenarios, make sure to use Standard Azure Load Balancer (rather than Basic)

## Storage considerations

When you plan your disk layout, find the optimal configuration based on the following factors:

* The number of data files 

* The number of disks that contain the files.

* The IOPS quotas of a single disk.

* The data throughput per disk.

* The number of additional data disks possible per VM size.

* The overall storage throughput a VM can provide.

* The latency different Azure Storage types can provide.

* VM SLAs

## Paging/swap file

Use the following recommendations when configuring the paging/swap file: 

* Windows operating system pagefile should reside on the D: drive (non-persistent disk)

* Linux swapfile should reside under /mnt/resource and be configured in the configuration file of the Linux Agent /etc/waagent.conf. Add or change the following settings:

    * ResourceDisk.EnableSwap=y

    * ResourceDisk.SwapSizeMB=<size_in_MBs>

* To activate the changes, you need to restart the Linux Agent by running:

    * sudo service waagent restart


## Managed disks

The use of managed disks is recommended for all SAP workloads. 
> [!NOTE]
> Note that managed disks are required to implement Write Accelerator. As explained earlier in this course, Write Accelerator is a disk capability of M-Series Azure VMs with Premium storage-based Azure-managed disks. Its purpose is to improve the I/O latency of writes. Write Accelerator is ideally suited where log file updates are required to persist to disk in a highly performant manner for modern databases. 

## Premium Storage

Premium Storage is providing significantly better performance than Standard Storage, especially for critical transaction log writes. Microsoft recommends using Azure Standard SSD storage as minimum for Azure VMs hosting the SAP application layer and for non-performance sensitive DBMS deployment and using Azure Premium SSD storage for all other Azure VMs DBMS workloads. 

For SAP application servers, including the Central Services virtual machines, you could potentially use Azure Standard Storage to reduce cost, because application execution takes place in memory and uses disks for logging only. However, as explained earlier, Standard Storage is only certified for unmanaged disks. Since application servers do not host any data, you can also use the smaller P4 and P6 Premium Storage disks to help minimize cost.

## Multi-disk volumes

The number of disks used for the DBMS data files and the type of Azure Storage these disks are hosted on should be determined by the IOPS requirements and the latency required. 
> [!NOTE]
> It is important to note that IOPS traffic to different data files is not always the same since existing customer systems might have differently sized data files representing their databases. Effectively, it is recommended to use striping over multiple disks to create volumes hosting data files. 

Storage latency is critical for DBMS systems, even for SAP HANA, which, for the most part, keeps data in-memory. The critical path in storage is usually around the transaction log writes of the DBMS systems. However, operations like writing savepoints or loading data in-memory after crash recovery can also be critical. Therefore, it is mandatory to leverage Azure Premium Disks for /hana/data and /hana/log volumes. In order to achieve the minimum throughput of /hana/log and /hana/data as required by SAP, build a RAID 0 volume using MDADM or LVM over multiple Azure Premium Storage disks. As stripe sizes for the RAID 0 the recommendation is to use:

* 64 KB or 128 KB for /hana/data

* 32 KB for /hana/log

## Caching

When you mount disks to VMs, you can choose whether the I/O traffic between the VM and those disks located in Azure storage is cached. Standard and Premium storage use two different technologies for this type of cache.

The following caching recommendations assume these I/O characteristics for standard DBMS:

* I/O consists mostly of a read workload against data files of a database. These reads are performance critical for the DBMS system.

* Writing against the data files occurs in bursts based on checkpoints or a constant stream. Averaged over a day, there are fewer writes than reads. Opposite to reads from data files, these writes are asynchronous and don't hold up any user transactions.

* There are hardly any reads from the transaction log or redo files. Exceptions are large I/Os when you perform transaction log backups.

* The main load against transaction or redo log files is writes. Dependent on the nature of the workload, you can have I/Os as small as 4 KB or, in other cases, I/O sizes of 1 MB or more.

* All writes must be persisted on disk in a reliable fashion.

Premium Storage offers the following caching options:

* None

* Read

* Read/write

* None + Write Accelerator, which is only for Azure M-Series VMs

* Read + Write Accelerator, which is only for Azure M-Series VMs

Premium Storage specific recommendation is to use Read caching for disks hosting SAP database data files and No caching for the disks containing SAP database log files.

The same principle applies to SAP HANA, where the caching for volumes using Azure Premium Storage should be set as follows:

* /hana/data - no caching

* /hana/log - no caching (with exception for M-Series VMs)

* /hana/shared - read caching

For M-Series deployments, Microsoft recommends that you use Azure Write Accelerator for your DBMS deployment. As a matter of fact, SAP HANA certification for Azure M-Series virtual machines requires that Azure Write Accelerator be enabled for the /hana/log volume. 
> [!NOTE]
> Note that there are limits of Azure Premium Storage VHDs per VM that can be supported by Azure Write Accelerator. 

The current limits are:

* 16 VHDs for an M128xx and M416xx VM

* 8 VHDs for an M64xx and M208xx VM

* 4 VHDs for an M32xx VM

These caching recommendations are based on the I/O characteristics of SAP HANA, including:

* There is hardly any read workload against the HANA data files. Exceptions are large sized I/Os after restart of the HANA instance or when data is loaded into HANA. Another case of larger read I/Os against data files can be HANA database backups. As a result, read caching mostly does not make sense since in most of the cases, all data file volumes need to be read completely.

* Writing against the data files is experienced in bursts based by HANA savepoints and HANA crash recovery. Writing savepoints is asynchronous and are not holding up any user transactions. Writing data during crash recovery is performance critical to get the system responding fast again. However, crash recovery should be rather exceptional situations

* There are hardly any reads from the HANA redo files. Exceptions are large I/Os when performing transaction log backups, crash recovery, or in the restart phase of a HANA instance.

* Main load against the SAP HANA redo log file is writes. Dependent on the nature of workload, you can have I/Os as small as 4 KB or in other cases I/O sizes of 1 MB or more. Write latency against the SAP HANA redo log is performance critical.

* All writes need to be persisted on disk in a reliable fashion

## Ultra SSD

Microsoft is in the process of introducing a new Azure storage type called Azure Ultra SSD. The primary difference between Azure storage offered so far and Ultra SSD is that the disk capabilities are not bound to the disk size anymore. As a customer, you can define these capabilities for Ultra SSD:

* Size of a disk ranging from 4 GiB to 65,536 GiB

* IOPS range from 100 IOPS to 160 K IOPS (maximum depends on the VM SKU)

* Storage throughput from 300 MB/sec to 2,000 MB/sec

UltraSSD gives you the possibility to define a single disk that fulfills your size, IOPS and disk throughput range, rather than using logical volume managers like LVM or MDADM on top of Azure Premium Storage to construct volumes that fulfill IOPS and storage throughput requirements. You have the option of attaching both UltraSSD and Premium Storage disks to the same Azure VMs. As a result, you can restrict the usage of UltraSSD for the performance critical /hana/data and /hana/log volumes and implement other volumes with Premium Storage 

## SAP HANA Dynamic Tiering 2.0

SAP HANA Dynamic Tiering 2.0 (DT 2.0) offers the ability to offload less frequently access data from memory into extended storage. SAP HANA Dynamic Tiering 2.0 isn't supported by SAP BW or S4HANA. Its primary use cases consist of native HANA applications.

There is a set of mandatory requirements, which must be followed to ensure supportability for DT 2.0 on Azure VMs:

* DT 2.0 must be installed on a dedicated Azure VM. It may not run on the same VM where SAP HANA runs

* SAP HANA and DT 2.0 VMs must be deployed within the same Azure Vnet

* The SAP HANA and DT 2.0 VMs must be deployed with Azure accelerated networking enabled

* Storage type for the DT 2.0 VMs must be Azure Premium Storage

* Multiple Azure disks must be attached to the DT 2.0 VM

* It's required to create a striped volume (either via lvm or mdadm) across the Azure disks

At the time of authoring of this course, customers can use the following two VM sizes to run SAP HANA DT 2.0:

* M64-32ms

* E32sv3

Given the basic premise of DT 2.0, which is to offload "warm" data to save costs, it typically makes sense to use following VM sizes:

|    SAP HANA VM type    |    DT 2.0 VM type    |
|-----------------------------------|--------------------------------------------------------------------------------|
|    M128ms    |    M64-32ms    |
|    M128s    |    M64-32ms    |
|    M64ms    |    E32sv3    |
|    M64s    |    E32sv3    |


However, there is no strict rule  regarding the possible combinations. The choice is dependent on the specific customer workload and all combinations of SAP HANA-certified M-series VMs with supported DT 2.0 VMs (M64-32ms and E32sv3) are supported.

Installing DT 2.0 on a dedicated VM requires network throughput between the DT 2.0 VM and the SAP HANA VM of 10 Gb minimum. Therefore, it's mandatory to place all VMs within the same Azure Vnet and enable Azure accelerated networking.

According to DT 2.0 best practice guidance, the disk IO throughput should be minimum 50 MB/sec per physical core. According to the specifications of the two Azure VM types that support DT 2.0, their maximum disk IO throughput values are:

* E32sv3 : 768 MB/sec (uncached) which means a ratio of 48 MB/sec per physical core

* M64-32ms : 1000 MB/sec (uncached) which means a ratio of 62.5 MB/sec per physical core

Depending on size requirements, there are different options to reach the maximum throughput of a VM. The following table contains data volume disk configurations for both DT 2.0 VM types that achieve the upper VM throughput limit. The E32sv3 VM should be considered as an entry level for smaller workloads. As the M64-32ms VMs have more memory, the IO load might not reach the limit especially for read intensive workloads. Therefore, fewer disks in the stripe set might be enough depending on the customer-specific workload.

|    VM SKU    |    Disk Config 1    |    Disk Config 2    |    Disk Config 3    |    Disk Config 4    |    Disk Config 5    |
|----------------|--------------------------|-------------------------|-------------------------|---------------------------|---------------------------|
|    M64-32ms    |    4 x P50   -> 16 TB    |    4 x P40   -> 8 TB    |    5 x P30   -> 5 TB    |    7 x P20   -> 3.5 TB    |    8 x P15   -> 2 TB     |
|    E32sv3    |    3 x P50   -> 12 TB    |    3 x P40 ->   6 TB    |    4 x P30   -> 4 TB    |    5 x P20   -> 2.5 TB    |    6 x P15   -> 1.5 TB    |


Based on heuristics, the recommended size of the log volume is 15% of the data volume size. The creation of the log volume can be accomplished by using different Azure disk types depending on cost and throughput requirements. In the case of using the VM type M64-32ms, Write Accelerator should be enabled. 

As with for SAP HANA scale-out, the /hana/shared directory must be shared between the SAP HANA VM and the DT 2.0 VM. The recommendation is to use the same architecture as for SAP HANA scale-out, which relies on dedicated VMs acting as a highly available NFS server. The identical design can be used in order to provide a shared backup volume. It is up to the customer to decide if HA is necessary or if it is enough to use a dedicated VM with enough storage capacity to act as a backup server.
