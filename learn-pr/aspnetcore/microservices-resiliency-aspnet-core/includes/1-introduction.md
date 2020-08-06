Cloud-hosted, microservices-based apps rely on communications with other systems across unreliable networks. Such systems may be unavailable or unreachable because of transient failures. Failures include network outages, request timeouts, and components that are offline, under excessive load, or otherwise unresponsive. Transient infrastructure failures, mostly network-related, are a problem that every cloud app must handle.

This module focuses on resiliency. Resiliency is about how to make your app fault-tolerant, in a way that has the lowest possible impact on the user. The following resilience approaches will be explored:

* Using a code-based approach with Polly
* Using an infrastructure-based approach with Linkerd

You'll modify the app to include some Polly resiliency handling policies in a microservice. You'll also reconfigure your Azure Kubernetes Service (AKS) deployment, without changing any code, to implement a Linkerd-based solution.

[!INCLUDE[Use your own Azure subscription](../../includes/microservices/your-own-az-subscription.md)]

## Learning objectives

In this module, you will:

* Understand foundational resiliency concepts.
* Observe the behavior of a microservice with no resiliency strategy.
* Implement failure handling code for HTTP requests in one microservice.
* Deploy Linkerd to an AKS cluster to implement an infrastructure-based resiliency solution.

## Prerequisites

* Familiarity C# and ASP.NET Core development at the beginner level
* Familiarity with RESTful service concepts and HTTP action verbs, such as GET, POST, PUT, and DELETE
* Conceptual knowledge of containers and AKS at the intermediate level
* Access to an Azure subscription with **Owner** privilege
