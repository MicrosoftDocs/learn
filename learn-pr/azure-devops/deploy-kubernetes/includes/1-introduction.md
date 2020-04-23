In [Automate Docker container deployments with Azure Pipelines](/learn/modules/deploy-docker?azure-portal=true), you updated a release pipeline to build and publish an ASP.NET Core app as a Docker container, which you then deployed to Azure App Service. The migration to a container-based project afforded the product team several key benefits. However, the adoption of container technologies can open new doors future innovations.

As development organizations scale, so do the complexities of the solutions they deliver. Over time, different products and services take increasing dependence on each other. This can result in different development and operations requirements for different components within a given application. Refactoring those components as their own distinct microservices can improve architectural efficiency. A *microservice* is a small, autonomous service designed to be self-contained and to fulfill a specific business capability. Containers provide a great technical foundation for building and deploying these services, but this leads to a new question: how do we *manage* all of these containers floating around?

This is where orchestration technologies like Kubernetes come in. Kubernetes is a platform for managing containerized workloads and services. It's a great option for organizations that have a growing number of containers that need to be deployed, integrated, and monitored in any environment.

In this module, you join the Tailspin Toys web team as they explore one way to use Kubernetes on Azure. You learn how to update a CI/CD pipeline to build, publish, and deploy multiple Docker containers to a Kubernetes cluster.

While this module focuses on the core tasks that are required to build and deploy your container app, it's important to understand that all of the other features of Azure Pipelines are still available for container deployments to Kubernetes. You can integrate testing, define multiple stages, and perform other tasks just like you would for your existing applications. We omit these tasks here to keep things focused.

## Learning objectives

In this module, you will:

- Create Azure resources to support a Kubernetes cluster.
- Update a basic release pipeline to build, publish, and deploy multiple Docker containers to the Kubernetes cluster.
- Monitor the build, release, and deployment of the project.

## Prerequisites

The modules in this learning path form a progression. To follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

We also recommend you start at the beginning of this learning path: [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true). This module picks up where [Automate Docker container deployments with Azure Pipelines](/learn/modules/deploy-docker?azure-portal=true) leaves off.

[!include[](../../shared/includes/project-details-note.md)]

This module also assumes you have basic familiarity with Kubernetes, although that knowledge is not required to complete it. If you are new to the topic, it is recommended that you complete the [Administer containers in Azure learning path](/learn/paths/administer-containers-in-azure/?azure-portal=true) learning path first.

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps. She's helping the team adopt a more automated process that uses Azure DevOps.