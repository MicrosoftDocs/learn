Here, we'll discuss how you can decide whether Azure Kubernetes Service (AKS) is the right choice for you.

You'll either approach your decision from a green fields or a lift-and-shift project point of view. A green fields project will allow you to evaluate AKS based on default features. A lift-and-shift project will force you to look at which features are best suited to support your migration.

We saw earlier that there are several features that enhance the AKS Kubernetes offering. Each of these features can be a compelling factor in your decision to use AKS.

| | Consideration |
| --- | --- |
| **Identity and security management** | Do you already use existing Azure resources and make use of Azure AD? You can configure an AKS cluster to integrate with Azure AD and reuse existing identities and group membership. |
| **Integrated logging and monitoring** | AKS includes Azure Monitor for containers to provide performance visibility of the cluster. With a custom Kubernetes installation, you normally decided on a monitoring solution that requires installation and configuration. |
| **Auto Cluster node and pod scaling** | Deciding when to scale up or down in large containerization environment is tricky. AKS supports two auto cluster scaling options. You can use either the horizontal pod autoscaler or the cluster autoscaler to scale the cluster. The horizontal pod autoscaler watches the resource demand of pods and will increase pods to match demand. The cluster autoscaler component watches for pods that can't be scheduled because of node constraints. It will automatically scale cluster nodes to deploy scheduled pods. |
| **Cluster node upgrades** | Do you want to reduce the number of cluster management tasks? AKS manages Kubernetes software upgrades and the process of cordoning off nodes and draining them to minimize disruption to running applications. Once done, these nodes are upgraded one by one. |
| **GPU enabled nodes** | Do you have compute-intensive or graphic-intensive workloads? AKS supports GPU enabled node pools. |
| **Storage volume support** | Is your application stateful, and does it require persisted storage? AKS supports both static and dynamic storage volumes. Pods can attach and reattach to these storage volumes as they're created or rescheduled on different nodes. |
| **Virtual network support** | Do you need pod to pod network communication or access to on-premise networks from your AKS cluster? An AKS cluster can be deployed into an existing virtual network with ease. |
| **Ingress with HTTP application routing support** | Do you need to make your deployed applications publicly available? The HTTP application routing add-on makes it easy to access AKS cluster deployed applications. |
| **Docker image support** | Do you already use Docker images for your containers? AKS by default supports the Docker file image format. |
| **Private container registry** | Do you need a private container registry? AKS integrates with Azure Container Registry (ACR). You aren't limited to ACR though, you can use other container repositories, public, or private. |

All the above features are configurable either when you create the cluster or following deployment.
