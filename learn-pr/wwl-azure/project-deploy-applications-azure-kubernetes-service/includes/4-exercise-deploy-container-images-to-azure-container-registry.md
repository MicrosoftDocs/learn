This guided project consists of the following exercises:

 -  Exercise 1: Provision Azure Container Registry (ACR) and Azure Kubernetes Service (AKS).
 -  Exercise 2: Build Linux and Windows container images and store them in Azure Container Registry.
 -  **Exercise 3: Deploy container images to Azure Kubernetes Service.**
 -  Exercise 4: Review the deployment and deprovision all resources.

In Exercise 3, you deploy two container images you created earlier in this guided project to the AKS cluster.

 -  **Task 1: Create custom AKS namespaces.** You create two namespaces on the AKS cluster you created in an earlier exercise.
 -  **Task 2: Create a Kubernetes manifest for deploying the Linux image**. You create a Kubernetes manifest for deploying the Linux image to the Linux node pool.
 -  **Task 3: Create a Kubernetes manifest for deploying the Windows image.** You create a Kubernetes manifest for deploying the Windows image to the Windows node pool.
 -  **Task 4: Perform AKS deployments by using YAML manifest files.** You deploy both container images to their namespaces and node pools in the target AKS cluster.

> [!NOTE]
> To complete this exercise, you need an [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

> [!IMPORTANT]
> Before you launch the hosted exercise, apply this manifest-file correction to the hosted steps:
>
> - In Task 3, when replacing the `ACR_NAME` placeholder for the Windows deployment, update `aks-deployment-w01.yaml`, not `aks-deployment-l01.yaml`. The command edits `./aks-deployment-w01.yaml`; the prose should point to the same Windows manifest file. For related Windows manifest guidance, see [Deploy a Windows Server container on AKS using the Azure portal](/azure/aks/learn/quick-windows-container-deploy-portal#deploy-the-application).

[![Button to launch exercise.](../media/launch-exercise-162c1d6a.png)](https://go.microsoft.com/fwlink/?linkid=2247298)
