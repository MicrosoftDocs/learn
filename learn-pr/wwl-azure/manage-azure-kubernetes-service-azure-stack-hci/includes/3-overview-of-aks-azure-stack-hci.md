Your research of the capabilities of Kubernetes yields promising results. However, you are concerned that its management will prove to be too challenging for your team, relatively new to the area of container orchestration. You need to identify a way to minimize the learning curve required to successfully implement containerized workloads for Contoso. You expect that the best way to accomplish this objective for your Azure Stack HCI deployments is to use its support for AKS.

## What is AKS on Azure Stack HCI?

AKS on Azure Stack HCI is a Microsoft implementation of AKS, which automates deployment and management of containerized applications. 

Microsoft introduced AKS as an Azure service, but later extended its availability to on-premises environments, including Windows Server and Azure Stack HCI operating systems. However, there are some differences between running AKS on these two operating systems:

- In Azure, Microsoft manages the control plane of each AKS cluster. In addition, management and worker nodes run on Azure virtual machines (VMs) or Azure VM scale sets.
- In on-premises environments, you manage the entire deployment. When using Azure Stack HCI, management and worker nodes run on VMs hosted by the hyperconverged cluster.

## What is the architecture of AKS on Azure Stack HCI?

The implementation of AKS on Azure Stack HCI consists of two types of clusters:

- A single AKS management cluster. This cluster serves as a dedicated control plane for management of Kubernetes clusters running on the same hyperconverged platform. It consists of Linux VMs, which host Kubernetes system components such as API server and load balancers. These VMs service requests that originate from the Azure Stack HCI administrative staff who use management interfaces such as Microsoft Azure Arc or Windows Admin Center.
- One or more Kubernetes clusters. These clusters consist of both control and worker nodes. Control nodes are implemented as Linux VMs, with API server and load balancer components servicing requests from Azure Stack HCI users, who deploy their workloads to Linux or Windows-based worker nodes. Users can interact directly with their respective Kubernetes clusters by using tools such as kubectl or Kubernetes dashboards.

:::image type="content" source="../media/aks-azshci-architecture.png" alt-text="The diagram illustrates the high-level architecture of AKS on Azure Stack HCI, consisting of the management cluster and Kubernetes clusters." border="false":::

Each Kubernetes cluster runs on its own dedicated set of VMs protected by Hypervisor-based isolation, making it possible to securely share the same physical infrastructure in scenarios that require workload isolation.

## What are the benefits of AKS on Azure Stack HCI?

AKS simplifies the deployment of Kubernetes clusters by providing an abstraction layer that hides some of the more challenging implementation details. It uses Windows Admin Center to guide you through the process of installing the AKS host serving as the management cluster. Windows Admin Center also facilitates installation of individual Kubernetes clusters that contain worker nodes hosting your containerized workloads. The installation process automatically provisions all relevant software components, including management tools such as kubectl.

AKS on Azure Stack HCI supports both Linux-based and Windows-based containers. When you create a Kubernetes cluster, you just specify the types of containers you intend to run. The hyperconverged platform automatically installs the required operating system on the Kubernetes cluster nodes. 

AKS running on Azure Stack HCI offers many other benefits, including:

- Streamlined deployment of containerized apps to Kubernetes clusters that run across the Azure Stack HCI cluster
- Horizontal scaling of compute resources by adding or removing nodes of Kubernetes clusters
- Simplified management of storage and networking configuration of clustered resources
- Automated upgrades of cluster nodes to the latest available Kubernetes version. Microsoft manages Windows Server and Linux images for cluster nodes and updates them on a monthly basis. 
- Integration with a range of Azure services and features, such as Microsoft Azure Monitor, Azure Policy, and Azure Role-Based Access Control (RBAC). This capability uses Azure Arc for Kubernetes.
- Centralized management of Azure Stack HCI-based Kubernetes clusters and their workloads through the Azure portal. This capability also uses Azure Arc for Kubernetes. 

> [!NOTE]
> The Azure portal-based management supplements traditional Kubernetes administrative tools and interfaces, such as kubectl command line utility and Kubernetes dashboards.

In addition, Azure Stack HCI manages automatic failover of VMs serving as Kubernetes cluster nodes if there is a localized failure of the underlying physical components. This supplements the high availability built into Kubernetes, which automatically restarts failed containers on the same or another VM.