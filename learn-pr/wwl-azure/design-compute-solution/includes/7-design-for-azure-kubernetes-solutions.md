[Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/) is a portable, extensible open-source platform for automating deployment, scaling, and the management of containerized workloads. This orchestration platform provides the same ease of use and flexibility as with Platform as a Service (PaaS) and Infrastructure as a Service (IaaS) offerings. Kubernetes provides both _container management_ and _container orchestration_. 

:::image type="content" source="../media/container-scaling.png" alt-text="Diagram that shows how container orchestration dynamically or automatically scales container instances." border="false":::

Container management is the process of organizing, adding, removing, or updating a significant number of containers. Most of these tasks are manual and error prone. Container orchestration is a system that automatically deploys and manages containerized applications. The orchestrator can dynamically increase or decrease the deployed instances of the managed application. The orchestrator can also ensure all deployed container instances get updated if a new version of a service is released.

[Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) manages your hosted Kubernetes environment and makes it simple to deploy and manage containerized applications in Azure. 

### Things to know about Azure Kubernetes Service

The Azure Kubernetes Service environment is enabled with many features, such as automated updates, self-healing, and easy scaling. Review the following characteristics that make AKS an appealing compute option to build new workloads and support lift and shift migrations.   

:::image type="content" source="../media/select-azure-kubernetes-service.png" alt-text="Flowchart that shows the decision tree for selecting Azure Kubernetes Service to build new workloads and to support lift and shift migrations." border="false":::

- The Kubernetes cluster is managed by Azure and is free. You manage the agent nodes in the cluster and only pay for the virtual machines on which your nodes run.

- When you create the cluster, you can use Azure Resource Manager (ARM) templates to automate cluster creation. With ARM templates, you specify features like as advanced networking, Microsoft Entra integration, and monitoring. 

- AKS gives you the benefits of open-source Kubernetes. You don't have the complexity or operational overhead of running your own custom Kubernetes cluster.

### Things to consider when using Azure Kubernetes Service

There are several factors to consider when deciding whether Azure Kubernetes Service is the right compute solution for your infrastructure. A good approach is to plan your strategy from two points of view. Consider the features from the approach of a _green field_ new project, and also from the perspective of a _lift-and-shift_ migration. The following features are configurable when you create a new cluster and also after you deploy.

| Feature | Consideration | Solution |
| --- | --- | --- |
| **Identity and security management** | _Do you already use existing Azure resources and make use of Microsoft Entra ID?_ | You can configure an Azure Kubernetes Service cluster to integrate with Microsoft Entra ID and reuse existing identities and group membership. |
| **Integrated logging and monitoring** | _Are you using Azure Monitor?_ | Azure Monitor provides performance visibility of the cluster. |
| **Automatic cluster node and pod scaling** | _Do you need to scale up or down a large containerization environment?_ | AKS supports two auto cluster scaling options. The _horizontal pod autoscaler_ watches the resource demand of pods and increases pods to meet demand. The _cluster autoscaler_ component watches for pods that can't be scheduled because of node constraints. It automatically scales cluster nodes to deploy scheduled pods. |
| **Cluster node upgrades** | _Do you want to reduce the number of cluster management tasks?_ | AKS manages Kubernetes software upgrades and the process of cordoning off nodes and draining them. |
| **Storage volume support** | _Does your application require persisted storage?_ | AKS supports both static and dynamic storage volumes. Pods can attach and reattach to these storage volumes as they're created or rescheduled on different nodes. |
| **Virtual network support** | _Do you need pod-to-pod network communication or access to on-premises networks from your AKS cluster?_ | An AKS cluster can be deployed into an existing virtual network with ease. |
| **Ingress with HTTP application routing support** | _Do you need to make your deployed applications publicly available?_ | The HTTP application routing add-on makes it easy to access AKS cluster deployed applications. |
| **Docker image support** | _Do you already use Docker images for your containers?_ | By default, AKS supports the Docker file image format. |
| **Private container registry** | _Do you need a private container registry?_ | AKS integrates with Azure Container Registry (ACR). You aren't limited to ACR though, you can use other container repositories, public, or private. |

#### Business application

Take a few minutes to read about how [Mercedes-Benz R&D is using Azure Kubernetes Service](https://customers.microsoft.com/story/784791-mercedes-benz-r-and-d-creates-container-driven-cars-powered-by-microsoft-azure).
