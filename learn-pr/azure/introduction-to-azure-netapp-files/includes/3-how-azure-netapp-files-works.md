Here, we discuss how Azure NetApp Files works behind the scenes. You learn about the main pieces of Azure NetApp Files and how they work together to provide a high-performance cloud NAS service. This knowledge helps you evaluate whether Azure NetApp Files is a good solution for migrating your organization's file-based workloads to the Azure cloud.

In this unit, you learn about:

- Azure NetApp Files storage hierarchy.
- How Azure NetApp Files migrations work.
- Connectivity to Azure NetApp Files storage.

## Storage hierarchy

One of the most important components of Azure NetApp Files is the storage hierarchy, which determines how much storage your workloads get and the maximum available throughput. Understanding these concepts is crucial to helping you decide if and how you want to migrate any on-premises workloads to Azure.

:::image type="content" source="../media/3-what-is-azure-netapp-files-storage-hierarchy.png" alt-text="Diagram depicting the storage hierarchy of Azure NetApp Files, with the Azure subscription and one or more Azure NetApp Files accounts, each of which has one or more capacity pools, each of which has one or more storage volumes." lightbox="../media/3-what-is-azure-netapp-files-storage-hierarchy.png":::

Azure NetApp Files storage hierarchy consists of the following elements:

- Capacity pool. A provisioned amount of storage to use. In Azure NetApp Files, the minimum capacity pool size is 4 tebibytes (TiB) and the maximum capacity pool size is 500 TiB.
- Volume. Storage space within a capacity pool. For example, you can divide a 4-TiB capacity pool into four 1-TiB volumes or eight 500 gibibyte (GiB) volumes, and so on. In Azure NetApp Files, the minimum volume size is 100 GiB and the maximum volume size is 100 TiB.
- Throughput. The maximum rate at which data can enter or leave a capacity pool, measured in mebibyte (MiB) per second.
- Multiple service levels. Azure NetApp Files offers three service levels for the capacity pools you create:
  - Standard. Provides up to 16 MiB/s of throughput per 1 TiB of capacity provisioned and 320,000 IOPS. Use Standard for static web content, file shares, and database backups.
  - Premium. Provides up to 64 MiB/s of throughput per 1 TiB of capacity provisioned and 450,000 IOPS. Premium is comparable to mainstream SSD performance and is suitable for SAP HANA, databases, enterprise apps, virtual desktop infrastructure (VDI), analytics, technical applications, and messaging queues.
  - Ultra. Provides up to 128 MiB/s of throughput per 1 TiB of capacity provisioned and 450,000 IOPS. Use Ultra for the most performance-intensive applications, such as HPC applications.
- Quality of service (QoS): Azure NetApp Files defines two types of QoS for capacity pools:
  - Auto. Azure NetApp Files automatically assigns a total throughput for each volume based on the service tier and the volume capacity. For example, a Standard tier 2-TiB volume is automatically assigned a maximum throughput of 32 MiB/s (16 MiB/s x 2).
  - Manual. You assign the throughput you need for a volume. For example, a Standard tier 8-TiB capacity pool has a total available throughput of 128 MiB/s (16 MiB/s x 8). For a 2-TiB volume within that capacity pool, you could assign a throughput of around 64 MiB/s, assuming that much throughput is still available after provisioning the capacity pool's other volumes.

> [!TIP]
> If you need a certain level of throughput for a particular workload in an automatic QoS volume, you can *overprovision* the volume. For example, suppose a Premium tier volume with automatic QoS only requires 1 TiB of storage, but 128 MiB/s of throughput. By default, the volume's throughput will be just 64 MiB/s. To get the 128 Mib/s you need, you can overprovision the volume to 2 TiB.

## Setting up Azure NetApp Files for a migration

Preparing Azure NetApp Files for a migration from your datacenter involves several steps. The following steps give you an overview of the process:

1. Decide on the service tier you need for your workload (Standard, Premium, or Ultra).
1. Set up a capacity pool that uses the tier you chose and is large enough to handle the workload.
1. Delegate a subnet of your Azure virtual network to Azure NetApp Files.
1. Create the volumes needed by each component of your workload.

