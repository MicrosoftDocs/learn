Imagine you're a software developer for an online retailer named *:::no-loc text="eShopOnContainers":::*. The retailer uses a microservices-based architecture that's native to the cloud. It uses .NET Core for its online storefront. The solution includes an ASP.NET Core web API referred to as the coupon service. Customers have reported a degraded experience from sporadic exceptions when redeeming coupons. You've been assigned the task of making the coupon service resilient against failure.

This module focuses on resiliency. Resiliency is about how to make your app fault-tolerant in a way that has the lowest possible impact on the user. The following resilience approaches will be explored:

* Using a code-based approach
* Using an infrastructure-based approach

You'll modify the app to include some code-based resiliency handling policies in a microservice. You'll also reconfigure your Azure Kubernetes Service (AKS) deployment to implement an infrastructure-based solution.

[!INCLUDE[Use your own Azure subscription](../../includes/microservices/your-own-az-subscription.md)]

## Learning objectives

In this module, you will:

* Understand foundational resiliency concepts.
* Observe the behavior of a microservice with no resiliency strategy.
* Implement failure handling code for HTTP requests in one microservice.
* Deploy an infrastructure-based resiliency solution to an AKS cluster.

## Prerequisites

* Familiarity with C# and ASP.NET Core development at the beginner level
* Familiarity with RESTful service concepts
* Conceptual knowledge of containers and AKS at the intermediate level
* Access to an Azure subscription with **Owner** privilege
