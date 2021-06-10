# Introduction

In a microservices architecture, each microservice exposes a set of (typically) fine-grained endpoints. This fact can impact the client-to-microservice communication because of the sheer endpoint count, so that has to be tackled somehow when using microservices.

In this module we'll focus on exposing a microservices application to the outside world, and we'll explore Ingress, API Gateways, and the [Back Ends For Frontends](https://samnewman.io/patterns/architectural/bff/) (BFF) pattern.

In this module you will:

- Deploy an existing ASP.NET Core microservices e-commerce application to AKS.

- Implement a BFF pattern using .NET.

- Deploy the microservices application to an AKS that's using the [Azure Application Gateway](https://docs.microsoft.com/azure/application-gateway/overview).

- Expose BFF API outside the Kubernetes cluster outside using [Application Gateway Ingress Controller](https://docs.microsoft.com/en-us/azure/application-gateway/ingress-controller-overview) and access that external Swagger Client.

## Learning objectives

- Understand the key concepts of Application Gateway and Backend for Front end pattern.
- Understand the key concepts of Ingress and Load balancer.
- Learn how to configure an AKS cluster to use Azure Application Gateway.

## Prerequisites

- Familiarity with C# and ASP.NET Core
- Familiarity with REST API services
- Access to an Azure subscription with **Owner** privilege
