Your company wanted to deploy a new online store using cloud native patterns and practices and settled on Kubernetes as the platform on which to run the application. You had to design a network that would support the needs of the application.

We reviewed how IP addresses get used by different components within a Kubernetes cluster. Then we looked at the application we wanted to deploy to determine what its resource requirements would be. We looked at how many pods the application would need and how much processor and memory it would consume. We factored in the requirement that the application can scale up and down as demand on the application changed. We used this information to determine what type of virtual machine would be most suitable for the nodes of the Kubernetes cluster and how many virtual machines would be needed. We could then use this information to determine what size the network should be and how many IP addresses it needed.

The design process for a Kubernetes cluster network can be complicated. But by starting out with a good understanding of the application's requirements, you can easily create a design that will meet your application's needs. Understanding your application will also help throughout its operational lifecycle. You'll know how you expect the application to run. You'll be in a better position to detect any potential issues that could affect its smooth operation.

## Learn More

Here are some links to more information about the areas we've covered in this module.

- [Configure Azure CNI networking in Azure Kubernetes Service](https://docs.microsoft.com/azure/aks/configure-azure-cni?azure-portal=true)
- [Network concepts for applications in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/concepts-network?azure-portal=true)
- [Scaling options for applications in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/concepts-scale?azure-portal=true)
- [Automatically scale a cluster to meet application demands on Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/cluster-autoscaler?azure-portal=true)
- [Upgrade an Azure Kubernetes Service (AKS) cluster](https://docs.microsoft.com/azure/aks/upgrade-cluster?azure-portal=true)