

Azure VMs constitute the primary infrastructure as a service (IaaS) compute service offerings available in Azure. When compared with other compute services, Azure VMs provide the greatest degree of control over the configuration of the virtual machine and its operating system. Users can configure the operating system running within a VM manually (or in an automated manner) by using Virtual Machine Extensions (VM Extensions), which rely on such technologies as Windows PowerShell scripts, Desired State Configuration (DSC), Chef, or Puppet. 


Azure VMs share most of their characteristics with the Microsoft Hyper V virtual machines that customers deploy in their on-premises datacenter. However, several important differences exist between them.

Azure VMs that users provision are available in specific sizes. Users cannot specify an arbitrary amount of processing, memory, or storage resources when deploying an Azure VM. Instead, they must select one of the predefined choices. This restriction does not impose significant constraints, since Microsoft offers a wide range of virtual machines sizes. The sizes are grouped into several categories, including the following categories: 

* **General purpose** (including the B, Dsv3, Dv3, DSv2, Dv2, Av2, and DC sizes) providing balanced CPU-to-memory ratio, ideal for testing and development, small to medium databases, and low to medium traffic web servers.

* **Compute optimized** (including the Fsv2 size) providing high CPU-to-memory ratio, good for medium traffic web servers, network appliances, batch processes, and application servers.

* **Memory optimized** (including the Esv3, Ev3, M, GS, G, DSv2, Dv2 sizes) providing high memory-to-CPU ratio, great for relational database servers, medium to large caches, and in-memory analytics.

* **Storage optimized** (including the Lsv2 and Ls sizes) providing high disk throughput and IO, ideal for Big Data, SQL, NoSQL databases, data warehousing, and large transactional databases.

* **GPU** (including the NV, NVv2, NC, NCv2, NCv3, ND, and NDv2 sizes) providing specialized virtual machines targeted for heavy graphic rendering and video editing, as well as model training and inferencing (ND) with deep learning, available with single or multiple GPUs.

* **High performance compute** (including the H size) providing the fastest and most powerful CPU Azure VMs with optional high-throughput network interfaces (RDMA).

Every individual VM size represents a combination of the following capacity characteristics:

* **Number of vCPUs**    

* **Amount of memory**

* **Maximum number of data disks**

* **Maximum network and storage throughput**    

There is a 2 terabyte (TB) size limit on a virtual disk hosting the operating system of an Azure VM and a 32-TB size limit on any additional virtual disk that users attach to an Azure VM (Ultra SSD disks, in preview at the time of authoring of this content, will offer disk sizes of up to 64 TB). Please note that this doesn't imply a limit on the size of data volumes. Users can create multiple-disk volumes by using Storage Spaces in Windows Server or volume managers, such as Logical Volume Manager (LVM) in Linux. Considering that the largest Azure VM size supports up to 64 data disks, this flexibility allows users to create petabyte (PB) size volumes. The maximum volume size depends on the size of the virtual machine, which determines the maximum number of disks that can be attached to a virtual machine.

A limit also exists on the throughput and input/output operations per second (IOPS) that individual disks support. With Standard HDD storage, users can expect about 60 megabytes per second (MBps) or 500 8 kilobyte (KB) IOPS. With Azure Premium SSD storage, performance depends on the disk size, with 32-TB disks supporting up to 900 MBps and 20,000 256-KB IOPS (Ultra SSD storage will offer 2,000 MBps and 160,000 IOPS per disk, regardless of its size). 

## Azure VMs for SAP
In general, there are three options when deploying SAP products in Azure:

* **Azure VMs**: There is a growing number of Azure VM SKUs certified for hosting SAP HANA including GS5 and a number of M family VM sizes (with M208ms_v2, featuring 5.7 TiB of memory and with M128s supporting scale-out configuration). There is also much larger selection of Azure VM SKUs that support non-HANA workloads (NetWeaver and non-NetWeaver products).

* **SAP HANA on Azure (Large Instances)**: There are several SKUs ranging from 2 TiB per node (S192 with scale-out support) to 20 TiB per node (S960m). Two different classes of hardware divide the SKUs into:

    * S72, S72m, S96, S144, S144m, S192, S192m, and S192xm, which are referred to as the "Type I class" of SKUs.

    * S384, S384m, S384xm, S384xxm, S576m, S576xm S768m, S768xm, and S960m, which are referred to as the "Type II class" of SKUs.

* **SAP Cloud Appliance Library (CAL)**: SAP CAL offers pre-configured software appliances on different public clouds, including Azure. The primary benefit of SAP CAL is that it provides an easy way to deploy and test pre-configured SAP solutions offered by SAP without having to provision underlying infrastructure. SAP CAL on Azure includes support for SAP S/4HANA or BW/4HANA. 