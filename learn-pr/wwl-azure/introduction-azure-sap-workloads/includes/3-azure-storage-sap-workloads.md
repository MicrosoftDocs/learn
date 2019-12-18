
## Azure Storage
Azure Storage is a service that stores unstructured and partially structured data. When implementing Azure Storage, users create a storage account. An Azure Storage account is a logical namespace that, depending on its type, is capable of hosting different types of objects, including blobs, tables, queues, and files:

* **Blobs**. These typically represent unstructured files such as media content, virtual machine disks, backups, or logs. Blobs offer a locking mechanism, which facilitates exclusive file access that IaaS virtual machines require. There are three types of blobs. The first one, known as a block blob, is optimized for sequential access, which is ideal for media content. The second one, referred to as a page blob, offers superior random-access capabilities, which are best suited for virtual machine disks. The third one, referred to as an append blob, supports data append operations, without the need to modify existing content. This works best with logging and auditing activities.

* **Tables**. These tables host non-relational and partially structured content, which consists of multiple rows of data with different sets of properties. In the context of Azure Table storage, these rows are referred to as entities. Developers frequently implement table storage as the backend data store for App Service or Cloud Services.

* **Queues**. These are temporary storage for messages that Azure services commonly use to asynchronously communicate with each other. In distributed applications, a source component sends a message by placing it in a queue. The destination component works though the messages in the queue one at a time.

* **Files**. Similar to blobs, these provide storage for unstructured files, but they offer support for file sharing via the Server Message Block (SMB) protocol in the same manner as traditional on-premises Windows file shares.

## Azure-managed disks
The Azure File storage service allows the creation of SMB file shares in Azure just as you would with an on-premises file server. Within each file share, you can create multiple levels of folders to categorize content. Each directory can contain multiple files and folders. Files can be up to 1 TB in size. The maximum size of a file share is 5 TB.

The Azure File storage service is available via both SMB 2.1 and SMB 3.x protocols. Starting with Windows 8 and Windows Server 2012, the operating system includes support for SMB 3.x. Linux distributions also provide support for SMB 3.x by using the cifs-utils package from the Samba project. 

The Windows server and client-based version of SMB 3.x offers several advantages over SMB 2.1, including built-in encryption. As the result, users can establish mapping to Azure File storage shares from locations outside the Azure region where the Azure Storage account that is hosting the shares resides. This includes other Azure regions and on-premises environment for outbound traffic on TCP port 445. With SMB 2.1, mappings to file shares are available only from the same Azure region.

Azure Files offers two performance tiers: 

* **Standard file shares** are backed by rotational hard disk drives (HDDs) that provide reliable performance for IO workloads that are less sensitive to performance variability such as general-purpose file shares and dev/test environments. 

* **Premium file shares** are backed by solid-state disks (SSDs) that provide consistent high performance and low latency, within single-digit milliseconds for most IO operations, for the most IO-intensive workloads. This makes them suitable for a wide variety of workloads like databases, web site hosting, development environments, etc.

There are three options for authorizing access to data objects in Azure Storage, including:

* **Using Azure AD** to authorize access to file shares and their content. At the time of authoring of this content, this option is available only when accessing Azure Files from Azure VMs joined to Azure Active Directory Domain Services-based domain.

* **Using your storage account keys** to authorize access to the entire content of the corresponding storage account. 

* **Using Shared Access Signatures** to grant controlled permissions to specific data objects or containers of objects for a specific amount of time in a target storage account.

## SAP HANA Azure VM storage

Azure provides different types of storage that are suitable for Azure VMs that are running SAP HANA. The SAP HANA certified Azure storage types that can be considered for SAP HANA deployments list such as:

-   Azure Premium SSD

-   Ultra disk

-   Azure NetApp Files



Azure offers two deployment methods for VHDs on Azure Standard and Premium Storage. If the overall scenario permits, take advantage of Azure-managed disk deployments.



The minimum SAP HANA certified conditions for the different storage types are:

-   **Azure Premium SSD** - /hana/log is required to be cached with Azure Write Accelerator. The /hana/data volume could be placed on Premium SSD without Azure Write Accelerator or on Ultra disk

-   **vAzure Ultra disk at least for the /hana/log volume**. The /hana/data volume can be placed on either Premium SSD without Azure Write Accelerator or in order to get faster restart times Ultra disk

-   **NFS v4.1** volumes on top of Azure NetApp Files for /hana/log **and** /hana/data

Some of the storage types can be combined. E.g., it is possible to put /hana/data onto Premium Storage and /hana/log can be placed on Ultra disk storage in order to get the required low latency. However, it is not recommended to mix NFS volumes for e.g. /hana/data and use one of the other certified storage types for /hana/log

As you build the Azure infrastructure you should be aware of some of the following requirements:
-   Enable read/write on **/hana/log of** a 250 MB/sec with 1 MB I/O sizes

-   Enable read activity of at least 400 MB/sec for **/hana/data** for 16 MB and 64 MB I/O sizes

-   Enable write activity of at least 250 MB/sec for **/hana/data** with 16 MB and 64 MB I/O sizes

Given that low storage latency is critical for DBMS systems, even as DBMS, like SAP HANA, keep data in-memory. The critical path in storage is usually around the transaction log writes of the DBMS systems. But also operations like writing savepoints or loading data in-memory after crash recovery can be critical. Therefore, it is **mandatory** to leverage Azure Premium Disks for **/hana/data **and **/hana/log** volumes. In order to achieve the minimum throughput of **/hana/log** and **/hana/data** as desired by SAP, you need to build a RAID 0 using MDADM or LVM over multiple Azure Premium Storage disks. And use the RAID volumes as **/hana/data** and **/hana/log** volumes.

**Recommendation**: As stripe sizes for the RAID 0 the recommendation is to use:

-   64 KB or 128 KB for **/hana/data**

-   32 KB for **/hana/log**

> **Note**: You don't need to configure any redundancy level using RAID volumes since Azure Premium and Standard storage keep three images of a VHD. The usage of a RAID volume is purely to configure volumes that provide sufficient I/O throughput.



## Azure ultra disk storage for SAP HANA

Microsoft is in the process of rolling out a new Azure storage type called Azure Ultra disk. The significant difference between Azure storage offered so far and Ultra disk is that the disk capabilities are not bound to the disk size anymore. As a customer you can define these capabilities for Ultra disk:

- Size of a disk ranging from 4 GiB to 65,536 GiB

- IOPS range from 100 IOPS to 160K IOPS (maximum depends on VM types as well)

- Storage throughput from 300 MB/sec to 2,000 MB/sec

