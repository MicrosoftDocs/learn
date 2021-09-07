Imagine you're a software developer for an online retailer. Your company uses an app named *:::no-loc text="eShopOnContainers":::* as its online storefront. The storefront is a cloud-native, microservices-based ASP.NET Core app. The product owner has asked you to migrate some data services from your Azure Kubernetes Service (AKS) cluster to managed services to reduce operational costs.

In a microservices architecture, each service typically exposes a set of fine-grained endpoints. There are often many endpoints to manage, so it's important to develop a sound strategy. In this module, you'll learn about exposing a microservices application to the outside world. You'll explore ingress, API gateways, and the [Backend for Frontend](https://samnewman.io/patterns/architectural/bff/) (BFF) pattern.

In this module, you will:

- Deploy an existing ASP.NET Core microservices e-commerce app to AKS.
- Implement a BFF pattern by using .NET.
- Redeploy the app to an instance of AKS configured to use [Azure Application Gateway](/azure/application-gateway/overview).
- Expose a BFF API outside the Kubernetes cluster by using [Application Gateway Ingress Controller (AGIC)](/azure/application-gateway/ingress-controller-overview).

## Learning objectives

- Understand the key concepts of Application Gateway and BFF patterns.
- Understand the key concepts of ingress and load balancers.
- Learn how to configure an AKS cluster to use Azure Application Gateway.

## Prerequisites

- Familiarity with C# and ASP.NET Core
- Familiarity with REST API services
- Access to an Azure subscription with owner privileges
