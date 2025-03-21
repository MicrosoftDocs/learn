Azure Virtual Machines make up the primary infrastructure as a service (IaaS) compute service offerings available in Azure. When compared with other compute services, Azure Virtual Machines provide the greatest degree of control over the configuration of the virtual machine and its operating system. You can configure the operating system running within a virtual machine manually or in an automated manner, by using Virtual Machine Extensions (VM Extensions), which rely on such technologies as Windows PowerShell scripts, Desired State Configuration (DSC), Chef, or Puppet.

Azure Virtual Machines share most of their characteristics with the Microsoft Hyper V virtual machines that customers deploy in their on-premises datacenter. However, several important differences exist between them.

Azure Virtual Machines that you deploy are available in specific sizes. You can't specify arbitrary amounts of processing, memory, or storage resources when deploying an Azure Virtual Machine. Instead, you must select one of the predefined choices. This restriction doesn't impose significant constraints, since Microsoft offers a wide range of virtual machine sizes. The sizes are grouped into several categories, including the following virtual machine sizes:

- **General purpose** (including the B, Dsv3, Dv3, DSv2, Dv2, Av2, and DC sizes) providing balanced CPU-to-memory ratio, ideal for testing and development, small to medium databases, and low to medium traffic web servers.
- **Compute optimized** (including the Fsv2 size) providing high CPU-to-memory ratio, good for medium traffic web servers, network appliances, batch processes, and application servers.
- **Memory optimized** (including the Esv3, Ev3, M, GS, G, DSv2, Dv2 sizes) providing high memory-to-CPU ratio, great for relational database servers, medium to large caches, and in-memory analytics. The M-family is effective for running in-memory databases like SAP HANA that require large amounts of RAM for real-time data processing and analytics.
- **Storage optimized** (including the Lsv2 and Ls sizes) providing high disk throughput and IO, ideal for Big Data, SQL, NoSQL databases, data warehousing, and large transactional databases.
- **GPU** (including the NV, NVv2, NC, NCv2, NCv3, ND, and NDv2 sizes) providing specialized virtual machines targeted for heavy graphic rendering and video editing, as well as model training and inferencing (ND) with deep learning, available with single, or multiple GPUs.
- **High performance compute** (including the H size) providing the fastest and most powerful CPU Azure Virtual Machines with optional high-throughput network interfaces (RDMA).

Every individual virtual machine size represents a combination of the following capacity characteristics:

- **Number of vCPUs**
- **Amount of memory**
- **Maximum number of data disks**
- **Maximum network and storage throughput**

## Key Features and Benefits for M-series VM Medium Memory and High Memory Series Azure Virtual Machines

**Medium Memory Series:** The Msv3 and Mdsv3 Medium Memory Virtual Machine series deliver:

- Memory sizes of up to 4 TB.
- Up to 4,000-MBps throughput to remote storage.

**High Memory Series:** The Msv3 and Mdsv3 High Memory, memory-optimized VM sizes deliver:

- Memory sizes ranging from 6 TB to 16 TB.
- Up to 8,000-MBps throughput to remote storage.

**Common Benefits:** Both the Msv3 and Mdsv3 Medium Memory & High Memory Virtual Machine series deliver:

- Up to 25% networking performance improvement over previous generations.
- Faster performance, lower total cost of ownership, and improved resilience to failures compared to the previous generation, Mv2-series VMs.

Information regarding performance characteristics (including maximum uncached disk throughput and the expected network bandwidth) are available in [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).

There's a 2 terabytes (TB) size limit on a virtual disk that hosts the operating system of an Azure Virtual Machine. Any additional virtual disk attached to an Azure Virtual Machine has a size limit of 32 TB, while Ultra SSD disks offer disk sizes of up to 64 TB. The 2 terabytes (TB) size limit doesn't imply a limit on the size of data volumes. You can create multiple-disk volumes by using Storage Spaces in Windows Server or volume managers, such as using Logical Volume Manager (LVM) in Linux. Considering that the largest Azure Virtual Machine size supports up to 64 data disks, and allows you to create petabyte (PB) size volumes. The maximum volume size depends on the size of the virtual machine, which determines the maximum number of disks you can attach to that virtual machine.

A limit also exists on the throughput and input/output operations per second (IOPS) that individual disks support. With Standard HDD storage, you should expect about 60 megabytes per second (MBps) or 500 8-kilobyte (KB) IOPS. With Azure Premium SSD storage, performance depends on the disk size, with 32-TB disks supporting up to 900 MBps and 20,000 256-KB IOPS (Ultra SSD storage offers 2,000 MBps and 160,000 IOPS per disk, regardless of its size). If you need to increase per-volume performance beyond these limits, you can create multiple-disk volumes.

> [!NOTE]
> At the time of writing, any virtual disks that you intend to attach to Azure Virtual Machines must be in the .vhd format. There's also no support for Generation 2 Hyper V virtual machines in Azure. Additionally, no support exists for dynamically expanding or differencing virtual disks—they all must be fixed.

## Optional demos

- [Demonstration: Explore the Azure portal](https://go.microsoft.com/fwlink/?linkid=2261105&clcid=0x409)
- [Demonstration: Create a virtual machine in the portal](https://go.microsoft.com/fwlink/?linkid=2261103&clcid=0x409)
- [Demonstration: Connect to Linux virtual machines](https://go.microsoft.com/fwlink/?linkid=2261009&clcid=0x409)
- [Demonstration: Create and delete resource groups](https://go.microsoft.com/fwlink/?linkid=2260567&clcid=0x409)
- [Demonstration: Experiment with the Cloud Shell](https://go.microsoft.com/fwlink/?linkid=2260473&clcid=0x409)
- [Demonstration: Work with Azure CLI locally](https://go.microsoft.com/fwlink/?linkid=2260918&clcid=0x409)
- [Demonstration: Work with PowerShell locally](https://go.microsoft.com/fwlink/?linkid=2260815&clcid=0x409)
- [Demonstration: Create a virtual machine with PowerShell](https://go.microsoft.com/fwlink/?linkid=2261104&clcid=0x409)
