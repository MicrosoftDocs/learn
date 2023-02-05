Most organizations and businesses, including Contoso, strive to ensure high availability of their mission critical workloads. Traditionally, this objective required a specialized, costly, and complex solution. With Failover Clustering, it's possible to accomplish the same objective in a cost-effective manner on commodity hardware.

Azure Stack HCI provides a hyperconverged infrastructure (HCI) failover cluster solution that hosts virtualized Windows and Linux workloads and their storage in a hybrid, on-premises environment. Azure Stack HCI connects with Azure hybrid services to add capabilities. These capabilities include, cloud-based monitoring, Site Recovery, virtual machine (VM) backups, and a central view of all of your Azure Stack HCI deployments in the Azure portal. Azure Stack HCI will be a required component of your proof-of-concept environment at Contoso.

# What is Failover Clustering on Azure Stack HCI?

Failover Clustering is a Windows Server and Azure Stack HCI feature that provides high availability of common workloads. For Azure Stack HCI, the clusters would only include virtual machines. You create a failover cluster by enabling Storage Spaces Direct on multiple servers running Azure Stack HCI. If a server that is part of an Azure Stack HCI fails or becomes unavailable, another server in the same failover cluster takes over the task of providing the services offered by the failed node. This process is called failover and it results in minimal or, in certain cases, no service disruptions for clients that are accessing the virtual machine.

## Reasons for using Azure Stack HCI

The most common uses of Azure Stack HCI include:

- Highly available guest Windows virtual machines
- Highly available guest Linux virtual machines

## Components of Azure Stack HCI

An Azure Stack HCI cluster consists of the following components:

- Nodes. Nodes are Azure Stack HCI computers that are members of a failover cluster and are enabled for Storage Spaces Direct. These computers have the Failover Clustering feature installed and run highly available virtual machine workloads consisting of services, applications, and resources. A failover cluster can consist of up to 64 nodes, while Azure Stack HCI supports up to 16 nodes. An Azure Stack HCI cluster can host up to 8,000 guest VMs, with up to 1,024 guest VMs per host.
- Clients. Clients are computers that consume available services and applications running within the highly available virtual machines. There should be multiple network paths between clients and the cluster. Configure client applications to automatically attempt to reconnect if they're temporary unavailable.
- Networks. Networks enable communication between nodes and computers consuming clustered workloads. In addition, nodes frequently use high-throughput, low-latency networks for accessing storage between the nodes.
- Clustered virtual machine role. A clustered virtual machine role is a highly available role that runs on the node. Clients consume this service by connecting to the virtual machines. If such a virtual machine becomes unavailable on one node, the failover cluster fails it over automatically to another node. The failover mechanism automatically redirects client requests for the service to the new node.
- Resources. Resources are physical or logical elements such as a storage pool, virtual disk, or virtual machine, which the failover cluster manages. Resources are the most basic and smallest configurable failover cluster components. A resource can run only on a single node at any given time.
- Cluster storage. In addition to its own local storage where the Azure Stack HCI operating system is installed, each cluster node has access to node’s local storage making up a shared storage pool where virtual machine configuration and data reside. The Storage Spaces Direct technology allows for sharing disks that are attached to the individual nodes.

:::image type="content" source="../media/3-failover-cluster-architecture.png" alt-text="A graphic depicting the architecture of a failover cluster with two nodes and shared storage." border="true":::

## What is quorum?

In an Azure Stack HCI cluster, the term *quorum* represents the number of clustering components that must be available for that cluster to remain online. These components can include the cluster nodes and, optionally, a witness. The term *witness* designates a resource whose role is to establish and maintain a quorum. For this purpose, an Azure Stack HCI cluster can use either a file share or a blob in Azure Storage. Failover Clustering determines the quorum based on the number of votes associated with cluster nodes and the witness. The purpose of the quorum is to prevent the *split-brain* scenario. In this scenario, because of internode connectivity issues, two sets of nodes in a cluster could potentially start operating independently of each other, resulting in the corruption of cluster state and its resources.

The quorum management model defines allocation of votes. Failover Clustering supports dynamic quorum management. Dynamic quorum provides higher availability within a failover cluster by continuously monitoring and adjusting the quorum model based on the available cluster nodes. Cluster quorum calculation is adjusted each time the number of nodes changes. Even if a failover cluster has less than 50 percent of the original number of nodes, the failover cluster continues to work and cluster roles are still available. With dynamic quorum enabled, a failover cluster can survive with only one node up and running.

> [!NOTE]
> The dynamic quorum model is enabled by default.

The functionality of a failover cluster depends on a quorum, but also on the resources available to cluster nodes and their ability to run clustered workloads that fail over to that node. For example, a cluster with five nodes will still have a quorum even if two nodes fail. However, each remaining cluster node continues serving clients only if it has enough resources to run cluster roles that failed over to the remaining three nodes. These resources include storage, processing power, network bandwidth, and memory. You can configure VM priority, start order, preferred hosts, and anti-affinity to decide the nodes on which the cluster role can run.

### Types of witness

There are two types of quorum witness available to Azure Stack HCI clustering:

- File Share Witness uses an external file share. In Windows Server 2019 and Azure Stack HCI, you can implement File Share Witness by using a USB drive attached to a network device accessible to all cluster nodes.
- Cloud Witness uses a blob in an Azure Storage account.

When selecting the quorum witness type, you should make sure that the witness remains accessible in the largest number of scenarios affecting the availability of cluster nodes.