To deploy your application, you need to create and deploy an AKS cluster.

[//]: # (This first paragraph will pull your reader into the unit. Try and relate the intro to the scenario from the introduction unit.)

Let's see some of the concepts behind Kubernetes and how we can better understand them.

## Kubernetes clusters

Kubernetes is based on clusters. Instead of having a single and powerful VM, it uses the power of several less potent machines working as one. Being a cluster-based orchestrator brings your application several benefits. Like availability, monitoring, scaling, rolling updates, and many more.

Clusters are based on nodes. There are two types of nodes in a Kubernetes cluster:

- **Control plane nodes**: Hosts the control plane aspects of the cluster. They're responsible for providing the API you and all the other nodes will use to communicate. No workloads are deployed or scheduled in these nodes. These nodes are reserved for services controlling the cluster, also known as the control plane.
- **Nodes**: These nodes are responsible for executing workloads and applications.

## Cluster architectures

There are several architectural considerations you have to keep in mind when deploying a Kubernetes cluster. For example, the number of nodes in a cluster should always be more than two. When a node becomes unavailable, the Kubernetes scheduler will try to reschedule all the workloads that were running on this node onto the remaining nodes in the cluster.

There are a few main cluster architectures for Kubernetes-based deployments.

### Single control plane and multiple nodes

:::image type="content" source="../media/2-1-diagram.png" alt-text="Single Control Plane Diagram":::

The single control plane and multiple worker architecture is the most common architectural pattern. While this is the easiest architecture to deploy, it doesn't provide high availability to your cluster's core management services.

If the control plane node becomes unavailable for any reason, no other interaction can happen with the cluster. Even by you as an operator, or by any workloads that use Kubernetes' APIs to communicate until, at least, the API server is back online.

Despite being less available than others, this architecture should be enough for most situations. It is less likely that the core management services become unavailable compared to a node going offline. The control plane nodes are subject to fewer modifications than nodes and, therefore, more resilient.

However, if you are dealing with a production scenario, this architecture might not be the best solution.

### Single control plane and a single nodes

:::image type="content" source="../media/2-2-single-diagram.png" alt-text="Single control plane and single node diagram":::

The single control plane and a single worker is a variant of the previous architecture and normally used as a development environment. This architecture provides only one node, hosting both the control plane and a worker node and is useful when testing or experimenting with different Kubernetes concepts. The single control plane and a single worker limit cluster scaling and makes this architecture not suitable for production and staging use.

## AKS concepts

When you create a new AKS cluster, you have several different items of information that you need to configure.  Each item impacts the final configuration of your cluster.

### Node pools

AKS requires you to create *node pools* to group nodes in your cluster. When you create a node pool, you have to specify the VM size to use for each node in the node pool.  Node pools use VM scale sets as the underlying infrastructure to allow the cluster to scale the number of nodes in a node pool when needed.  New nodes created in the node pool, will always be the same size as you specified when creating the node pool.

:::image type="content" source="../media/2-3-nodepool-diagram.png" alt-text="Node pool diagram":::

### Node count

The node count is the number of nodes your cluster will have in a node pool. Nodes are Azure virtual machines (VMs), and you can change their size and count to match your usage pattern.

You can change this later in the cluster's configuration panel. It's also a best practice to keep this number as low as possible to avoid unnecessary costs and unused compute power.

### Automatic routing

By default, all external communications are blocked by a Kubernetes cluster. So, when deploying applications that are going to be open to the world – like the website for Contoso – we need to manually create an __Ingress__ to make an exception and allow the incoming connections to that particular service. This requires some network-related changes to forward that request to an internal IP and then to your application, which is complicated.

AKS allows you to enable what is called HTTP application routing. This add-on makes it easy to access applications deployed to the cluster through the automatic creation of an Ingress Controller. Ingress Controllers provide the capability to deploy and expose your applications to the world without the need to configure network-related services.

:::image type="content" source="../media/2-4-httpar-diagram.png" alt-text="HTTP Application Routing Diagram":::

Ingress Controllers create a reverse-proxy server that allows for all the requests to be served from a single DNS output automatically. You don't have to create a DNS record every time a new service is deployed, the ingress controller will take care of it. As soon as a new ingress is deployed to the cluster, the Ingress Controller will create a new record on an Azure-managed DNS zone and will link it to an existing load balancer. This allows for easy access to the resource through the Internet without the need of additional configuration.

Despite the advantages, HTTP application routing is better suited to more basic clusters because it doesn't provide the amount of customization needed for a more complex configuration. If you are planning to deal with more complex clusters, there are better-suited options like the official Kubernetes Ingress Controller.
