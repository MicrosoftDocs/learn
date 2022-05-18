[Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/) is a portable, extensible open-source platform for automating deployment, scaling, and the management of containerized workloads. This orchestration platform gives us the same ease of use and flexibility as with Platform as a Service (PaaS) and Infrastructure as a Service (IaaS) offerings. Kubernetes provides both container management and container orchestration. 

- Container management is the process of organizing, adding, removing, or updating a significant number of containers. Most of these tasks are manual and error prone. 

- Container orchestration is a system that automatically deploys and manages containerized apps. For example, the orchestrator can dynamically increase or decrease the deployed instances of the managed app. Or it can ensure all deployed container instances get updated if a new version of a service is released.

:::image type="content" source="../media/container-scaling.png" alt-text="Dynamically or automatically adjust container instances.":::

 

### What is Azure Kubernetes Services (AKS)?

[Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) manages your hosted Kubernetes environment and makes it simple to deploy and manage containerized applications in Azure. Your AKS environment is enabled with features such as automated updates, self-healing, and easy scaling. 

:::image type="content" source="../media/kubernetes-features.png" alt-text="Self-healing, dynamic scaling, and rolling updates.":::



- The Kubernetes cluster is managed by Azure and is free. You manage the agent nodes in the cluster and only pay for the VMs on which your nodes run.

- When you create the cluster, you can use Resource Manager templates to automate cluster creation. With these templates, you specify features such as advanced networking, Azure Active Directory (AD) integration, and monitoring. 

- With AKS, we get the benefits of open-source Kubernetes. You don’t have the complexity or operational overhead running your own custom Kubernetes cluster.

### When to use Azure Kubernetes Service

Here, we'll discuss how you can decide whether Azure Kubernetes Service (AKS) is the right choice for you.

You'll either approach your decision from a green field or a lift-and-shift project point of view. A green fields project will allow you to evaluate AKS based on default features. A lift-and-shift project will require you to determine which features are best suited to support your migration. Here are a few factors to consider. 

| Factor| Things to consider |
| - | - |
| Identity and security management| Do you already use existing Azure resources and make use of Azure AD? If so, you can configure an AKS cluster to integrate with Azure AD and reuse existing identities and group membership. |
| Integrated logging and monitoring| Are you using Azure Monitor? If so, Azure Monitor provides performance visibility of the cluster. |
| Automatic cluster node and pod scaling| Do you need to scale up or down a large containerization environment? If so, AKS supports two auto cluster scaling options. The horizontal pod autoscaler watches the resource demand of pods and will increase pods to match demand. The cluster autoscaler component watches for pods that can't be scheduled because of node constraints. It will automatically scale cluster nodes to deploy scheduled pods. |
| Cluster node upgrades| Do you want to reduce the number of cluster management tasks? If so, AKS manages Kubernetes software upgrades and the process of cordoning off nodes and draining them. |
| Storage volume support| Does your application require persisted storage? If so, AKS supports both static and dynamic storage volumes. Pods can attach and reattach to these storage volumes as they're created or rescheduled on different nodes. |
| Virtual network support| Do you need pod to pod network communication or access to on-premises networks from your AKS cluster? If so, an AKS cluster can be deployed into an existing virtual network with ease. |
| Ingress with HTTP application routing support| Do you need to make your deployed applications publicly available? If so, the HTTP application routing add-on makes it easy to access AKS cluster deployed applications. |
| Docker image support| Do you already use Docker images for your containers? If so, AKS by default, supports the Docker file image format. |
| Private container registry| Do you need a private container registry? If so, AKS integrates with Azure Container Registry (ACR). You aren't limited to ACR though, you can use other container repositories, public, or private. |


 

All the above features are configurable either when you create the cluster or following deployment.

> [!TIP]
> Take a few minutes to read about how [Mercedes-Benz R&D is using AKS](https://customers.microsoft.com/story/784791-mercedes-benz-r-and-d-creates-container-driven-cars-powered-by-microsoft-azure). 
