Imagine you're a software developer for an online retailer named *:::no-loc text="eShopOnContainers":::*. The retailer uses a microservices-based architecture that's native to the cloud. It uses .NET Core for its online storefront. A new project is underway to add support for accepting coupon codes at checkout. Your assignment on the project is to finish writing a containerized ASP.NET Core web API to manage coupon codes. This web API is referred to as the *coupon service*.

This module explores completing the coupon service, adding it to the existing solution, and deploying it to the multi-container Kubernetes cluster. You'll use your own Azure subscription to deploy the resources in this module. To estimate the expected costs for these resources, see the [preconfigured Azure Calculator estimate](https://aka.ms/microservices-aspnet-core-estimate?azure-portal=true) of the resources that you'll deploy. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/dotnet/?azure-portal=true) before you begin.

> [!IMPORTANT]
> This module uses your own Azure subscription. To avoid unnecessary charges in your Azure subscription, remember to deprovision your Azure resources when you're done with this module.

## Learning objectives

In this module, you will:

* Examine existing ASP.NET Core microservices that run in Azure Kubernetes Service (AKS).
* Implement a new ASP.NET Core microservice, and containerize it.
* Publish the Docker image to Azure Container Registry.
* Deploy the Docker container to the existing AKS cluster.

## Prerequisites

* Experience writing C# at the beginner level
* Familiarity with RESTful service concepts and HTTP action verbs, such as GET, POST, PUT, and DELETE
* Conceptual knowledge of containers at the beginner level
* Access to an Azure subscription
