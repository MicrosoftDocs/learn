Imagine you're a software developer for an online retailer named *:::no-loc text="eShopOnContainers":::*. The retailer's online storefront is a cloud-native, microservices-based ASP.NET Core app. To ease triaging of production issues, you'll implement a comprehensive logging and monitoring solution. In a microservices-based solution, logging and monitoring tools help illustrate the relationships among the components involved. The tools can also help identify resource consumption and performance bottlenecks.

This module guides you through configuring diagnostics logging and performance monitoring with Azure Monitor features. You'll begin with a simplified, revamped version of [:::no-loc text="eShopOnContainers":::](https://github.com/dotnet-architecture/eShopOnContainers)&mdash;the companion reference app for the guide [.NET Microservices: Architecture for Containerized .NET Applications](/dotnet/architecture/microservices). Instrumentation and monitoring of three microservices and an HTTP aggregator is the focus in this module.

You'll use your own Azure subscription to deploy the resources in this module. To estimate the expected resource costs, see the [preconfigured Azure Calculator estimate](https://aka.ms/microservices-logging-aspnet-core-estimate?azure-portal=true). If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/dotnet/?azure-portal=true) before you begin.

> [!IMPORTANT]
> This module uses your own Azure subscription. To avoid unnecessary charges in your Azure subscription, remember to de-provision your Azure resources when you're done with this module.

## Learning objectives

In this module, you will:

- Review diagnostics logging and performance monitoring concepts.
- Implement diagnostics logging with Application Insights.
- Implement performance monitoring with Application Insights.
- Enable Azure Monitor for Containers in a Kubernetes cluster.
- Create a custom performance metric using Prometheus.
- Examine a custom performance metric using Azure Monitor for Containers.

## Prerequisites

- Familiarity with C# and ASP.NET Core development at the beginner level
- Familiarity with RESTful service concepts
- Familiarity with the Kusto query language at the beginner level
- Conceptual knowledge of containers and Azure Kubernetes Service (AKS) at the intermediate level
- Access to an Azure subscription with **Owner** privilege
