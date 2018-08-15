# Introduction to private Docker container registries in Azure

Azure Container Registry is a managed Docker registry service based on the open-source Docker Registry 2.0. Create and maintain Azure container registries to store and manage your private Docker container images.

Use container registries in Azure with your existing container development and deployment pipelines. Use Azure Container Registry Build (ACR Build) to build container images in Azure. Build on demand, or fully automate builds with source code commit and base image update build triggers.

## Use cases

Pull images from an Azure container registry to various deployment targets:

* **Scalable orchestration systems** that manage containerized applications across clusters of hosts, including [DC/OS](https://docs.mesosphere.com/), [Docker Swarm](https://docs.docker.com/swarm/), and [Kubernetes](http://kubernetes.io/docs/).

* **Azure services** that support building and running applications at scale, including [Azure Kubernetes Service (AKS)](../aks/index.yml), [App Service](/app-service/index.md), [Batch](../batch/index.yml), [Service Fabric](/azure/service-fabric/), and others.

Developers can also push to a container registry as part of a container development workflow. For example, target a container registry from a continuous integration and deployment tool such as [Visual Studio Team Services](https://www.visualstudio.com/docs/overview) or [Jenkins](https://jenkins.io/).

Configure [ACR Build](#azure-container-registry-build) build tasks to automatically rebuild application images when their base images are updated. Use ACR Build to automate image builds when your team commits code to a Git repository. *ACR Build is currently in preview.*