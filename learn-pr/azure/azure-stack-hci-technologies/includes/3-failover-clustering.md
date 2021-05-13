Most organizations and businesses, including Contoso, strive to ensure high availability of their mission critical workloads. Traditionally, this required specialized, costly, and complex solution. With Failover Clustering, it is possible to accomplish the same objective in a cost-effective manner on commodity hardware. Failover Clustering will be a required component of your proof-of-concept environment at Contoso.

# What is Failover Clustering?

Failover Clustering is a Windows Server and Azure Stack HCI feature that provides high availability of common workloads. This includes file shares, VMs, database management systems, and messaging services. To accomplish this, you create a failover cluster consisting of multiple servers running the Windows Server or Azure Stack HCI operating system. If a server that is part of a failover cluster fails or becomes unavailable, another server in the same failover cluster takes over the task of providing the services that the failed node was offering. This process is called failover and it results in minimal or, in certain cases, no service disruptions for clients that are accessing the service.

## Reasons for using Failover Clustering

The most common uses of Failover Clustering include:

- Highly available services and applications that run on physical servers or in guest VMs that clustered Hyper-V servers host.
- Highly available or continuously available file shares hosting Microsoft SQL Server databases and Hyper-V VMs configuration and disk files.

## Components of Failover Clustering

A failover cluster consists of the following components:

- Nodes. Nodes are Windows Server or Azure Stack HCI computers that are members of a failover cluster. These computers have the Failover Clustering feature installed, and they run highly available workloads consisting of services, applications, and resources that are associated with a cluster. A Windows Server failover cluster can consist of up to 64 nodes, while Azure Stack HCI supports up to 16 nodes. A Hyper-V cluster can host up to 8,000 guest VMs, with up to 1,024 guest VMs per host.
- Clients. Clients are computers that consume highly available services and applications running in a failover cluster. There should be multiple network paths between clients and the cluster. Configure client applications to automatically attempt to reconnect to clustered services if they are  temporary unavailable.
- Networks. Networks enable communication between nodes and computers consuming clustered workloads. In addition, nodes frequently use high-throughput, low-latency networks for accessing shared storage.
- Clustered role. A clustered role is a highly available role or service that runs on the cluster node. Clients consume this service by connecting to the cluster node. If such a service becomes unavailable on one node, the failover cluster fails it over automatically to another node. The failover mechanism automatically redirects client requests for the service to the new node.
- Resources. Resources are physical or logical elements such as a shared folder, disk, or IP address, which the failover cluster manages. Resources might be integral parts of highly available applications or provide service to clients. Resources are the most basic and smallest configurable failover cluster components. A resource can run only on a single node at any given time.
- Cluster storage. In addition to its own local storage, where the Windows Server or the Azure Stack HCI operating system is installed, each cluster node has access to highly available shared storage, where application configuration and data reside. For example, cluster storage hosts configuration data and virtual hard disks of highly available guest VMs.

:::image type="content" source="../media/3-failover-cluster-architecture.png" alt-text="A graphic depicting the architecture of a failover cluster with two nodes and shared storage." border="true":::

> [!NOTE]
> The Storage Spaces Direct technology allows for sharing disks that are attached to individual nodes.

## What is the Failover Clustering quorum?

In a failover cluster, the term *quorum* represents the number of clustering components that must be available for that cluster to remain online. These components can include the cluster nodes and, optionally, a witness. The term *witness* designates a resource whose role is to establish and maintain a quorum. For this purpose, a failover cluster can use a file share, a disk, or a blob in Azure Storage. Failover Clustering determines the quorum based on the number of votes associated with cluster nodes and the witness. The purpose of the quorum is to prevent the *split-brain* scenario. In this scenario, because of internode connectivity issues, two sets of nodes in a cluster could potentially start operating independently of each other, resulting in the corruption of cluster state and its resources.

The quorum management model defines allocation of votes. Failover Clustering supports dynamic quorum management. Dynamic quorum provides higher availability within a failover cluster by continuously monitoring and adjusting the quorum model based on the available cluster nodes. Cluster quorum calculation is adjusted each time the number of nodes changes, so that even if a failover cluster has less than 50 percent of the original number of nodes, the failover cluster continues to work and cluster roles are still available. With dynamic quorum enabled, a failover cluster can survive with only one node up and running.

> [!NOTE]
> The dynamic quorum model is enabled by default.

The functionality of a failover cluster depends not only on a quorum but also on the resources available to cluster nodes and their ability to run clustered workloads that fail over to that node. For example, a cluster with five nodes will still have a quorum even if two nodes fail. However, each remaining cluster node continues serving clients only if it has enough resources to run cluster roles that failed over to the remaining three nodes. These resources include storage, processing power, network bandwidth, and memory. You can configure VM priority, start order, preferred hosts, and anti-affinity to decide the nodes on which the cluster role can run.

### Types of witness

There are three types of quorum witness available to Fail over Clustering:

- Disk Witness uses a clustered disk resource in the same failover cluster. All nodes must have access to the shared disk.
- File Share Witness uses an external file share. In Windows Server 2019 and Azure Stack HCI, you can implement this by using a USB drive attached to a network device accessible to all cluster nodes.
- Cloud Witness uses a blob in an Azure Storage account.

When selecting the quorum witness type, you should make sure that the witness remains accessible in the majority of scenarios affecting the availability of cluster nodes.
