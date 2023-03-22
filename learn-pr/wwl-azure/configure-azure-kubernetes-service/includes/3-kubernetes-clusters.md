An Azure Kubernetes Service cluster is divided into two components: Azure-managed nodes and customer-managed nodes. Azure-managed nodes provide the core Kubernetes services and orchestration of application workloads in your AKS cluster. Customer-managed nodes run your application workloads in your AKS cluster.

The following illustration shows an example AKS cluster. The Azure-managed node has a scheduler, controller, API server, and storage. The customer-managed node has a container runtime, container, kubelet agent, and kube-proxy component. We'll examine these items in the following section.

:::image type="content" source="../media/kubernetes-clusters-4ae0bac1.png" alt-text="Illustration that shows an example AKS cluster. The Azure-managed node has a scheduler, controller, API server, and storage. The customer-managed node has a container runtime, container, kubelet agent, and kube-proxy component." border="false":::
 
### Things to know about AKS clusters, nodes, and pools

Let's take a closer look at how Azure Kubernetes Service implements clusters and nodes.

- To run your applications and supporting services, you need a Kubernetes node for your AKS cluster. Each AKS cluster contains one or more nodes that run the Kubernetes node components and the container runtime.

- Nodes are instances of Azure Virtual Machines. Nodes of the same configuration are grouped together into node pools. A Kubernetes cluster contains one or more node pools. 

- The initial number of nodes and size are defined when you create an AKS cluster, which creates the default node pool. The default node pool in AKS contains the underlying virtual machines that run your agent nodes.

- When you create an AKS cluster, an Azure-managed cluster node is automatically created and configured. This node is provided as a managed Azure resource that's abstracted from the user.

- The kubelet is the Kubernetes agent that processes the orchestration requests from the Azure-managed node, and scheduling of running the requested containers.

- The kube-proxy component handles virtual networking on each node. The proxy routes network traffic and manages IP addressing for services and pods.

- The container runtime component allows containerized applications to run and interact with other resources such as the virtual network and storage.
   - AKS clusters with Kubernetes version 1.19 node pools and later use `containerd` as the container runtime.
   - AKS clusters with node pools that use Kubernetes versions earlier than v1.19 implement Moby (upstream Docker) as the container runtime.

- When you implement Azure Kubernetes Service clusters, you pay only for running agent nodes in your cluster.