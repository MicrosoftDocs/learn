Azure Container Registry is a managed Docker registry service based on the open-source Docker Registry 2.0. Azure Container Registry is a private registry, hosted in Azure, and allows you to build, store, and manage images for all types of container deployments.

Use container registries in Azure with your existing container development and deployment pipelines. Use Azure Container Registry Build (ACR Build) to build container images in Azure. Build on demand, or fully automate builds with source code commit and base image update build triggers.

## Use cases

With Azure Container Registry you can pull images from an Azure container registry to various deployment targets:

- **Scalable orchestration systems** that manage containerized applications across clusters of hosts, including DC/OS, Docker Swarm, and Kubernetes.
- **Azure services** that support building and running applications at scale, including Azure Kubernetes Service (AKS), App Service, Batch, Service Fabric, and others.

Developers can also push to a container registry as part of a container development workflow. For example, target a container registry from a continuous integration and deployment tool such as Visual Studio Team Services or Jenkins.

Use ACR Build to automate image builds when your team commits code to a Git repository.

## Azure Container Registry SKUs

Azure Container Registry (ACR) is available in multiple service tiers, known as SKUs. These SKUs provide predictable pricing and several options for aligning to the capacity and usage patterns of your private Docker registry in Azure.

| SKU | Managed | Description |
| --- | :-------: | ----------- |
| **Basic** | Yes | A cost-optimized entry point for developers learning about Azure Container Registry. Basic registries have the same programmatic capabilities as Standard and Premium (Azure Active Directory authentication integration, image deletion, and web hooks), however, there are size and usage constraints. |
| **Standard** | Yes | Standard registries offer the same capabilities as Basic, with increased storage limits and image throughput. Standard registries should satisfy the needs of most production scenarios. |
| **Premium** | Yes | Premium registries provide higher limits on constraints such as storage and concurrent operations, enabling high-volume scenarios. In addition to higher image throughput capacity, Premium adds features like [geo-replication][container-registry-geo-replication] for managing a single registry across multiple regions, maintaining a network-close registry to each deployment. |
| Classic | No | The Classic registry SKU enabled the initial release of the Azure Container Registry service in Azure. Classic registries are backed by a storage account that Azure creates in your subscription, which limits the ability for ACR to provide higher-level capabilities such as increased throughput and geo-replication. Because of its limited capabilities, we plan to deprecate the Classic SKU in the future. |