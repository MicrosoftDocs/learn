There are four main components to the HPC system: Compute, Storage, Networking, and Visualization.

## Compute

High-performance computing resources are offered at nearly unlimited scale on Azure. You can use the different H-series, N-series and Cray for memory, graphic and managed applications.

* __H-series virtual machines__ for memory-bound applications
* __N-series virtual machines__ for graphic intensive and CUDA/OpenCL based applications
* __Cray__ for a fully dedicated and customized supercomputer delivered as a managed service

![Diagram of Azure computing.](../media/6-azure-computing.png)

## Storage

The highly secure cloud storage is available to customers at a massive scale and it allows HPC applications to use it efficiently customizing with either HPC Cache or Azure NetApp files or Cray ClusterSor.

* Burst your HPC applications into Azure using data stored in on-premises NAS devices with __HPC Cache__
* Access large amounts of I/O with a submillisecond latency with __Azure NetApp Files__, delivered as an Azure service natively within an Azure datacenter
* For a high throughput storage solution, use __Cray ClusterSor__, a Lustre-based, bare-metal HPC storage solution that’s fully integrated with Azure

![Diagram of Azure storage.](../media/7-azure-storage.png)

## Networking

Azure allows you to create private virtual networks in the cloud, which simplifies the network architecture and secures the connection between endpoints by disabling the data exposure to the public internet.

* Establish private, secure tunnels for hybrid cloud connectivity using Azure ExpressRoute
* Take advantage of Linux remote direct memory access (RDMA) with InfiniBand for message passing interface (MPI) workloads within your datacenter

![Diagram of Azure networking.](../media/8-azure-networking.png)

## Visualization

Run visualization workloads with HPC and Azure Virtual Machines that boost productivity, reduces costs, and has flexible deployments.

* Visualize simulation data and run streaming, gaming, encoding, and VDI scenarios on GPU-powered __Azure NV-series Virtual Machines (VMs)__
* For the most extreme GPU-accelerated graphics applications, such as 3D CAD modeling, 3D rendering, and scientific visualization, use high-performance __NVv3-series VMs__  
  * NVv3 VMs support premium storage and come with twice the system memory (RAM) as earlier NV VMs

![Diagram of Azure visualization.](../media/9-azure-visualization.png)

## Mapping Azure VM and Storage products to components in an HPC system

### Azure Compute Virtual Machine Solutions  

#### VMs with low latency (HPC SKUs)

The H-series and N-series VMs that are RDMA capable and can communicate over the low latency and high bandwidth InfiniBand network. The RDMA capability over such an interconnect is critical to boost the scalability and performance of distributed-node HPC and AI workloads

#### VMs with accelerators

|   **CPU**    |  **GP-GPU**    | **VISUAL**   |
| :------------------- | :-------------------  | :------------------- |
| __HB-series__ VMs are optimized for applications that are memory intensive, such as fluid dynamics, explicit finite element analysis, and weather modeling <br><br>__HC-series__ VMs are optimized for applications that are compute intensive, such as molecular dynamics, implicit finite element analysis, and computational chemistry <br><br><br>| __NC-series__ VMs are powered by the NVIDIA Tesla K80 card and the Intel Xeon E5-2690 v3 (Haswell) processor. Users can crunch through data faster by using CUDA for energy exploration applications, crash simulations, ray traced rendering, deep learning, and more. <br><br> __ND-series__ VMs are a new addition to the GPU family designed for AI, and deep learning workloads. It offers configuration with a secondary low-latency, high-throughput network through RDMA, and InfiniBand connectivity enables running of large-scale training jobs spanning many GPUs.| __NV-series__ VMs are made for desktop accelerated applications and virtual desktops where customers are able to visualize their data or simulations. Enables users to visualize their graphics intensive workflows on the NV instances to get a superior graphics capability and additionally run single precision workloads such as encoding and rendering.<br><br><br><br><br><br><br>|

### Azure Storage Solutions

* __Azure Blob Storage__
  * Allows massively scalable and secure object storage for cloud-native workloads, archives, data lakes, high-performance computing, and machine learning. It's scalable and optimized for data lakes with comprehensive data management.

  * Key design includes features
    * Serving images or documents directly to a browser.
    * Storing files for distributed access.
    * Streaming video and audio.
    * Writing to log files.
    * Storing data for backup and restore, disaster recovery, and archiving.
    * Storing data for analysis by an on-premises or Azure-hosted service.

