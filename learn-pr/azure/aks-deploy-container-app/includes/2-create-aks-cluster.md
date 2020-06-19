To deploy your application, you need to create and deploy an AKS cluster.

[//]: # (This first paragraph will pull your reader into the unit. Try and relate the intro to the scenario from the introduction unit.)

Now let's see some of the concepts behind Kubernetes and how we can better understand them.

## Kubernetes Clusters

[//]: # (You're mentioning - clusters, nodes, orchestration, and benefits. However, you only mention one benefit. What is the core take away from this section that is important to the reader? To me, it seems the core concept is that a cluster is made up of nodes, and, therefore, I need to know about the correct configuration. Orchestration and benefits are covered in prerequisite material.)

Kubernetes is based on clusters. Instead of having a single and powerful VM, it uses the power of several less potent machines working as one. Being a cluster-based orchestrator brings your application several benefits. Like availability.

Clusters are based on nodes. There are two types of nodes in a Kubernetes cluster:

- **Control Plane nodes**: Hosts the control plane aspects of the cluster. They're responsible for providing the API you and all the other nodes will use to communicate. No workloads are deployed or scheduled in these nodes. These nodes are reserved for services controlling the cluster, also known as the control plane.
- **Nodes**: These nodes are responsible for executing workloads and applications.

## Cluster architectures

There are several architectural considerations you have to keep in mind when deploying a Kubernetes cluster. For example, the number of nodes in a cluster should always be more than two. When a node becomes unavailable, the Kubernetes schedular will try to reschedule all the workloads that were running on this node onto the remaining nodes in the cluster.

There are a few main cluster architectures for Kubernetes-based deployments.

### Single control plane and multiple workers

[//]: # (I suggest putting a diagram that shows this configuration)

The single control plane and multiple worker architecture is the most common architectural pattern. While this is the easiest architecture to deploy, it doesn't provide high availability to your cluster's core management services.

If the control plane node becomes unavailable for any reason, no other interaction can happen with the cluster. Even by you as an operator, or by any workloads that use Kubernetes' APIs to communicate until, at least, the API server is back online.

Despite being less available than others, this architecture should be enough for most situations. It is less likely that the core management services become unavailable compared to a node going offline. The control plane nodes are subject to fewer modifications than nodes and, therefore, more resilient.

However, if you are dealing with a production scenario, this architecture might not be the best solution.

### Single control plane and a single worker

[//]: # (I suggest putting a diagram that shows this configuration)

The single control plane and a single worker is a variant of the previous architecture and normally used as a development environment. This architecture provides only one node, hosting both the control plane and a worker node and is useful when testing or experimenting with different Kubernetes concepts. The single control plane and a single worker limit cluster scaling and makes this architecture not suitable for production and staging use.

### Multiple control planes and multiple workers

[//]: # (I suggest putting a diagram that shows this configuration)

The multiple control planes and multiple worker architecture is the most used architecture for production clusters. Deploying multiple control planes nodes and multiple nodes allows for high availability even when a control plane node is down.

For this purpose, master nodes are deployed in odd numbers, so quorum can be maintained if one or more masters fail.

[//]: # (You'll need to discuss the concept of quorum a bit more. Otherwise, mentioning high availability in the previous paragraph may be enough information. Keep in mind that you're referring "Despite this difference" in the next paragraph, and it's not clear to me what the difference is that you're referring to.)

Despite this difference, all other worker nodes can communicate with any master using the API server through a load balancer. This architecture is more involved in terms of deployment but is the recommended configuration for most production clusters.

## AKS Concepts

When you create a new AKS cluster, you have several different items of information that you need to configure.  Each item impacts the final configuration of your cluster.

### Kubernetes version

Kubernetes is an open-source project and is continuously evolving. Its versions bear differences between each other, the best practice is to use the default version for most of the common scenarios.

[//]: # (I'm not sure what you're trying to say here with the second sentence above? Think about some of the questions your reader may have after reading this part. Why would I need to use a different version? What happens when I need to upgrade?)

### Node Count

The node count is the number of worker nodes your cluster will have. Nodes are Azure virtual machines (VMs), and you can change their size and count to match your usage pattern. 

You can change this later in the cluster's configuration panel. It's also a best practice to keep this number as low as possible to avoid unnecessary costs and unused compute power.

[//]: # (Maybe you want to talk about node pools 1st? Your opening sentence can then read: "The node count is the number of worker nodes your cluster will have in a node pool".)

### Node Pools

AKS requires you to create *node pools* to group nodes in your cluster. When you create a node pool, you have to specify the VM size to use for each node in the node pool.  Node pools use VM scale sets as the underlying infrastructure to allow the cluster to scale the number of nodes in a node pool when needed.  New nodes created in the node pool, will always be the same size as you specified when creating the node pool.

[//]: # (Do we need to talk about node affinity? If so, then we'll need to define it with more detail. For example, you'll need to mention multiple node pools and highlight this in the exercises.)

You can even tell applications and pods to spin up in nodes according to their characteristics. This is called *node affinity*.

### Automatic Routing

[//]: # (The reason why a user needs to enable Automatic Routing is not immediately apparent. You explain what the ingress controller does and going by this description seems as if the default ingress installed is NGINX.)

AKS allows you to enable what is called HTTP Application Routing. This add-on makes it easy to access applications deployed to the cluster through the automatic creation of an Ingress Controller. Ingress Controllers provide the capability to deploy and expose your applications to the world without the need to configure network-related services.

Ingress Controllers create a reverse-proxy NGINX server that allows for all the requests to be served from a single DNS output automatically. You don't have to create an ingress every time a new service is deployed, the ingress controller will take care of it. As soon as a new ingress is deployed to the cluster, the Ingress Controller will create a new record on an Azure-managed DNS zone and will link it to an existing load balancer. This allows for easy access to the resource through the Internet without the need of additional configuration.

Despite the advantages, HTTP Application Routing is better suited to more basic clusters because it doesn't provide the amount of customization needed for a more complex configuration. If you are planning to deal with more complex clusters, there are better-suited options like the official Kubernetes NGINX Ingress Controller.

### Private clusters

*Private clusters* allow you to keep your Kubernetes API internal only. This means no one outside your cluster will be able to access it.

[//]: # (You may want to expand on this section. Is the concept of "no access" only applicable to the control plane or also workloads? Maybe add an example where a private cluster makes sense to use?)

### Network policies

*Network policies* allow you to customize how your cluster's data flow between all the workloads. By default, all internal communications are allowed. But it's possible to define the cluster to use other resource policies you can customize better. In this module, we'll use the default network policy.

[//]: # (I'm not completely clear what you want to say with this sentence: "But it's possible to define the cluster to use other resource policies you can customize better.")

In the next unit, you'll see how to apply these configuration options to create an AKS cluster for your company.
