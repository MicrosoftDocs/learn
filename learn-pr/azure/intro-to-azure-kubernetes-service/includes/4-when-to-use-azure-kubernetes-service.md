Here, you can decide whether Azure Kubernetes Service (AKS) is the right choice for you.

You can either approach your decision from a *green fields* or a *lift-and-shift* project point of view. A green fields project allows you to evaluate AKS based on default features. A lift-and-shift project forces you to look at which features are best suited to support your migration.

Earlier, you learned of AKS support for DevOps capabilities through Azure. Here, we list out Azure resources for consideration to enhance your AKS Kubernetes offering. These features each represent compelling factors for why customers choose AKS.

| Service | Consideration |
| --- | --- |
| **Identity and security management** | Do you already use existing Azure resources and make use of Microsoft Entra ID? You can configure an AKS cluster to integrate with Microsoft Entra ID and reuse existing identities and group membership. |
| **Integrated logging and monitoring** | AKS includes Azure Monitor for containers to provide performance visibility into the cluster. With a custom Kubernetes installation, you decide on a monitoring solution that requires installation and configuration. |
| **Auto Cluster node and pod scaling** | Deciding when to scale up or down in large containerization environment is tricky. AKS supports two auto cluster scaling options. You can use either the horizontal pod autoscaler or the cluster autoscaler to scale the cluster. The horizontal pod autoscaler watches the resource demand of pods and increases pod resources to match demand. The cluster autoscaler component watches for pods that can't be scheduled because of node constraints. It  automatically scales cluster nodes to deploy scheduled pods. |
| **Cluster node upgrades** | Do you want to reduce the number of cluster management tasks? AKS manages Kubernetes software upgrades and the process of cordoning off nodes and draining them to minimize disruption to running applications. Once done, these nodes are upgraded one at a time. |
| **GPU enabled nodes** | Do you have compute-intensive or graphic-intensive workloads? AKS supports GPU enabled node pools. |
| **Storage volume support** | Is your application stateful, and does it require persisted storage? AKS supports both static and dynamic storage volumes. Pods can attach and reattach to these storage volumes as they're created or rescheduled on different nodes. |
| **Virtual network support** | Do you need pod-to-pod network communication or access to on-premises networks from your AKS cluster? An AKS cluster can be deployed into an existing virtual network with ease. |
| **Ingress with HTTP application routing support** | Do you need to make your deployed applications publicly available? The HTTP application routing add-on makes it easy to access AKS cluster deployed applications. |
| **Docker image support** | Do you already use Docker images for your containers? AKS  supports the Docker file image format by default. |
| **Private container registry** | Do you need a private container registry? AKS integrates with Azure Container Registry (ACR). You aren't limited to ACR; you can use other container repositories, whether public or private. |

All of these features are configurable, either when you create the cluster or following deployment.
