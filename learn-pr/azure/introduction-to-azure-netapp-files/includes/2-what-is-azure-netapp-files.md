<!-- 1. Topic sentence(s) ---------------------------------------------------------------

    Goal: briefly state that this unit will define the product.

    Heading: none

    Example: "Let's start with a few definitions and a quick tour of the core features of Logic Apps. This overview should help you see whether Logic Apps might be a good fit for your work."
-->
Let's start with a quick tour of Azure NetApp Files, including what it is and what are its core features. This overview should help you decide whether Azure NetApp Files will enable you to migrate your on-premises workloads to the cloud.

<!-- 2. Background-concept definitions (optional) ----------------------------------------

    Goal:
        Define any needed underlying concepts or terms the learner must know to understand the product.
        Repeat this pattern multiple times if multiple concepts are needed.

    Heading:
        "## What is <concept>?"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "<concept> is..." (ensure this is a definition, do not give use cases like "<concept> lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        (Note: the product "Logic Apps" implements business processes in the cloud; therefore, "business process" is a background concept.)
        Heading: "What is a business process?
        Lead sentence: "A business process or _workflow_ is a sequence of tasks that produce a specific outcome. The result might be a decision, some data, or a notification...."
-->

## What is shared file storage?

Many modern applications use one of the following storage technologies:

- **Block storage**: Data is divided into discrete chunks called *blocks* and stored on disk at the sector and track level.
- **Object storage**: Information is stored as unstructured data with no hierarchy.

However, most organizations still have many applications and services that require shared access to files stored using a file system that enables hierarchical access to the data. *Shared file storage* is a way of storing file-based data in a networked environment so that the files are available to servers, applications, and users over the network. Most shared file storage is composed of network-attached storage (NAS) devices that use a shared file system.

There are two main file system protocols used for most shared file storage implementations:

- **Network File System (NFS)**: Most often used with Linux and similar Unix-like operating systems.
- **Server Message Block (SMB)**: Most often used with Windows operating systems.

<!-- 3. Define the product -------------------------------------------------------------

    Goal:
        Give a formal and precise definition of the product.

    Heading:
        "## <product> definition"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "<product> is..." (ensure this is a definition, do not give use cases like "<product> lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "Azure Logic Apps definition"
        Lead sentence: "Azure Logic Apps is a cloud service that automates the execution of your business processes."
-->

## Azure NetApp Files definition

Azure NetApp Files is an enterprise-class, high-performance, fully managed NAS service for shared file storage. The service is built on NetApp hardware running NetApp's OnTap storage operating system located within Azure data centers. Azure NetApp Files is a first-party service, meaning you deploy and manage it through the Azure portal.

### Storage hierarchy

One of the most important components of Azure NetApp Files is the storage hierarchy, which determines how much storage your workloads get and the maximum available throughput. Understanding these concepts is crucial to helping you decide if and how you want to migrate any on-premises workloads to Azure. The following image gives you an overview of the Azure NetApp Files storage hierarchy.

:::image type="content" source="../media/2-what-is-azure-netapp-files-storage-hierarchy.png" alt-text="Diagram depicting the storage hierarchy of Azure NetApp Files, with the Azure subscription at the top, then one or more Azure NetApp Files accounts, each of which has one or more capacity pools, each of which has one or more storage volumes.":::

Azure NetApp Files storage hierarchy consists of the following elements:

- **Capacity pool**: A provisioned amount of storage to use. In Azure NetApp Files, the minimum capacity pool size is 4 TiB.
- **Volume**: A division of a capacity pool. For example, you can divide a 4-TiB capacity pool into four 1-TiB volumes or eight 500-GiB volumes (and so on).
- **Throughput**: The maximum rate at which data can enter or leave a capacity pool, usually measured in MiB/s.
- **Multiple service levels**: Azure NetApp Files offers three service levels for the capacity pools you create:
  - *Standard*: Provides up to 16 MiB/s of throughput per 1 TiB of capacity provisioned. Use Standard for static web content, file shares, and database backups.
  - *Premium*: Provides up to 64 MiB/s of throughput per 1 TiB of capacity provisioned. Premium is comparable to mainstream SSD performance and is suitable for SAP HANA, databases, enterprise apps, virtual desktop infrastructure (VDI), analytics, technical applications, and messaging queues.
  - *Ultra*: Provides up to 128 MiB/s of throughput per 1 TiB of capacity provisioned. Use Ultra for the most performance-intensive applications, such as those found in high-performance computing (HPC).
- **Quality of service (QoS)**: Azure NetApp Files defines two types of QoS for capacity pools:
  - *Auto*: Azure NetApp Files automatically assigns a total throughput for each volume based on the service tier and the volume capacity. For example, a Standard tier 2-TiB volume is automatically assigned a maximum throughput of 32 MiB/s (16 MiB/s x 2).
  - *Manual*: You assign the throughput you need for a volume. For example, a Standard tier 8-TiB capacity pool has a total available throughput of 128 MiB/s (16 MiB/s x 8). For a 2-TiB volume within that capacity pool, you could assign a throughput of, say, 64 MiB/s (assuming that much throughput is still available after provisioning the capacity pool's other volumes).

> [!TIP]
> If you need a certain level of throughput for a particular workload in an automatic QoS volume, you can *overprovision* the volume. For example, suppose a Premium tier volume with automatic QoS only requires 1 TiB of storage, but 128 MiB/s of throughput. By default, the volume's throughput will be just 64 MiB/s. To get the 128 Mib/s you need, you can overprovision the volume to 2 TiB.

### Other features

Here are a few other important Azure NetApp Files features to consider when evaluating the product for your organization:

- **High performance**: With very high input/output operations per seconds (IOPS) and sub-millisecond latency, Azure NetApp Files provides performance that is comparable to or even better than on-premises performance.
- **High availability**: The Azure NetApp Files service level agreement (SLA) guarantees at least 99.99% availability.
- **Multiple NAS protocols**: Azure NetApp Files offers the widest choice of file protocols among public cloud NAS providers. Azure NetApp Files supports all of the following:
  - NFS 3.0
  - NFS 4.1
  - SMB 1
  - SMB 2.x
  - SMB 3.x
- **Dual protocol volumes**: Azure NetApp Files supports creating volumes that can use both NFS 3.0 and SMB at the same time. Using both protocols on a volume enables both Linux- and Windows-based enterprise applications that rely on file-based datasets to simultaneously access and share that data.
- **Data management**: Azure NetApp Files offers a complete range of data management features, including near-instantaneous snapshots, cloning, and integrated cross-region replication, all  without impacting performance.

<!-- 4. Solve the scenario -------------------------------------------------------------

    Goal:
        At a high level, describe how the <product> solves one of the customer tasks in your <scenario>.
        Avoid teaching how to actually do the work (you're not teaching how-to-use in this module).

    Heading:
        "## How to <solve scenario>"

    Pattern:
        1. H2 heading.
        2. Lead sentence that summarizes how the <product> solved the <scenario>.
        3. Additional text as needed (typically 1-2 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "How to implement a Twitter monitor"
        Lead sentence: "To implement a Twitter monitor, you map each task to a Logic Apps component and connect them with conditional logic."
-->

## How to set up Azure NetApp Files for an SAP HANA migration

Getting Azure NetApp Files ready for a migration from your data center involves several steps, but the following steps give you an overview of the process:

1. Decide on the service tier you need for your workload (Standard, Premium, or Ultra).
1. Set up a capacity pool that uses the above tier and is large enough to handle the workload.
1. Delegate a subnet of your Azure virtual network to Azure NetApp Files.
1. Create the volumes needed by each component of your workload.

For example, suppose your organization uses SAP with the HANA database and you want to set up Azure NetApp Files to migrate this workload to the cloud.

For SAP HANA, the Premium tier is a good place to start. For maximum flexibility, use a manual QoS capacity pool so that you can assign the capacity and throughput for a volume independently. The total throughput that you can assign to volumes in a manual QoS capacity pool is given by multiplying the capacity pool size by the service level throughput value per TiB. For instance, a 20-TiB capacity pool with the Premium service level has a total throughput capacity of 1280 MiB/s (64 MiB/s x 20) available for the volumes.

In the SAP HANA migration scenario, this capacity pool can be used to create the following volumes:

|Volume  |Size  |Max. throughput  |
|---------|---------|---------|
|Data     | 4 TiB        | 704 MiB/s        |
|Log     | 500 GiB        | 256 MiB/s        |
|Shared     | 1 TiB        | 64 MiB/s        |
|Backup     | 4.5 TiB        | 256 MiB/s        |

The following diagram illustrates the scenarios for the SAP HANA volumes.

:::image type="content" source="../media/2-what-is-azure-netapp-files-scenario.png" alt-text="Diagram depicting a graph showing the relative size and throughput for each of the four volumes in the SAP HANA migration scenario.":::

<!-- 5. Additional content (optional, as needed) ------------------------------------------------

    Goal:
        The section is a catch-all for any information not covered in the sections above.
        Repeat the pattern here as many times as needed.

    Possible topics:
        - Key feature(s).
        - Example use case in addition to the scenario.
        - High-level of how practitioners use the product (e.g. there's an API and a web UI to support multiple use cases).
        - Business value (e.g. it lets you do something that would be difficult to achieve without <product>).

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote (image preferred).

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple topic -->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->