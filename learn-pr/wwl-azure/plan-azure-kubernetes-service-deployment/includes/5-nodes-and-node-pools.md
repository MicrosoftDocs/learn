
Creating an Azure Kubernetes Service (AKS) cluster automatically creates and configures the control plane, which provides [core Kubernetes services](https://kubernetes.io/docs/concepts/overview/components) and application workload orchestration. The Azure platform provides the AKS control plane at no cost as a managed Azure resource. The control plane and its resources exist only in the region where you created the cluster.

The nodes, also called *agent nodes* or *worker nodes*, host the workloads and applications. In AKS, customers fully manage and pay for the agent nodes attached to the AKS cluster.

To run applications and supporting services, an AKS cluster needs at least one node: An Azure virtual machine (VM) to run the Kubernetes node components and container runtime. Every AKS cluster must contain at least one system node pool with at least one node.

AKS groups nodes of the same configuration into *node pools* of VMs that run AKS workloads. User node pools serve the primary purpose of hosting workload pods. If you want to have only one node pool in your AKS cluster, for example in a development environment, you can schedule application pods on the system node pool.

:::image type="content" source="../media/aks-node-resource-interactions-b139408f.png" alt-text="Diagram showing an Azure Kubernetes node.":::


You can also create multiple user node pools to segregate different workloads on different nodes.
