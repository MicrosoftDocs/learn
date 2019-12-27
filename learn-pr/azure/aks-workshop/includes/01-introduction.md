// TODO: Add intro text to introduce the scenario

In this workshop, you’ll go through tasks that will help you master the basic and more advanced topics required to deploy a multi-container application to Kubernetes on Azure Kubernetes Service (AKS).

Use this [pre-configured Azure Calculator](https://aka.ms/aks-workshop-estimate) to review a monthly cost-estimate of the resources that will be deployed.

## Learning objectives

In this module, you will:

- Create an Azure Kubernetes Service (AKS) cluster
- Build and push a containers based application to Azure Container Registry
- Deploy MongoDB using Helm 3
- Use Kubernetes concepts such as Deployment, Service and Ingress to deploy an application to the Azure Kubernetes Service (AKS) cluster
- Configure monitoring, Horizontal Pod Autoscaler and the Cluster Autoscaler
- Build CI/CD pipelines
- Scale using Virtual Nodes
- Set up SSL/TLS

## Prerequisites

- Familiarity with Kubernetes and its concepts. If you are new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/)
- An Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service/)
- [Azure Cloud Shell](https://shell.azure.com)

## Source code

The application consists of 2 components, the API and the frontend. Both components are written in Node.js. The API stores data in a MongoDB.

![Application diagram](media/app-overview.png)

| Component                                          | Link                                                               |
|----------------------------------------------------|--------------------------------------------------------------------|
| An API `rating-api`                   | [GitHub repo](https://github.com/microsoft/rating-api)             |
| A frontend `rating-web`          | [GitHub repo](https://github.com/microsoft/rating-web)             |

Once you're done, you'll have an experience similar to the below.

![Application](media/app-overview-1.png)

![Application](media/app-overview-2.png)

![Application](media/app-overview-3.png)
