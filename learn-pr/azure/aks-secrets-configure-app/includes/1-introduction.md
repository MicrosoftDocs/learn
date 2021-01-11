Imagine you work for a freight company that transports goods all over the world by using ships. The operations department uses a small system that tracks where all the company's ships are docked. Due to staff increases, this system is being moved to Azure Kubernetes Service (AKS). However, the security team noted some flaws in the app configuration.

Some configurations were hardcoded in the app, and some sensitive values like connection strings were left as plain text. They required changes before this application could be deployed to production.

## Learning objectives

By the end of this module, you'll be able to:

- Understand configuration concepts behind Kubernetes workloads such as Secrets and ConfigMaps
- Deploy a complete application, securely storing application secrets
- Deploy workload-based configuration for a web application

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes).
- Familiarity with [Git](https://docs.microsoft.com/contribute/git-github-fundamentals) and [GitHub](https://github.com).
- Familiarity with [Docker](https://docker.com) and Docker images.
- An active Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service).
- The ability to use the [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough).
- The ability to create a Docker container. If you're new to Docker, start with the [introduction to containers](https://docs.microsoft.com/learn/modules/intro-to-containers/).

All exercises will use [Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/overview), which already has all the needed tools installed. If you prefer to run the examples in your own terminal, you'll need to have the following tools installed first:
- [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough)
- [Kubectl](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough#connect-to-the-cluster)

## Before we start

We'll assume an AKS cluster is already created and running. To create your AKS cluster, run the following commands in a Cloud Shell environment:

```azurecli-interactive
RESOURCE_GROUP=learn-ship-manager \
az group create -n $RESOURCE_GROUP -l eastus
```

```azurecli-interactive
CLUSTER_NAME=ship-manager \
az aks create \
 -g $RESOURCE_GROUP \
 -n $CLUSTER_NAME \
 --node-count 1 \
 --node-vm-size Standard_B2s \
 --generate-ssh-keys \
 --enable-addons http_application_routing
```

```azurecli-interactive
az aks get-credentials -n $CLUSTER_NAME -g $RESOURCE_GROUP
```

The complete cluster creation can take up to five minutes.

> [!IMPORTANT]
> Make a note of the `RESOURCE_GROUP` and `CLUSTER_NAME` variables for later use.
