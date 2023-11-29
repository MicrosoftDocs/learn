Azure Container Registry is a managed Docker registry service based on the open-source Docker Registry 2.0. Container Registry is private, hosted in Azure, and allows you to build, store, and manage images for container deployments.

You can push and pull container images with Azure Container Registry using the Docker CLI or the Azure CLI. Azure portal integration allows you to visually inspect the container images in your container registry. In distributed environments, you can use the container registry geo-replication feature to distribute container images to multiple Azure data centers for localized distribution.

You can use Azure Container Registry Tasks to store and build container images in Azure. Tasks use a standard Dockerfile to create and store the container images in Azure Container Registry without the need for local Docker tooling. With Azure Container Registry Tasks, you can build on-demand or fully automate container image builds using DevOps processes and tooling.

## Learning objectives

By the end of this module, you'll be able to:

- Deploy an Azure container registry.
- Build and deploy a container image to an Azure container instance using Azure Container Registry Tasks.
- Replicate a container image to multiple Azure regions.

## Prerequisites  

- An active Azure subscription.
- Ability to use the Azure CLI.

> [!IMPORTANT]
> All exercises in this module use the [Azure Cloud Shell](/azure/cloud-shell/overview?WT.mc_id=deploycontainerapps_intro-learn-ludossan), which already has all the needed tooling installed. If you prefer to run the examples in your own terminal, you need to have the [Azure CLI](/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan) installed.
