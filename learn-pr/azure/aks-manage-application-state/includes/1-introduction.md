Imagine you work for a freight company that transports goods all over the world using ships. The operations department already uses a small system that tracks where all the company's are docket at, but, due to staff increasing, this system will need to be ported to Kubernetes.

This application uses MongoDB as a database and it's already built using a separated backend, the problem you have to solve is how you can manage your database access in this distributed environment, and deploy a new database to support this critical application.

## Learning objectives

By the end of this module, you'll be able to:

- Deploy a stateful cloud-native application to Azure Kubernetes service (AKS)
- Create a CosmosDB database
- Understand the concepts of database security using Kubernetes

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes).
- Familiarity with [Git](https://docs.microsoft.com/contribute/git-github-fundamentals) and [GitHub](https://github.com).
- Familiarity with [Docker](https://docker.com) and Docker images.
- An active Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service).
- Ability to use the [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough).
- Ability to create a Docker container. If you're new to Docker, start with the [intro to containers](https://docs.microsoft.com/learn/modules/intro-to-containers/).

All exercises will use [Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/overview), which already has all the needed tooling installed. If you prefer to run the examples in your own terminal, you'll need to have the following tooling installed first:
- [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough)
- [Kubectl](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough#connect-to-the-cluster)
