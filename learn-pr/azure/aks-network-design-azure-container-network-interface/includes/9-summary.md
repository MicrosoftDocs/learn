Your company wanted to deploy a new online store using cloud native patterns and practices. They settled on using Kubernetes as the platform to run the application. Your job was to design a network to support the needs of the application.

You reviewed how IP addresses get used by different components within a Kubernetes cluster. You looked at the application you needed to deploy to determine what its resource requirements would be. You looked at how many pods the application would need and how much processor and memory it would consume and factored in that the application might scale up and down with application demand. You used this information to determine what type of virtual machine would be most suitable for the nodes of the Kubernetes cluster and how many VMs would be needed. Then, you determined what size the network should be and how many IP addresses it needed.

The design process for a Kubernetes cluster network can be complicated. But by starting out with a good understanding of the application's requirements, you can easily create a design that meets your application's needs. Understanding your application helps you throughout its operational lifecycle. Knowing how you expect the application to run puts you in a better position to detect any potential issues that could affect its smooth operation.

[!include[azure-optional-exercise-subscription-cleanup](../../../includes/azure-optional-exercise-subscription-cleanup.md)]

## Learn more

To continue learning about AKS networking, see the following articles:

- [Configure Azure container networking in Azure Kubernetes Service (AKS)](/azure/aks/configure-azure-cni)
- [Network concepts for applications in Azure Kubernetes Service (AKS)](/azure/aks/concepts-network)
- [Scaling options for applications in Azure Kubernetes Service (AKS)](/azure/aks/concepts-scale)
- [Automatically scale a cluster to meet application demands on Azure Kubernetes Service (AKS)](/azure/aks/cluster-autoscaler)
- [Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster)
- [Manage system node pools in Azure Kubernetes Service (AKS)](/azure/aks/use-system-pools)
- [Use an internal load balancer with Azure Kubernetes Service (AKS)](/azure/aks/internal-lb)
- [Baseline architecture for an Azure Kubernetes Service (AKS) cluster](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks#plan-the-ip-addresses)