* __Azure Netapp Files__
  * Makes it easy for enterprise line-of-business and storage professionals to migrate and run complex, file-based applications with no code change. It's used as the underlying shared file-storage service in various scenarios such as, lift-shift migration of POSIX compliant Linux and Windows applications, SAP HANA, databases, and enterprise web applications.

  * Key benefits include
    * 99.99% availability, High-performance, Secure.  
    * PaaS service – easy to use and manage.  
    * Online scale up/down size and/or service levels.  
    * Data protection using Cross-Region replication.  
    * Advanced Enterprise Data Management features.

* __Azure Files__
  * Azure Files offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) protocol or Network File System (NFS) protocol
    * Can be mounted concurrently by cloud or on-premises deployments.
    * Azure Files SMB file shares are accessible from Windows, Linux, and macOS clients.
    * Azure Files NFS file shares are accessible from Linux or macOS clients.
    * Also, Azure Files SMB file shares can be cached on Windows Servers with Azure File Sync for fast access near where the data is being used.

  * Useful for
    * Replace or supplement on-premises file servers
    * Lift and shift applications
    * Simplify cloud development
    * Containerization

  * Key benefits include:
    * Shared access
    * Fully Managed
    * Scripting and Tooling
    * Resiliency
    * Familiar Programmability

* __Azure HPC Cache__
  * Azure HPC Cache speeds access to your data for high-performance computing (HPC) tasks.
    * By caching files in Azure, Azure HPC Cache brings the scalability of cloud computing to your existing workflow.
    * Can be used even for workflows where your data is stored across WAN links, such as in your local datacenter network-attached storage (NAS) environment.

  * When to use:
    * Read-heavy file access workflow
    * Data stored in NFS-accessible storage, Azure Blob, or both
    * Compute farms of up to 75,000 CPU cores

  * Key benefits include:
    * Easy to launch and monitor from the Azure portal. Existing NFS storage or new Blob containers can become part of its aggregated namespace, which makes client access simple even if you change the back-end storage target.
    * High performance with up to 8 GB/s throughput, reducing latency for cacheable workloads
    * Scalable to meet changing compute demand
    * Aggregated namespace bringing together multiple file sources

* __VM-based file systems__
  * Single VM NAS
    * Cloud-based Network Attached Storage (NAS) helps you address storage needs in the cloud using the same constructs as an on-premises NAS system.
    * Gives organizations storage that’s as performant as their on-premises NAS with the added ability to scale in the cloud—and all without having to make major changes to their existing application interfaces and processes.
      * NAS is a centralized storage appliance that allows applications and services to access data from a centralized location in the network.
      * Virtual NAS is the virtual appliance version of NAS systems that can run on virtualization platforms such as VMware, Hyper-V, etc.

  * Key benefits include:  
    * Network devices accessing Virtual NAS storage can continue to do so using the same protocols without any reconfiguration.
    * Capacity management is also easier since any required storage can be allocated from the underlying virtualization layer.

  * Multi-node parallel file systems
    * Parallel file systems distribute block level storage across multiple networked storage nodes.
    * File data is spread among these nodes, meaning file data is spread among multiple storage devices. It pools any individual storage I/O requests across multiple storage nodes that are accessible through a common namespace.
    * Multiple storage devices and multiple paths to data are utilized to provide a high degree of parallelism, reducing bottlenecks imposed by accessing only a single node at a time.
    * Parallel file systems are broken up into two main pieces:
      * Metadata services - Store namespace metadata, such as filenames, directories, access permissions, and file layout. Based on the parallel file system, metadata services are provided as an integrated part of an overall storage node distribution or through a separate server cluster.
      * Object storage - Object storage contains actual file data. Clients pull the location of files and directories from the metadata services, then access file storage directly.
    * The advantages of distributed storage and superior I/O performance make parallel file systems preferable to NFS in most HPC scenarios, particularly when it comes to shared working storage space

    ![Diagram of Azure object storage.](../media/10-azure-object-storage.png)

* __Cray ClusterStor__
  * The Cray ClusterStor in Azure storage system is a high capacity and high throughput storage solution to accelerate your HPC simulations.

  * It's a bare metal appliance that is fully integrated in the Azure fabric and accessible by a large selection of other Azure services.

  * Cray ClusterStor in Azure offers a Lustre-based, single-tenant, bare metal and fully managed HPC environment in Microsoft Azure.

  * Key benefits include:
    * Can be used with Cray XC and CS series supercomputers and also now supports data processing of HPC jobs executed on H-series virtual machines from Azure.  
    * Can move your data within Azure from high-performance scratch, to warm Azure blob storage and cold archive storage.  
    * Get access to high performance and capacity during simulation. Move post-simulation data to a redundant, less-expensive cloud storage solution, to either be easily distributed or made available for your next simulation.
    * Enables more than three times the throughput in GB/sec per Lustre Object Storage Servers (OSS) than the currently available Lustre offer.
