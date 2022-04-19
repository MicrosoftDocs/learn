Imagine you work for a freight company that transports goods all over the world by using ships. The operations department uses a small system that tracks where all the company's ships are docked. Due to staff increases, this system is being moved to Azure Kubernetes Service (AKS). However, the security team noted some flaws in the app configuration.

Some configurations were hardcoded in the app, and some sensitive values like connection strings were left as plain text. They required changes before this application could be deployed to production.

[!INCLUDE [azure-optional-exercise-subscription-prerequisite](../../../includes/azure-optional-exercise-subscription-prerequisite.md)]

## Learning objectives

By the end of this module, you'll be able to:

- Understand configuration concepts behind Kubernetes workloads such as Secrets and ConfigMaps
- Deploy a complete application, securely storing application secrets
- Deploy workload-based configuration for a web application

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes).
- Familiarity with [Git](/contribute/git-github-fundamentals) and [GitHub](https://github.com).
- Familiarity with [Docker](https://docker.com) and Docker images.
- An active Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service).
- The ability to use the [Azure CLI](/azure/aks/kubernetes-walkthrough).
- The ability to create a Docker container. If you're new to Docker, start with the [introduction to containers](/learn/modules/intro-to-containers/).

All exercises will use [Azure Cloud Shell](/azure/cloud-shell/overview), which already has all the needed tools installed. If you prefer to run the examples in your own terminal, you'll need to have the following tools installed first:
- [Azure CLI](/azure/aks/kubernetes-walkthrough)
- [Kubectl](/azure/aks/kubernetes-walkthrough#connect-to-the-cluster)
