Given the wide variety of Azure infrastructure options, nearly all existing SAP NetWeaver and S/4HANA systems can be hosted in Azure. Azure supports VM SKUs with terabytes of memory and more than 200 CPUs. For even more demanding workloads, Azure offers HANA Large Instances (HLI), which allow for HANA deployments that can scale up to 24 TB and scale-out to 120 TB.

To successfully deploy SAP systems into Azure IaaS, it is important to understand the differences between the offerings of traditional outsourcers or hosters and IaaS offerings. While the traditional hoster or outsourcer adapts infrastructure (network, storage, and server type) to the workload a customer wants to host, it is the customer's or partner's responsibility to identify the workload’s requirement and choose the correct Azure components of VMs, storage, and network for IaaS deployments.




The four methods for provisioning storage for SAP workloads in Azure are as follows:

* Azure VM disks

* Azure VM NFS storage

* Azure VM SMB storage

* SAP HANA on Azure (Large Instance) storage

## Azure VM disks
The storage-specific provisions for Azure VMs hosting SAP workloads are as follows:

* To increase the total number of IOPS per volume presented to the guest operating system in the VM, multiple disks can be striped using functionality operating systems offer. Each disk is protected from physical drive failure by the means of mirroring, so using a software RAID level higher than RAID-0 is not necessary.

* DB log files should be stored on different disks than the DB data files.

* Azure Virtual Machines automatically offer a D:\ drive within the VM instance. This drive is not persisted and should NOT be used at all for any DBMS files/directories or any SAP files/directories.

* The use of managed disks is recommended for SAP workloads

Additionally, Azure Standard HDD storage-based managed disks are not supported for SAP workloads. Microsoft recommends using Azure Standard SSD storage as minimum for Azure VMs hosting the SAP application layer and for non-performance sensitive DBMS deployment and using Azure Premium SSD storage for all other Azure VMs DBMS workloads.

The use cases for the Standard and Premium storage. Premium storage is required for all database-related files with exception of the following A-series VM SKUs (including Standard_A5, Standard_A6, Standard_A7, Standard_A8, Standard_A9, Standard_A10, Standard_A11) and D-series VM SKUs (including Standard_D11, Standard_D12, Standard_D13, and Standard_D14). 

SAP recommends using Azure Premium Storage for all SAP production systems in Azure VMs. Even for non-production systems, which require reliable and predictable performance. Azure Premium Storage should be used instead of Azure Standard Storage for storing DBMS files.

As SAP software in Azure VMs is deployed with Azure Standard Storage for database files, it is important to be aware of the limitations of Azure Standard Storage side, such as:

* A single VHD can deliver a maximum of 500 IOPS. However, there is no certainty that the  500 IOPS maximum will be achieved.

* An Azure Storage Account, which uses Standard Storage throttles around 20 K IOPS.

* Latency for typical DBMS I/Os is usually in the double-digit millisecond range. Depending on the size, latencies can be even in the middle double digit millisecond range.


* Latency for writing to DBMS transaction logs might be so high that the database throttles. This might restrict the CPU resource consumption for the DBMS, and slow down business processing of the SAP application.

* When using Azure Standard different VM types might not be certified for SAP usage, for example, D- and G-Series. Only those VMs that work with Azure Premium Storage (DS- and GS-series) were certified.

Most of the performance issues of the DBMS that are deployed in Azure VMs are related to:

* IOPS limits of Standard Storage

* High latency with Azure Standard Storage, which slows down business processing

> [!NOTE]
> It is important to note that the use of Premium Storage has cost implications, so customers might consider using a mix of Standard and Premium Storage disks on the same Azure VM (e.g. use Standard Storage for the OS disk).



The choice of the storage also has backup implications. Backups of DBMS data files based on Premium Storage are way faster than on Azure Standard Storage. Writing the backups to VHD destination is also significantly faster with Azure Premium Storage. Premium Storage must also be used in combination with Microsoft Data Protection Manager (DPM) in Azure.


## Azure VM NFS storage
Highly available Azure VM NFS storage for SAP workloads can be implemented by using Distributed Replicated Block Device (DRBD) with Pacemaker clustering on Azure VMs running SUSE and by using GlusterFS clustering on RHEL. Details regarding both implementations are described later in this course. 

Managed NFS storage is available in the form of Azure NetApp Files. The Azure NetApp Files service is an enterprise-class, high-performance, metered file storage service. Azure NetApp Files supports a wide range of workloads and is highly available by default. You can select service and performance levels and set up snapshots through the service.


## Azure VM SMB storage
Highly available SMB shares for SAP workloads in Azure VMs can be implemented by using Storage Spaces Direct (S2D)-based clusters with the Scale-Out File Servers (SOFS) role.  Alternatively, such shares can be created by leveraging third-party solutions (such as SIOS DataKeeper) that emulate shared disks by synchronously replicating the content of local disks of clustered Azure VMs. 

Azure also offers Azure Files, which deliver managed SMB file sharing. However, at the time of authoring of this content, Azure Files support file system-level permissions only in scenarios that involve Azure Active Directory Domain Services. 


## SAP HANA on Azure (Large Instance) storage
The storage layout for SAP HANA on Azure (Large Instances) is configured according to SAP recommended guidelines. 

The guidelines are documented in the SAP HANA storage requirements white paper available at [https://www.sap.com/documents/2015/03/74cdb554-5a7c-0010-82c7-eda71af511fa.html](https://www.sap.com/documents/2015/03/74cdb554-5a7c-0010-82c7-eda71af511fa.html) 