Assume you're an IT engineer at Fruit Smoothies. The company's development team developed a new website that allows users to rate the company's different smoothy flavors. Fruit Smoothies has outlets worldwide with a large follower base and the company expects many fans to visit the new website. You want to make sure when you deploy the ratings website, you can scale the site quickly when needed.

The ratings website consists of several components. There's a web frontend, a document database that stores captured data, and a RESTful API. The API allows the web frontend to communicate with the database. Since the ratings website may store sensitive data, an additional requirement is to protect the site with an HTTPS certificate.

Fruit Smoothies wants to use Kubernetes as their compute platform. The development teams already use containers for application development and deployment, and using an orchestration platform will introduce many benefits. Kubernetes is a portable, extensible open-source platform for automating deployment, scaling, and the management of containerized workloads. Kubernetes abstracts away complex container management and provides declarative configuration to orchestrate containers in different compute environments. This orchestration platform give the same ease of use and flexibility as with Platform as a Service (PaaS) and Infrastructure as a Service (IaaS) offerings.

In this module, we'll go through tasks to deploy a multicontainer application to Kubernetes on Azure Kubernetes Service (AKS).

You'll use your Azure subscription to deploy the resources in this workshop. To estimate the expected costs for these resources, see the [preconfigured Azure Calculator estimate](https://aka.ms/aks-workshop-estimate?azure-portal=true) of the resources that you'll deploy.

## Learning objectives

In this module, you will:

- Create an Azure Kubernetes Service cluster
- Choose the best deployment options for you Pods
- Expose Pods to internal and external network users
- Configure SSL/TLS for Azure Kubernetes Service ingress
- Monitor the health of an Azure Kubernetes Service cluster
- Scale your application in an Azure Kubernetes Service cluster

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
| A front end `ratings-web` | [GitHub repo](https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-web?azure-portal=true)             |

![Application diagram](../media/01-app-overview.svg)
