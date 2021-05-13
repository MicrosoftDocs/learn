Enterprise workloads might require higher degrees of scalability and availability than those workloads that are available with the traditional Windows Server failover clustering model. You can accommodate this requirement by implementing cluster sets.

## What are cluster sets?

In the simplest terms, you can think of a cluster set as a cluster of clusters running Windows Server 2019. Cluster sets enable you to extend the scope of your Software Defined Data Center (SDDC) by combining multiple clusters into a logical, highly scalable and resilient fabric. The fabric delivers a single Scale-Out File Server (SOFS)-based namespace along with the ability to easily transition VMs between clusters without negatively affecting availability or uptime of their workloads.

Cluster sets provide a layer of abstraction that hides individual clusters and presents a unified interface for clients connecting to clustered applications and services. They also facilitate seamless provisioning and de-provisioning of individual clusters.

Cluster sets address two primary challenges associated with individual clusters:

- Availability. Individual clusters, regardless of their size, are subject to the same rules regarding their resiliency. For example, a Storage Spaces Direct cluster with four or more nodes can withstand a failure of at most two of them. Because this rule applies even to the largest clusters with 64 nodes, it's more practical to create more clusters that are smaller, rather than fewer clusters that are larger. However, this approach has negative scalability implications.
- Scalability. Scaling clusters vertically or horizontally when they exhaust their current storage or processing capacity requires matching hardware and involves lengthy rebuilds.

The additional resiliency provisions built into cluster sets' design increase overall workload availability. To address scalability challenges, you can deploy another cluster and add it to the cluster set.

> [!IMPORTANT]
> Cluster sets don't support automatic failover between clusters.

> [!NOTE]
> To provide cross-cluster storage resiliency, you should implement a Storage Replica.

## Cluster set components

A cluster set consists of the following components:

- Management cluster. This is a failover cluster that hosts the management plane of the cluster set, including the unified SOFS namespace. Nodes of the management cluster can be physical or virtual, including guest VMs running on member clusters.
- Member clusters. These are clusters running Windows Server 2019, which host VMs, SOFS shares, and Storage Spaces Direct-based workloads.
- Cluster set namespace referral SOFS. This is an instance of SOFS hosted on the management cluster. This mechanism serves as the abstraction layer that presents a uniform interface to SMB clients for accessing SMB shares hosted on member cluster SOFS.
- Cluster set master. This is a cluster resource hosted on the management cluster, which coordinates communication between member clusters.
- Cluster set worker. This is a cluster resource hosted on each member cluster, which manages interaction between the management cluster and individual member clusters, such as the reporting status of local resources or VM placement.

:::image type="content" source="../media/m28-cluster-set.png" alt-text="A depiction of the architecture of a cluster set, with the management cluster and multiple member clusters." border="false":::
