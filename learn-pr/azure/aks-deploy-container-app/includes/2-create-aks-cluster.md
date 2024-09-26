Your company plans to deploy your cloud-based video rendering service using Azure Kubernetes Service (AKS) as your cloud-native development platform. Before you can deploy any application, you need to create your AKS cluster.

Let's review a few concepts so that you can deploy a new AKS cluster successfully.

## Kubernetes clusters

Kubernetes is based on clusters. Instead of having a single virtual machine (VM), it uses several machines working as one. These VMs are called nodes. Kubernetes is a cluster-based orchestrator. It provides your application with several benefits, such as availability, monitoring, scaling, and rolling updates.

## Cluster nodes

A cluster is node-based. There are two types of nodes in a Kubernetes cluster that provide specific functionality.

- **Control plane nodes**: These nodes host the cluster's control plane aspects and are reserved for services that control the cluster. They're responsible for providing the API you and all the other nodes use to communicate. No workloads are deployed or scheduled on these nodes.

- **Nodes**: These nodes are responsible for executing custom workloads and applications, such as components from your cloud-based video rendering service.

## Cluster architectures

Use a cluster architecture to conceptualize the number of control planes and nodes you deploy in your Kubernetes cluster.

For example, the number of nodes in a cluster should always be more than two. When a node becomes unavailable, the Kubernetes scheduler tries to reschedule all the workloads running on this node onto the remaining nodes in the cluster.

There are two popular cluster architectures for Kubernetes-based deployments.

## Single control plane and multiple nodes

:::image type="content" source="../media/2-1-diagram.png" alt-text="A diagram that shows a single control plane and multiple nodes in a cluster configuration.":::

The *single control plane to multiple nodes* per cluster architecture is the most common architectural pattern, and is the easiest to deploy, but it doesn't provide high availability to your cluster's core management services.

If the control plane node becomes unavailable for any reason, no other interaction can happen with the cluster. This problem occurs even if you're the operator, or by any workloads that use Kubernetes' APIs to communicate until, at least, the API server is back online.

Despite being less available than others, this architecture should be enough for most situations. It's less likely that the core management services become unavailable compared to a node going offline. The control plane nodes are subject to fewer modifications than nodes and more resilient.

If you're dealing with a production scenario, this architecture might not be the best solution.

## Single control plane and a single node

:::image type="content" source="../media/2-2-single-diagram.png" alt-text="A diagram that depicts a single control plane and single node in a cluster configuration.":::

The *single control plane to single node* architecture is a variant of the previous architecture and is used in development environments. This architecture provides only one node that hosts both the control plane and a worker node. It's useful when testing or experimenting with different Kubernetes concepts. The single control plane and single node architecture limits cluster scaling and makes this architecture unsuitable for production and staging use.

## Configure an AKS cluster

When you create a new AKS cluster, you have several different items to configure. Each item affects the final configuration of your cluster for compute resource allocation.

These items include:

- Node pools
- Node count
- Node VM size

## Node pools

You create *node pools* to group nodes in your AKS cluster. When you create a node pool, you specify the VM size and OS type (Linux or Windows) for each node in the node pool based on application requirement. To host user application pods, node pool **Mode** should be **User** otherwise **System**.

By default, an AKS cluster has a Linux node pool (**System Mode**) whether you create it through the Azure portal or CLI. However, you can configure it to add Windows node pools along with default Linux node pools during the creation wizard in the portal, parameters in CLI, or with ARM templates.

Node pools use Virtual Machine Scale Sets as the underlying infrastructure to allow the cluster to scale the number of nodes in a node pool. New nodes created in the node pool are always the same size as you specified when you created the node pool.

:::image type="content" source="../media/2-3-node-pool-diagram.png" alt-text="A diagram that depicts a Kubernetes cluster with two node pools. The first node pool uses NC24s_v2 VMs, and the second node pool uses B2s standard VMs.":::

## Node count

The node count is the number of nodes your cluster has in a node pool. Nodes are Azure VMs. You can change their size and count to match your usage pattern.

You can change the node count later in the cluster's configuration panel. It's also a best practice to keep this number as low as possible to avoid unnecessary costs and unused compute power.

## Node VM size

Select from a wide range of VM specs. For development purposes, you can choose the B series to save on costs. In the exercises, you use series B2, the standard size. For more guidance to select a VM based on your needs, visit the [Azure VM selector tool](https://azure.microsoft.com/pricing/vm-selector/)
