In this workshop, you'll go through tasks to deploy a multi-container application to Kubernetes on Azure Kubernetes Service (AKS).

You'll deploy the resources in this workshop into a subscription you have access to. To estimate the expected costs for these resources, see the [preconfigured Azure Calculator estimate](https://aka.ms/aks-workshop-estimate?azure-portal=true) of the resources that will be deployed.

## Learning objectives

In this module, you will:

- Create an Azure Kubernetes Service cluster.
- Build and push a container-based application to Azure Container Registry.
- Deploy MongoDB by using Helm 3.
- Use Kubernetes concepts such as deployment, service, and ingress to deploy an application to the Azure Kubernetes Service cluster.
- Set up SSL/TLS.
- Configure monitoring, the horizontal pod autoscaler, and the cluster autoscaler.

## Prerequisites

- Familiarity with Kubernetes and its concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/?azure-portal=true).
- An Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service/?azure-portal=true) to deploy resources in.
- Familiarity with [Azure Cloud Shell](https://shell.azure.com?azure-portal=true).
- A [GitHub](https://github.com/join?azure-portal=true) account.

## Source code

The application consists of two components: the API and the front end. Both components are written in Node.js. The API stores data in a MongoDB database.

| Component                | Link                                                                                                           |
|--------------------------|----------------------------------------------------------------------------------------------------------------|
| An API `ratings-api`     | [GitHub repo](https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-api?azure-portal=true)             |
| A front-end `ratings-web` | [GitHub repo](https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-web?azure-portal=true)             |

![Application diagram](../media/01-app-overview.svg)
