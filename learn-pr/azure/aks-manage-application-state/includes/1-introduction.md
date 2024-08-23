Imagine you work for a freight company that uses ships to transport goods across the world. The operations department uses a small system that tracks where all the company's ships are docked. Due to staff increases, your company has decided to move this system to Kubernetes.

The system's application uses Azure Cosmos DB as a database, and it's built through a separated back end. You've been tasked with determining how to manage your database access in this distributed environment and how to deploy a new database to support this critical application.

## Learning objectives

By the end of this module, you'll be able to:

- Deploy a stateful cloud-native application to Azure Kubernetes Service (AKS).
- Create an Azure Cosmos DB database.
- Understand the concepts of database security through Kubernetes.

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, review the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes) before you begin.
- Familiarity with [Git](/contribute/git-github-fundamentals) and [GitHub](https://github.com).
- Familiarity with [Docker](https://docker.com) and Docker images.
- An active Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service).
- The ability to use the [Azure CLI](/azure/aks/kubernetes-walkthrough).
- The ability to create a Docker container. If you're new to Docker, review the [introduction to containers](/training/modules/intro-to-containers/) before you begin.

[!INCLUDE [azure-subscription-prerequisite](../../../includes/azure-subscription-prerequisite.md)]

> [!NOTE]
> All exercises use [Azure Cloud Shell](/azure/cloud-shell/overview), which already has all the needed tools installed. If you prefer to run the examples in your own terminal, you need to install [Azure CLI](/azure/aks/kubernetes-walkthrough) and [Kubectl](/azure/aks/kubernetes-walkthrough#connect-to-the-cluster).
