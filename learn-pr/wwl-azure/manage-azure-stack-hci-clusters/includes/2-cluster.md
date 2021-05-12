As Contoso transitions to a new operational model that uses the capabilities of Azure Stack HCI clusters, you want to identify the optimal way to perform the most common cluster management tasks. To accomplish this, rather than relying on traditional administrative tools such as Failover Cluster Manager, you decide to focus on the clustering support in Windows Admin Center.

## Overview of the most common Azure Stack HCI cluster management tasks

The most common Azure Stack HCI cluster management tasks include:

- Changing cluster configuration, such as the access point name, node shutdown behavior, cluster traffic encryption scope, cluster witness selection, virtual machine (VM) load-balancing behavior, VM affinity rules, and diagnostic data levels.
- Changing storage caching configuration, such as persistent and in-memory cache settings.
- Changing Hyper-V settings, such as placement of VM disks and configuration files, enhanced session mode options, NUMA spanning, as well as Live Migration and Storage Migration behavior.
- Registering the Azure Stack HCI cluster with Azure.

## Manage an Azure Stack HCI cluster by using Windows Admin Center

Windows Admin Center offers a graphical, intuitive interface that simplifies most Azure Stack HCI cluster management tasks. In some cases, it still might be necessary to resort to traditional administrative tools such as Failover Cluster Manager. When operating at scale or when performing the same sequence of tasks regularly, you should consider PowerShell-based automation. 

> [!NOTE]
> You can implement any cluster management task available in Windows Admin Center by using Windows PowerShell.

### Change cluster settings

Azure Stack HCI relies on Windows Server Failover Clustering to implement high availability for its workloads. You can use Windows Admin Center to manage the core clustering features, including:

- **Access point name**. Designates the name that you can use to connect to the cluster to perform administrative tasks by using tools such as Failover Cluster Manager. Although the *access point name* is assigned during the deployment of an Azure Stack HCI cluster, you have the option to modify it.
- **Node shutdown behavior**. After you enable this behavior, it automatically triggers the live migration of VMs residing on a cluster node for which you initiate a shutdown.

    :::image type="content" source="../media/node-shutdown.png" alt-text="The screenshot depicts the node shutdown behavior setting of an Azure Stack HCI cluster." border="false":::

- **Cluster traffic encryption scope**. Allows you to protect data from eavesdropping by signing and encrypting all the Server Message Block (SMB) traffic between cluster nodes. You can enable signing or encryption for core traffic, which represents network traffic and storage traffic. Network traffic flows between cluster virtual network adapters. Storage traffic contains Cluster Shared Volume (CSV) and Storage Bus Layer (SBL) data. 

    :::image type="content" source="../media/traffic-encryption.png" alt-text="The screenshot depicts the cluster traffic encryption settings of an Azure Stack HCI cluster." border="false":::

- **Cluster witness selection**. Identifies your choice of the witness type, which affects the mechanism for establishing and maintaining the cluster quorum. The purpose of the quorum is to prevent situations caused by internode connectivity issues. In these situations, two sets of nodes in a cluster start operating independently of each other, resulting in the corruption of the cluster state and its resources.
- **VM load-balancing behavior**. Controls the load-balancing mechanism, which continually monitors cluster performance metrics and periodically redistributes clustered VMs across cluster nodes to optimize the use of cluster resources. 
- **VM affinity rules**. Defines rules that establish relationships between two or more cluster roles and resources, such as VMs and storage, to indicate that you prefer to host them on the same cluster node. You can also define anti-affinity rules to indicate preference of the opposite arrangement, with two or more cluster roles and resources distributed across different cluster nodes.
- **Diagnostic data levels**. Establishes the scope of telemetry that an Azure Stack HCI cluster sends automatically to Microsoft for diagnostic purposes.

    :::image type="content" source="../media/diagnostic-data.png" alt-text="The screenshot depicts the diagnostic data settings of an Azure Stack HCI cluster." border="false":::

### Change storage settings

