In a microservices architecture, each microservice typically exposes a set of fine-grained endpoints. This can impact the client-to-microservice communication due to sheer endpoint count, so it's important to develop a sound strategy to manage app endpoints.

In this module, you'll learn about exposing a microservices application to the outside world. You'll explore ingress, API Gateways, and the [Backends For Frontends](https://samnewman.io/patterns/architectural/bff/) (BFF) pattern.

In this module you will:

- Deploy an existing ASP.NET Core microservices e-commerce app to Azure Kubernetes Services.
- Implement a BFF pattern using .NET.
- Redeploy the app to an instance of AKS configured to use [Azure Application Gateway](/azure/application-gateway/overview).
- Expose a BFF API outside the Kubernetes cluster outside using [Application Gateway Ingress Controller](/azure/application-gateway/ingress-controller-overview).

## Learning objectives

- Understand the key concepts of Application Gateway and Backends For Frontends patterns.
- Understand the key concepts of ingress and load balancers.
- Learn how to configure an AKS cluster to use Azure Application Gateway.

## Prerequisites

- Familiarity with C# and ASP.NET Core
- Familiarity with REST API services
- Access to an Azure subscription with **Owner** privilege
