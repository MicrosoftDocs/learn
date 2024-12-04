Imagine that you work for a freight company that uses ships to transport goods across the world. The operations department uses a small system that tracks where all the company's ships are docked. Due to staff increases, your company decided to move this system to Azure Kubernetes Service (AKS). However, the security team noted some flaws in the app configuration: some configurations were hardcoded in the app, and some sensitive values like connection strings were left as plain text. These flaws require changes before the application can be deployed for production use.

[!INCLUDE [azure-optional-exercise-subscription-prerequisite](../../../includes/azure-optional-exercise-subscription-prerequisite.md)]

## Learning objectives

By the end of this module, you're able to:

- Understand configuration concepts behind Kubernetes workloads, such as Secrets and ConfigMaps.
- Deploy a complete application, securely storing application secrets.
- Deploy a workload-based configuration for a web application.

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, review the [Kubernetes basics](https://azure.microsoft.com/topic/what-is-kubernetes).
- Familiarity with [Git](/contribute/git-github-fundamentals) and [GitHub](https://github.com).
- Familiarity with [Docker](https://docker.com) and Docker images.
- An active Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service).
- The ability to use the [Azure CLI](/azure/aks/kubernetes-walkthrough).
- The ability to create a Docker container. If you're new to Docker, start with the [Introduction to containers](/training/modules/intro-to-containers/).

All exercises use the [Azure Cloud Shell](/azure/cloud-shell/overview), which already has all the needed tools installed. If you prefer to run the examples in your own terminal, you need to have the [Azure CLI](/azure/aks/kubernetes-walkthrough)
and [kubectl](/azure/aks/kubernetes-walkthrough#connect-to-the-cluster) installed.
