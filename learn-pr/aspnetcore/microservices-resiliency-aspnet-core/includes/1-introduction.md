Imagine that you're a software developer for an online retailer named *:::no-loc text="eShop":::*. The retailer uses a microservices-based architecture that's native to the cloud, and uses .NET for its online storefront. The solution includes a NET API referred to as the product service. The store service makes calls to the backend products API to get details of the products for sale.

This module focuses on *resiliency*, which is the ability of an application or service to handle problems. Resiliency helps make your app fault-tolerant in a way that has the lowest possible impact on the user. The following resilience approaches are explored:

* Using a code-based approach
* Using an infrastructure-based approach

You'll modify the app to include some code-based resiliency handling policies in a microservice. You'll also reconfigure your Azure Kubernetes Service (AKS) deployment to implement an infrastructure-based solution.

[!INCLUDE[Use your own Azure subscription](../../includes/microservices/your-own-az-subscription.md)]

[!INCLUDE[Dev containers](../../includes/dev-containers/required.md)]

## Learning objectives

In this module, you will:

* Understand foundational resiliency concepts.
* Observe the behavior of a microservice that has no resiliency strategy.
* Implement failure handling code for HTTP requests in one microservice.
* Deploy an infrastructure-based resiliency solution to an AKS cluster.

## Prerequisites

* Familiarity with C# and .NET development at the beginner level.
* Familiarity with RESTful service concepts.
* Conceptual knowledge of containers and AKS at the intermediate level.
* Ability to run development containers GitHub Codespaces or in Visual Studio Code.