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

- **Network File System (NFS)**: Most often used with the Linux operating system.
- **Server Message Block (SMB)**: Most often used with the Windows operating system.

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

Azure NetApp Files is an enterprise-class, high-performance, fully managed NAS service for shared file storage. Azure NetApp Files is a first-party service, meaning you deploy and manage it through the Azure portal.

## Performance

Azure NetApp Files is designed for the highest possible performance so that it can handle even the most demanding Windows and Linux workloads. This performance is achieved by running Azure NetApp Files instances on dedicated NetApp hardware running NetApp's proprietary ONTAP operating system, which is optimized for extremely high storage throughput and availability.

Azure NetApp Files performance is measured in two ways:

- **Input/output operations per second (IOPS)**: IOPS is a storage performance benchmark that measures the average number of read and write operations a storage device can perform per second. Azure NetApp Files offers up to 320,000 IOPS on its lowest performance tier, and up to 450,000 IOPS on its highest tiers. For comparison, most solid-state drives have throughput measurements between 100,000 IOPS and 400,000 IOPS.
- **Latency**: Latency is the time required to access a particular storage location. Azure NetApp Files offers an average latency of less than 1 millisecond (ms). For comparison, regular hard drives have latencies between 1 ms and 10 ms, while solid-state drives have latencies between 0.05 ms and 0.15 ms.

Given these measures, you can understand why Azure NetApp Files provides performance that is comparable to or even better than on-premises performance.

## Security and compliance

Azure NetApp Files is purpose-built to offer high levels of security, compliance, and availability:

- **Security**: Azure NetApp Files offers FIPS-140-2-compliant data encryption at rest, role-based access control (RBAC), Active Directory authentication, and export policies for network-based access control lists (ACLs).
- **Compliance**: Azure NetApp Files complies with leading industry certifications, such as HIPAA and GDPR.
- **Availability**: The Azure NetApp Files service level agreement (SLA) guarantees at least 99.99% availability.

## Protocols

Azure NetApp Files offers the widest choice of file protocols among public cloud NAS providers. Azure NetApp Files supports all of the following:

- NFS 3.0
- NFS 4.1
- SMB 1
- SMB 2.x
- SMB 3.x

Azure NetApp Files also supports creating volumes that can use both NFS 3.0 and SMB at the same time. Using both protocols on a volume enables both Linux- and Windows-based enterprise applications that rely on file-based datasets to simultaneously access and share that data.

## Data management

Azure NetApp Files offers a complete range of data management features, including near-instantaneous snapshots, and volume cloning, all without impacting performance.

### Instance access

Although Azure NetApp Files instances run on bare-metal NetApp devices, that hardware resides in an Azure datacenter and is configured to be a first-party Azure service that's sold and supported by Microsoft. This means you can set up an Azure NetApp Files instance in just a few minutes. And since Azure NetApp Files is a full Azure service, you can manage your instances the same way you do any other Azure service: using Azure portal, Azure CLI, Azure PowerShell, or Azure REST API.

### Snapshots

An Azure NetApp Files *snapshot* is a point-in-time image of a volume. These snapshots have low overhead because of the way Azure NetApp Files performs volume virtualization. Like a database, this layer uses pointers to the actual data blocks on disk. But, unlike a database, it doesn't rewrite existing blocks; it writes updated data to a new block and changes the pointer.

The following diagram illustrates the snapshot process:

- **Time A**: A snapshot (Snapshot 1) is created.
- **Time B**: Changed data (B is now B1) is written to a new block and the pointer is updated. But the snapshot pointer still points to the previously written block, giving you both a live and a historical view of the data.
- **Time C**: Another snapshot (Snapshot 2) is created. Now you have access to three generations of data—the live data, Snapshot 2, and Snapshot 1, in descending order of age—without taking up the volume space that three full copies would require.

:::image type="content" source="../media/2-what-is-azure-netapp-files-snapshots.png" alt-text="How Azure NetApp Files snapshots work.":::

An Azure NetApp Files snapshot just manipulates block pointers, creating a "frozen," read-only view of a volume. Actual data blocks aren't copied, which leads to two efficiencies:

- **Speed**: Creating a snapshot is near-instantaneous. No matter what volume size you're working with, creating a snapshot takes only a few seconds.
- **Space**: A snapshot consumes minimal storage space because it doesn't copy the data blocks of the entire volume. Two snapshots taken in sequence differ only by the blocks added or changed in the time interval between the two.

You can create up to 255 snapshots per volume and creating a snapshot has no impact on volume performance. There are two ways to create and maintain snapshots:

- **Manually**: You can create on-demand snapshots using the Azure portal, Azure CLI, Azure PowerShell, or Azure REST API.
- **Automatically**: You can automate snapshot creation using either snapshot policies—which you can set using the Azure portal, Azure CLI, Azure PowerShell, or Azure REST API—or you can use a snapshot tool, such as AzAcSnap.

### Data recovery

The point of create volume snapshots is to recover data that has been corrupted or has been accidentally deleted, overwritten, or modified. Azure NetApp Files gives you three ways to recover data using snapshots:

- Restore one or more files or directories from a snapshot.
- Restore a snapshot to a new volume. This is called *cloning* the volume because you're creating an identical copy of the volume in a new location.
- Restore a snapshot in-place. This is called *reverting* the volume because it returns the volume to the state it was in when you created the snapshot.

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

## How to give your web development team access to the same data

Azure NetApp Files enables enterprise teams that use different operating systems to access the same data. For example, it's likely that your organization's web development team uses various operating systems:

- **Linux**: Your backend development team might use computers running the Linux operating system.
- **Windows**: Your frontend development team might use PCs running Windows 10.
- **macOS**: Your design team might use Macs running the macOS operating system.

Although each team would usually work on separate aspects of the website, if the website data files reside on the same volume, then you need to configure that volume to allow access from computers running Linux, Windows, and macOS.

You can accomplish this goal in Azure NetApp Files by configuring the volume to simultaneously use both NFS (supported by Linux) and SMB (supported by Windows and macOS).

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