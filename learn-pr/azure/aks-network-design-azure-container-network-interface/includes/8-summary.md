Your company wanted to deploy a new online store using cloud native patterns and practices and settled on Kubernetes as the platform on which to run the application. You had to design a network that would support the needs of the application.

We reviewed how IP addresses get used by different components within a Kubernetes cluster. Then we looked at the application we wanted to deploy to determine what its resource requirements would be. We looked at how many pods the application would need and how much processor and memory it would consume. We factored in the requirement that the application can scale up and down as demand on the application changed. We used this information to determine what type of virtual machine would be most suitable for the nodes of the Kubernetes cluster and how many virtual machines would be needed. We could then use this information to determine what size the network should be and how many IP addresses it needed.

The design process for a Kubernetes cluster network can be complicated. But by starting out with a good understanding of the application's requirements, you can easily create a design that meets your application's needs. Understanding your application helps you throughout its operational lifecycle. Knowing how you expect the application to run puts you in a better position to detect any potential issues that could affect its smooth operation.

[!include[azure-optional-exercise-subscription-cleanup](../../../includes/azure-optional-exercise-subscription-cleanup.md)]

## Learn More

Here are some links to more information about the areas we've covered in this module.

- [Configure Azure CNI networking in Azure Kubernetes Service](/azure/aks/configure-azure-cni)
- [Network concepts for applications in Azure Kubernetes Service (AKS)](/azure/aks/concepts-network)
- [Scaling options for applications in Azure Kubernetes Service (AKS)](/azure/aks/concepts-scale)
- [Automatically scale a cluster to meet application demands on Azure Kubernetes Service (AKS)](/azure/aks/cluster-autoscaler)
- [Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster)
- [Manage system node pools in Azure Kubernetes Service (AKS)](/azure/aks/use-system-pools)
- [Use an internal load balancer with Azure Kubernetes Service (AKS)](/azure/aks/internal-lb)
- IP address planning section in the [Baseline architecture for an Azure Kubernetes Service (AKS) cluster](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks#plan-the-ip-addresses)