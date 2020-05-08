You were asked to spin up an Azure AKS Service so the company can deploy all the applications.

As the first step towards this implementation, you need to create and deploy an AKS cluster.

## Creating a cluster

Kubernetes is based on clusters. Which means that, instead of having a single and powerful VM, it uses the power of several less potent machines working as one. Being a cluster-based orchestrator brings your application several benefits. The biggest of them is __availability__.

There are two types of nodes in a Kubernetes cluster:

- Master Nodes: Hosts the control plane aspects of the cluster. Also, they're responsible for, among other things, providing the API you and all the other Nodes will use to communicate with each other. In general, there's no workloads being deployed or scheduled in these nodes, they're restricted to controlling the cluster.
- Compute Nodes (or Worker Nodes): These nodes are the ones responsible for executing workloads and applications.

When deploying a highly available cluster, there are some thoughts that should be considered. For instance, the number of nodes should always be greater than 2, this way you're covered if a Worker Node goes down, because the workloads will continue to be executed on the remaining nodes.

Also, it's important to note that Kubernetes __doesn't__ scale workloads on its own. You'll need to provide it with a _Horizontal Pod Autoscaler_, a resource that is going to be discussed later on this learning path.

## Cluster architectures

There are a few main cluster architectures for Kubernetes-based infrastructures.

### Single master, several workers

This is the most common architectural pattern since it removes most of the complexity related to quorums and multiple masters (discussed in the next architecture). While this is the easiest architecture to deploy, it doesn't provide a high availability to the core management services of your cluster.

That's because, if the master node goes unavailable for any reason, no other interaction can happen with the cluster. Even by you as operator, or by any workloads that use Kubernetes' APIs to communicate until, at least, the API server is back online.

Despite being less available than others, this architecture should be enough for most situations. Since the odds of the core management services become unavailable are several times less than a Worker Node going offline.

Because the control plane nodes are subject to fewer alterations than worker nodes. However, if you are dealing with a production like scenario, then this architecture might not be the best solution.

#### Single master, single worker

A variant of the previous architecture, mostly used as developer environment on your own machine. This architecture provides only one node, hosting both the master and a worker node. This is useful when testing os experimenting with different concepts and architectures. However, this harshly limits your scale and capacity, which makes this architecture unusable for production, or even staging, scenarios.

### Multiple master, several workers

This is the most used architecture to production clusters. Deploying multiple master nodes and multiple worker nodes allows for a high availability even when a master node is down. For this purpose, master nodes should be deployed in odd numbers, so quorum can be maintained in case one or more masters fail, because Kubernetes holds elections for the master manager node in order to avoid conflicts.

Despite this difference, all other worker nodes should be able to communicate with any master using the API server through a Load Balancer. This architecture is more complex to be deployed, but is the recommended configuration for most production clusters.
