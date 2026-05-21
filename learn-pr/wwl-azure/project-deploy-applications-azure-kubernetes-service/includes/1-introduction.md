Welcome to this guided project. In four hands-on exercises, you practice creating and configuring an Azure Container Registry and an Azure Kubernetes Service cluster, and you deploy Linux and Windows container workloads to it.

You'll:

 -  Provision Azure Container Registry (ACR) and Azure Kubernetes Service (AKS).
 -  Build Linux and Windows container images and store them in Azure Container Registry.
 -  Deploy container images to Azure Kubernetes Service.

By the end of this guided project, you have hands-on experience creating and configuring these services in Azure.

> [!NOTE]
> In the guided exercise, you complete an end-to-end project by following step-by-step instructions.

## What you do

The guided project is structured into four exercises:

| Exercise | Activities |
| --- | --- |
| 1. Provision ACR and AKS | Create an Azure Container Registry, an Azure virtual network, and an AKS cluster that includes a Windows node pool. |
| 2. Build container images | Build a Linux container image and a Windows container image, and push both to Azure Container Registry by using `az acr build`. |
| 3. Deploy to AKS | Create custom AKS namespaces, author Kubernetes manifests with `nodeSelector` targeting your Linux and Windows node pools, and deploy both workloads with `kubectl apply`. |
| 4. Review and clean up | Verify the deployments and services, then deprovision all Azure resources. |