Azure Stack HCI relies on Storage Spaces Direct to implement highly resilient and performant storage, which includes an automatic caching mechanism. Usually, because of built-in optimization and self-healing characteristics, this mechanism does not require manual management. You can control some aspects of its behavior by:

- Enabling or disabling persistent cache
- Changing the cache mode for hard disk drives (HDDs) and solid-state drives (SSDs) to none, read only, read/write, or write only.

    :::image type="content" source="../media/persistent-cache.png" alt-text="The screenshot depicts the Storage Spaces Direct persistent cache settings for an Azure Stack HCI cluster." border="false":::

- Increasing the cache size by making a designated amount of physical memory on each cluster node available for read caching. The in-memory cache settings allow you to enable the use of server memory to cache reads and set the limit of memory per server.

    :::image type="content" source="../media/inmemory-cache.png" alt-text="The screenshot depicts the in-memory cache settings that allow you to enable the use of server memory to cache reads and set the limit of memory per server." border="false":::

You also have the option to customize the name of Storage Spaces Direct pools, allowing you to designate their location in stretched clustering scenarios.


### Change Hyper-V settings

Azure Stack HCI relies on Hyper-V to implement highly resilient and performant compute. You can use Windows Admin Center to manage the most essential Hyper-V features, including:

- **Placement of VM disks and configuration files**. Specifies the default file system path for clustered VM-related files.
- **Enhanced session mode options**. Provides the ability to configure redirection of local devices and resources when connecting to clustered VMs by using Virtual Machine Connection (VMConnect).

    :::image type="content" source="../media/enhanced-session-mode.png" alt-text="The screenshot depicts the Enhanced Session Mode settings for clustered VMs." border="false":::

- **NUMA spanning**. Enables the non-uniform memory architecture (NUMA) mechanism, which increases the amount of memory available to clustered VMs by providing simultaneous access to multiple NUMA nodes. While this might allow you to increase the number of VMs that can run on a cluster at the same time, it could have a detrimental impact on their overall performance.

    :::image type="content" source="../media/numa-spanning.png" alt-text="The screenshot depicts the NUMA spanning settings of an Azure Stack HCI cluster." border="false":::

- **Live Migration**. Controls the availability and the behavior of the process that transitions clustered VMs across cluster nodes without shutting down or pausing their guest operating systems. After you enable this functionality, you can limit the number of simultaneous migrations, enforce the use of the CredSSP or Kerberos authentication protocol, and assign either the SMB or Compression performance option, which determines the method that the migration process uses to transfer the VM memory. 

    :::image type="content" source="../media/live-migration.png" alt-text="The screenshot depicts the Live Migration settings of an Azure Stack HCI cluster." border="false":::

- **Storage Migration**. Controls the availability of the process that transitions storage of clustered VMs across cluster nodes without shutting down or pausing their guest operating systems. After you enable this functionality, you can limit the number of simultaneous storage migrations.

    :::image type="content" source="../media/storage-migration.png" alt-text="The screenshot depicts the Storage Migration settings of an Azure Stack HCI cluster." border="false":::


### Register the Azure Stack HCI cluster with Azure

Azure Stack HCI is an Azure service and you must register it within 30 days of installation to comply with the Azure Online Services Terms. The easiest way to perform such registration is by using Windows Admin Center.

:::image type="content" source="../media/register-azure.png" alt-text="The screenshot depicts the Register Azure Stack HCI settings of an Azure Stack HCI cluster." border="false":::

---
## Check your knowledge

## Multiple Choice
Contoso's Information Security requires that all the network traffic for mission critical workloads is encrypted. You need to ensure that all SMB traffic between cluster nodes is encrypted. Which type of setting should you configure?
(x) Cluster setting. {{Correct. Cluster settings include the option to encrypt SMB connections.}}
( ) Storage setting. {{Incorrect. Storage settings include the options to configure caching behavior, but not to encrypt SMB connections.}}
( ) Hyper-V setting. {{Incorrect. Hyper-V settings allow you to manage placement of VM disks and configuration files, enhanced session mode options, NUMA spanning, as well as Live Migration and Storage Migration behavior, but not encryption of SMB connections.}}