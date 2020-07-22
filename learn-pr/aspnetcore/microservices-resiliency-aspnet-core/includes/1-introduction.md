Using a microservices app in the cloud offers many advantages. There are also several shortcomings. Transient infrastructure failures, mostly network-related, are a key problem that every cloud app must handle.

This module focuses on resiliency. Resiliency is about how to make your app fault-tolerant, in a way that has the lowest possible impact on the user. The following resilience approaches will be explored:

* Using a library-based approach with Polly
* Using an infrastructure-based approach with Linkerd

You'll modify the app to include some Polly resiliency handling policies in a microservice. You'll also reconfigure your Azure Kubernetes Service (AKS) deployment, without changing any code, to implement a Linkerd-based solution.

## Learning objectives

In this module, you will:

* Understand the key resiliency concepts.
* Implement failure handling code for HTTP requests in one microservice.
* Deploy Linkerd to an AKS cluster to implement an infrastructure-based resiliency solution.

## Prerequisites

* Familiarity C# and ASP.NET Core development at the beginner level
* Familiarity with RESTful service concepts and HTTP action verbs, such as GET, POST, PUT, and DELETE
* Conceptual knowledge of containers at the beginner level
* Access to an Azure subscription with **Owner** privilege
