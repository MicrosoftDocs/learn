This guided project consists of the following exercises:

 -  **Exercise 1: Provision Azure Container Registry (ACR) and Azure Kubernetes Service (AKS).**
 -  Exercise 2: Build Linux and Windows container images and store them in Azure Container Registry.
 -  Exercise 3: Deploy container images to Azure Kubernetes Service.
 -  Exercise 4: Review the deployment and deprovision all resources.

In Exercise 1, you provision Azure Container Registry and Azure Kubernetes Service resources.

 -  **Task 1**: Create an Azure Container registry. You create an Azure Container registry.
 -  **Task 2**: Create an Azure virtual network and an AKS cluster. You create an Azure virtual network and deploy an AKS cluster including a Windows node pool into that virtual network.

> [!NOTE]
> To complete this exercise, you need an [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

> [!IMPORTANT]
> Before you launch the hosted exercise, apply these current AKS and ACR corrections to the hosted steps:
>
> - In Task 1, don't set **Use availability zones** to **Disabled** for Azure Container Registry. Zone redundancy is enabled automatically for all service tiers in supported regions, can't be disabled there, and any displayed `Disabled` value is a legacy artifact. No action is required. For details, see [Zone redundancy in Azure Container Registry](/azure/container-registry/zone-redundancy).
> - In Task 2, Windows node pools require Azure CNI. Don't treat **Kubenet** as the normal/default path for new designs; kubenet is a legacy AKS networking option scheduled for retirement on 31 March 2028. For kubenet-based clusters, plan migration to Azure CNI Overlay by following [Update Azure CNI IPAM mode and data plane technology](/azure/aks/upgrade-aks-ipam-and-dataplane).
> - In the Windows node pool table, read **OS type: Windows 2022** as **OS SKU: Windows 2022**. Before accepting the default Kubernetes version, confirm it supports Windows Server 2022: Windows Server 2022 is supported for Kubernetes 1.25 through 1.35 and can't be used with Kubernetes 1.36 or later. If the default Kubernetes version is 1.36 or later, choose a supported Kubernetes version for Windows Server 2022 or use a Windows OS SKU supported by that Kubernetes version when one is available for your scenario. See [Deploy a Windows Server container on AKS using the Azure portal](/azure/aks/learn/quick-windows-container-deploy-portal#create-an-aks-cluster) and [Upgrade the OS version for AKS Windows workloads](/azure/aks/upgrade-windows-os).

[![Button to launch exercise.](../media/launch-exercise-162c1d6a.png)](https://go.microsoft.com/fwlink/?linkid=2247331)
