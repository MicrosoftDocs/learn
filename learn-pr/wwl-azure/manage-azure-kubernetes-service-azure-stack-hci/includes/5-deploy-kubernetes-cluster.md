With AKS running on the Azure Stack HCI cluster, you're now ready to install your first Kubernetes cluster. To simplify this task, you decide to use Windows Admin Center.

## Create a Kubernetes cluster on the Azure Stack HCI cluster

Just like AKS, Windows Admin Center relies on the AKS extension to guide you through the process of creating a Kubernetes cluster. The process steps are:

- Prerequisites
- Basics
- Node pools
- Authentication
- Networking
- Integration
- Review + create

### Prerequisites

Windows Admin Center lists the compute, storage, and software prerequisites for creating a Kubernetes cluster on Azure Stack HCI. It's your responsibility to verify that the prerequisites are met. 

:::image type="content" source="../media/kubernetes-setup-prerequisites.png" alt-text="The screenshot depicts the Prerequisites step of the Create Kubernetes cluster wizard in Windows Admin Center." border="false":::

### Basics

Windows Admin Center automatically registers your Kubernetes cluster with Azure and onboards it to Azure Arc. For this configuration to succeed, provide the name of your Azure subscription and the resource group you intend to host the Azure resource corresponding to the Kubernetes cluster you are deploying. You also need to authorize Windows Admin Center to perform registration on your behalf.

:::image type="content" source="../media/kubernetes-setup-basics-1-completed-rg.png" alt-text="The screenshot depicts the Azure Arc integration settings of the Basics step of the Create Kubernetes cluster wizard in Windows Admin Center." border="false":::

Windows Admin Center also allows you to specify the size of VMs used to host the control plane components. 

:::image type="content" source="../media/kubernetes-setup-basics-2-completed-rg.png" alt-text="The screenshot depicts the Kubernetes version and the primary node pool settings of the Basics step of the Create Kubernetes cluster wizard in Windows Admin Center." border="false":::

### Node pools

Windows Admin Center provides the option to specify Windows and Linux worker node pools that should be provisioned as part of the Kubernetes cluster setup. 

:::image type="content" source="../media/kubernetes-setup-node-pool-mixed.png" alt-text="The screenshot depicts the Node pools step of the Create Kubernetes cluster wizard in Windows Admin Center." border="false":::

### Authentication

Windows Admin Center allows you to enable Active Directory authentication for the control plane of the Kubernetes cluster you are deploying. If you do choose to use this option, you will need to provide additional information necessary to establish a secure channel between the API Server of the cluster and AD DS domain controllers. 

:::image type="content" source="../media/kubernetes-setup-authentication-enabled.png" alt-text="The screenshot depicts the Authentication step of the Create Kubernetes cluster wizard in Windows Admin Center." border="false":::

### Networking

Windows Admin Center exposes the networking features that will determine the IP address range for virtual networks hosting cluster nodes and provide the ability to implement network traffic controls. 

:::image type="content" source="../media/kubernetes-setup-networking-basic.png" alt-text="The screenshot depicts the Networking step of the Create Kubernetes cluster wizard in Windows Admin Center." border="false":::

### Integration

Windows Admin Center presents the integration settings, which indicate the Azure Stack HCI-based persistent storage available to containerized workloads. 

:::image type="content" source="../media/kubernetes-setup-integration.png" alt-text="The screenshot depicts the Integration step of the Create Kubernetes cluster wizard in Windows Admin Center." border="false":::

### Review + Create

Windows Admin Center provides an overview of your configuration choices. After you verify those, initiate the cluster creation process.

:::image type="content" source="../media/kubernetes-setup-review-create-1.png" alt-text="The screenshot depicts the Review + Create step of the Create Kubernetes cluster wizard in Windows Admin Center." border="false":::

After creating the Kubernetes cluster, you can deploy containerized workloads.

:::image type="content" source="../media/kubernetes-setup-finished-final.png" alt-text="The screenshot depicts the New cluster step of the Create Kubernetes cluster wizard in Windows Admin Center." border="false":::

> [!NOTE] 
> You can fully automate the process of creating a Kubernetes cluster on Azure Stack HCI by using Windows PowerShell.