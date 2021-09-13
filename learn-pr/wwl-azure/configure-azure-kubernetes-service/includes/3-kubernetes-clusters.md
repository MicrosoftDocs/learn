A Kubernetes cluster is divided into two components:

 -  **Azure-managed nodes**, which provide the core Kubernetes services and orchestration of application workloads.
 -  **Customer-managed nodes** that run your application workloads.

:::image type="content" source="../media/kubernetes-clusters-4ae0bac1.png" alt-text="Graphic representing an Azure-managed cluster node, which is in a box. A second box within contains a scheduler, controller, API server, and storage. A separate customer-managed node box has boxes within containing container runtime, container, kubelet and kube-proxy.":::


## Azure-managed node

When you create an AKS cluster, a cluster node is automatically created and configured. This node is provided as a managed Azure resource abstracted from the user. You pay only for running agent nodes

## Nodes and node pools

To run your applications and supporting services, you need a Kubernetes node. An *AKS cluster* contains one or more nodes (Azure Virtual Machines) that run the Kubernetes node components and the container runtime.

 -  The *kubelet* is the Kubernetes agent that processes the orchestration requests from the Azure-managed node, and scheduling of running the requested containers.
 -  Virtual networking is handled by the *kube-proxy* on each node. The proxy routes network traffic and manages IP addressing for services and pods.
 -  The *container runtime* is the component that allows containerized applications to run and interact with additional resources such as the virtual network and storage. AKS clusters using Kubernetes version 1.19 node pools and greater use containerd as its containers runtime. AKS clusters using Kubernetes prior to v1.19 for node pools use Moby (upstream docker) as its container runtime.

Nodes of the same configuration are grouped together into *node pools*. A Kubernetes cluster contains one or more node pools. The initial number of nodes and size are defined when you create an AKS cluster, which creates a default node pool. This default node pool in AKS contains the underlying VMs that run your agent nodes.