For example, suppose your organization uses SAP with the HANA database and you want to set up Azure NetApp Files to migrate this workload to the cloud. For SAP HANA, the Premium tier is a good place to start. For maximum flexibility, use a manual QoS capacity pool so that you can assign the capacity and throughput for a volume independently. The total throughput that you can assign to volumes in a manual QoS capacity pool is determined by multiplying the capacity pool size by the service level throughput value per TiB. For instance, a 20-TiB capacity pool with the Premium service level has a total throughput capacity of 1280 MiB/s (64 MiB/s x 20) available for the volumes.

In the SAP HANA migration scenario, this capacity pool can be used to create the following volumes.

|**Volume**  |**Size**  |**Max. throughput**  |
| --- | --- | --- |
|Data     | 4 TiB        | 704 MiB/s        |
|Log     | 500 GiB        | 256 MiB/s        |
|Shared     | 1 TiB        | 64 MiB/s        |
|Backup     | 4.5 TiB        | 256 MiB/s        |


:::image type="content" source="../media/3-what-is-azure-netapp-files-example.png" alt-text="Illustration of the scenarios for the SAP HANA volumes with a graph comparing the relative size and throughput for each of the four volumes in the SAP HANA migration scenario." lightbox="../media/3-what-is-azure-netapp-files-example.png":::

After your volumes are set up, you can use any of the following tools to migrate data to Azure NetApp Files:

- NetApp Cloud Sync
- rsync (for NFS volumes)
- robocopy (for SMB volumes)

## Connectivity to Azure NetApp Files

A key consideration when evaluating whether to migrate on-premises workloads to Azure NetApp Files is how your existing applications, services, and users connect to the data in its new location. When you create an instance of Azure NetApp Files, you assign the instance to a delegated subnet. A *delegated subnet* is a subnet that's configured with permissions to create resources that are specific to a service, which in this case is Azure NetApp Files. How network nodes connect to Azure NetApp Files in that subnet depends on where those nodes are located. There are three main scenarios to consider:

- Connectivity in the same virtual network. Any resource running on an Azure virtual machine in the same virtual network that contains the delegated subnet can connect to the file storage provided by Azure NetApp Files. In the diagram that follows this list, both VM 3 and Azure NetApp Files Volume 1 reside in the Hub virtual network, so VM 3 has direct access to Volume 1.
- Connectivity in a peered virtual network. Any resource running on an Azure virtual machine in a virtual network that's peered to the network containing the delegated subnet can connect to the file storage provided by Azure NetApp Files. In the diagram that follows this list:
  - The Spoke 1 virtual network is peered to the Hub virtual network, so VM 4 has peered access to Azure NetApp Files Volume 1.
  - The Spoke 2 virtual network is peered to the Hub virtual network, so VM 5 has peered access to Azure NetApp Files Volume 1.
  - The Spoke 1 and Spoke 2 virtual networks aren't peered to each other, so VM 4 can't access Azure NetApp Files Volume 3 and VM 5 can't access Azure NetApp Files Volume 2.
- Connectivity in a hybrid network. Any resource running in an on-premises network that's connected to the Azure virtual network that contains the delegated subnet via VPN or ExpressRoute can connect to the file storage provided by Azure NetApp Files. In the diagram that follows this list, the on-premises network is connected to the Azure Hub virtual network via a VPN gateway. Enabling the following scenarios:
  - A resource in the on-premises network has gateway access to any Azure NetApp Files volume in the gateway's virtual network. For example, VM 2 in the on-premises network can connect to Azure NetApp Files Volume 1.
  - A resource in the on-premises network has gateway access to any Azure NetApp Files volume in a peered virtual network. For example, VM 1 in the on-premises network can connect to Azure NetApp Files Volume 2 (and VM 2 can connect to Azure NetApp Files Volume 3).

:::image type="content" source="../media/3-how-azure-netapp-files-works-topology.png" alt-text="Diagram depicting the three types of network connectivity supported by Azure NetApp Files." lightbox="../media/3-how-azure-netapp-files-works-topology.png":::

> [!IMPORTANT]
> Azure NetApp Files only supports peered connectivity in the same region. It doesn't support cross-region peering or global peering.
