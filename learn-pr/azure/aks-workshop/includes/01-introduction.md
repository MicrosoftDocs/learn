// TODO: Add intro text to introduce the scenario

In this workshop, you’ll go through tasks that will help you master the basic and more advanced tasks required to deploy a multi-container application to Kubernetes on Azure Kubernetes Service (AKS).

Use this [pre-configured Azure Calculator](https://aka.ms/aks-workshop-estimate?azure-portal=true) to review a monthly cost-estimate of the resources that will be deployed.

## Learning objectives

In this module, you will:

- Create an Azure Kubernetes Service (AKS) cluster
- Build and push a container-based application to Azure Container Registry
- Deploy MongoDB using Helm 3
- Use Kubernetes concepts such as Deployment, Service, and Ingress to deploy an application to the Azure Kubernetes Service (AKS) cluster
- Configure monitoring, Horizontal Pod Autoscaler, and the Cluster Autoscaler
- Build CI/CD pipelines
- Scale using Virtual Nodes
- Set up SSL/TLS

## Prerequisites

- Familiarity with Kubernetes and its concepts. If you are new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/?azure-portal=true)
- An Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service/?azure-portal=true) to deploy resources in
- Familiarity with [Azure Cloud Shell](https://shell.azure.com?azure-portal=true)
- A [GitHub](https://github.com/join?azure-portal=true) account

## Source code

The application consists of two components: the API and the frontend. Both components are written in Node.js. The API stores data in a MongoDB.

| Component                | Link                                                                                                           |
|--------------------------|----------------------------------------------------------------------------------------------------------------|
| An API `ratings-api`     | [GitHub repo](https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-api?azure-portal=true)             |
| A frontend `ratings-web` | [GitHub repo](https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-web?azure-portal=true)             |

![Application diagram](../media/01-app-overview.svg)
