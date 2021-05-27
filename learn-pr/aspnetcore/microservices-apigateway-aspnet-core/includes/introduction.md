In a microservices architecture, each microservice exposes a set of (typically) fine-grained endpoints. This fact can impact the client-to-microservice communication because of the sheer endpoint count, so that has to be tackled somehow when using microservices.

In this module we'll focus on exposing a microservices application to the outside world, and we'll explore Ingress and TLS termination, API Gateways, and the [Back Ends For Frontends](https://samnewman.io/patterns/architectural/bff/) (BFF) pattern.

In this module you will:

- Deploy an existing ASP.NET Core microservices e-commerce application to AKS.

- Implement a TLS termination using the NGINX Ingress Controller.

- Deploy the microservices application to an AKS that's using the [Azure Application Gateway](https://docs.microsoft.com/azure/application-gateway/overview).

## Learning objectives

- Understand the key concepts for PKI certificates management in an AKS cluster.
- Learn how to deploy [cert-manager](https://cert-manager.io/docs/) in a Kubernetes cluster.
- Understand the key API Gateway and BFF concepts.
- Learn how to configure an AKS cluster to use Azure Application Gateway.

## Prerequisites

- Familiarity with REST API services
- Familiarity with Private Key Infrastructure (PKI)
- Access to an Azure subscription with **Owner** privilege
- 