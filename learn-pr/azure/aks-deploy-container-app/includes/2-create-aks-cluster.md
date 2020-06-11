In order to deploy your application, you need to create and deploy an AKS cluster. Now let's see some of the concepts behind Kubernetes and how we can better understand them.

## Kubernetes Clusters

Kubernetes is based on clusters. Instead of having a single and powerful VM, it uses the power of several less potent machines working as one. Being a cluster-based orchestrator brings your application several benefits. Like availability.

Clusters are based of nodes. There are two types of nodes in a Kubernetes cluster:

- __Master nodes__: Hosts the control plane aspects of the cluster. They're responsible for providing the API you and all the other nodes will use to communicate with each other. In general, there's no workloads being deployed or scheduled in these nodes, they're restricted to controlling the cluster.
- __Worker nodes__: These nodes are responsible for executing workloads and applications.

When deploying a highly available cluster, there are some thoughts that should be considered. For instance, the number of nodes should always be greater than two, this way you're covered if a worker node becomes unavailable, as the workloads will continue to be executed on the remaining nodes.

## Cluster architectures

There are a few main cluster architectures for Kubernetes-based infrastructures.

### Single master, multiple workers

This is the most common architectural pattern. While this is the easiest architecture to deploy, it doesn't provide a high availability to the core management services of your cluster.

If the master node goes unavailable for any reason, no other interaction can happen with the cluster. Even by you as operator, or by any workloads that use Kubernetes' APIs to communicate until, at least, the API server is back online.

Despite being less available than others, this architecture should be enough for most situations. Since the odds of the core management services become unavailable are several times less than a worker node going offline, because the control plane nodes are subject to fewer modifications than worker nodes.

However, if you are dealing with a production scenario, then this architecture might not be the best solution.

### Single master, single worker

A variant of the previous architecture, mostly used as developer environment on your own machine. This architecture provides only one node, hosting both the master and a worker node. This is useful when testing os experimenting with different concepts and architectures. However, this harshly limits your scale and capacity, which makes this architecture unusable for production, or even staging, scenarios.

### Multiple master, multiple workers

This is the most used architecture for production clusters. Deploying multiple master nodes and multiple worker nodes allows for a high availability even when a master node is down.

For this purpose, master nodes should be deployed in odd numbers, so quorum can be maintained in case one or more masters fail.

Despite this difference, all other worker nodes can communicate with any master using the API server through a load balancer. This architecture is more complex to be deployed, but is the recommended configuration for most production clusters.

## AKS Concepts

When you create a new AKS cluster, you'll be presented with several different options and inputs to fill, let's examine some of them to understand the impacts these configurations have on your final cluster.

### Kubernetes version

Since Kubernetes is an open-source project, it's constantly evolving. Its versions bear differences between each other, the best practice is to use the default version for most of the common scenarios.

### Node Count

Nodes are Azure virtual machines (VMs), and you can change their size and count to match your usage pattern. The node count is the number of worker nodes your cluster will have.

You can change this later in the cluster's configuration panel. It's also a best practice to keep this number as low as possible to avoid unnecessary costs and unused compute power.

### Node Pools

*Node pools* is the name given to the configuration needed to create multiple node types within the same cluster. This configuration is provided through the virtual machine scale sets configuration.

Each node is put into a *Node Pool*, which enable you to have different sized nodes in different node pools across your cluster. You can even tell applications and pods to spin up in nodes according to their characteristics. This is called *node affinity*.

A common use case is to have CPU-intensive nodes and GPU-intensive nodes in separate node pools so future applications that use more CPU, such ase processing spreadsheets, and applications that use intense GPU power, such ase rendering, can be deployed to separate nodes based on the *affinity* they have with the desired resource.

### Automatic Routing

AKS allows you to enable what is called HTTP Application Routing. This add-on makes it easy to access applications deployed to the cluster through the automatic creation of an Ingress Controller. Ingress Controllers provide the capability to deploy and expose your applications to the world without the need to configure network-related services.

Ingress Controllers create a reverse-proxy NGINX server that allows for all the requests to be served from a single DNS output automatically. You don't have to create an ingress every time a new service is deployed, the ingress controller will take care of it. As soon as a new ingress is deployed to the cluster, the Ingress Controller will create a new record on an Azure-managed DNS zone and will link it to an existing load balancer. This allows for easy access to the resource through the Internet without the need of additional configuration.

Despite the advantages, HTTP Application Routing is better suited to more basic clusters because it doesn't provide the amount of customization needed for a more complex configuration. If you are planning to deal with more complex clusters, there are better suited options like the official Kubernetes NGINX Ingress Controller.

### Private clusters

*Private clusters* allow you to keep your Kubernetes API internal only. This means no one outside your cluster will be able to access it.

### Network policies

*Network policies* allow you to customize how your cluster's data will flow between all the workloads. By default, all internal communications are allowed. But it's possible to define the cluster to use other resource policies you can customize better. In this module, we'll use the default network policy.

Now that you've seem all the configurations you're going to need to spin up the cluster for your company.
