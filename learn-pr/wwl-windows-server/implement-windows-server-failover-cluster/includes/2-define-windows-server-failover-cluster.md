Most organizations and businesses, including Contoso, strive to ensure high availability of its mission-critical workloads. Contoso could consider using Windows Server failover clustering. This is a Windows Server feature that provides high availability of common Windows-based workloads, including file shares, virtual machines (VMs), database management systems, and messaging services.

## Overview of failover clustering

To accomplish high availability of workloads, you create a failover cluster consisting of multiple Windows Server computers. If a server that is part of a failover cluster fails or becomes unavailable, another server in the same failover cluster takes over the services that the failed node was offering. This is called *failover* and it results in minimal service disruptions for clients that are accessing the service.

The most common uses of failover clustering include:

- Highly or continuously available file shares hosting Microsoft SQL Server databases and Microsoft Hyper-V VMS' configuration and disk files.
- Highly available services and applications that run on physical servers or in guest VMs hosted on clustered Hyper-V servers.

## Failover clustering components

A failover cluster consists of the components described in the following table.

|Component|Description|
|---------------|--------------|
| Nodes| Windows Server computers that are members of a failover cluster. These computers have the Windows Server failover clustering feature installed, and they run highly available workloads consisting of services, applications, and resources. |
| Clients| Computers that consume highly available services and applications running in a failover cluster. There should be multiple network paths between clients and the cluster. |
| Networks| Enable communication between nodes and computers consuming clustered workloads. In addition, nodes frequently access shared storage. |
| Clustered role  | A highly-available role or service that runs on the cluster node. Clients consume this service by connecting to the cluster node. If such a service becomes unavailable on one node, the failover cluster fails it over automatically to another node. |
| Resources| Physical or logical elements such as a shared folder, disk, or IP address, which the failover cluster manages. Resources may provide service to clients or may be integral parts of highly available applications. A resource can run only on a single node at any given time. |
| Cluster storage | In addition to its own local storage, where the Windows Server OS is installed, each cluster node has access to highly available shared storage, where application configuration and data reside. For example, *cluster storage* hosts configuration data and virtual hard disks of highly available guest VMs. |

:::image type="content" source="../media/m28-cluster-with-shared-storage.png" alt-text="A depiction of the architecture of a failover cluster with two nodes and shared storage." border="false":::

> [!NOTE]
> Shared storage doesn't have to be directly attached to multiple nodes. The Storage Spaces Direct technology introduced in Windows Server 2016 allows for sharing disks that are attached to individual nodes.

## Failover clustering functional levels

Windows Server failover clustering capabilities depend on the cluster's functional level. In general, you would want to ensure that the cluster uses the highest possible functional level. However, support for lower functional levels in Windows Server 2016 and Windows Server 2025 allows you to perform rolling upgrades of failover clusters running earlier OS versions. This way, during an upgrade, it's possible to have Windows Server 2016 and Windows Server 2025 nodes in the same failover cluster, eliminating the need for downtime.

> [!TIP]
> After all the nodes that were running Windows Server 2016 have been replaced with Windows Server 2025 nodes, you can update the cluster functional level.

## Failover clustering quorum

In a failover cluster, the term *quorum* represents the number of clustering components that must be available for that cluster to remain online. These components can include the cluster nodes and, optionally, a witness. The term *witness* designates a resource whose role is to establish and maintain a quorum. For this purpose, a failover cluster can use:

- A file share
- A disk 
- A blob in Azure Storage

The quorum is determined based on the number of votes associated with cluster nodes and the witness. The purpose of the quorum is to prevent the "split brain" scenario. In this scenario, as a result of internode connectivity issues, two sets of nodes in a cluster could potentially start operating independently of each other, resulting in the corruption of the cluster state and its resources.

The quorum model defines allocation of votes. Windows Server failover clustering offers dynamic quorum management. This provides higher availability within a failover cluster by continuously monitoring and adjusting the quorum model based on the available cluster nodes.

Cluster quorum calculation is adjusted when the number of nodes changes. Even if a failover cluster has less than 50 percent of the original number of nodes, the failover cluster continues to work and cluster roles are still available. With dynamic quorum enabled, a failover cluster can survive with only one node up and running.

> [!NOTE]
> The dynamic quorum model is enabled by default.

Failover clustering also supports the following quorum-related capabilities:

- Node weights. Windows Server uses cluster node weight primarily in environments where failover nodes are in multiple physical locations. In such environments, you might want the failover cluster to continue running uninterrupted at the primary location even if multiple nodes at the secondary location become unavailable. To accomplish this, you can assign a node weight of 0 to the failover cluster nodes at the secondary location, which effectively eliminates their impact on the state of the quorum.
- Dynamic witness. By default, Windows Server adjusts the witness vote dynamically based on the number of voting nodes in the failover cluster. If the failover cluster has an odd number of votes, the quorum witness doesn't have a vote. If the failover cluster has an even number of votes, the quorum witness has a vote. The quorum witness vote is also dynamically adjusted based on the state of the witness resource. If the witness resource is offline or has failed, then the witness doesn't have a vote.
- Tie breaker for 50 percent node split. Failover cluster can dynamically adjust a node's vote to maintain an odd number of total votes. To accomplish this, the failover cluster first adjusts the quorum witness vote by leveraging the dynamic witness functionality. If a quorum witness isn't available, then the failover cluster can adjust a node's vote. There's also a failover cluster property that you can use to determine which site survives if there is a 50 percent node split and neither site has a quorum.

The functionality of a failover cluster depends not only on a quorum but also on the resources available to cluster nodes and their ability to run clustered workloads that fail over to that node. For example, a cluster with five nodes will still have a quorum even if two nodes fail. However, each remaining cluster node continues serving clients only if it has enough resources to run cluster roles that failed over to the remaining three nodes. These resources include storage, processing power, network bandwidth, and memory. You can configure VM priority, start order, preferred hosts, and anti-affinity to decide the nodes on which the cluster role can run.

### Failover clustering witness types

There are three types of quorum witness available to failover clustering.

- Disk Witness uses a clustered disk resource in the same failover cluster. All nodes must have access to the shared disk.
- File Share Witness uses an external file share. It's possible to implement this by using a USB drive attached to a network switch.
- Cloud Witness uses a blob in an Azure Storage account.

> [!IMPORTANT]
> When selecting the quorum witness type, you should make sure that the witness remains accessible for most scenarios that affect cluster node availability.
