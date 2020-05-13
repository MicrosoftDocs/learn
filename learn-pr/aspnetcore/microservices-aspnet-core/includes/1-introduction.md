Imagine you're a software developer for an online retailer named eShopOnContainers. The retailer uses a cloud-native, microservices-based architecture developed using .NET Core for its online storefront. A new project is underway to add support for accepting coupon codes at checkout. Your assignment on the project is to finish writing a containerized ASP.NET Core web API to manage coupon codes&mdash;a web API that will be referred to as the coupon service.

This module explores completing the coupon service, adding it to the existing solution, and deploying it to the multi-container Kubernetes cluster. You'll use your own Azure subscription to deploy the resources in this module. To estimate the expected costs for these resources, see the [preconfigured Azure Calculator estimate](https://aka.ms/microservices-aspnet-core-estimate?azure-portal=true) of the resources that you'll deploy.

> [!IMPORTANT]
> Since you will be using your own Azure subscription, be sure to deprovision your Azure resources when you are done with this module to avoid unnecessary charges.

## Learning objectives

In this module, you will:

* Examine an existing ASP.NET Core microservice running in Azure Kubernetes Service (AKS).
* Create an ASP.NET Core microservice.
* Deploy the microservice to the existing application in AKS.

## Prerequisites

* Experience writing C# at the beginner level
* Conceptual knowledge of containers at the beginner level
* Access to an Azure subscription
